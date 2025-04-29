import 'dart:async';
import 'package:flutter/material.dart';
import 'package:learning2/screens/login_screen.dart';
import 'package:learning2/screens/Home_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  bool _showLogin = false;
  late AnimationController _animationController;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 1),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
    _checkLoginStatus(); // This method checks login status
  }

  Future<void> _checkLoginStatus() async {
    final prefs = await SharedPreferences.getInstance();
    // Check for the 'isLoggedIn' flag
    final isLoggedIn = prefs.getBool('isLoggedIn') ?? false;

    // Define the duration you want the splash screen to show
    const splashDuration = Duration(seconds: 2); // You can adjust this duration

    if (isLoggedIn) {
      // If logged in, wait for the splash duration then navigate to HomeScreen
      Future.delayed(splashDuration, () {
        if (mounted) { // Check if the widget is still mounted before navigating
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => HomeScreen()),
          );
        }
      });
    } else {
      // If not logged in, wait for the splash duration then show the LoginScreen
      Future.delayed(splashDuration, () {
        if (mounted && !_showLogin) { // Check if the widget is still mounted
          _handleSwipeUp(); // This triggers showing the LoginScreen with animation
        }
      });
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _handleSwipeUp() {
    setState(() {
      _showLogin = true;
      _animationController.forward();
    });
  }

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.sizeOf(context).width;
    double _height = MediaQuery.sizeOf(context).height;

    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Positioned.fill(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    buildImageContainer(
                      _width,
                      _height * 0.2,
                      Image.asset('assets/image11.png', fit: BoxFit.cover),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        buildImageContainer(
                          _width * 0.4,
                          _height * 0.2,
                          Image.asset('assets/image12.png', fit: BoxFit.cover),
                        ),
                        buildImageContainer(
                          _width * 0.5,
                          _height * 0.2,
                          Image.asset('assets/image13.png', fit: BoxFit.cover),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        buildImageContainer(
                          _width * 0.5,
                          _height * 0.2,
                          Image.asset('assets/image14.png', fit: BoxFit.contain),
                        ),
                        buildImageContainer(
                          _width * 0.5,
                          _height * 0.2,
                          Image.asset('assets/image15.png', fit: BoxFit.contain),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        buildImageContainer(
                          _width * 0.4,
                          _height * 0.2,
                          Image.asset('assets/image16.png', fit: BoxFit.contain),
                        ),
                        buildImageContainer(
                          _width * 0.5,
                          _height * 0.2,
                          Image.asset('assets/image17.png', fit: BoxFit.contain),
                        ),
                      ],
                    ),
                    buildImageContainer(
                      _width * 0.9,
                      _height * 0.2,
                      Image.asset('assets/image18.png', fit: BoxFit.contain),
                    ),
                    const SizedBox(height: 100),
                  ],
                ),
              ),
            ),
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      const Color(0x80093C73),
                      Colors.blue.shade700,
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
              ),
            ),
            Positioned.fill(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  MediaQuery(
                    data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
                    child: const Text('Welcome', style: TextStyle(fontSize: 25, color: Colors.white)),
                  ),
                  MediaQuery(
                    data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
                    child: const Text(
                      'SPARSH',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 45,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 2,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: 12,
              left: 0,
              right: 0,
              child: Center(
                child: MediaQuery(
                  data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
                  child: Text(
                    'Developed By Birla White IT 🔴',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.9),
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            if (_showLogin)
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: SlideTransition(
                  position: _slideAnimation,
                  child: const LoginScreen(),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Container buildImageContainer(double width, double height, Image image) {
    return Container(
      width: width,
      height: height,
      margin: const EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: image,
      ),
    );
  }
}
