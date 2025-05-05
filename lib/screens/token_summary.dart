import 'package:flutter/material.dart';
import 'package:learning2/screens/token_details.dart';
import 'package:learning2/screens/token_summary_model.dart';

class TokenSummaryScreen extends StatefulWidget {
  final String activeTab;
  const TokenSummaryScreen({super.key, this.activeTab = 'Summary'});

  @override
  State<TokenSummaryScreen> createState() => _TokenSummaryScreenState();
}

class _TokenSummaryScreenState extends State<TokenSummaryScreen> {
  late TokenSummaryModel summary;

  @override
  void initState() {
    super.initState();
    summary = TokenSummaryModel();
  }

  @override
  Widget build(BuildContext context) {
    // Re-fetch the summary so it reflects changes
    summary = TokenSummaryModel();

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
          _buildTopNav(context, widget.activeTab),
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
                    child: _buildSummaryTable(),
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
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
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

  Widget _buildSummaryTable() {
    return Table(
      border: TableBorder.all(color: Colors.grey.shade400),
      children: [
        _buildTableRow('Total Scan', summary.totalScan.toString(), Colors.blue),
        _buildTableRow('Valid Scan', summary.validScan.toString(), Colors.green),
        _buildTableRow('Expired Scan', summary.expiredScan.toString(), Colors.orange),
        _buildTableRow('Already Scanned', summary.alreadyScanned.toString(), Colors.deepPurple),
        _buildTableRow('Invalid Scan', summary.invalidScan.toString(), Colors.red),
        _buildTableRow('Total Amount', summary.totalAmount.toString(), Colors.black),
      ],
    );
  }

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