import 'package:dartz/dartz.dart';
import 'package:parking_lots_rating/core/data/models/parking_lot.dart';
import 'package:parking_lots_rating/core/domain/repository/parking_lot_repository.dart';
import 'package:parking_lots_rating/core/error/failures.dart';

class GetLabeledParkinglots {
  final ParkingLotRepository repository;

  GetLabeledParkinglots({required this.repository});

  Future<Either<Failure, List<ParkingLot>>> call() async {
    return await repository.getLabeledParkinglots();
  }
}
