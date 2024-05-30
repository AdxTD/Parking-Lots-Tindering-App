import 'package:fpdart/fpdart.dart';
import 'package:parking_lots_rating/core/domain/repository/parking_lot_repository.dart';
import 'package:parking_lots_rating/core/domain/usecase/usecase.dart';
import 'package:parking_lots_rating/core/error/failures.dart';

class SaveUserDecision implements UseCase<bool, bool> {
  final ParkingLotRepository repository;

  SaveUserDecision({required this.repository});

  @override
  Future<Either<Failure, bool>> call(bool label) async {
    return repository.saveParkinglotLabel(label);
  }
}
