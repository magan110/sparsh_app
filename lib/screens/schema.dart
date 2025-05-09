import 'package:flutter/material.dart';
import 'package:learning2/Models/SearchableDropdown.dart'; // Assuming these are correctly implemented
import 'package:learning2/Models/TextModel.dart';       // and available.  If not, you'll need to
import '../Models/DatePickerTextField.dart';     // provide the code for these as well.
import '../Models/SearchField.dart';           //

class Schema extends StatefulWidget {
  const Schema({super.key});

  @override
  State<Schema> createState() => _SchemaState();
}

class _SchemaState extends State<Schema> {
  final TextEditingController controller = TextEditingController();
  final List<String> types = ['Scheme Period Date', 'Account Ledger wise Date'];
  final List<Map<String, String>> _tableData = [
    {
      'Primary/Secondary Scheme': '',
      'Scheme No.': '',
      'Sparsh Scheme No': '',
      'Scheme Name': '',
      'Scheme Value': '',
      'Adjustment Amount': '',
      'CN / DN Value': '',
      'Posting Date': '',
      'CN / DN Document No': '',
    },
  ];

  // Added a function to build styled text for consistent labels.
  Widget _buildStyledText(String text) {
    return Text(
      text,
      style: const TextStyle(
        fontWeight: FontWeight.w500, // Medium font weight for labels
        color: Color(0xFF555555),  // Darker gray for better readability
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA), // Consistent background color
      appBar: AppBar(
        title: const Text(
          'Scheme Details',
          style: TextStyle(fontWeight: FontWeight.w600), // Medium-bold title
        ),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        elevation: 0,
        centerTitle: true, // Center the title for better alignment
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20), // Increased padding for better spacing
        child: Column(
          children: [
            // Card container for grouped input fields
            Card(
              elevation: 5, // Slightly increased elevation for a more pronounced effect
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12), // Slightly less rounded corners
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24), // Increased horizontal padding
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildStyledText('Type'), // Using the styled text widget
                    const SizedBox(height: 12),
                    buildSearchableDropdown(context, types),
                    const SizedBox(height: 20), // Consistent spacing
                    _buildStyledText('Scheme Start Date'),
                    const SizedBox(height: 12),
                    DatePickerTextField(),
                    const SizedBox(height: 20),
                    _buildStyledText('Scheme End Date'),
                    const SizedBox(height: 12),
                    DatePickerTextField(),
                    const SizedBox(height: 20),
                    _buildStyledText('CN / DN No.'),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(child: SearchField(controller: controller)),
                        const SizedBox(width: 12),
                        ElevatedButton.icon(
                          onPressed: () {
                            // your action
                          },
                          icon: const Icon(
                            Icons.search,
                            color: Colors.white,
                          ),
                          label: const Text(
                            "Go",
                            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500), // Added font weight
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8), // Less rounded button corners
                            ),
                            elevation: 2, // Added a slight elevation to the button
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24), // Increased spacing before the table

            // Search field above the table
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildStyledText('Search'),
                      const SizedBox(height: 8),
                      SearchField(controller: controller), // Use the SearchField widget
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            // Display the table
            _buildTable(),
          ],
        ),
      ),
    );
  }

  Widget _buildTable() {
    return Card(
      elevation: 5, // Increased elevation for the table card
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)), // Less rounded table corners
      child: Padding(
        padding: const EdgeInsets.all(20), // Increased padding for the table
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Scheme Data',
              style: TextStyle(
                fontSize: 20, // Slightly larger title
                fontWeight: FontWeight.w600, // Medium-bold font weight for title
                color: Color(0xFF333333), // Darker title color
              ),
            ),
            const SizedBox(height: 16), // Increased spacing
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                columnSpacing: 24, // Increased column spacing
                headingRowColor:
                MaterialStateColor.resolveWith((states) => const Color(0xFFF0F0F0)), // Lighter heading row color
                dataRowColor: MaterialStateColor.resolveWith((states) {
                  // Alternate row colors for better readability
                  if (states.contains(MaterialState.selected)) {
                    return Colors.blue.withOpacity(0.1); // Lighter selection color
                  }
                  return Color(0xFFFFFFFF); // Use default color for other rows
                }),
                border: TableBorder.all(
                  color: const Color(0xFFE0E0E0), // Lighter border color
                  borderRadius: BorderRadius.circular(8), // Rounded table border
                ),
                columns: const [
                  DataColumn(
                      label: Text('Primary/Secondary Scheme',
                          style: TextStyle(fontWeight: FontWeight.w500))), // Added font weight to headers
                  DataColumn(
                      label: Text('Scheme No.',
                          style: TextStyle(fontWeight: FontWeight.w500))),
                  DataColumn(
                      label: Text('Sparsh Scheme No',
                          style: TextStyle(fontWeight: FontWeight.w500))),
                  DataColumn(
                      label: Text('Scheme Name',
                          style: TextStyle(fontWeight: FontWeight.w500))),
                  DataColumn(
                      label: Text('Scheme Value',
                          style: TextStyle(fontWeight: FontWeight.w500))),
                  DataColumn(
                      label: Text('Adjustment Amount',
                          style: TextStyle(fontWeight: FontWeight.w500))),
                  DataColumn(
                      label: Text('CN / DN Value',
                          style: TextStyle(fontWeight: FontWeight.w500))),
                  DataColumn(
                      label: Text('Posting Date',
                          style: TextStyle(fontWeight: FontWeight.w500))),
                  DataColumn(
                      label: Text('CN / DN Document No',
                          style: TextStyle(fontWeight: FontWeight.w500))),
                ],
                rows: _tableData.map((item) {
                  return DataRow(cells: [
                    DataCell(Text(item['Primary/Secondary Scheme'] ?? '',
                        style: const TextStyle(color: Color(0xFF666666)))), // Slightly darker text
                    DataCell(Text(item['Scheme No.'] ?? '',
                        style: const TextStyle(color: Color(0xFF666666)))),
                    DataCell(Text(item['Sparsh Scheme No'] ?? '',
                        style: const TextStyle(color: Color(0xFF666666)))),
                    DataCell(Text(item['Scheme Name'] ?? '',
                        style: const TextStyle(color: Color(0xFF666666)))),
                    DataCell(Text(item['Scheme Value'] ?? '',
                        style: const TextStyle(color: Color(0xFF666666)))),
                    DataCell(Text(item['Adjustment Amount'] ?? '',
                        style: const TextStyle(color: Color(0xFF666666)))),
                    DataCell(Text(item['CN / DN Value'] ?? '',
                        style: const TextStyle(color: Color(0xFF666666)))),
                    DataCell(Text(item['Posting Date'] ?? '',
                        style: const TextStyle(color: Color(0xFF666666)))),
                    DataCell(Text(item['CN / DN Document No'] ?? '',
                        style: const TextStyle(color: Color(0xFF666666)))),
                  ]);
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

