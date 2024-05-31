import 'package:flutter/material.dart';
import 'package:parking_lots_rating/core/data/models/parking_lot.dart';

class ParkinglotSummaryCard extends StatelessWidget {
  final ParkingLot lot;

  const ParkinglotSummaryCard({super.key, required this.lot});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Image.network(lot.image ?? ""),
        title: Text(lot.name),
        subtitle: Text(lot.address),
        trailing: Text(lot.liveDate ?? ""),
      ),
    );
  }
}
