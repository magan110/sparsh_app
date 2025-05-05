import 'package:flutter/material.dart';
import 'package:learning2/screens/token_details.dart';
import 'package:learning2/screens/token_report.dart';



class TokenSummaryScreen extends StatelessWidget {
  final String activeTab;
  const TokenSummaryScreen({super.key, this.activeTab = 'Summary'});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('Token Summary'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        children: [
          _buildTopNav(context, activeTab),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
              child: Column(
                children: [
                  // Dynamic Summary Table
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(color: Colors.grey.shade300, blurRadius: 6)
                      ],
                    ),
                    child: _buildSummaryTable(),
                  ),
                  const SizedBox(height: 40),
                  // Buttons for Close and Save
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const SizedBox(width: 10),
                      _buildButton("Close", Colors.grey, Colors.black,
                              () => Navigator.pop(context)),
                      _buildButton("Save", Colors.blue, Colors.white, () {}),
                      const SizedBox(width: 10),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Table Row for displaying summary data dynamically
  TableRow _buildTableRow(String label, String value, Color valueColor) {
    return TableRow(
      children: [
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Text(label,
              style:
              const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        ),
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Center(
            child: Text(
              value,
              style: TextStyle(
                  fontSize: 16, fontWeight: FontWeight.bold, color: valueColor),
            ),
          ),
        ),
      ],
    );
  }

  // Dynamic Summary Table
  Widget _buildSummaryTable() {
    // Simulating dynamic data
    List<Map<String, String>> summaryData = [
      {'label': 'Total Scan', 'value': '3', 'color': 'blue'},
      {'label': 'Valid Scan', 'value': '2', 'color': 'green'},
      {'label': 'Expired Scan', 'value': '0', 'color': 'green'},
      {'label': 'Already Scanned', 'value': '0', 'color': 'green'},
      {'label': 'Invalid Scan', 'value': '1', 'color': 'red'},
      {'label': 'Total Amount', 'value': '77', 'color': 'black'},
    ];

    return Table(
      border: TableBorder.all(color: Colors.grey.shade400),
      children: summaryData.map((data) {
        Color valueColor = data['color'] == 'blue'
            ? Colors.blue
            : (data['color'] == 'green' ? Colors.green : Colors.red);

        return _buildTableRow(data['label']!, data['value']!, valueColor);
      }).toList(),
    );
  }

  // Button builder with icon
  Widget _buildButton(
      String text, Color bgColor, Color textColor, VoidCallback onPressed) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: bgColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
      ),
      icon: Icon(
        text == "Close" ? Icons.close : Icons.save,
        color: textColor,
      ),
      label: Text(text, style: TextStyle(color: textColor, fontSize: 16)),
    );
  }

  // Top navigation bar with tabs for switching between screens
  Widget _buildTopNav(BuildContext context, String activeTab) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.grey.shade300,
            width: 1.0,
          ),
          borderRadius: BorderRadius.circular(8.0),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _navItem(context, 'Details', activeTab == 'Details',
                const TokenDetailsPage(activeTab: 'Details')),
            _navItem(context, 'Report', activeTab == 'Report',
                const TokenReportScreen(activeTab: 'Report')),
            _navItem(context, 'Summary', activeTab == 'Summary',
                const TokenSummaryScreen(activeTab: 'Summary')),
          ],
        ),
      ),
    );
  }

  // Navigation item for switching between tabs
  Widget _navItem(
      BuildContext context, String label, bool isActive, Widget targetPage) {
    return GestureDetector(
      onTap: () {
        if (!isActive) {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (_) => targetPage));
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isActive
              ? const Color.fromRGBO(0, 112, 183, 1)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isActive ? Colors.white : Colors.black,
            fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
