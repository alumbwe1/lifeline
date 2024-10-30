import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import '../core/service_card.dart';
import '../menu/about.dart';
import '../menu/settings.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: const SelectService(
        username: 'YourUsernameHere',
      ),
      drawer: _buildDrawer(context),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      title: Row(
        children: [
          Builder(
            builder: (context) => GestureDetector(
              onTap: () {
                Scaffold.of(context).openDrawer();
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image.asset(
                      'assets/menu_icon.png', // Replace with your custom menu icon
                      width: 30,
                      height: 30,
                    ),
                  ],
                ),
              ),
            ),
          ),
          const Spacer(),
          Builder(builder: (context) {
            return GestureDetector(
              onTap: () {
                Scaffold.of(context).openDrawer();
              },
              child: const CircleAvatar(
                radius: 19,
                backgroundColor: Colors.orange,
                child: CircleAvatar(
                  radius: 15,
                  backgroundImage: AssetImage('assets/alumbwe.jpg'),
                ),
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildDrawer(BuildContext context) {
    return Drawer(
      child: Stack(
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                SizedBox(
                  height: 30,
                ),
                Center(
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      CircleAvatar(
                        radius: 80,
                        backgroundImage: AssetImage('assets/back.jpg'),
                      ),
                      Positioned(
                        bottom: 0,
                        child: const Text(
                          'Lifeline',
                          style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'Roboto',
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                _buildDrawerItem(
                  icon:
                      'assets/info.png', // Replace with your custom about icon
                  label: 'About Us',
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AboutUsPage()),
                    );
                  },
                ),
                _buildDrawerItem(
                  icon:
                      'assets/information.png', // Replace with your custom help icon
                  label: 'Help',
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SettingsPage()),
                    );
                  },
                ),
                _buildDrawerItem(
                  icon:
                      'assets/share.png', // Replace with your custom share icon
                  label: 'Share',
                  onTap: () {
                    Navigator.pop(context);
                    _shareApp();
                  },
                ),
                _buildDrawerItem(
                  icon:
                      'assets/feedback.png', // Replace with your custom feedback icon
                  label: 'Feedback',
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDrawerItem({
    required String icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Image.asset(
        icon,
        width: 24,
        height: 24,
        color: Colors.black,
      ),
      title: Text(
        label,
        style: const TextStyle(color: Colors.black),
      ),
      onTap: onTap,
    );
  }

  void _shareApp() {
    Share.share(
      'Check out the Lifeline app! It helps you in emergencies.',
      subject: 'Lifeline App',
    );
  }
}
