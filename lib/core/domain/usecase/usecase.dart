import 'package:dartz/dartz.dart';
import 'package:parking_lots_rating/core/error/failures.dart';

abstract interface class UseCase<SuccessType, Params> {
  Future<Either<Failure, SuccessType>> execute(Params params);
}

class NoParams {}
