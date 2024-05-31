part of 'summary_view_bloc.dart';

@immutable
sealed class SummaryViewState {
  const SummaryViewState();
}

class SummaryInitial extends SummaryViewState {}

class SummaryLoading extends SummaryViewState {}

class SummarySuccess extends SummaryViewState {
  final List<ParkingLot> lots;

  const SummarySuccess(this.lots);
}

class SummaryError extends SummaryViewState {
  final String message;

  const SummaryError(this.message);
}
