import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:parking_lots_rating/core/data/models/parking_lot.dart';
import 'package:parking_lots_rating/features/summary_view/domain/usecases/get_labeled_parkinglots.dart';

part 'summary_view_state.dart';
part 'summary_view_event.dart';

class SummaryViewBloc extends Bloc<SummaryViewEvent, SummaryViewState> {
  final GetLabeledParkinglots _getLabeledParkinglots;
  List<ParkingLot> allLots = [];
  bool isGoodLotsDisplayed = true;
  bool isBadLotsDisplayed = true;

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
    final res = await _getLabeledParkinglots();
    res.fold((l) => emit(SummaryError(l.message)), (lots) {
      allLots.addAll(lots);
      emit(SummarySuccess(lots));
    });
  }

  _onFilterParkingLots(
    FilterParkinglots event,
    Emitter<SummaryViewState> emit,
  ) async {
    if (event.showTrueLabelLots != null) {
      isGoodLotsDisplayed = event.showTrueLabelLots!;
    }
    if (event.showFalseLabelLots != null) {
      isBadLotsDisplayed = event.showFalseLabelLots!;
    }
    try {
      List<ParkingLot> filteredLots = allLots.where((lot) {
        if (isGoodLotsDisplayed && lot.label!) {
          return true;
        } else if (isBadLotsDisplayed && !lot.label!) {
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
