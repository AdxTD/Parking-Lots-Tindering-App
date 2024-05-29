import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parking_lots_rating/core/data/repository/parking_lot_repository_impl.dart';
import 'package:parking_lots_rating/features/tinder_view/domain/usecase/get_new_parkinglots.dart';
import 'package:parking_lots_rating/features/tinder_view/domain/usecase/save_user_decision.dart';
import 'package:parking_lots_rating/features/tinder_view/presentation/bloc/tinder_view_bloc.dart';

class TinderViewPage extends StatefulWidget {
  const TinderViewPage({super.key});

  static route() =>
      MaterialPageRoute(builder: ((context) => const TinderViewPage()));

  @override
  State<TinderViewPage> createState() => _TinderViewPageState();
}

class _TinderViewPageState extends State<TinderViewPage> {
  late TinderViewBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = TinderViewBloc(
      getNewParkinglots:
          GetNewParkinglots(repository: FakeParkingLotRepository()),
      saveUserDecision:
          SaveUserDecision(repository: FakeParkingLotRepository()),
    );
    _bloc.add(ParkinglotGetInitial());
  }

  @override
  void dispose() {
    _bloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tinder View'),
      ),
      body: BlocBuilder<TinderViewBloc, TinderViewState>(
        bloc: _bloc,
        builder: (context, state) {
          if (state is ParkinglotLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is ParkingLotDisplaySuccess) {
            final parkingLot = state.parkingLot;
            return Column(
              children: [
                Text(parkingLot.imageUrl!),
                const Text('Label the parking lot with "good" or "bad"'),
                ElevatedButton(
                  onPressed: () {
                    _bloc.add(const ParkinglotGetNext(false));
                  },
                  child: const Text('Left'),
                ),
                ElevatedButton(
                  onPressed: () {
                    _bloc.add(const ParkinglotGetNext(true));
                  },
                  child: const Text('Right'),
                ),
              ],
            );
          } else if (state is ParkinglotFailure) {
            return Center(
              child: Text(state.error),
            );
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
    );
  }
}
