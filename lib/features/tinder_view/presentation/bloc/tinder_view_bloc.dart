import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:parking_lots_rating/core/data/models/parking_lot.dart';
import 'package:parking_lots_rating/core/domain/usecase/usecase.dart';
import 'package:parking_lots_rating/features/tinder_view/domain/usecase/get_new_parkinglots.dart';
import 'package:parking_lots_rating/features/tinder_view/domain/usecase/save_user_decision.dart';

part 'tinder_view_event.dart';
part 'tinder_view_state.dart';

class TinderViewBloc extends Bloc<TinderViewEvent, TinderViewState> {
  final GetNewParkinglots _getNewParkinglots;
  final SaveUserDecision _saveUserDecision;
  List<ParkingLot> currentParkinglots = [];
  int currentDisplayedIndex = 0;

  TinderViewBloc(
      {required GetNewParkinglots getNewParkinglots,
      required SaveUserDecision saveUserDecision})
      : _getNewParkinglots = getNewParkinglots,
        _saveUserDecision = saveUserDecision,
        super(TinderViewInitial()) {
    on<TinderViewEvent>((event, emit) => emit(ParkinglotLoading()));
    on<ParkinglotGetInitial>(_onParkinglotInitial);
    on<ParkinglotGetNext>(_onParkinglotNext);
  }

  void _onParkinglotInitial(
      ParkinglotGetInitial event, Emitter<TinderViewState> emit) async {
    _updateCurrentParkinglots(emit);
  }

  void _onParkinglotNext(
      ParkinglotGetNext event, Emitter<TinderViewState> emit) async {
    await _saveUserDecision(event.isRight);
    currentDisplayedIndex++;
    if (currentDisplayedIndex < currentParkinglots.length) {
      emit(ParkingLotDisplaySuccess(currentParkinglots[currentDisplayedIndex]));
    } else {
      currentDisplayedIndex = 0;
      currentParkinglots.clear();
      _updateCurrentParkinglots(emit);
    }
  }

  void _updateCurrentParkinglots(Emitter<TinderViewState> emit) async {
    final res = await _getNewParkinglots(NoParams());
    res.fold((l) => emit(ParkinglotFailure(l.message)), (r) {
      currentParkinglots.addAll(r);
      emit(ParkingLotDisplaySuccess(currentParkinglots[currentDisplayedIndex]));
    });
  }
}
