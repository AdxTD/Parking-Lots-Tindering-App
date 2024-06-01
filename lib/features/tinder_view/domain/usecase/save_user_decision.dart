import 'package:dartz/dartz.dart';
import 'package:parking_lots_rating/core/domain/repository/parking_lot_repository.dart';
import 'package:parking_lots_rating/core/error/failures.dart';

class SaveUserDecision {
  final ParkingLotRepository repository;

  SaveUserDecision({required this.repository});

  Future<Either<Failure, bool>> call(bool label) async {
    return repository.saveParkinglotLabel(label);
  }
}
