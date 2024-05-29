import 'package:parking_lots_rating/core/data/models/parking_lot.dart';
import 'package:parking_lots_rating/core/error/failures.dart';
import 'package:parking_lots_rating/core/domain/repository/parking_lot_repository.dart';
import 'package:fpdart/fpdart.dart';

class FakeParkingLotRepository implements ParkingLotRepository {
  @override
  Future<Either<Failure, List<ParkingLot>>> fetchParkingLots() async {
    // Replace this with your actual API call to fetch parking lots
    // For now, return the fake list you mentioned
    return right([
      ParkingLot(
        imageUrl: 'URL',
        name: '...',
        address: '...',
        status: '...',
        id: '...',
        liveData: '...',
        type: '...',
        size: 0,
      ),
      // Add more fake parking lots here
    ]);
  }

  @override
  Future<Either<Failure, bool>> saveParkinglotLabel(bool isRight) async {
    return right(true);
  }
}
