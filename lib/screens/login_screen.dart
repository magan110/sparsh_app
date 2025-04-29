import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/io_client.dart'; // Import for IOClient
import 'package:fluttertoast/fluttertoast.dart'; // Import for showing toast messages
import 'dart:io'; // Import for Platform and HttpClient
import 'Home_screen.dart'; // Import HomeScreen
import 'log_in_otp.dart'; // Import LogInOtp
import 'package:shared_preferences/shared_preferences.dart'; // Import shared_preferences

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final String apiUrl = "https://qa.birlawhite.com:55232/api/Auth/execute";
  bool _obscurePassword = true; // Track password visibility

  // This method makes a POST request to the API with user credentials
  Future<void> loginUser() async {
    final String userID = _usernameController.text.trim();
    final String password = _passwordController.text.trim();

    if (userID.isEmpty || password.isEmpty) {
      Fluttertoast.showToast(msg: "Please enter both username and password");
      return;
    }

    // Replace this with your actual appRegId
    // Note: Using userID + password as appRegId might not be secure.
    // Consider a more robust method for generating or obtaining appRegId.
    final String appRegId = userID + password;


    final Map<String, dynamic> requestBody = {
      'userID': userID,
      'password': password,
      'appRegId': appRegId
    };

    // Show a loading indicator (optional but recommended)
    showDialog(
      context: context,
      barrierDismissible: false, // Prevent dialog dismissal
      builder: (context) => const AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 16),
            Text("Logging in..."),
          ],
        ),
      ),
    );


    try {
      // Check for internet connectivity
      final result = await InternetAddress.lookup('google.com');
      if (result.isEmpty || result.first.rawAddress.isEmpty) {
        throw SocketException('No Internet Connection');
      }

      // Use IOClient to bypass SSL certificate verification (if needed)
      // **SECURITY WARNING:** Bypassing SSL certificate verification is INSECURE
      // and should only be used for development/testing purposes.
      // In a production app, you should properly handle SSL certificates.
      final client = IOClient(HttpClient()..badCertificateCallback = (X509Certificate cert, String host, int port) => true);

      // Send POST request with username, password, and appRegId
      final response = await client.post(
        Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(requestBody),
      );

      // Dismiss the loading indicator
      if (mounted) {
        Navigator.of(context, rootNavigator: true).pop(); // Dismiss the loading dialog
      }


      // Check the response status
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        print("Response Data: $responseData");

        if (responseData['msg'] == 'Authentication successful') {
          // --- START: Added code to save login status ---
          // Get an instance of SharedPreferences
          final prefs = await SharedPreferences.getInstance();
          // Set the 'isLoggedIn' flag to true
          await prefs.setBool('isLoggedIn', true);
          // --- END: Added code to save login status ---

          // Save necessary data or handle response for successful authentication

          // Navigate to the HomeScreen after successful login
          // Navigator.pushReplacement is already correct here
          if (mounted) { // Check if the widget is still mounted before navigating
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => HomeScreen()),
            );
          }
        } else {
          Fluttertoast.showToast(msg: "Authentication failed");
        }
      } else {
        Fluttertoast.showToast(msg: "Failed to authenticate. Please try again. Status Code: ${response.statusCode}");
        print("API Error Response Body: ${response.body}"); // Log response body for debugging
      }

      client.close(); // Close the client after the request

    } on SocketException catch (_) {
      // Dismiss the loading indicator in case of error
      if (mounted) {
        Navigator.of(context, rootNavigator: true).pop();
      }
      print('Not connected to the internet');
      // Show a dialog to the user indicating no internet connection.
      if (mounted) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('No Internet Connection'),
            content: const Text('Please check your internet connection and try again.'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('OK'),
              ),
            ],
          ),
        );
      }
    } catch (e) {
      // Dismiss the loading indicator in case of error
      if (mounted) {
        Navigator.of(context, rootNavigator: true).pop();
      }
      print("Error: $e");
      if (mounted) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Error'),
            content: Text('An error occurred: ${e.toString()}'), // Use e.toString()
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('OK'),
              ),
            ],
          ),
        );
      }
    }
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(50),
          topRight: Radius.circular(50),
        ),
        color: Colors.white,
      ),
      child: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(minHeight: screenHeight * 0.8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 30),
              const Text(
                'Log In',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 30,
                  decoration: TextDecoration.underline,
                ),
              ),

              // Username TextField
              Padding(
                padding: const EdgeInsets.only(left: 39, right: 39, top: 55),
                child: TextField(
                  controller: _usernameController,
                  decoration: InputDecoration(
                    labelText: 'User ID',
                    labelStyle: const TextStyle(fontSize: 20, color: Colors.cyan),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0)),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: const BorderSide(color: Colors.blue, width: 2.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: const BorderSide(color: Colors.grey),
                    ),
                  ),
                ),
              ),

              // Password TextField with Show Password Icon
              Padding(
                padding: const EdgeInsets.only(left: 39, right: 39, top: 20),
                child: TextField(
                  controller: _passwordController,
                  obscureText: _obscurePassword, // Toggle based on _obscurePassword
                  decoration: InputDecoration(
                    labelText: 'Password',
                    labelStyle: const TextStyle(fontSize: 20, color: Colors.cyan),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0)),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: const BorderSide(color: Colors.blue, width: 2.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: const BorderSide(color: Colors.grey),
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscurePassword ? Icons.visibility_off : Icons.visibility,
                        color: Colors.cyan,
                      ),
                      onPressed: () {
                        setState(() {
                          _obscurePassword = !_obscurePassword; // Toggle password visibility
                        });
                      },
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 10),
              const Padding( // Added const for optimization
                padding: EdgeInsets.only(left: 200),
                child: Text(
                  'Forgotten Password?',
                  style: TextStyle(color: Colors.blue, fontSize: 16),
                ),
              ),
              const SizedBox(height: 20),

              // Login Button
              InkWell(
                onTap: loginUser, // Call the loginUser method
                child: Container(
                  height: 50,
                  width: 200,
                  decoration: const BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  child: const Center(
                    child: Text(
                      "Log In",
                      style: TextStyle(
                          fontSize: 22,
                          color: Colors.white,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // Login with OTP
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const LogInOtp()),
                  );
                },
                child: const Text(
                  'Login With OTP',
                  style: TextStyle(fontSize: 16),
                ),
              ),

              const SizedBox(height: 20),

              // Footer Text
              const Padding( // Added const for optimization
                padding: EdgeInsets.only(bottom: 30.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Developed By Birla White IT",
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                          fontWeight: FontWeight.w400),
                    ),
                    Icon(Icons.favorite, color: Colors.red),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}