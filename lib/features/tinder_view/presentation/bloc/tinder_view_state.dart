part of 'tinder_view_bloc.dart';

@immutable
sealed class TinderViewState extends Equatable {
  const TinderViewState();

  @override
  List<Object?> get props => [];
}

final class TinderViewInitial extends TinderViewState {}

final class ParkinglotLoading extends TinderViewState {}

final class ParkingLotDisplaySuccess extends TinderViewState {
  final ParkingLot parkingLot;
  const ParkingLotDisplaySuccess(this.parkingLot);

  @override
  List<Object?> get props => [parkingLot];
}

final class ParkinglotFailure extends TinderViewState {
  final String error;

  const ParkinglotFailure(this.error);

  @override
  List<Object?> get props => [error];
}
