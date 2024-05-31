part of 'init_dependencies.dart';

final serviceLocator = GetIt.asNewInstance();

Future<void> initDependencies() async {
  // API client
  _initGraphQLClient();

  // remote data source
  serviceLocator.registerLazySingleton<RemoteParkinglotsDataSourceInterface>(
    () => RemoteParkinglotsDataSource(
      serviceLocator(),
    ),
  );

  // repository
  serviceLocator.registerLazySingleton<ParkingLotRepository>(
    () => ParkingLotRepositorImpl(
      serviceLocator(),
    ),
  );

  // use cases
  serviceLocator.registerLazySingleton(
    () => GetNewParkinglots(
      repository: serviceLocator(),
    ),
  );

  serviceLocator.registerLazySingleton(
    () => SaveUserDecision(
      repository: serviceLocator(),
    ),
  );

  serviceLocator.registerLazySingleton(
    () => GetLabeledParkinglots(
      repository: serviceLocator(),
    ),
  );
}

void _initGraphQLClient() {
  final HttpLink httpLink = HttpLink(
    'https://interview-apixx07.dev.park-depot.de/',
  );
  final ValueNotifier<GraphQLClient> client = ValueNotifier<GraphQLClient>(
    GraphQLClient(
      cache: GraphQLCache(),
      link: httpLink,
    ),
  );
  serviceLocator.registerLazySingleton(() => client.value);
}
