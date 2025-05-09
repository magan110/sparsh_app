import 'package:flutter/material.dart';
import 'package:learning2/screens/Home_screen.dart';
import 'package:learning2/screens/splash_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildProfileHeader(),
            const SizedBox(height: 20),
            _buildSectionTitle('Account Info'),
            _buildTextField('Username*'),
            _buildTextField('Email Address*'),
            _buildTextField('Phone Number*'),
            const SizedBox(height: 20),
            _buildSectionTitle('Dashboard Report'),
            _buildDropdownField('Select Report*'),
            const SizedBox(height: 20),
            _buildSectionTitle('Personal Info'),
            _buildDropdownField('Gender*'),
            _buildTextField('Address*'),
            const SizedBox(height: 30),
            _buildLogoutButton(context),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileHeader() {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(color: Colors.black12, blurRadius: 6, offset: Offset(0, 2)),
        ],
      ),
      child: Row(
        children: [
          const CircleAvatar(
            radius: 30,
            backgroundImage:
                AssetImage('assets/avatar.png'), // Replace with actual asset
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text('Magan',
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                Text('ID  S2948', style: TextStyle(color: Colors.black54)),
                Text('IT Department', style: TextStyle(color: Colors.black45)),
              ],
            ),
          ),
          const Icon(Icons.edit, color: Colors.black54),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
          fontSize: 16, fontWeight: FontWeight.bold, color: Colors.blue),
    );
  }

  Widget _buildTextField(String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),
    );
  }

  Widget _buildDropdownField(String label) {
    List<DropdownMenuItem<String>> items = [];

    if (label == 'Gender*') {
      items = const [
        DropdownMenuItem(value: 'Male', child: Text('Male')),
        DropdownMenuItem(value: 'Female', child: Text('Female')),
        DropdownMenuItem(value: 'Other', child: Text('Other')),
      ];
    } else if (label == 'Select Report*') {
      items = const [
        DropdownMenuItem(value: 'Sales Summary', child: Text('Sales Summary')),
        DropdownMenuItem(value: 'DSR VIST', child: Text('DSR VIST')),
        DropdownMenuItem(value: 'Token Scan', child: Text('Token Scan')),
      ];
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: DropdownButtonFormField<String>(
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        ),
        items: items,
        onChanged: (value) {},
      ),
    );
  }

  Widget _buildLogoutButton(context) {
    return Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(colors: [Colors.blue, Colors.indigo]),
        borderRadius: BorderRadius.circular(10),
      ),
      child: ElevatedButton(
        onPressed: () async {
          // Show a confirmation dialog
          final bool? confirmLogout = await showDialog<bool>(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('Logout'),
              content: const Text('Are you sure you want to logout?'),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: const Text('Cancel'),
                ),
                TextButton(
                  onPressed: () => Navigator.of(context).pop(true),
                  child: const Text('Logout'),
                ),
              ],
            ),
          );

          // If the user confirmed the logout, proceed with clearing shared preferences and navigating
          if (confirmLogout == true) {
            final prefs = await SharedPreferences.getInstance();
            await prefs.clear();
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => SplashScreen()),
            );
          }
          // If the user cancelled, do nothing.  The dialog already closed.
        },
        style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          padding: const EdgeInsets.symmetric(vertical: 14.0),
        ),
        child: const Text('Logout',
            style: TextStyle(fontSize: 16, color: Colors.white)),
      ),
    );
  }
}
