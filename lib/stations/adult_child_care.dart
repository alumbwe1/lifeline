// stations_page.dart
import 'package:flutter/material.dart';
import '../classes/adult_child_care.dart';
import '../components/back_arrow.dart';
import '../components/seach_bar.dart' as CustomSearchBar;
import '../core/station_card.dart';
import '../core/bottom_sheet.dart';

class AdultChildCarePage extends StatefulWidget {
  AdultChildCarePage({Key? key}) : super(key: key);

  @override
  _AdultChildCarePageState createState() => _AdultChildCarePageState();
}

class _AdultChildCarePageState extends State<AdultChildCarePage> {
  List<AdultChildCare> displayedAdultChildCare = [];
  TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    displayedAdultChildCare = allAdults;
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
                      titleSearch: 'Seach in Adult child care for stations',
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
      displayedAdultChildCare = allAdults
          .where((AdultChildCare) =>
              AdultChildCare.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  Widget _buildStationList() {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        children: displayedAdultChildCare.isEmpty
            ? [
                const SizedBox(height: 16),
                const Text('No results found'),
              ]
            : displayedAdultChildCare.map((AdultChildCare) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CustomStationCard(
                    name: AdultChildCare.name,
                    imagePath: AdultChildCare.imagePath,
                    phoneNumber: AdultChildCare.phoneNumber,
                    onPressed: () {
                      _handleServiceRequest(AdultChildCare);
                    },
                  ),
                );
              }).toList(),
      ),
    );
  }

  void _handleServiceRequest(AdultChildCare AdultChildCare) {
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
          phoneNumber: AdultChildCare.phoneNumber,
          onPressed: () {
            _showServiceRequestedDialog(AdultChildCare);
          },
        );
      },
    );
  }

  void _showServiceRequestedDialog(AdultChildCare AdultChildCare) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Service Requested'),
          content:
              Text('You have requested service from ${AdultChildCare.name}.'),
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
