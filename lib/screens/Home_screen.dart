import 'package:flutter/material.dart';
import 'dart:async';
import 'package:learning2/reports/Gerneral%20Reports/account_statement.dart';
import 'package:learning2/reports/SAP%20Reports/day_summary.dart';
import 'package:learning2/screens/notification_screen.dart';
import 'package:learning2/screens/profile_screen.dart';
import 'package:learning2/screens/dashboard_screen.dart';
import 'package:learning2/screens/schema.dart';
import 'package:learning2/screens/token_scan.dart';
import '../dsr_entry_screen/dsr_entry.dart';
import '../reports/scheme_discount/rpl_outlet_tracker.dart';
import 'dsr_screen.dart'; // Import not used, so I'll comment it out.  If you use it, uncomment.
import 'mail_screen.dart';
import 'app_drawer.dart';
import 'package:flutter_animate/flutter_animate.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'SPARSH App',
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  bool _isSearchVisible = false;
  final TextEditingController _searchController = TextEditingController();
  final List<Widget> _screens = [
    const HomeContent(),
    const DashboardScreen(),
    const Schema(),
    const ProfilePage(),
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildAppBar(),
      drawer: const AppDrawer(),
      body: Stack(
        children: [
          IndexedStack(
            index: _selectedIndex,
            children: _screens,
          ),
          _buildSearchInput(context),
        ],
      ),
      bottomNavigationBar: _buildPremiumBottomBar() ,
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      elevation: 2,
      flexibleSpace: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.blue, Colors.blue],
          ),
        ),
      ),
      title: const Text(
        'SPARSH',
        style: TextStyle(
          color: Colors.white,
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
      iconTheme: const IconThemeData(color: Colors.white),
      actions: [
        IconButton(
          icon: const Icon(Icons.notifications_none, size: 30, color: Colors.white),
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => NotificationScreen()));
            print('Notifications tapped');
          },
        ),
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          transitionBuilder: (Widget child, Animation<double> animation) {
            return SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(0.0, -1.0),
                end: Offset.zero, // Corrected: Use Offset.zero
              ).animate(animation),
              child: child,
            );
          },
          child: _isSearchVisible
              ? const SizedBox(width: 48, height: 48)
              : IconButton(
            key: const ValueKey('search_icon'),
            icon: const Icon(Icons.search, size: 30, color: Colors.white),
            onPressed: () {
              setState(() {
                _isSearchVisible = true;
              });
            },
          ),
        ),
      ],
    );
  }

  Widget _buildSearchInput(BuildContext context) {
    return AnimatedOpacity(
      opacity: _isSearchVisible ? 1.0 : 0.0,
      duration: const Duration(milliseconds: 300),
      child: Visibility(
        visible: _isSearchVisible,
        child: Container(
          color: Colors.white,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: 'Search for reports, orders, etc...',
                  prefixIcon: const Icon(Icons.search),
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () {
                      setState(() {
                        _isSearchVisible = false;
                        _searchController.clear();
                      });
                    },
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                onSubmitted: (value) {
                  print('Searching for: $value');
                  setState(() {
                    _isSearchVisible = false;
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPremiumBottomBar() {
    final List<Map<String, dynamic>> navItems = [
      {
        'icon': Icons.home_outlined,
        'activeIcon': Icons.home_rounded,
        'label': 'Home',
        'color': Colors.blueAccent
      },
      {
        'icon': Icons.dashboard,
        'activeIcon': Icons.dashboard,
        'label': 'DashBoard',
        'color': Colors.purpleAccent
      },
      {
        'icon': Icons.schema,
        'activeIcon': Icons.schema,
        'label': 'Scheme',
        'color': Colors.orangeAccent
      },
      {
        'icon': Icons.person_outline,
        'activeIcon': Icons.person_rounded,
        'label': 'Profile',
        'color': Colors.lightGreen
      },
    ];

    return Container(
      height: 80,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            blurRadius: 20,
            spreadRadius: 2,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(navItems.length, (index) {
          final item = navItems[index];
          final isActive = _selectedIndex == index;
          final color = item['color'] as Color;

          return GestureDetector(
            onTap: () => setState(() => _selectedIndex = index),
            child: AnimatedContainer(
              duration: 500.ms,
              curve: Curves.fastOutSlowIn,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                gradient: isActive
                    ? LinearGradient(
                  colors: [
                    color.withOpacity(0.15),
                    color.withOpacity(0.05),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                )
                    : null,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Icon with floating effect
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      // Background glow
                      if (isActive)
                        Container(
                          width: 36,
                          height: 36,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: color.withOpacity(0.2),
                          ),
                        ).animate(
                          onComplete: (controller) => controller.reverse(),
                        ).scale(
                          duration: 600.ms,
                          begin: const Offset(0.8, 0.8),
                          curve: Curves.elasticOut,
                        ).fadeIn(duration: 300.ms),

                      // Icon with smooth transition
                      AnimatedSwitcher(
                        duration: 300.ms,
                        transitionBuilder: (child, anim) => ScaleTransition(
                          scale: anim,
                          child: FadeTransition(
                            opacity: anim,
                            child: child,
                          ),
                        ),
                        child: IconTheme(
                          data: IconThemeData(
                            size: isActive ? 28 : 24,
                            color: isActive ? color : Colors.grey.shade500,
                          ),
                          child: isActive
                              ? Icon(item['activeIcon'], key: ValueKey('active-$index'))
                              : Icon(item['icon'], key: ValueKey('inactive-$index')),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 6),

                  // Label with simple fade animation
                  AnimatedDefaultTextStyle(
                    duration: 300.ms,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: isActive ? FontWeight.w600 : FontWeight.w500,
                      color: isActive ? color : Colors.grey.shade600,
                      height: 1.2,
                    ),
                    child: Text(item['label']),
                  ),

                  // Animated underline
                  if (isActive)
                    Container(
                      width: 24,
                      height: 3,
                      margin: const EdgeInsets.only(top: 4),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(2),
                        gradient: LinearGradient(
                          colors: [color, color.withOpacity(0.7)],
                        ),
                      ),
                    ).animate().scaleX(
                      duration: 600.ms,
                      begin: 0.5,
                      curve: Curves.elasticOut,
                    ).fadeIn(duration: 300.ms),
                ],
              ),
            ).animate().shakeX(
              duration: 300.ms,
              hz: 4,
              amount: 0.5,
            ),
          );
        }),
      ),
    );
  }
}

class HomeContent extends StatefulWidget {
  const HomeContent({super.key});

  @override
  State<HomeContent> createState() => _HomeContentState();
}

class _HomeContentState extends State<HomeContent> {
  late ScrollController _scrollController;
  Timer? _autoScrollTimer;
  double _scrollPosition = 0.0;
  final List<String> _bannerImagePaths = [
    'assets/image1.png',
    'assets/image21.jpg',
    'assets/image22.jpg',
    'assets/image23.jpg',
    'assets/image24.jpg',
  ];

  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    if (_bannerImagePaths.length > 1) {
      _startAutoScroll();
    }
    _scrollController.addListener(() {
      if (_scrollController.position.isScrollingNotifier.value == false) {
        _restartAutoScroll();
      }
    });
  }

  void _startAutoScroll() {
    _autoScrollTimer?.cancel();
    _autoScrollTimer = Timer.periodic(const Duration(seconds: 3), (timer) {
      if (!_scrollController.hasClients) {
        timer.cancel();
        return;
      }
      double itemWidth = MediaQuery.of(context).size.width;
      double spacing = 10;
      double fullItemWidth = itemWidth + spacing;
      double maxScroll = _scrollController.position.maxScrollExtent;
      double nextPosition = _currentIndex * fullItemWidth;

      if (nextPosition > maxScroll - itemWidth / 2) {
        _currentIndex = 0;
        nextPosition = 0;
      } else {
        _currentIndex++;
      }

      _scrollController.animateTo(
        nextPosition,
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeInOut,
      );
    });
  }

  void _restartAutoScroll() {
    _autoScrollTimer?.cancel();
    Future.delayed(const Duration(seconds: 5), () {
      if (mounted && _bannerImagePaths.length > 1) {
        _startAutoScroll();
      }
    });
  }

  @override
  void dispose() {
    _autoScrollTimer?.cancel();
    _scrollController.removeListener(_restartAutoScroll);
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final double screenWidth = screenSize.width;
    final double screenHeight = screenSize.height;

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            _banner(screenWidth, screenHeight),
            const SizedBox(height: 20),
            _sectionTitle("Mostly Used Apps"),
            const SizedBox(height: 10),
            _mostlyUsedApps(screenWidth, screenHeight),
            const SizedBox(height: 20),
            const HorizontalMenu(),
            const SizedBox(height: 20),
            _sectionTitle("Quick Menu"),
            const SizedBox(height: 10),
            _quickMenu(screenHeight, screenWidth)
          ],
        ),
      ),
    );
  }

  Widget _sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 4.0),
      child: Text(
        title,
        style: const TextStyle(fontSize: 16),
      ),
    );
  }

  Widget _quickMenu(double screenHeight, double screenWidth) {
    final List<Map<String, String>> quickMenuItems = [
      {'image': 'assets/image37.png', 'label': 'RPL Outlet\nTracker'},
      {'image': 'assets/image38.png', 'label': 'GKC\nLead Entry'},
      {'image': 'assets/image8.png', 'label': 'RPL Outlet\nTracker'},
      {'image': 'assets/image39.png', 'label': 'Training\nFeedback'},
      {'image': 'assets/image28.png', 'label': 'Settings'},
      {'image': 'assets/image29.png', 'label': 'Sales\nSummary'},
      {'image': 'assets/image30.png', 'label': 'Inventory'},
      {'image': 'assets/image31.png', 'label': 'Order\nHistory'},
      {'image': 'assets/image32.png', 'label': 'Delivery\nStatus'},
      {'image': 'assets/image40.png', 'label': 'First Aid\nPersonal'},
      {'image': 'assets/image41.png', 'label': 'Account\nStatement'},
    ];
    final double itemWidth = screenWidth / 4;

    return Container(
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(12.0)),
        border: Border.all(color: Colors.grey.shade300, width: 1),
        color: Colors.white,
      ),
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          crossAxisSpacing: 8.0,
          mainAxisSpacing: 8.0,
          childAspectRatio: itemWidth / (itemWidth + 40),
        ),
        itemCount: quickMenuItems.length,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          final item = quickMenuItems[index];
          return GestureDetector(
            onTap: () {
              print('${item['label']} tapped');
              if (item['label']!.contains('RPL Outlet')) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const RplOutletTracker()),
                );
              } else if (item['label']!.contains('Account')) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const AccountStatement()),
                );
              }
            },
            child: _buildQuickMenuItem(item['image']!, item['label']!, itemWidth),
          );
        },
      ),
    );
  }

  Widget _buildQuickMenuItem(String imagePath, String label, double itemWidth) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset(
          imagePath,
          width: itemWidth * 0.6,
          height: itemWidth * 0.6,
          fit: BoxFit.contain,
        ),
        const SizedBox(height: 8),
        Text(
          label,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 12, color: Colors.black),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }

  Widget _mostlyUsedApps(double screenWidth, double screenHeight) {
    final List<Map<String, String>> mostlyUsedItems = [
      {'image': 'assets/image33.png', 'label': 'DSR', 'route': 'dsr'},
      {'image': 'assets/image34.png', 'label': 'Staff\nAttendance', 'route': 'attendance'},
      {'image': 'assets/image35.png', 'label': 'DSR\nException', 'route': 'dsr_exception'},
      {'image': 'assets/image36.png', 'label': 'Token Scan', 'route': 'scanner'},
    ];

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 8.0),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(12.0)),
        border: Border.all(color: Colors.grey.shade300, width: 1),
        color: Colors.white,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: mostlyUsedItems.map((item) {
          return InkWell(
            onTap: () {
              print('${item['label']} tapped');
              if (item['route'] == 'dsr') {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const DsrEntry()));
              } else if (item['route'] == 'scanner') {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => TokenScanPage()));
              }
            },
            child: _buildMostlyUsedAppItem(item['image']!, item['label']!),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildMostlyUsedAppItem(String imagePath, String text) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Material(
          elevation: 4.0,
          borderRadius: BorderRadius.circular(12.0),
          child: Container(
            width: 56,
            height: 56,
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.0),
              color: Colors.white,
            ),
            child: Image.asset(imagePath, fit: BoxFit.contain),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          text,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 12, color: Colors.black87),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }

  Widget _banner(double screenWidth, double screenHeight) {
    return SizedBox(
      height: screenHeight * 0.2,
      child: ListView.builder(
        controller: _scrollController,
        scrollDirection: Axis.horizontal,
        itemCount: _bannerImagePaths.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.only(
              right: index < _bannerImagePaths.length - 1 ? 10.0 : 0.0,
            ),
            child: _buildBannerItem(
                screenWidth, screenHeight, _bannerImagePaths[index]),
          );
        },
      ),
    );
  }

  Widget _buildBannerItem(
      double screenWidth, double screenHeight, String imagePath) {
    return Container(
      width: screenWidth,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: Colors.grey.shade400, width: 1.0),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(7.0),
        child: Image.asset(
          imagePath,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

class HorizontalMenu extends StatefulWidget {
  const HorizontalMenu({super.key});

  @override
  State<HorizontalMenu> createState() => _HorizontalMenuState();
}

class _HorizontalMenuState extends State<HorizontalMenu> {
  String selected = "Quick Menu";

  final List<String> menuItems = [
    "Quick Menu",
    "Document",
    "Registration",
    "Entertainment",
    "Painter",
    "Attendance"
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: menuItems.length,
        itemBuilder: (context, index) {
          final label = menuItems[index];
          final isSelected = selected == label;

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0),
            child: OutlinedButton(
              style: OutlinedButton.styleFrom(
                backgroundColor: isSelected ? Colors.blue : Colors.white,
                foregroundColor: isSelected ? Colors.white : Colors.blue,
                side: BorderSide(
                    color: isSelected ? Colors.blue : Colors.grey.shade400),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30)),
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              ),
              onPressed: () {
                setState(() {
                  selected = label;
                });
                print('$label selected');
              },
              child: Text(
                label,
                style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
              ),
            ),
          );
        },
      ),
    );
  }
}

