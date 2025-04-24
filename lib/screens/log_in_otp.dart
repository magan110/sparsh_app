import 'package:flutter/material.dart';

class LogInOtp extends StatefulWidget {
  const LogInOtp({super.key});

  @override
  State<LogInOtp> createState() => _LogInOtpState();
}

class _LogInOtpState extends State<LogInOtp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: MediaQuery(
          data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
          child: Text(
            'Log In Mobile Number',
            style: TextStyle(fontSize: 16),
          ),
        ),
      ),
      body: Container(
        height: 550,
        width: double.infinity,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(50),
            topRight: Radius.circular(50),
          ),
          color: Colors.white,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            MediaQuery(
              data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
              child: Text(
                'Log In Mobile Number',
                style: TextStyle(fontSize: 30),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 39, right: 39, top: 55),
              child: TextField(
                decoration: InputDecoration(
                  labelText: 'Enter Mobile Number', // Updated label
                  labelStyle: const TextStyle(
                    fontSize: 18, // Reduced font size for better appearance
                    color: Colors.cyan,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(
                        color: Colors.grey),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(
                        color: Colors.blue, width: 2.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(
                        color: Colors.grey),
                  ),
                ),
                keyboardType: TextInputType.phone, // Added keyboard type for phone number
              ),
            ),
             Padding(
              padding: EdgeInsets.only(left: 300, top: 20),
              child: MediaQuery(
                data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
                child: Text(
                  'Send OTP',
                  style: TextStyle(fontSize: 18,color: Colors.blue),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 39, right: 39, top: 20),
              child: TextField(
                decoration: InputDecoration(
                  labelText: 'Enter OTP',
                  labelStyle: const TextStyle(
                    fontSize: 18, // Reduced font size for better appearance
                    color: Colors.cyan,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(
                        color: Colors.grey),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(
                        color: Colors.blue, width: 2.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(
                        color: Colors.grey),
                  ),
                ),
                keyboardType: TextInputType.number, // Added keyboard type for OTP
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            InkWell(
              child: Container(
                height: 50,
                width: 200,
                decoration: const BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.all(
                    Radius.circular(20),
                  ),
                ),
                child: Center(
                  child: MediaQuery(
                    data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
                    child: Text(
                      'Verify Now',
                      style: TextStyle(fontSize: 30,color: Colors.white),
                    ),
                  ),
                ),
              ),
              onTap: () {},
            ),
            const SizedBox(
              height: 20,
            ),
             Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                MediaQuery(
                  data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
                  child: Text(
                    'Log In Mobile Number',
                    style: TextStyle(fontSize: 30),
                  ),
                ),
                Icon(Icons.favorite, color: Colors.red)
              ],
            ),
          ],
        ),
      ),
    );
  }
}
