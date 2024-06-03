part of 'summary_view_bloc.dart';

@immutable
sealed class SummaryViewState extends Equatable {
  const SummaryViewState();

  @override
  List<Object?> get props => [];
}

class SummaryInitial extends SummaryViewState {}

class SummaryLoading extends SummaryViewState {}

class SummarySuccess extends SummaryViewState {
  final List<ParkingLot> lots;

  const SummarySuccess(this.lots);

  @override
  List<Object?> get props => [lots];
}

class SummaryError extends SummaryViewState {
  final String message;

  const SummaryError(this.message);

  @override
  List<Object?> get props => [message];
}
