import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: ScannerScreen(),
  ));
}

class ScannerScreen extends StatefulWidget {
  @override
  _ScannerScreenState createState() => _ScannerScreenState();
}

class _ScannerScreenState extends State<ScannerScreen> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController? controller;
  bool flashOn = false;
  String? scannedData;
  int _selectedIndex = 0;

  final List<Map<String, dynamic>> _items = [
    {'icon': Icons.home, 'label': 'Home'},
    {'icon': Icons.task, 'label': 'Tasks'},
    {'icon': Icons.mail, 'label': 'Mail'},
    {'icon': Icons.person, 'label': 'Profile'},
  ];

  @override
  void reassemble() {
    super.reassemble();
    if (controller != null) {
      controller!.pauseCamera();
      controller!.resumeCamera();
    }
  }

  @override
  void dispose() {
    controller?.stopCamera();
    controller?.dispose();
    super.dispose();
  }

  void _toggleFlash() async {
    await controller?.toggleFlash();
    final status = await controller?.getFlashStatus();
    setState(() {
      flashOn = status ?? false;
    });
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        scannedData = scanData.code;
      });
    });
  }

  Widget _buildBottomBar() {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(_items.length, (index) {
          final isSelected = _selectedIndex == index;
          return GestureDetector(
            onTap: () {
              setState(() {
                _selectedIndex = index;
              });
              // Add navigation logic here if needed
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: isSelected
                    ? Colors.blue.withOpacity(0.1)
                    : Colors.transparent,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    _items[index]['icon'],
                    size: isSelected ? 45 : 40,
                    color: isSelected ? Colors.blue : Colors.black,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    _items[index]['label'],
                    style: TextStyle(
                      color: isSelected ? Colors.blue : Colors.black,
                      fontWeight:
                      isSelected ? FontWeight.bold : FontWeight.normal,
                    ),
                  )
                ],
              ),
            ),
          );
        }),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          QRView(
            key: qrKey,
            onQRViewCreated: _onQRViewCreated,
            overlay: QrScannerOverlayShape(
              borderColor: Colors.blue,
              borderRadius: 8,
              borderLength: 20,
              borderWidth: 18,
              cutOutSize: 250,
            ),
          ),
          Column(
            children: [
              const SizedBox(height: 60),
              const Center(
                child: Text(
                  'Place the QR Code properly inside the area\nScanning will start automatically',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ),
              const Spacer(),
              IconButton(
                icon: Icon(
                  flashOn ? Icons.flash_on : Icons.flash_off,
                  color: Colors.white,
                  size: 36,
                ),
                onPressed: _toggleFlash,
              ),
              const SizedBox(height: 200),
            ],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: _buildBottomBar(),
          ),
        ],
      ),
    );
  }
}
