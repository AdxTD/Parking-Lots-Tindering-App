import 'package:parking_lots_rating/core/data/models/parking_lot.dart';
import 'package:parking_lots_rating/core/error/failures.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class ParkingLotRepository {
  Future<Either<Failure, List<ParkingLot>>> fetchParkingLots();
}
