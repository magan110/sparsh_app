import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Although not used in this specific screen, keeping if needed elsewhere

class LogInOtp extends StatefulWidget {
  const LogInOtp({super.key});

  @override
  State<LogInOtp> createState() => _LogInOtpState();
}

class _LogInOtpState extends State<LogInOtp> {
  // Controllers for text fields
  final TextEditingController _mobileNumberController = TextEditingController();
  final TextEditingController _otpController = TextEditingController();

  // Global key for the form for potential validation later
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    // Dispose controllers when the widget is removed
    _mobileNumberController.dispose();
    _otpController.dispose();
    super.dispose();
  }

  // Helper method to show a simple dialog (e.g., for success or error)
  void _showAlertDialog(String title, String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[100], // Light grey background for the body
        appBar: AppBar(
          // Removed backgroundColor, using a gradient instead for consistency
          elevation: 4, // Subtle shadow
          flexibleSpace: Container(
            // Added flexibleSpace
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft, // Changed gradient direction
                end: Alignment.bottomRight, // Changed gradient direction
                colors: <Color>[
                  Color(0xFF42a5f5), // Top-left color (a shade of blue)
                  Color(0xFF1976d2), // Bottom-right color (a darker blue)
                ],
              ),
            ),
          ),
          title: const Text( // Use const for static text
            'Log In / OTP', // Simplified title
            style: TextStyle(
              color: Colors.white, // White title color
              fontSize: 20, // Adjusted font size
              fontWeight: FontWeight.bold,
            ),
          ),
          iconTheme: const IconThemeData(color: Colors.white), // White back arrow icon
        ),
        body: Center( // Center the content vertically and horizontally
          child: SingleChildScrollView( // Allow content to scroll if it overflows
            padding: const EdgeInsets.all(16.0), // Add padding around the content
            child: Form(
              key: _formKey, // Assign the form key
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center, // Center column content
                crossAxisAlignment: CrossAxisAlignment.stretch, // Stretch children horizontally
                children: [
                  // Title Text
                  const Text( // Use const for static text
                    'Welcome Back!', // More engaging title
                    textAlign: TextAlign.center, // Center align the title
                    style: TextStyle(
                      fontSize: 28, // Adjusted font size
                      fontWeight: FontWeight.bold,
                      color: Colors.blueAccent, // Use blueAccent
                    ),
                  ),
                  const SizedBox(height: 8), // Spacing below title
                  const Text( // Use const for static text
                    'Log in with your mobile number',
                    textAlign: TextAlign.center, // Center align the subtitle
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.blueGrey, // Use blueGrey
                    ),
                  ),
                  const SizedBox(height: 40), // Increased spacing before first field

                  // Mobile Number Field
                  _buildLabel('Mobile Number'), // Use helper for label
                  const SizedBox(height: 8), // Spacing below label
                  _buildTextField( // Use helper for text field
                    'Enter Mobile Number',
                    controller: _mobileNumberController,
                    keyboardType: TextInputType.phone,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your mobile number';
                      }
                      // Optional: Add mobile number format validation
                      // if (!RegExp(r'^[0-9]{10}$').hasMatch(value)) {
                      //   return 'Please enter a valid 10-digit mobile number';
                      // }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16), // Spacing between fields/actions

                  // Send OTP Button/Text
                  Align( // Align to the right
                    alignment: Alignment.centerRight,
                    child: TextButton( // Use TextButton for a tappable text
                      onPressed: () {
                        // TODO: Implement send OTP logic
                        if (_formKey.currentState!.validate()) {
                          print('Send OTP tapped for: ${_mobileNumberController.text}');
                          _showAlertDialog('OTP Sent', 'OTP sent to ${_mobileNumberController.text}'); // Show a confirmation
                        }
                      },
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.zero, // Remove default padding
                        minimumSize: Size.zero, // Remove minimum size constraints
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap, // Shrink tap target
                      ),
                      child: const Text(
                        'Send OTP',
                        style: TextStyle(
                          fontSize: 16, // Adjusted font size
                          color: Colors.blueAccent, // Use blueAccent
                          fontWeight: FontWeight.w600, // Semi-bold
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24), // Increased spacing before OTP field

                  // OTP Field
                  _buildLabel('OTP'), // Use helper for label
                  const SizedBox(height: 8), // Spacing below label
                  _buildTextField( // Use helper for text field
                    'Enter OTP',
                    controller: _otpController,
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter the OTP';
                      }
                      // Optional: Add OTP length validation
                      // if (value.length != 6) { // Assuming 6-digit OTP
                      //   return 'Please enter a valid OTP';
                      // }
                      return null;
                    },
                    // Optional: Add input formatters for OTP
                  ),
                  const SizedBox(height: 30), // Increased spacing before button

                  // Verify Now Button
                  ElevatedButton(
                    onPressed: () {
                      // TODO: Implement verify OTP logic
                      if (_formKey.currentState!.validate()) {
                        print('Verify Now tapped with OTP: ${_otpController.text}');
                        // Add your verification logic here
                        _showAlertDialog('Verification', 'Verifying OTP...'); // Placeholder message
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white, // White text color
                      backgroundColor: Colors.blueAccent, // BlueAccent background
                      padding: const EdgeInsets.symmetric(vertical: 14), // Increased vertical padding
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10), // Rounded corners
                      ),
                      textStyle: const TextStyle(
                        fontSize: 18, // Adjusted font size
                        fontWeight: FontWeight.bold,
                      ),
                      elevation: 4.0, // Add subtle elevation
                    ),
                    child: const Text('Verify Now'),
                  ),
                  const SizedBox(height: 20), // Spacing below button

                  // Example of another row (if needed, styled consistently)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Need help?',
                        style: TextStyle(fontSize: 14, color: Colors.black54),
                      ),
                      const SizedBox(width: 4),
                      TextButton(
                        onPressed: () {
                          // TODO: Implement help/support action
                          print('Need help tapped');
                        },
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.zero,
                          minimumSize: Size.zero,
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                        child: const Text(
                          'Contact Support',
                          style: TextStyle(fontSize: 14, color: Colors.blueAccent, fontWeight: FontWeight.w600),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // --- Helper Methods for Building Widgets ---

  // Helper to build a standard text field
  Widget _buildTextField(
      String hintText, {
        TextEditingController? controller,
        TextInputType? keyboardType,
        int maxLines = 1, // Default to single line
        String? Function(String?)? validator,
        bool readOnly = false, // Added readOnly parameter
      }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      maxLines: maxLines,
      readOnly: readOnly, // Apply readOnly property
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(
          color: Colors.grey[500], // Slightly darker grey hint text
          fontSize: 16,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10), // Rounded corners
          borderSide: BorderSide(color: Colors.grey.shade400), // Lighter border
        ),
        focusedBorder: OutlineInputBorder( // Style for focused state
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.blueAccent, width: 2.0), // BlueAccent border when focused
        ),
        enabledBorder: OutlineInputBorder( // Style for enabled state
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.grey.shade400), // Lighter border when enabled
        ),
        errorBorder: OutlineInputBorder( // Style for error state
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.redAccent, width: 2.0), // Red border on error
        ),
        focusedErrorBorder: OutlineInputBorder( // Style for focused error state
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.redAccent, width: 2.0), // Red border on focused error
        ),
        filled: true, // Add a background fill
        fillColor: Colors.white, // White background for text fields
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 15), // Adjusted padding
      ),
      validator: validator, // Assign the validator function
    );
  }

  // Helper to build a standard text label
  Widget _buildLabel(String text) => Text(
    text,
    style: const TextStyle(
      fontSize: 16, // Slightly smaller label font size
      fontWeight: FontWeight.w600, // Slightly bolder
      color: Colors.black87, // Darker text color
    ),
  );
}
