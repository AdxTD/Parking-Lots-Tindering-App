import 'package:bloc_test/bloc_test.dart';
import 'package:mockito/annotations.dart';
import 'package:test/test.dart';
import 'package:dartz/dartz.dart';
import 'package:mockito/mockito.dart';
import 'package:parking_lots_rating/core/constants/constants.dart';
import 'package:parking_lots_rating/core/data/models/parking_lot.dart';
import 'package:parking_lots_rating/core/error/failures.dart';
import 'package:parking_lots_rating/features/tinder_view/domain/usecase/get_new_parkinglots.dart';
import 'package:parking_lots_rating/features/tinder_view/domain/usecase/save_user_decision.dart';
import 'package:parking_lots_rating/features/tinder_view/presentation/bloc/tinder_view_bloc.dart';

import 'tinder_view_bloc_test.mocks.dart';

@GenerateMocks([GetNewParkinglots, SaveUserDecision])
void main() {
  group('TinderViewBloc', () {
    late TinderViewBloc tinderViewBloc;
    late MockGetNewParkinglots mockGetNewParkinglots;
    late MockSaveUserDecision mockSaveUserDecision;
    final List<ParkingLot> fakeParkingLots = [
      ParkingLot(
          name: "Parking Lot 1",
          address: "Address 1",
          status: "Status 1",
          id: "1",
          type: "Type 1",
          size: 1),
      ParkingLot(
          name: "Parking Lot 2",
          address: "Address 2",
          status: "Status 2",
          id: "2",
          type: "Type 2",
          size: 2),
      ParkingLot(
          name: "Parking Lot 3",
          address: "Address 3",
          status: "Status 3",
          id: "3",
          type: "Type 3",
          size: 3),
      ParkingLot(
          name: "Parking Lot 4",
          address: "Address 3",
          status: "Status 3",
          id: "3",
          type: "Type 3",
          size: 3),
      ParkingLot(
          name: "Parking Lot 5",
          address: "Address 3",
          status: "Status 3",
          id: "3",
          type: "Type 3",
          size: 3),
    ];

    setUp(() {
      mockGetNewParkinglots = MockGetNewParkinglots();
      mockSaveUserDecision = MockSaveUserDecision();
      tinderViewBloc = TinderViewBloc(
        getNewParkinglots: mockGetNewParkinglots,
        saveUserDecision: mockSaveUserDecision,
      );
    });

    tearDown(() {
      tinderViewBloc.close();
    });

    test('initial state is TinderViewInitial', () {
      expect(tinderViewBloc.state, TinderViewInitial());
    });

    blocTest<TinderViewBloc, TinderViewState>(
      'should emit ParkingLotDisplaySuccess after ParkinglotGetInitial event',
      build: () {
        when(mockGetNewParkinglots())
            .thenAnswer((_) async => Right(fakeParkingLots));
        return tinderViewBloc;
      },
      act: (bloc) => bloc.add(ParkinglotGetInitial()),
      wait: const Duration(microseconds: 500),
      expect: () => [
        ParkinglotLoading(),
        ParkingLotDisplaySuccess(fakeParkingLots[0]),
      ],
      verify: (_) {
        verify(mockGetNewParkinglots()).called(1);
        verifyNever(mockSaveUserDecision(true));
      },
    );

    blocTest<TinderViewBloc, TinderViewState>(
      'should emit ParkingLotDisplaySuccess, and not fetch new lots when currentDisplayedIndex is within bounds, i.e. less than maxmimum number of cases - 1',
      build: () {
        tinderViewBloc.currentParkinglots = fakeParkingLots;
        tinderViewBloc.currentDisplayedIndex = numberOfMaxCases - 2;
        when(mockSaveUserDecision(true))
            .thenAnswer((_) async => const Right(true));
        when(mockGetNewParkinglots())
            .thenAnswer((_) async => Right(fakeParkingLots));
        return tinderViewBloc;
      },
      act: (bloc) {
        return bloc.add(const ParkinglotGetNext(true));
      },
      wait: const Duration(microseconds: 500),
      verify: (_) {
        verify(mockSaveUserDecision(true)).called(1);
        verifyNever(mockGetNewParkinglots());
      },
      expect: () => [
        ParkinglotLoading(),
        ParkingLotDisplaySuccess(tinderViewBloc
            .currentParkinglots[tinderViewBloc.currentDisplayedIndex]),
      ],
    );

    blocTest<TinderViewBloc, TinderViewState>(
      'should fetch new lots and emit ParkingLotDisplaySuccess when currentDisplayedIndex is at maxmimum number of cases - 1, i.e. will exceeds bounds next time',
      build: () {
        tinderViewBloc.currentParkinglots = fakeParkingLots;
        tinderViewBloc.currentDisplayedIndex = numberOfMaxCases - 1;
        List<ParkingLot> moreParkinglots = [];
        moreParkinglots.addAll(fakeParkingLots);
        when(mockSaveUserDecision(true))
            .thenAnswer((_) async => const Right(true));
        when(mockGetNewParkinglots())
            .thenAnswer((_) async => Right(moreParkinglots));
        return tinderViewBloc;
      },
      act: (bloc) => bloc.add(const ParkinglotGetNext(true)),
      wait: const Duration(microseconds: 500),
      expect: () => [
        ParkinglotLoading(),
        ParkingLotDisplaySuccess(tinderViewBloc
            .currentParkinglots[tinderViewBloc.currentDisplayedIndex]),
      ],
      verify: (_) {
        verify(mockSaveUserDecision(true)).called(1);
        verify(mockGetNewParkinglots()).called(1);
      },
    );

// Test case when currentDisplayedIndex exceeds bounds and fetching new parking lots fails
    blocTest<TinderViewBloc, TinderViewState>(
      'emits ParkinglotFailure when currentDisplayedIndex exceeds bounds and fetching new parking lots fails',
      build: () {
        tinderViewBloc.currentParkinglots = fakeParkingLots;
        tinderViewBloc.currentDisplayedIndex = numberOfMaxCases - 1;
        when(mockSaveUserDecision(true))
            .thenAnswer((realInvocation) async => const Right(true));
        when(mockGetNewParkinglots()).thenAnswer(
            (_) async => Left(Failure('Failed to fetch new parking lots')));
        return tinderViewBloc;
      },
      act: (bloc) => bloc.add(const ParkinglotGetNext(true)),
      wait: const Duration(microseconds: 500),
      expect: () => [
        ParkinglotLoading(),
        const ParkinglotFailure('Failed to fetch new parking lots'),
      ],
      verify: (_) {
        verify(mockSaveUserDecision(true)).called(1);
        verify(mockGetNewParkinglots()).called(1);
      },
    );
  });
}
