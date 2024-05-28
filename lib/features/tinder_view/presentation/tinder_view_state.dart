part of 'tinder_view_bloc.dart';

@immutable
sealed class TinderViewState {
  const TinderViewState();
}

final class TinderViewInitial extends TinderViewState {}

final class ParkinglotLoading extends TinderViewState {}

final class ParkingLotDisplaySuccess extends TinderViewState {
  final ParkingLot parkingLot;
  const ParkingLotDisplaySuccess(this.parkingLot);
}

final class ParkinglotFailure extends TinderViewState {
  final String error;

  const ParkinglotFailure(this.error);
}
