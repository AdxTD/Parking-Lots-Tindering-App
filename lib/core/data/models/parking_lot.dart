class ParkingLot {
  final String id;
  final String? image;
  final String name;
  final String address;
  final String status;
  final String? liveDate;
  final String type;
  final int size;
  bool? label;

  ParkingLot({
    this.image,
    required this.name,
    required this.address,
    required this.status,
    required this.id,
    this.liveDate,
    required this.type,
    required this.size,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'image': image,
      'name': name,
      'address': address,
      'status': status,
      'live_date': liveDate,
      'type': type,
      'size': size,
    };
  }

  factory ParkingLot.fromJson(Map<String, dynamic> map) {
    return ParkingLot(
      id: map['id'] as String,
      image: map['image'] as String?,
      name: map['name'] as String,
      address: map['address'] as String,
      status: map['status'] as String,
      liveDate: map['live_date'] as String?,
      type: map['type'] as String,
      size: map['size'] as int,
    );
  }
}
