import 'package:flutter/material.dart';
import '../pages/first_aid_tips_page.dart';

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
        _navigateToDetailsPage(context);
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
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
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

  void _navigateToDetailsPage(BuildContext context) {
    // Implement navigation to details page here
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DescriptionPage(
          directoryName: directoryName,
          description: description,
          alert: alert,
          bodyImage: bodyImage,
          title: 'Hey',
          uploadedBy: 'Red Cross',
        ),
      ),
    );
  }
}
