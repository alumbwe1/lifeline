import 'package:flutter/material.dart';

class SearchBar extends StatelessWidget {
  final TextEditingController controller;
  final Function(String) onSearch;
  final String titleSearch;
  final double width;
  final double height;

  const SearchBar({
    Key? key,
    required this.controller,
    required this.onSearch,
    required this.titleSearch,
    this.width = 230, // Set a default value for width (full width)
    this.height = 50.0, // Set a default value for height
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 2),
      child: SizedBox(
        width: width,
        height: height,
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: controller,
                style: const TextStyle(color: Colors.black),
                onChanged: (value) {
                  onSearch(value);
                },
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(vertical: 8),
                  hintText: titleSearch,
                  prefixIcon: const Icon(
                    Icons.search,
                    color: Colors.grey,
                  ),
                  hintStyle: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
                  ),
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.orange),
                    borderRadius: BorderRadius.horizontal(
                      left: Radius.circular(50),
                      right: Radius.circular(50), // Right border radius
                    ),
                  ),
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.orange),
                    borderRadius: BorderRadius.horizontal(
                      left: Radius.circular(50),
                      right: Radius.circular(50), // Right border radius
                    ),
                  ),
                ),
              ),
            ),
            if (controller.text.isNotEmpty)
              IconButton(
                icon: const Icon(Icons.clear, color: Colors.grey),
                onPressed: () {
                  controller.clear();
                  onSearch('');
                },
              ),
          ],
        ),
      ),
    );
  }
}
