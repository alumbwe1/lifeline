class AdultChildCare {
  final String name;
  final String phoneNumber;
  final String location;
  final String imagePath;

  AdultChildCare({
    required this.name,
    required this.phoneNumber,
    required this.location,
    required this.imagePath,
  });
}

final List<AdultChildCare> allAdults = [
  AdultChildCare(
    name: 'Chirundu1',
    phoneNumber: '123-456-7890',
    location: 'Chirundu',
    imagePath: 'assets/Police1.jpg',
  ),
  AdultChildCare(
    name: 'Kalingalinga',
    phoneNumber: '987-654-3210',
    location: 'Lusaka',
    imagePath: 'assets/back.jpg',
  ),
  AdultChildCare(
    name: 'Kalingalinga',
    phoneNumber: '987-654-3210',
    location: 'Lusaka',
    imagePath: 'assets/fire.jpg',
  ),
];
