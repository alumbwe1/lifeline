import 'package:flutter/material.dart';
import '../core/card_widget.dart';

class FirstAidTipsPage extends StatefulWidget {
  const FirstAidTipsPage({Key? key}) : super(key: key);

  @override
  _FirstAidTipsPageState createState() => _FirstAidTipsPageState();
}

class _FirstAidTipsPageState extends State<FirstAidTipsPage> {
  List<CardWidget> allFirstAidTips = [
    CardWidget(
      directoryName: 'MOH',
      description:
          'Take your children tomorrow in your clinics. Cholera is bad for your health. '
          'If you notice any symptoms, please seek medical attention immediately. '
          'Read more about cholera prevention and treatment on our website.',
      bodyImage: 'assets/back.jpg',
      alert: 'Hey',
    ),
    CardWidget(
      directoryName: 'Fire Safety',
      description:
          'In case of a fire emergency, remember to stay low, cover your nose and mouth with a cloth, '
          'and proceed to the nearest exit. Do not use elevators during a fire.',
      bodyImage: 'assets/fire.jpg',
      alert: 'Hey',
    ),
    CardWidget(
      directoryName: 'Fire Safety',
      description:
          'In case of a fire emergency, remember to stay low, cover your nose and mouth with a cloth, '
          'and proceed to the nearest exit. Do not use elevators during a fire.',
      bodyImage: 'assets/fire.jpg',
      alert: 'Hey',
    ),
    CardWidget(
      directoryName: 'Fire Safety',
      description:
          'In case of a fire emergency, remember to stay low, cover your nose and mouth with a cloth, '
          'and proceed to the nearest exit. Do not use elevators during a fire.',
      bodyImage: 'assets/fire.jpg',
      alert: 'Hey',
    ),
    CardWidget(
      directoryName: 'Fire Safety',
      description:
          'In case of a fire emergency, remember to stay low, cover your nose and mouth with a cloth, '
          'and proceed to the nearest exit. Do not use elevators during a fire.',
      bodyImage: 'assets/fire.jpg',
      alert: 'Hey',
    ),
    CardWidget(
      directoryName: 'Fire Safety',
      description:
          'In case of a fire emergency, remember to stay low, cover your nose and mouth with a cloth, '
          'and proceed to the nearest exit. Do not use elevators during a fire.',
      bodyImage: 'assets/fire.jpg',
      alert: 'Hey',
    ),
    // Add more CardWidgets as needed
  ];

  List<CardWidget> filteredFirstAidTips = [];
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    searchController.addListener(searchListener);
    filteredFirstAidTips =
        allFirstAidTips; // Initialize filteredFirstAidTips with allFirstAidTips
  }

  void searchListener() {
    setState(() {
      filteredFirstAidTips = allFirstAidTips
          .where((tip) =>
              tip.directoryName
                  .toLowerCase()
                  .contains(searchController.text.toLowerCase()) ||
              tip.description
                  .toLowerCase()
                  .contains(searchController.text.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: _buildSearchBar(),
      ),
      body: Center(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: filteredFirstAidTips.isNotEmpty
                ? filteredFirstAidTips.map((tip) => tip as Widget).toList()
                : allFirstAidTips.map((tip) => tip as Widget).toList(),
          ),
        ),
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        border: Border.all(
          color: Colors.orange,
          width: 2,
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: searchController,
              decoration: InputDecoration(
                hintText: "Search First Aid Tips...",
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(horizontal: 16),
              ),
              onChanged: (text) {
                // Implement your search logic here
                // For now, let's just print the text to the console
                print("Search: $text");
              },
            ),
          ),
          if (searchController.text.isNotEmpty)
            IconButton(
              icon: Icon(Icons.clear),
              onPressed: () {
                searchController.clear();
                // Implement your clear search logic if needed
              },
            ),
        ],
      ),
    );
  }
}

class DescriptionPage extends StatelessWidget {
  final String directoryName;
  final String description;
  final String bodyImage;
  final String alert;

  DescriptionPage({
    required this.directoryName,
    required this.description,
    required this.bodyImage,
    required this.alert,
    required String title,
    required String uploadedBy,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            child: Image.asset(
              bodyImage,
              width: double.infinity,
              height: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            top: 40,
            left: 16,
            child: IconButton(
              icon: Icon(Icons.arrow_back_ios),
              onPressed: () {
                Navigator.pop(context);
              },
              color: Colors.white,
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
              ),
              // Ensure that your bottom sheet has constraints
              // and is not relying on infinite dimensions.
              // You might consider using specific heights for children.
              height: 400, // Adjust the height as needed
              child: _buildBottomSheet(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomSheet() {
    return SingleChildScrollView(
      // Ensure that SingleChildScrollView has constraints and
      // is not in a context where it can have infinite dimensions.
      child: Container(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Icon(Icons.person, size: 40),
                SizedBox(width: 16),
                Text(
                  directoryName,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
            SizedBox(height: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  alert,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 30),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
