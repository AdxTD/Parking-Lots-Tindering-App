part of 'summary_view_bloc.dart';

@immutable
sealed class SummaryViewEvent {
  const SummaryViewEvent();
}

class FetchGroupedSortedLots extends SummaryViewEvent {}

class FilterParkinglots extends SummaryViewEvent {
  final bool? showTrueLabelLots;
  final bool? showFalseLabelLots;

  const FilterParkinglots({
    this.showTrueLabelLots,
    this.showFalseLabelLots,
  });
}
