class Ambulance {
  final String name;
  final String phoneNumber;
  final String location;
  final String imagePath;

  Ambulance({
    required this.name,
    required this.phoneNumber,
    required this.location,
    required this.imagePath,
  });
}

final List<Ambulance> allStations = [
  Ambulance(
    name: 'Chirundu1',
    phoneNumber: '123-456-7890',
    location: 'Chirundu',
    imagePath: 'assets/gps.png',
  ),
  Ambulance(
    name: 'Kalingalinga',
    phoneNumber: '987-654-3210',
    location: 'Lusaka',
    imagePath: 'assets/back.jpg',
  ),
  Ambulance(
    name: 'Kalingalinga',
    phoneNumber: '987-654-3210',
    location: 'Lusaka',
    imagePath: 'assets/fire.jpg',
  ),
];
