import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parking_lots_rating/features/summary_view/presentation/bloc/summary_view_bloc.dart';
import 'package:parking_lots_rating/features/summary_view/presentation/widgets/filter_checkbox.dart';
import 'package:parking_lots_rating/features/summary_view/presentation/widgets/parkinglot_summary_card.dart';
import 'package:parking_lots_rating/init_dependencies.dart';

class SummaryViewPage extends StatefulWidget {
  const SummaryViewPage({super.key});

  static route() =>
      MaterialPageRoute(builder: ((context) => const SummaryViewPage()));

  @override
  State<SummaryViewPage> createState() => _SummaryViewPageState();
}

class _SummaryViewPageState extends State<SummaryViewPage> {
  late SummaryViewBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = SummaryViewBloc(getLabeledParkinglots: serviceLocator());
    _bloc.add(FetchGroupedSortedLots());
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
        title: const Text('Summary'),
      ),
      body: BlocBuilder<SummaryViewBloc, SummaryViewState>(
        bloc: _bloc,
        builder: (context, state) {
          if (state is SummaryLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is SummarySuccess) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Filter:'),
                      FilterCheckbox(
                        label: 'Show good lots',
                        initialValue: true,
                        onChanged: (value) {
                          _bloc.add(FilterParkinglots(
                            showTrueLabelLots: value,
                          ));
                        },
                      ),
                      FilterCheckbox(
                        label: 'Show bad lots',
                        initialValue: true,
                        onChanged: (value) {
                          _bloc.add(FilterParkinglots(
                            showFalseLabelLots: value,
                          ));
                        },
                      ),
                    ],
                  ),
                ),
                Flexible(
                  fit: FlexFit.loose,
                  child: ListView.builder(
                    itemCount: state.lots.length,
                    itemBuilder: (context, index) {
                      final lot = state.lots[index];
                      return Column(
                        children: [
                          if (index == 0 && lot.label!)
                            const Text(
                              "Good lots:",
                              style: TextStyle(color: Colors.green),
                            ),
                          if ((index == 0 && !lot.label!) ||
                              (!lot.label! && state.lots[index - 1].label!))
                            const Text(
                              "Bad lots:",
                              style: TextStyle(color: Colors.redAccent),
                            ),
                          ParkinglotSummaryCard(lot: lot),
                        ],
                      );
                    },
                  ),
                ),
              ],
            );
          } else if (state is SummaryError) {
            return Center(
              child: Text(state.message),
            );
          }
          return Container();
        },
      ),
    );
  }
}
