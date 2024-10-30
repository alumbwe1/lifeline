import 'package:flutter/material.dart';
import '../classes/police.dart';
import '../components/back_arrow.dart';
import '../components/seach_bar.dart' as CustomSearchBar;
import '../core/station_card.dart';
import '../core/bottom_sheet.dart';

class StationsPage extends StatefulWidget {
  StationsPage({Key? key}) : super(key: key);

  @override
  _StationsPageState createState() => _StationsPageState();
}

class _StationsPageState extends State<StationsPage> {
  List<Station> displayedStations = [];
  TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    displayedStations = allStations;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SafeArea(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const BackArrow(),
                    CustomSearchBar.SearchBar(
                      controller: _searchController,
                      onSearch: _search,
                      titleSearch: 'Search for Ambulance stations',
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: _buildStationList(),
          ),
        ],
      ),
    );
  }

  void _search(String query) {
    setState(() {
      displayedStations = allStations
          .where((station) =>
          station.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  Widget _buildStationList() {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        children: displayedStations.isEmpty
            ? [
          const SizedBox(height: 16),
          const Text('No results found'),
        ]
            : displayedStations.map((station) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: CustomStationCard(
              name: station.name,
              imagePath: station.imagePath,
              phoneNumber: station.phoneNumber,
              onPressed: () {
                _handleServiceRequest(station);
              },
            ),
          );
        }).toList(),
      ),
    );
  }

  void _handleServiceRequest(Station station) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(40),
          topRight: Radius.circular(40),
        ),
      ),
      builder: (BuildContext context) {
        return ServiceRequestBottomSheet(
          phoneNumber: station.phoneNumber,
          onPressed: () {
            _showServiceRequestedDialog(station);
          },
        );
      },
    );
  }

  void _showServiceRequestedDialog(Station station) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Service Requested'),
          content: Text('You have requested service from ${station.name}.'),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
