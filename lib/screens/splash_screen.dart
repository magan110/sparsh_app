// lib/screens/splash_screen.dart
import 'package:flutter/material.dart';


import 'login_screen.dart'; // Ensure this import is correct

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
      duration: const Duration(milliseconds: 500), // Increased duration to 500 milliseconds
      vsync: this,
    );
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 1),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));

    // Automatically trigger the swipe up after 1 second
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted && !_showLogin) {
        _handleSwipeUp();
      }
    });
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
            // Background image grid
            Positioned.fill( // Make the background fill the entire stack
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
                    const SizedBox(height: 100), // Extra space for scroll
                  ],
                ),
              ),
            ),

            // Gradient overlay
            Positioned.fill( // Make the gradient fill the entire stack
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      const Color(0x80093C73), // Semi-transparent navy blue
                      Colors.blue.shade700, // Semi-transparent light blue
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
              ),
            ),

            // Centered text
             Positioned.fill(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  MediaQuery(
                    data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
                    child: const Text(
                      'Welcome',
                      style: TextStyle(fontSize: 25,color: Colors.white),
                    ),
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

            // Footer text
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

            // Login screen (animated and full height)
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