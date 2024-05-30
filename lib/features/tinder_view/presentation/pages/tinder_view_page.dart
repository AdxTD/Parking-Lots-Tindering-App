import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parking_lots_rating/core/data/repository/parking_lot_repository_impl.dart';
import 'package:parking_lots_rating/features/tinder_view/domain/usecase/get_new_parkinglots.dart';
import 'package:parking_lots_rating/features/tinder_view/domain/usecase/save_user_decision.dart';
import 'package:parking_lots_rating/features/tinder_view/presentation/bloc/tinder_view_bloc.dart';
import 'package:parking_lots_rating/features/tinder_view/presentation/widgets/parkinglot_card.dart';

class TinderViewPage extends StatefulWidget {
  const TinderViewPage({super.key});

  static route() =>
      MaterialPageRoute(builder: ((context) => const TinderViewPage()));

  @override
  State<TinderViewPage> createState() => _TinderViewPageState();
}

class _TinderViewPageState extends State<TinderViewPage>
    with TickerProviderStateMixin {
  late TinderViewBloc _bloc;
  late AnimationController _animationController;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    _slideAnimation = Tween<Offset>(
      begin: Offset.zero,
      end: const Offset(-1.0, 0.0),
    ).animate(_animationController);

    _bloc = TinderViewBloc(
      getNewParkinglots:
          GetNewParkinglots(repository: FakeParkingLotRepository()),
      saveUserDecision:
          SaveUserDecision(repository: FakeParkingLotRepository()),
    );
    _bloc.add(ParkinglotGetInitial());
  }

  void _swipeLeft() {
    _animationController.forward().then((value) {
      _bloc.add(const ParkinglotGetNext(false));
      _animationController.reset();
    });
  }

  void _swipeRight() {
    _animationController.forward().then((value) {
      _bloc.add(const ParkinglotGetNext(true));
      _animationController.reset();
    });
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
              return Stack(
                children: [
                  Positioned.fill(
                    child: AnimatedBuilder(
                      animation: _slideAnimation,
                      builder: (context, child) {
                        return FractionalTranslation(
                          translation: _slideAnimation.value,
                          child: child,
                        );
                      },
                      child: ParkinglotCard(parkingLot: state.parkingLot),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          FloatingActionButton(
                            onPressed: _swipeLeft,
                            backgroundColor: Colors.red,
                            child: const Icon(Icons.close),
                          ),
                          FloatingActionButton(
                            onPressed: _swipeRight,
                            backgroundColor: Colors.green,
                            child: const Icon(Icons.check),
                          ),
                        ],
                      ),
                    ),
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
          }),
    );
  }

  @override
  void dispose() {
    _bloc.close();
    _animationController.dispose();
    super.dispose();
  }
}
