// stations_page.dart
import 'package:flutter/material.dart';
import '../classes/more.dart';
import '../components/back_arrow.dart';
import '../components/seach_bar.dart' as CustomSearchBar;
import '../core/station_card.dart';
import '../core/bottom_sheet.dart';

class MorePage extends StatefulWidget {
  MorePage({Key? key}) : super(key: key);

  @override
  _MorePageState createState() => _MorePageState();
}

class _MorePageState extends State<MorePage> {
  List<More> displayedMore = [];
  TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    displayedMore = allStations;
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
                      titleSearch: 'Seach for any service',
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
      displayedMore = allStations
          .where(
              (More) => More.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  Widget _buildStationList() {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        children: displayedMore.isEmpty
            ? [
                const SizedBox(height: 16),
                const Text('No results found'),
              ]
            : displayedMore.map((More) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CustomStationCard(
                    name: More.name,
                    imagePath: More.imagePath,
                    phoneNumber: More.phoneNumber,
                    onPressed: () {
                      _handleServiceRequest(More);
                    },
                  ),
                );
              }).toList(),
      ),
    );
  }

  void _handleServiceRequest(More More) {
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
          phoneNumber: More.phoneNumber,
          onPressed: () {
            _showServiceRequestedDialog(More);
          },
        );
      },
    );
  }

  void _showServiceRequestedDialog(More More) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Service Requested'),
          content: Text('You have requested service from ${More.name}.'),
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
