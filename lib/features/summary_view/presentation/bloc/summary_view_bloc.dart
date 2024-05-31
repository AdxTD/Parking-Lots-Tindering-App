import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:parking_lots_rating/core/data/models/parking_lot.dart';
import 'package:parking_lots_rating/core/domain/usecase/usecase.dart';
import 'package:parking_lots_rating/features/summary_view/domain/usecases/get_labeled_parkinglots.dart';

part 'summary_view_state.dart';
part 'summary_view_event.dart';

class SummaryViewBloc extends Bloc<SummaryViewEvent, SummaryViewState> {
  final GetLabeledParkinglots _getLabeledParkinglots;
  List<ParkingLot> allLots = [];

  SummaryViewBloc({required GetLabeledParkinglots getLabeledParkinglots})
      : _getLabeledParkinglots = getLabeledParkinglots,
        super(SummaryInitial()) {
    on<SummaryViewEvent>((_, emit) => emit(SummaryLoading()));
    on<FetchGroupedSortedLots>(_onFetchParkinglots);
    on<FilterParkinglots>(_onFilterParkingLots);
  }

  _onFetchParkinglots(
    FetchGroupedSortedLots event,
    Emitter<SummaryViewState> emit,
  ) async {
    final res = await _getLabeledParkinglots(NoParams());
    res.fold((l) => emit(SummaryError(l.message)), (lots) {
      allLots.addAll(lots);
      emit(SummarySuccess(lots));
    });
  }

  _onFilterParkingLots(
    FilterParkinglots event,
    Emitter<SummaryViewState> emit,
  ) async {
    try {
      List<ParkingLot> filteredLots = allLots.where((lot) {
        if (event.showTrueLabelLots && lot.label!) {
          return true;
        } else if (event.showFalseLabelLots && !lot.label!) {
          return true;
        }
        return false;
      }).toList();
      emit(SummarySuccess(filteredLots));
    } catch (e) {
      emit(const SummaryError('Failed to filter lots'));
    }
  }
}
