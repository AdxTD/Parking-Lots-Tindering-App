import 'package:dartz/dartz.dart';
import 'package:parking_lots_rating/core/data/models/parking_lot.dart';
import 'package:parking_lots_rating/core/error/failures.dart';
import 'package:parking_lots_rating/core/domain/repository/parking_lot_repository.dart';

class GetNewParkinglots {
  final ParkingLotRepository repository;

  GetNewParkinglots({required this.repository});

  Future<Either<Failure, List<ParkingLot>>> call() async {
    return await repository.fetchParkingLots();
  }
}
