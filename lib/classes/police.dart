class Station {
  final String name;
  final String phoneNumber;
  final String location;
  final String imagePath;

  Station({
    required this.name,
    required this.phoneNumber,
    required this.location,
    required this.imagePath,
  });
}

final List<Station> allStations = [
  Station(
    name: 'Chirundu1',
    phoneNumber: '123-456-7890',
    location: 'Chirundu',
    imagePath: 'assets/Police1.jpg',
  ),
  Station(
    name: 'Kalingalinga',
    phoneNumber: '987-654-3210',
    location: 'Lusaka',
    imagePath: 'assets/back.jpg',
  ),
  Station(
    name: 'Kalingalinga',
    phoneNumber: '987-654-3210',
    location: 'Lusaka',
    imagePath: 'assets/fire.jpg',
  ),
];
