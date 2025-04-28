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
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(color: Colors.grey.shade300, blurRadius: 6)
                      ],
                    ),
                    child: Table(
                      border: TableBorder.all(color: Colors.grey.shade400),
                      children: [
                        _buildTableRow("Total Scan", "3", Colors.blue),
                        _buildTableRow("Valid Scan", "2", Colors.green),
                        _buildTableRow("Expired Scan", "0", Colors.green),
                        _buildTableRow("Already Scanned", "0", Colors.green),
                        _buildTableRow("Invalid Scan", "1", Colors.red),
                        _buildTableRow("Total Amount", "77", Colors.black),
                      ],
                    ),
                  ),
                  const SizedBox(height: 40),
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

  Widget _buildButton(
      String text, Color bgColor, Color textColor, VoidCallback onPressed) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: bgColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
      ),
      child: Text(text, style: TextStyle(color: textColor, fontSize: 16)),
    );
  }

  Widget _buildTopNav(BuildContext context, String activeTab) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: 8, vertical: 4), // Add padding outside the border
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
        padding:
            EdgeInsets.symmetric(horizontal: 16, vertical: 8), // Add padding
        decoration: BoxDecoration(
          color: isActive
              ? Color.fromRGBO(0, 112, 183, 1)
              : Colors.transparent, // Background color
          borderRadius: BorderRadius.circular(8), // Optional: rounded corners
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isActive
                ? Colors.white
                : Colors.black, // White text when active
            fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
