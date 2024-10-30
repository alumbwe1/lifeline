import 'package:flutter/material.dart';

import 'description_page.dart';

class AlertsPage extends StatefulWidget {
  const AlertsPage({Key? key}) : super(key: key);

  @override
  State<AlertsPage> createState() => _AlertsPageState();
}

class _AlertsPageState extends State<AlertsPage> {
  List<CardWidget> allAlerts = [
    CardWidget(
      directoryName: 'MOH',
      description:
          'Take your children tomorrow in your clinics. Cholera is bad for your health. '
          'Report any criminal by dialing 7070. Cybersecurity is everyone\'s responsibility. '
          'Protect your online identity and be cautious about sharing personal information. '
          'Report any criminal by dialing 7070. Cybersecurity is everyone\'s responsibility. '
          'Protect your online identity and be cautious about sharing personal information. '
          'If you notice any symptoms, please seek medical attention immediately. '
          'Read more about cholera prevention and treatment on our website.',
      alert: 'Polio Alert',
      bodyImage: 'assets/back.jpg',
    ),
    CardWidget(
      directoryName: 'Police',
      description:
          'Report any criminal near the police station. Stay alert and stay safe! '
          'If you witness any suspicious activity, contact your local authorities immediately. '
          'Read more about crime prevention on our website.',
      alert: 'Robbers Alert in Chirundu',
      bodyImage: 'assets/back.jpg',
    ),
    CardWidget(
      directoryName: 'Zicta',
      description:
          'Report any criminal by dialing 7070. Cybersecurity is everyone\'s responsibility. '
          'Protect your online identity and be cautious about sharing personal information. '
          'Read more about cybersecurity tips on our website.',
      alert: 'Cyber Alert',
      bodyImage: 'assets/back.jpg',
    ),
    CardWidget(
      directoryName: 'Zicta',
      description:
          'Report any criminal by dialing 7070. Cybersecurity is everyone\'s responsibility. '
          'Protect your online identity and be cautious about sharing personal information. '
          'Report any criminal by dialing 7070. Cybersecurity is everyone\'s responsibility. '
          'Protect your online identity and be cautious about sharing personal information. '
          'Read more about cybersecurity tips on our website.',
      alert: 'Cyber Alert',
      bodyImage: 'assets/back.jpg',
    ),
    CardWidget(
      directoryName: 'Zicta',
      description:
          'Report any criminal by dialing 7070. Cybersecurity is everyone\'s responsibility. '
          'Protect your online identity and be cautious about sharing personal information. '
          'Read more about cybersecurity tips on our website.',
      alert: 'Cyber Alert',
      bodyImage: 'assets/back.jpg',
    ),
    CardWidget(
      directoryName: 'Zicta',
      description:
          'Report any criminal by dialing 7070. Cybersecurity is everyone\'s responsibility. '
          'Protect your online identity and be cautious about sharing personal information. '
          'Read more about cybersecurity tips on our website.',
      alert: 'Cyber Alert',
      bodyImage: 'assets/back.jpg',
    ),
  ];

  List<CardWidget> filteredAlerts = [];
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    searchController.addListener(searchListener);
    filteredAlerts = allAlerts; // Initialize filteredAlerts with allAlerts
  }

  void searchListener() {
    setState(() {
      filteredAlerts = allAlerts
          .where((alert) =>
              alert.directoryName
                  .toLowerCase()
                  .contains(searchController.text.toLowerCase()) ||
              alert.alert
                  .toLowerCase()
                  .contains(searchController.text.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            IconButton(
              icon: Icon(Icons.arrow_back_ios),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            Expanded(
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 8),
                decoration: BoxDecoration(
                  color: Colors.white,
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
                          hintText: "Search Alerts...",
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(horizontal: 16),
                        ),
                      ),
                    ),
                    if (searchController.text.isNotEmpty)
                      IconButton(
                        icon: Icon(Icons.clear),
                        onPressed: () {
                          searchController.clear();
                          searchListener(); // Trigger search on clearing
                        },
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: filteredAlerts.isNotEmpty
                ? filteredAlerts.map((alert) => alert as Widget).toList()
                : allAlerts.map((alert) => alert as Widget).toList(),
          ),
        ),
      ),
    );
  }
}

class AlertSearch extends SearchDelegate<CardWidget> {
  final List<CardWidget> allAlerts;

  AlertSearch(this.allAlerts);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      if (query.isNotEmpty)
        IconButton(
          icon: Icon(Icons.clear),
          onPressed: () {
            query = '';
          },
        ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back_ios),
      onPressed: () {},
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return _buildResults();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return _buildResults();
  }

  Widget _buildResults() {
    final List<CardWidget> results = allAlerts
        .where((alert) =>
            alert.directoryName.toLowerCase().contains(query.toLowerCase()) ||
            alert.alert.toLowerCase().contains(query.toLowerCase()))
        .toList();

    return SingleChildScrollView(
      child: Column(
        children: results.isNotEmpty
            ? results.map((result) => result as Widget).toList()
            : [Text('No results')],
      ),
    );
  }
}

class ExpandableText extends StatefulWidget {
  final String text;

  ExpandableText({required this.text});

  @override
  _ExpandableTextState createState() => _ExpandableTextState();
}

class _ExpandableTextState extends State<ExpandableText> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.text,
          maxLines: isExpanded ? null : 1,
          overflow: TextOverflow.ellipsis,
        ),
        SizedBox(height: 5),
        GestureDetector(
          onTap: () {
            setState(() {
              isExpanded = !isExpanded;
            });
          },
          child: Text(
            isExpanded ? 'Read less' : 'Read more',
            style: TextStyle(
              color: Colors.blue,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}

class CardWidget extends StatelessWidget {
  final String directoryName;
  final String description;
  final String bodyImage;
  final String alert;

  const CardWidget({
    Key? key,
    required this.directoryName,
    required this.description,
    required this.bodyImage,
    required this.alert,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DescriptionPage(
              directoryName: directoryName,
              description: description,
              alert: alert,
              bodyImage: bodyImage,
            ),
          ),
        );
      },
      child: Column(
        children: [
          Divider(
            thickness: 0,
            color: Colors.grey,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Text(
                        description,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                width: 3,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Image.asset(
                    bodyImage,
                    width: 120,
                    height: 90,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
