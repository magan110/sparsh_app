import 'dart:async';
import 'package:flutter/material.dart';
import 'package:learning2/screens/profile_screen.dart';
import 'package:learning2/screens/scanner_screen.dart';
import 'package:learning2/screens/tasks_screen.dart';
import '../dsr_entry_screen/dsr_entry.dart';
import 'dsr_screen.dart';
import 'mail_screen.dart'; // Make sure dsr_screen.dart exists

// Main HomeScreen Widget
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  // List of screens to navigate between using the bottom bar
  final List<Widget> _screens = [
    const HomeContent(), // The main content for the home tab
    const TasksScreen(), // Placeholder for Tasks Screen
    const MailScreen(), // Placeholder for Mail Screen
    const ProfileScreen(), // Placeholder for Profile Screen
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: _buildAppBar(), // Custom AppBar
        drawer: _buildDrawer(), // Custom Navigation Drawer
        body: IndexedStack(
          // Use IndexedStack to preserve state of screens
          index: _selectedIndex,
          children: _screens,
        ),
        bottomNavigationBar: _buildBottomBar(), // Custom Bottom Navigation Bar
      ),
    );
  }

  // Builds the AppBar
  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      // Removed backgroundColor, using a gradient instead
      elevation: 2, // Subtle shadow
      flexibleSpace: Container(
        // Added flexibleSpace
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: <Color>[
              Color(0xFF42a5f5), // Top color
              Color(0xFFb3e5fc), // Bottom color
            ],
          ),
        ),
      ),
      title: const Text(
        'SPARSH',
        style: TextStyle(
          color: Colors.white, // Changed title color to white for better visibility
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
      iconTheme:
      const IconThemeData(color: Colors.white), // Drawer icon color, changed to white
      actions: [
        IconButton(
          icon: const Icon(Icons.notifications_none,
              size: 30, color: Colors.white), //changed to white
          onPressed: () {
            // TODO: Implement notification action
            print('Notifications tapped');
          },
        ),
        IconButton(
          icon: const Icon(Icons.search, size: 30, color: Colors.white),
          onPressed: () {
            // TODO: Implement search action
            print('Search tapped');
          },
        ),
      ],
    );
  }

  // Builds the Navigation Drawer
  Widget _buildDrawer() {
    return Drawer(
      backgroundColor: Colors.white,
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: const BoxDecoration(
              color: Colors.blue, // Consider using Theme colors
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Error handling for image loading is good
                Image.asset(
                  'assets/image27.png', // Ensure this asset exists in pubspec.yaml
                  height: 80,
                  errorBuilder: (context, error, stackTrace) {
                    print('Error loading drawer header image: $error');
                    return const Icon(Icons.business,
                        size: 80, color: Colors.white); // Placeholder icon
                  },
                ),
                const SizedBox(height: 8),
                const Text(
                  'Birla White Ltd.',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
          // Helper method for creating drawer items
          _buildDrawerItem('Transactions', Icons.swap_horiz),
          _buildDrawerItem('Reports', Icons.assessment),
          _buildDrawerItem('Masters', Icons.folder),
          _buildDrawerItem('Exports', Icons.import_export),
          _buildDrawerItem('CASC', Icons.category),
          _buildDrawerItem('Miscellaneous', Icons.widgets),
          _buildDrawerItem('Advertisement', Icons.campaign),
          // Add other drawer items as needed
        ],
      ),
    );
  }

  // Helper to build individual drawer list items
  Widget _buildDrawerItem(String title, IconData icon) {
    return ListTile(
      leading: Icon(icon, color: Colors.blueGrey),
      title: Text(title, style: const TextStyle(fontSize: 16)),
      trailing:
      const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
      onTap: () {
        // TODO: Implement navigation logic for each drawer item
        print('$title tapped');
        Navigator.pop(context); // Close the drawer after selection
        // Example navigation:
        // if (title == 'Reports') {
        //  Navigator.push(context, MaterialPageRoute(builder: (context) => ReportsScreen()));
        // }
      },
    );
  }

  // Builds the custom Bottom Navigation Bar
  Widget _buildBottomBar() {
    // Define items for the bottom bar
    final List<Map<String, dynamic>> bottomNavItems = [
      {'icon': Icons.home, 'label': 'Home'},
      {'icon': Icons.task, 'label': 'Tasks'},
      {'icon': Icons.mail, 'label': 'Mail'},
      {'icon': Icons.person, 'label': 'Profile'},
    ];

    return Container(
      // Add some elevation or decoration if desired
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, -1), // changes position of shadow upwards
          ),
        ],
      ),
      padding:
      const EdgeInsets.symmetric(vertical: 10.0, horizontal: 5.0), // Adjust padding
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(bottomNavItems.length, (index) {
          final item = bottomNavItems[index];
          final isSelected = _selectedIndex == index;
          return GestureDetector(
            onTap: () {
              // Update the selected index to change the screen
              setState(() {
                _selectedIndex = index;
              });
              print("Tapped: ${item['label']}");
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200), // Animation duration
              padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20), // More rounded corners
                color: isSelected
                    ? Colors.blue.withOpacity(0.15) // Slightly stronger highlight
                    : Colors.transparent,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min, // Important for Column in Row
                children: [
                  Icon(
                    item['icon'],
                    size: isSelected ? 30 : 28, // Adjust size difference
                    color: isSelected
                        ? Colors.blue
                        : Colors.grey[600], // Use theme/specific colors
                  ),
                  const SizedBox(height: 4),
                  Text(
                    item['label'],
                    style: TextStyle(
                      fontSize: 12, // Slightly smaller text
                      color: isSelected ? Colors.blue : Colors.grey[600],
                      fontWeight: isSelected
                          ? FontWeight.bold
                          : FontWeight.normal,
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
}

// Content Widget for the Home Tab
class HomeContent extends StatefulWidget {
  const HomeContent({super.key});

  @override
  State<HomeContent> createState() => _HomeContentState();
}

class _HomeContentState extends State<HomeContent> {
  late ScrollController _scrollController;
  Timer? _autoScrollTimer; // Make Timer nullable
  double _scrollPosition = 0.0;
  // Define image paths for the banner
  final List<String> _bannerImagePaths = [
    'assets/image1.png',
    'assets/image21.jpg',
    'assets/image22.jpg',
    'assets/image23.jpg',
    'assets/image24.jpg',
  ];

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    // Start timer only if there's more than one banner item
    if (_bannerImagePaths.length > 1) {
      _startAutoScroll();
    }

    // Add listener to restart timer if user scrolls manually
    _scrollController.addListener(() {
      if (_scrollController.position.isScrollingNotifier.value == false) {
        // Optional: Debounce this if it triggers too often
        _restartAutoScroll();
      }
    });
  }

  int _currentIndex = 0;

  void _startAutoScroll() {
    _autoScrollTimer?.cancel(); // Cancel existing timer
    _autoScrollTimer = Timer.periodic(const Duration(seconds: 3), (timer) {
      if (!_scrollController.hasClients) {
        timer.cancel();
        return;
      }

      double itemWidth = MediaQuery.of(context).size.width; // Full screen width per banner
      double spacing = 10; // Or get from your actual item padding/margin
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
    // Add a small delay before restarting after manual scroll
    Future.delayed(const Duration(seconds: 5), () {
      if (mounted && _bannerImagePaths.length > 1) {
        // Check if widget is still mounted
        _startAutoScroll();
      }
    });
  }

  @override
  void dispose() {
    _autoScrollTimer?.cancel(); // Cancel timer safely
    _scrollController.removeListener(_restartAutoScroll); // Remove listener
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Get screen dimensions once
    final Size screenSize = MediaQuery.of(context).size;
    final double screenWidth = screenSize.width;
    final double screenHeight = screenSize.height;

    return SingleChildScrollView(
      // Allows the whole column to scroll if needed
      child: Padding(
        padding: const EdgeInsets.all(12.0), // Consistent padding
        child: Column(
          crossAxisAlignment:
          CrossAxisAlignment.start, // Align titles to the left
          children: [
            const SizedBox(height: 10),
            _banner(screenWidth, screenHeight), // Banner Section
            const SizedBox(height: 20),
            _sectionTitle("Mostly Used Apps"), // Reusable title widget
            const SizedBox(height: 10),
            _mostlyUsedApps(screenWidth, screenHeight),
            const SizedBox(height: 20),
            const HorizontalMenu(), // Horizontal Filter Menu
            const SizedBox(height: 20),
            _sectionTitle("Quick Menu"), // Reusable title widget
            const SizedBox(height: 10),
            _quickMenu(screenHeight, screenWidth) // Quick Menu Grid Section
          ],
        ),
      ),
    );
  }

  // Reusable Section Title Widget
  Widget _sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 4.0), // Slight indent
      child: MediaQuery(
        data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
        child: Text(
          '$title',
          style: const TextStyle(fontSize: 16),
        ),
      ),
    );
  }

  // Builds the Quick Menu Grid Section
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
    ];
    final double itemWidth = screenWidth / 4;

    return MediaQuery(
      data: MediaQuery.of(context).copyWith(
          textScaleFactor: 1.0), // Lock text scale here
      child: Container(
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
            return _buildQuickMenuItem(item['image']!, item['label']!, itemWidth);
          },
        ),
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
          style: const TextStyle(
            fontSize: 12,
            color: Colors.black,
          ),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }

  // Builds the Mostly Used Apps Section
  Widget _mostlyUsedApps(double screenWidth, double screenHeight) {
    final List<Map<String, String>> mostlyUsedItems = [
      {'image': 'assets/image33.png', 'label': 'DSR', 'route': 'dsr'},
      {
        'image': 'assets/image34.png',
        'label': 'Staff\nAttendance',
        'route': 'attendance'
      },
      {
        'image': 'assets/image35.png',
        'label': 'DSR\nException',
        'route': 'dsr_exception'
      },
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
                  MaterialPageRoute(builder: (context) => const DsrEntry()),
                );
              } else if (item['route'] == 'scanner') {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ScannerScreen()),
                );
              }
              // TODO: Add navigation for 'attendance' and 'dsr_exception'
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
          shadowColor: Colors.grey.withOpacity(0.5),
          child: Container(
            width: 56,
            height: 56,
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.0),
              color: Colors.white,
            ),
            child: Image.asset(
              imagePath,
              fit: BoxFit.contain,
              errorBuilder: (context, error, stackTrace) {
                print('Error loading mostly used image ($imagePath): $error');
                return const Icon(Icons.error_outline,
                    color: Colors.red); // Placeholder
              },
            ),
          ),
        ),
        const SizedBox(height: 8),
        MediaQuery(
          data: MediaQueryData.fromWindow(WidgetsBinding.instance.window)
              .copyWith(textScaleFactor: 1.0),
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 12, color: Colors.black87),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  // Builds the Auto-Scrolling Banner Section
  Widget _banner(double screenWidth, double screenHeight) {
    // Use screenWidth obtained in build method
    return SizedBox(
      height: screenHeight * 0.2, // Adjust height as needed
      child: ListView.builder(
        controller: _scrollController,
        scrollDirection: Axis.horizontal,
        itemCount: _bannerImagePaths.length,
        itemBuilder: (context, index) {
          // Add spacing between items except for the last one
          return Padding(
            padding: EdgeInsets.only(
                right: index < _bannerImagePaths.length - 1 ? 10.0 : 0.0),
            child: _buildBannerItem(
                screenWidth, screenHeight, _bannerImagePaths[index]),
          );
        },
      ),
    );
  }

  // Builds individual banner items
  Widget _buildBannerItem(
      double screenWidth, double screenHeight, String imagePath) {
    return Container(
      width: screenWidth - (2 * 12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0), // Rounded corners for banners
        border: Border.all(
          color: Colors.grey.shade400,
          width: 1.0,
        ), // Slightly lighter border
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(
            7.0), // Slightly less than container border radius
        child: Image.asset(
          imagePath,
          fit: BoxFit.cover, // Use cover to fill the container, might crop
          errorBuilder: (context, error, stackTrace) {
            print('Error loading banner image ($imagePath): $error');
            return Container(
                color: Colors.grey.shade200,
                child: const Center(
                    child: Icon(Icons.image_not_supported,
                        color: Colors.grey))); // Placeholder
          },
        ),
      ),
    );
  }
}

// Horizontal Filter Menu Widget
class HorizontalMenu extends StatefulWidget {
  const HorizontalMenu({super.key});

  @override
  State<HorizontalMenu> createState() => _HorizontalMenuState();
}

class _HorizontalMenuState extends State<HorizontalMenu> {
  String selected = "Quick Menu"; // Default selection

  final List<String> menuItems = [
    "Quick Menu",
    "Dashboard",
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
                    color: isSelected
                        ? Colors.blue
                        : Colors.grey.shade400),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                padding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              ),
              onPressed: () {
                setState(() {
                  selected = label;
                });
                print('$label selected');
              },
              child: MediaQuery(
                data: MediaQuery.of(context).copyWith(
                    textScaleFactor: 1.0),
                child: Text(
                  label,
                  style: const TextStyle(
                      fontWeight: FontWeight.w500, fontSize: 14),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
