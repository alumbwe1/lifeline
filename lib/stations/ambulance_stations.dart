// ambulance_page.dart
import 'package:flutter/material.dart';
import '../classes/ambulance.dart';
import '../components/back_arrow.dart';
import '../components/seach_bar.dart' as CustomSearchBar;
import '../core/station_card.dart';
import '../core/bottom_sheet.dart';

class AmbulancePage extends StatefulWidget {
  AmbulancePage({Key? key}) : super(key: key);

  @override
  _AmbulancePageState createState() => _AmbulancePageState();
}

class _AmbulancePageState extends State<AmbulancePage> {
  List<Ambulance> displayedAmbulance = [];
  TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    displayedAmbulance = allStations;
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
                      titleSearch: 'Seach for Ambulance stions',
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
      displayedAmbulance = allStations
          .where((ambulance) =>
              ambulance.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  Widget _buildStationList() {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        children: displayedAmbulance.isEmpty
            ? [
                const SizedBox(height: 16),
                const Text('No results found'),
              ]
            : displayedAmbulance.map((ambulance) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CustomStationCard(
                    name: ambulance.name,
                    imagePath: ambulance.imagePath,
                    phoneNumber: ambulance.phoneNumber,
                    onPressed: () {
                      _handleServiceRequest(ambulance);
                    },
                  ),
                );
              }).toList(),
      ),
    );
  }

  void _handleServiceRequest(Ambulance ambulance) {
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
          phoneNumber: ambulance.phoneNumber,
          onPressed: () {
            _showServiceRequestedDialog(ambulance);
          },
        );
      },
    );
  }

  void _showServiceRequestedDialog(Ambulance ambulance) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Service Requested'),
          content: Text('You have requested service from ${ambulance.name}.'),
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
