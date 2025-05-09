import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView( // Added SingleChildScrollView
          child: Column(
            children: [
              CreditLimitScreen(),
              const SizedBox(height: 20),
              PrimarySaleScreen(),
              const SizedBox(height: 20),
              SecondarySaleScreen(),
              const SizedBox(height: 20),
              MyNetworkScreen(),
            ],
          ),
        ),
      ),
    );
  }
}

class SecondarySaleScreen extends StatefulWidget {
  const SecondarySaleScreen({super.key});

  @override
  _SecondarySaleScreenState createState() => _SecondarySaleScreenState();
}

class _SecondarySaleScreenState extends State<SecondarySaleScreen> {
  // Sample data for the chart.  In a real app, this would come from your data source.
  final List<ChartData> _chartData = [
    ChartData('WC', 0.4),
    ChartData('WCP', 0.5),
    ChartData('VAP', 0.3),
    ChartData('Primer', 0.6),
    ChartData('Water Proofing', 0.2),
    ChartData('Distemper', 0.7),
  ];

  // List of product names
  final List<String> _productNames = [
    'WC',
    'WCP',
    'VAP',
    'Primer',
    'Water Proofing Compound', // Changed to match the screenshot
    'Distemper',
  ];

  //Tooltip behavior
  final TooltipBehavior _tooltipBehavior = TooltipBehavior(enable: true);

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Secondary Sale',
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 20.0),
          Container(
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              children: [
                // Top side: Line Chart
                SizedBox(
                  height: 200,
                  child: SfCartesianChart(
                    tooltipBehavior: _tooltipBehavior, //Added tooltip
                    primaryXAxis: CategoryAxis(
                      // labelsPlacement: LabelsPlacement.outside,
                      labelRotation: 0,
                    ),
                    primaryYAxis: NumericAxis(minimum: 0, maximum: 1),
                    series: <LineSeries<ChartData, String>>[
                      LineSeries<ChartData, String>(
                        dataSource: _chartData,
                        xValueMapper: (ChartData data, _) => data.x,
                        yValueMapper: (ChartData data, _) => data.y,
                        dataLabelSettings: const DataLabelSettings(isVisible: true),
                        markerSettings: const MarkerSettings(isVisible: true),
                      )
                    ],
                  ),
                ),

                // Space between chart and product names
                const SizedBox(height: 20),

                // Bottom side: Product Names and Values
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: _productNames.map((productName) {
                    // Get the corresponding data value from _chartData
                    double dataValue = _chartData.firstWhere(
                          (data) => data.x == productName,
                      orElse: () => ChartData(productName, 0.0), // Default value if not found
                    ).y;

                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween, // Space between name and value
                        children: [
                          Text(
                            productName,
                            style: const TextStyle(fontSize: 14.0, color: Colors.black),
                          ),
                          Text(
                            dataValue.toStringAsFixed(3), // Format the value
                            style: const TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold, color: Colors.black),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Represents the data for the chart
class ChartData {
  ChartData(this.x, this.y);

  final String x;
  final double y;
}



class PrimarySaleScreen extends StatefulWidget {
  const PrimarySaleScreen({super.key});

  @override
  _PrimarySaleScreenState createState() => _PrimarySaleScreenState();
}

class _PrimarySaleScreenState extends State<PrimarySaleScreen> {
  // Sample data for the chart.  In a real app, this would come from your data source.
  final List<ChartData> _chartData = [
    ChartData('WC', 0.4),
    ChartData('WCP', 0.5),
    ChartData('VAP', 0.3),
    ChartData('Primer', 0.6),
    ChartData('Water Proofing', 0.2),
    ChartData('Distemper', 0.7),
  ];

  // List of product names
  final List<String> _productNames = [
    'WC',
    'WCP',
    'VAP',
    'Primer',
    'Water Proofing Compound',
    'Distemper',
  ];

  //Tooltip Behavior
  final TooltipBehavior _tooltipBehavior = TooltipBehavior(enable: true);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
        const Text(
        'Primary Sale', // Changed title
        style: TextStyle(
          fontSize: 20.0,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
      const SizedBox(height: 20.0),
      Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10.0),
            boxShadow: [
        BoxShadow(
        color: Colors.grey.withOpacity(0.3),
        spreadRadius: 2,
        blurRadius: 5,
        offset: const Offset(0, 2),
      ),
      ]),
      child: Column(
        children: [
          // Top side: Scatter Chart
          SizedBox(
            height: 200,
            child: SfCartesianChart( // Changed to Scatter Chart
              tooltipBehavior: _tooltipBehavior,
              primaryXAxis: CategoryAxis(
                // labelsPlacement: LabelsPlacement.outside,
                labelRotation: 0,
              ),
              primaryYAxis: NumericAxis(minimum: 0, maximum: 1),
              series: <ScatterSeries<ChartData, String>>[ // Changed to ScatterSeries
                ScatterSeries<ChartData, String>(
                  dataSource: _chartData,
                  xValueMapper: (ChartData data, _) => data.x,
                  yValueMapper: (ChartData data, _) => data.y,
                  markerSettings: const MarkerSettings(
                      height: 10,
                      width: 10,
                      isVisible: true
                  ),
                )
              ],
            ),
          ),
          // Space between chart and product names
          const SizedBox(height: 20),
          // Bottom side: Product Names and Values
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: _productNames.map((productName) {
              // Get the corresponding data value from _chartData
              double dataValue = _chartData.firstWhere(
                    (data) => data.x == productName,
                orElse: () => ChartData(productName, 0.0), // Default value if not found
              ).y;

              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      productName,
                      style: const TextStyle(fontSize: 14.0, color: Colors.black),
                    ),
                    Text(
                      dataValue.toStringAsFixed(3),
                      style: const TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold, color: Colors.black),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ],
      ),
    ),
    ],
    ),
    );
  }
}

// Represents the data for the chart.
class ChartData1 {
  ChartData1(this.x, this.y);

  final String x;
  final double y;
}

class MyNetworkScreen extends StatelessWidget {
  const MyNetworkScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // "My Network" Section
          const Text(
            "My Network",
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 10),
          // Container for Total Retailer and Billed info
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: const [
                BoxShadow(
                  color: Colors.grey,
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Total Retailer",
                        style: TextStyle(fontSize: 16, color: Colors.black),
                      ),
                      const SizedBox(height: 5),
                      const Text(
                        "173",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Total Unique Billed",
                        style: TextStyle(fontSize: 16, color: Colors.black),
                      ),
                      const SizedBox(height: 5),
                      const Text(
                        "0",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          // Product-wise billing information
          const Text(
            "Billing Details", // Added a title for this section
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: const [
                BoxShadow(
                  color: Colors.grey,
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildProductBillingRow("WC", 0),
                _buildProductBillingRow("WCP", 0),
                _buildProductBillingRow("VAP", 0),
                _buildProductBillingRow("Primer", 0),
                _buildProductBillingRow("Water Proofing Compound", 0),
                _buildProductBillingRow("Distemper", 0),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Helper method to build a row for product billing
  static Widget _buildProductBillingRow(String productName, int billedCount) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            productName,
            style: const TextStyle(fontSize: 16, color: Colors.black),
          ),
          Text(
            billedCount.toString(),
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}

class CreditLimitScreen extends StatelessWidget {
  const CreditLimitScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Credit Limit Section Title
          const Text(
            "Credit Limit",
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 10),
          // Credit Limit Container
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: const [
                BoxShadow(
                  color: Colors.grey,
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Balance Limit",
                        style: TextStyle(fontSize: 16, color: Colors.black),
                      ),
                      const SizedBox(height: 5),
                      const Text(
                        "0", // Hardcoded value from image
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildCreditInfoRow("Credit Limit", 0),
                      _buildCreditInfoRow("Open Billing", 0),
                      _buildCreditInfoRow("Open Order", 0),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Helper method to build a row for credit information
  static Widget _buildCreditInfoRow(String title, int value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 16, color: Colors.blueGrey), //Using a color that looks close to the image
          ),
          Text(
            value.toString(),
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}

