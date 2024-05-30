import 'package:fpdart/fpdart.dart';
import 'package:parking_lots_rating/core/data/models/parking_lot.dart';
import 'package:parking_lots_rating/core/domain/usecase/usecase.dart';
import 'package:parking_lots_rating/core/error/failures.dart';
import 'package:parking_lots_rating/core/domain/repository/parking_lot_repository.dart';

class GetNewParkinglots implements UseCase<List<ParkingLot>, NoParams> {
  final ParkingLotRepository repository;

  GetNewParkinglots({required this.repository});

  @override
  Future<Either<Failure, List<ParkingLot>>> call(NoParams params) async {
    return await repository.fetchParkingLots();
  }
}
