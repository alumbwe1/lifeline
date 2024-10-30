import 'package:flutter/material.dart';
import 'package:lifeline_zm/pages/first_aid_tips_page.dart';
import 'package:lifeline_zm/stations/firebrigade_station.dart';
import '../pages/alerts_page.dart';
import '../stations/adult_child_care.dart';
import '../stations/ambulance_stations.dart';

import '../stations/more_stations.dart';
import '../stations/police_stations.dart';

class CustomService {
  final String name;
  final String imageAsset;
  final Widget page;

  CustomService(this.name, this.imageAsset, this.page);
}

class SelectService extends StatefulWidget {
  final String username;

  const SelectService({Key? key, required this.username}) : super(key: key);

  @override
  _SelectServiceState createState() => _SelectServiceState();
}

class _SelectServiceState extends State<SelectService> {
  List<CustomService> services = [
    CustomService('Police', 'assets/download.png', StationsPage()),
    CustomService('Ambulance', 'assets/ambula.png', AmbulancePage()),
    CustomService(
        'Adult & Child Care', 'assets/child.jpeg', AdultChildCarePage()),
    CustomService('Fire Brigade', 'assets/fire.jpg', FireBrigadePage()),
    CustomService('Alerts', 'assets/alert.png', AlertsPage()),
    CustomService('First Aid Tips', 'assets/firstaid.jpg',
        FirstAidTipsPage()), // Replace with the actual page
    CustomService('More', 'assets/service.jpg', MorePage()),
  ];

  int selectedServiceIndex = -1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: selectedServiceIndex >= 0
          ? FloatingActionButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            services[selectedServiceIndex].page));
              },
              backgroundColor: Colors.blue,
              child: const Icon(Icons.arrow_forward_ios, size: 20),
            )
          : null,
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 50.0, right: 20.0, left: 20.0),
              child: Text(
                'Which service \ndo you need?',
                style: TextStyle(
                  fontSize: 25,
                  fontFamily: 'Roboto',
                  color: Colors.black, // Change color as needed
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 20.0),
            SizedBox(
              height: 280.0,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: services.length,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedServiceIndex =
                            selectedServiceIndex == index ? -1 : index;
                      });
                    },
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                      transform: Matrix4.identity()
                        ..scale(selectedServiceIndex == index ? 1.05 : 1.0),
                      margin: const EdgeInsets.only(right: 20.0),
                      padding: const EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Colors.white,
                            Colors.grey.shade300,
                          ],
                        ),
                        border: Border.all(
                          color: selectedServiceIndex == index
                              ? Colors.blue
                              : Colors.transparent,
                          width: 2.0,
                        ),
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          CircleAvatar(
                            radius: 100,
                            backgroundImage: AssetImage(
                              services[index].imageAsset,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            services[index].name,
                            style: const TextStyle(
                              fontSize: 17,
                              fontFamily: 'Roboto',
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
