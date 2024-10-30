// stations_page.dart
import 'package:flutter/material.dart';
import '../classes/firebrigade.dart';
import '../components/back_arrow.dart';
import '../components/seach_bar.dart' as CustomSearchBar;
import '../core/station_card.dart';
import '../core/bottom_sheet.dart';

class FireBrigadePage extends StatefulWidget {
  FireBrigadePage({Key? key}) : super(key: key);

  @override
  _FireBrigadePageState createState() => _FireBrigadePageState();
}

class _FireBrigadePageState extends State<FireBrigadePage> {
  List<Firebrigade> displayedFirebrigade = [];
  TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    displayedFirebrigade = allStations;
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
                      titleSearch: 'Search for firebrigade stations',
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
      displayedFirebrigade = allStations
          .where((Firebrigade) =>
              Firebrigade.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  Widget _buildStationList() {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        children: displayedFirebrigade.isEmpty
            ? [
                const SizedBox(height: 16),
                const Text('No results found'),
              ]
            : displayedFirebrigade.map((Firebrigade) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CustomStationCard(
                    name: Firebrigade.name,
                    imagePath: Firebrigade.imagePath,
                    phoneNumber: Firebrigade.phoneNumber,
                    onPressed: () {
                      _handleServiceRequest(Firebrigade);
                    },
                  ),
                );
              }).toList(),
      ),
    );
  }

  void _handleServiceRequest(Firebrigade Firebrigade) {
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
          phoneNumber: Firebrigade.phoneNumber,
          onPressed: () {
            _showServiceRequestedDialog(Firebrigade);
          },
        );
      },
    );
  }

  void _showServiceRequestedDialog(Firebrigade Firebrigade) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Service Requested'),
          content: Text('You have requested service from ${Firebrigade.name}.'),
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
