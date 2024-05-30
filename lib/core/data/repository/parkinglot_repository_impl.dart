import 'package:parking_lots_rating/core/constants/constants.dart';
import 'package:parking_lots_rating/core/data/datasources/remote_data_source.dart';
import 'package:parking_lots_rating/core/data/models/parking_lot.dart';
import 'package:parking_lots_rating/core/error/failures.dart';
import 'package:parking_lots_rating/core/domain/repository/parking_lot_repository.dart';
import 'package:fpdart/fpdart.dart';
import 'package:parking_lots_rating/core/error/exceptions.dart'
    as core_exceptions;

class ParkingLotRepositorImpl implements ParkingLotRepository {
  final RemoteDataSource remoteDataSource;
  int _currentOffset = 0;
  int _latestLabeledIndex = 0;
  List<ParkingLot> lotsToLabel = [];

  ParkingLotRepositorImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, List<ParkingLot>>> fetchParkingLots() async {
    try {
      final result =
          await remoteDataSource.fetchData(numberOfMaxCases, _currentOffset);
      _currentOffset += numberOfMaxCases;
      lotsToLabel.addAll(result);
      return right(result);
    } on core_exceptions.ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, bool>> saveParkinglotLabel(bool label) async {
    lotsToLabel[_latestLabeledIndex].label = label;
    _latestLabeledIndex++;
    return right(true);
  }
}
