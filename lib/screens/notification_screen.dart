import 'package:flutter/material.dart';
import 'package:learning2/screens/Home_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SPARSH Notifications',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: NotificationScreen(),
    );
  }
}

class NotificationScreen extends StatelessWidget {
  final List<NotificationItem> notifications = [
    NotificationItem(
      icon: Icons.check,
      message: 'Your order #12345 has been confirmed and is being processed.',
      status: 'Completed',
      statusColor: Colors.green,
      iconColor: Colors.green[800]!,
      iconBgColor: Colors.green[100]!,
      date: DateTime.now().subtract(Duration(minutes: 5)),
    ),
    NotificationItem(
      icon: Icons.currency_rupee,
      message: 'Payment of ₹1,500 has been processed successfully.',
      status: 'Completed',
      statusColor: Colors.green,
      iconColor: Colors.green[800]!,
      iconBgColor: Colors.green[100]!,
      date: DateTime.now().subtract(Duration(hours: 2)),
    ),
    NotificationItem(
      icon: Icons.discount,
      message: 'Special 20% discount on all electronics. Limited time offer!',
      status: 'Cancelled',
      statusColor: Colors.red,
      iconColor: Colors.red[800]!,
      iconBgColor: Colors.red[100]!,
      date: DateTime.now().subtract(Duration(days: 1)),
    ),
    NotificationItem(
      icon: Icons.local_shipping,
      message: 'Your package is out for delivery.',
      status: 'In Progress',
      statusColor: Colors.blue,
      iconColor: Colors.blue[800]!,
      iconBgColor: Colors.blue[100]!,
      date: DateTime.now().subtract(Duration(days: 3)),
    ),
    NotificationItem(
      icon: Icons.person,
      message: 'Your profile has been successfully updated.',
      status: 'In Progress',
      statusColor: Colors.blue,
      iconColor: Colors.blue[800]!,
      iconBgColor: Colors.blue[100]!,
      date: DateTime.now().subtract(Duration(days: 7)),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        leading: IconButton(onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen()));
        }, icon: Icon(Icons.arrow_back,color: Colors.white,)),
        title: const Text('SPARSH',style: TextStyle(color: Colors.white),),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: notifications.length,
        itemBuilder: (context, index) {
          return NotificationCard(item: notifications[index]);
        },
      ),
    );
  }
}

class NotificationItem {
  final IconData icon;
  final String message;
  final String status;
  final Color statusColor;
  final Color iconColor;
  final Color iconBgColor;
  final DateTime date;

  NotificationItem({
    required this.icon,
    required this.message,
    required this.status,
    required this.statusColor,
    required this.iconColor,
    required this.iconBgColor,
    required this.date,
  });
}

class NotificationCard extends StatelessWidget {
  final NotificationItem item;

  const NotificationCard({Key? key, required this.item}) : super(key: key);

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inMinutes < 1) {
      return 'Just now';
    } else if (difference.inHours < 1) {
      return '${difference.inMinutes} min ago';
    } else if (difference.inDays < 1) {
      return '${difference.inHours} hours ago';
    } else if (difference.inDays == 1) {
      return 'Yesterday';
    } else if (difference.inDays < 7) {
      return '${difference.inDays} days ago';
    } else {
      return '${date.day}/${date.month}/${date.year}';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: item.iconBgColor,
                shape: BoxShape.circle,
              ),
              child: Icon(
                item.icon,
                color: item.iconColor,
                size: 24,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.message,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: item.statusColor.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          item.status,
                          style: TextStyle(
                            color: item.statusColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        _formatDate(item.date),
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}