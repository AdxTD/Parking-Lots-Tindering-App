part of 'tinder_view_bloc.dart';

@immutable
sealed class TinderViewEvent {
  const TinderViewEvent();
}

final class ParkinglotGetInitial extends TinderViewEvent {}

final class ParkinglotGetNext extends TinderViewEvent {
  final bool isRight;

  const ParkinglotGetNext(this.isRight);
}
