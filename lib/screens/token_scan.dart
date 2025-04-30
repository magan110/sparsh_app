import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:learning2/screens/Home_screen.dart';
import 'package:learning2/screens/token_details.dart';
import 'package:learning2/screens/token_summary.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

void main() {
  runApp(const TokenScanApp());
}

class TokenScanApp extends StatelessWidget {
  const TokenScanApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const TokenScanPage(),
    );
  }
}

class TokenScanPage extends StatefulWidget {
  const TokenScanPage({super.key});

  @override
  State<TokenScanPage> createState() => _TokenScanPageState();
}

class _TokenScanPageState extends State<TokenScanPage> {
  final MobileScannerController _cameraController = MobileScannerController();
  String? _scannedValue;
  String? _pinValidationMessage;
  bool _isTokenValid = false;
  int _remainingAttempts = 3;
  final TextEditingController _pinController = TextEditingController();
  bool _isTorchOn = false;
  final List<TextEditingController> pinControllers =
      List.generate(3, (_) => TextEditingController());
  List<FocusNode> pinFocusNodes = List.generate(3, (_) => FocusNode());

  final List<TokenCard> _predefinedCards = [
    const TokenCard(
      token: '08WX1NDVTPKB',
      id: '112473052',
      date: '12 Jan 2026',
      value: '35',
      handling: '3.50',
      isValid: true,
      pin: '256',
    ),
    const TokenCard(
      token: '15TY8BGFWCNH',
      id: '112425634',
      date: '12 Jan 2026',
      value: '35',
      handling: '3.50',
      isValid: true,
      pin: '123',
    ),
    const TokenCard(
      token: 'XTR9PU5RXT00',
      id: '',
      date: '',
      value: '',
      handling: '',
      isValid: false,
      pin: '',
    ),
    const TokenCard(
      token: '15TY8BGFWCNH',
      id: '112425634',
      date: '12 Jan 2026',
      value: '35',
      handling: '3.50',
      isValid: true,
      pin: '123',
    ),
  ];

  List<TokenCard> _scannedCards = [];

  void _validateToken(String value) {
    setState(() {
      if (value == 'http://en.m.wikipedia.org') {
        _scannedValue = value;
        _isTokenValid = true;
      } else {
        _scannedValue = value;
        _isTokenValid = false;
      }
    });
    _cameraController.stop();
    _showPinDialog();
  }

  void _validatePin(String value) {
    if (value == '123') {
      setState(() {
        _pinValidationMessage = '✅ OK';
        _addScannedToken(); // Add valid token
      });
    } else {
      setState(() {
        _remainingAttempts--;
        if (_remainingAttempts > 0) {
          _pinValidationMessage =
              '❌ WRONG PIN, $_remainingAttempts RETRY REMAINING';
        } else {
          _pinValidationMessage = '❌ WRONG PIN, 0 RETRY REMAINING';
          _isTokenValid = false; // Force token invalid on 3rd fail
          _addScannedToken(); // Add invalid token
        }
      });
    }
  }

  void _addScannedToken() {
    setState(() {
      _scannedCards.insert(
        0,
        TokenCard(
          token: _scannedValue ?? '',
          id: _isTokenValid ? '112473052' : '',
          date: _isTokenValid ? '12 Jan 2026' : '',
          value: _isTokenValid ? '35' : '',
          handling: _isTokenValid ? '3.50' : '',
          isValid: _isTokenValid,
          pin: _isTokenValid ? '123' : '',
        ),
      );
    });
  }

  void _restartScan() {
    setState(() {
      _scannedValue = null;
      _isTokenValid = false;
      _pinController.clear();
      _pinValidationMessage = null;
      _remainingAttempts = 3;
    });
    _cameraController.start();
  }

  @override
  void dispose() {
    _cameraController.dispose();
    super.dispose();
  }

  void _showPinDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          child: StatefulBuilder(
            builder: (context, setState) {
              return SingleChildScrollView(
                child: Center(
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(24),
                      boxShadow: [
                        BoxShadow(color: Colors.black26, blurRadius: 10),
                      ],
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 6, horizontal: 12),
                          decoration: BoxDecoration(
                            color: _isTokenValid
                                ? Colors.green.shade300
                                : Colors.red.shade300,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            _isTokenValid
                                ? "✅ Token Validated"
                                : "❌ Token Invalid",
                            style: TextStyle(
                              fontSize: 16,
                              // color: _isTokenValid ? Colors.green : Colors.red,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),
                        const Text("Token No.", style: TextStyle(fontSize: 18)),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 6, horizontal: 12),
                          margin: const EdgeInsets.only(top: 4),
                          decoration: BoxDecoration(
                            color: Colors.grey.shade300,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            _scannedValue ?? '',
                            style: const TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ),
                        const SizedBox(height: 16),
                        const Text("Enter Pin Code :",
                            style: TextStyle(fontSize: 18)),
                        const SizedBox(height: 12),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(3, (index) {
                            return Container(
                              width: 40,
                              margin: const EdgeInsets.symmetric(horizontal: 4),
                              child: Focus(
                                onKeyEvent: (node, event) {
                                  if (event.logicalKey ==
                                          LogicalKeyboardKey.backspace &&
                                      event is KeyDownEvent &&
                                      pinControllers[index].text.isEmpty &&
                                      index > 0) {
                                    pinControllers[index - 1].clear();
                                    FocusScope.of(context)
                                        .requestFocus(pinFocusNodes[index - 1]);
                                  }
                                  return KeyEventResult.ignored;
                                },
                                child: TextField(
                                  controller: pinControllers[index],
                                  focusNode: pinFocusNodes[index],
                                  keyboardType: TextInputType.number,
                                  textAlign: TextAlign.center,
                                  maxLength: 1,
                                  obscureText: true,
                                  autofocus: index == 0,
                                  decoration:
                                      const InputDecoration(counterText: ''),
                                  onChanged: (value) {
                                    if (value.isNotEmpty &&
                                        index < pinControllers.length - 1) {
                                      FocusScope.of(context).requestFocus(
                                          pinFocusNodes[index + 1]);
                                    }
                                  },
                                ),
                              ),
                            );
                          }),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          _pinValidationMessage ?? '',
                          style: TextStyle(
                            color: _pinValidationMessage != null &&
                                    _pinValidationMessage!.contains('❌')
                                ? Colors.red
                                : Colors.green,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: () {
                            final pin =
                                pinControllers.map((c) => c.text).join();
                            if (pin.length == 3) {
                              _validatePin(pin);
                              setState(() {});

                              if (_pinValidationMessage == '✅ OK' ||
                                  _remainingAttempts <= 0) {
                                Navigator.pop(context);
                                _restartScan();
                              } else {
                                for (var c in pinControllers) {
                                  c.clear();
                                }
                                FocusScope.of(context)
                                    .requestFocus(pinFocusNodes[0]);
                              }
                            } else {
                              setState(() {
                                _pinValidationMessage = '❌ Enter 3-digit PIN';
                              });
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 24, vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(24),
                            ),
                            backgroundColor: Colors.blue,
                          ),
                          child: const Text(
                            "Submit",
                            style: TextStyle(fontSize: 16, color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Token Scan'),
        backgroundColor: Colors.white,
        leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              dispose();
              if (Navigator.canPop(context)) {
                Navigator.pop(context);
              } else {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const HomeScreen()),
                );
              }
            }),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            SizedBox(
              height: 280,
              child: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: MobileScanner(
                        controller: _cameraController,
                        onDetect: (capture) {
                          final barcode = capture.barcodes.first;
                          final value = barcode.rawValue;
                          if (value != null && _scannedValue != value) {
                            _validateToken(value);
                          }
                        },
                      ),
                    ),
                  ),
                  Center(
                    child: Container(
                      width: 200,
                      height: 200,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.white, width: 2),
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                  Positioned(
                    right: 20,
                    top: 0,
                    bottom: 0,
                    child: Center(
                      child: Container(
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                        ),
                        child: IconButton(
                          icon: Icon(
                            _isTorchOn ? Icons.flash_off : Icons.flash_on,
                            color: Colors.black,
                          ),
                          onPressed: () {
                            setState(() => _isTorchOn = !_isTorchOn);
                            _cameraController.toggleTorch();
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'Scan a token',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Container(
              height: 1,
              color: Colors.grey.shade300,
            ),
            const SizedBox(height: 8),
            _buildTopNav(context, 'Details'),
            const SizedBox(height: 8),
            Expanded(
              child: ListView.builder(
                itemCount: _scannedCards.length + _predefinedCards.length,
                itemBuilder: (context, index) {
                  if (index < _scannedCards.length) {
                    return _scannedCards[index];
                  } else {
                    return _predefinedCards[index - _scannedCards.length];
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTopNav(BuildContext context, String activeTab) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade300, width: 1.0),
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
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => targetPage),
          );
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

class TokenCard extends StatefulWidget {
  final String token;
  final String id;
  final String date;
  final String value;
  final String handling;
  final bool isValid;
  final String pin;

  const TokenCard({
    super.key,
    required this.token,
    required this.id,
    required this.date,
    required this.value,
    required this.handling,
    required this.isValid,
    required this.pin,
  });

  @override
  State<TokenCard> createState() => _TokenCardState();
}

class _TokenCardState extends State<TokenCard> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: BorderSide(color: Colors.grey.shade300),
      ),
      child: Column(
        children: [
          InkWell(
            onTap: () => setState(() => isExpanded = !isExpanded),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              decoration: BoxDecoration(
                color: widget.isValid ? Colors.blue : Colors.red,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.token,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                  Icon(
                    isExpanded ? Icons.expand_less : Icons.expand_more,
                    color: Colors.white,
                  ),
                ],
              ),
            ),
          ),
          if (isExpanded)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              color: Colors.white,
              child: widget.isValid
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('ID: ${widget.id}'),
                        Text('Valid Upto: ${widget.date}'),
                        Text('Value To Pay: ₹${widget.value}'),
                        Text('Handling: ₹${widget.handling}'),
                        Row(
                          children: [
                            const Text('PIN: '),
                            Container(
                              width: 50,
                              height: 30,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.blue),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Text(widget.pin,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold)),
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
                        Text('Error - ${widget.token}',
                            style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.red)),
                        const Text(
                          'Please check with IT or Company Officer',
                          style: TextStyle(
                            fontSize: 16,
                          ),
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
}
