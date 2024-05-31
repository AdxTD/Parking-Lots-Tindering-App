import 'package:fpdart/fpdart.dart';
import 'package:parking_lots_rating/core/data/models/parking_lot.dart';
import 'package:parking_lots_rating/core/domain/repository/parking_lot_repository.dart';
import 'package:parking_lots_rating/core/domain/usecase/usecase.dart';
import 'package:parking_lots_rating/core/error/failures.dart';

class GetLabeledParkinglots implements UseCase<List<ParkingLot>, NoParams> {
  final ParkingLotRepository repository;

  GetLabeledParkinglots({required this.repository});

  @override
  Future<Either<Failure, List<ParkingLot>>> call(NoParams params) async {
    return await repository.getLabeledParkinglots();
  }
}
