import 'package:flutter/material.dart';
import 'package:parking_lots_rating/core/data/models/parking_lot.dart';

class ParkinglotCard extends StatelessWidget {
  final ParkingLot parkingLot;

  const ParkinglotCard({
    super.key,
    required this.parkingLot,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(10.0)),
              child: Image.network(
                parkingLot.image ?? "",
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  parkingLot.name,
                  style: const TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4.0),
                Row(
                  children: [
                    const Text(
                      'Address:  ',
                      style: TextStyle(
                        fontSize: 14.0,
                        color: Colors.black87,
                      ),
                    ),
                    Text(
                      parkingLot.address,
                      style: const TextStyle(
                        fontSize: 14.0,
                        color: Colors.blueGrey,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4.0),
                Row(
                  children: [
                    const Text(
                      'Live date:   ',
                      style: TextStyle(
                        fontSize: 14.0,
                        color: Colors.black87,
                      ),
                    ),
                    Text(
                      parkingLot.liveDate ?? "Unknown",
                      style: const TextStyle(
                        fontSize: 14.0,
                        color: Colors.blueGrey,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4.0),
                Row(
                  children: [
                    const Text(
                      'Size:  ',
                      style: TextStyle(
                        fontSize: 14.0,
                        color: Colors.black87,
                      ),
                    ),
                    Text(
                      '${parkingLot.size}',
                      style: const TextStyle(
                        fontSize: 14.0,
                        color: Colors.blueGrey,
                      ),
                    ),
                    const SizedBox(width: 20.0),
                    const Text(
                      'Type:  ',
                      style: TextStyle(
                        fontSize: 14.0,
                        color: Colors.black87,
                      ),
                    ),
                    Text(
                      parkingLot.type,
                      style: const TextStyle(
                        fontSize: 14.0,
                        color: Colors.blueGrey,
                      ),
                    ),
                    const SizedBox(width: 20.0),
                    const Text(
                      'Status:  ',
                      style: TextStyle(
                        fontSize: 14.0,
                        color: Colors.black87,
                      ),
                    ),
                    Text(
                      parkingLot.status,
                      style: const TextStyle(
                        fontSize: 14.0,
                        color: Colors.blueGrey,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
