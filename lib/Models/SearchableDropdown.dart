import 'package:flutter/material.dart';
import 'package:dropdown_search/dropdown_search.dart';

class SearchableDropdownExample extends StatelessWidget {
  final List<String> items; // Declare the items list as a class property

  // Constructor to pass items into the widget
  const SearchableDropdownExample({Key? key, required this.items}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: DropdownSearch<String>(
        items: items, // Use the passed items list
        popupProps: PopupProps.menu(
          showSearchBox: true,
          searchFieldProps: TextFieldProps(
            decoration: InputDecoration(
              hintText: "Search...",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
            ),
          ),
        ),
        dropdownDecoratorProps: DropDownDecoratorProps(
          dropdownSearchDecoration: InputDecoration(
            labelText: "Select an item",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
          ),
        ),
        onChanged: (value) {
          print("Selected: $value");
        },
      ),
    );
  }
}
