import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:parking_lots_rating/core/data/models/parking_lot.dart';
import 'package:parking_lots_rating/core/error/exceptions.dart'
    as core_exceptions;

abstract interface class RemoteParkinglotsDataSourceInterface {
  Future<List<ParkingLot>> fetchData(int limit, int offset);
}

class RemoteParkinglotsDataSource
    implements RemoteParkinglotsDataSourceInterface {
  final GraphQLClient _client;

  RemoteParkinglotsDataSource(this._client);

  @override
  Future<List<ParkingLot>> fetchData(int limit, int offset) async {
    final query = gql("""
query {
  getAllParkingLots (offset: $offset, limit: $limit) {
    address
    image
    live_date
    name
    size
    status
    type
    id
  }
}

""");

    final options = QueryOptions(
      document: query,
    );

    final result = await _client.query(options);

    if (result.hasException) {
      throw core_exceptions.ServerException(
          'Failed to fetch data: ${result.exception}');
    }

    final List<ParkingLot> parkinglotsList = [];
    final data = result.data!['getAllParkingLots'] as List<dynamic>;
    for (final item in data) {
      final parkingLot = ParkingLot.fromJson(item);
      parkinglotsList.add(parkingLot);
    }
    return parkinglotsList;
  }
}
