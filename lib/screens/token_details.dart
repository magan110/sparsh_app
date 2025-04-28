import 'package:flutter/material.dart';
import 'package:learning2/screens/token_report.dart';
import 'package:learning2/screens/token_summary.dart';


class TokenDetailsPage extends StatelessWidget {
  final String activeTab;

  const TokenDetailsPage({super.key, this.activeTab = 'Details'});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Token Details'),
        backgroundColor: Colors.white,
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
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  Expanded(
                    child: ListView(
                      children: [
                        _buildTokenCard('08WX1NDVTPKB', '112473052',
                            '12 Jan 2026', '35', '3.50', true, '256'),
                        _buildTokenCard('15TY8BGFWCNH', '112425634',
                            '12 Jan 2026', '35', '3.50', true, '123'),
                        _buildTokenCard(
                            'XTR9PU5RXT00', '', '', '', '', false, ''),
                        _buildTokenCard('15TY8BGFWCNH', '112425634',
                            '12 Jan 2026', '35', '3.50', true, '123'),
                      ],
                    ),
                  ),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //   children: [
                  //     const SizedBox(width: 10),
                  //     _buildButton(context, 'Close', Colors.grey,
                  //         () => Navigator.pop(context)),
                  //     _buildButton(context, 'Submit', Colors.blue, () {}),
                  //     const SizedBox(width: 10),
                  //   ],
                  // ),
                ],
              ),
            ),
          ),
        ],
      ),
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

  Widget _buildTokenCard(String token, String id, String date, String value,
      String handling, bool isValid, String pin) {
    return Card(
      shape: RoundedRectangleBorder(
        side: BorderSide(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(8.0),
      ),
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            padding:
                const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
            decoration: BoxDecoration(
              color: isValid ? Colors.blue : Colors.red,
              borderRadius: BorderRadius.circular(5.0),
            ),
            child: Text(
              token,
              style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
          ),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              color: Colors.white,
              // borderRadius: BorderRadius.circular(5.0),
            ),
            child: isValid
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(id,
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold)),
                      Text('Valid Upto - $date',
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold)),
                      Text(
                        'Value To Pay - $value',
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Handling - $handling',
                              style: const TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold)),
                          Row(
                            children: [
                              const Text('PIN',
                                  style: TextStyle(color: Colors.grey)),
                              const SizedBox(width: 5),
                              Container(
                                width: 50,
                                height: 30,
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.blue),
                                  borderRadius: BorderRadius.circular(5.0),
                                ),
                                alignment: Alignment.center,
                                child: Text(pin,
                                    style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold)),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: const Text(
                          'Accepted',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Error - XTR9PU5RXT00',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.red)),
                      const Text(
                        'Please check with IT or Company Officer',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: const Text(
                          'Rejected',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
          ),
        ],
      ),
    );
  }

  // Widget _buildButton(
  //     BuildContext context, String text, Color color, VoidCallback onPressed) {
  //   return ElevatedButton(
  //     style: ElevatedButton.styleFrom(
  //       backgroundColor: color,
  //       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
  //       padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
  //     ),
  //     onPressed: onPressed,
  //     child:
  //         Text(text, style: const TextStyle(color: Colors.white, fontSize: 16)),
  //   );
  // }
}
