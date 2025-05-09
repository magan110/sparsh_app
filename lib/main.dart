import 'dart:io';

import 'package:flutter/material.dart';
import 'package:learning2/dsr_entry_screen/Meeting_with_new_purchaser.dart';
import 'package:learning2/dsr_entry_screen/Meetings_With_Contractor.dart';
import 'package:learning2/dsr_entry_screen/any_other_activity.dart';
import 'package:learning2/dsr_entry_screen/btl_activites.dart';
import 'package:learning2/dsr_entry_screen/check_sampling_at_site.dart';
import 'package:learning2/dsr_entry_screen/dsr_entry.dart';
import 'package:learning2/dsr_entry_screen/dsr_retailer_in_out.dart';
import 'package:learning2/dsr_entry_screen/internal_team_meeting.dart';
import 'package:learning2/dsr_entry_screen/office_work.dart';
import 'package:learning2/dsr_entry_screen/on_leave.dart';
import 'package:learning2/dsr_entry_screen/phone_call_with_builder.dart';
import 'package:learning2/dsr_entry_screen/work_from_home.dart';
import 'package:learning2/reports/Gerneral%20Reports/account_statement.dart';
import 'package:learning2/reports/SAP%20Reports/day_summary.dart';
import 'package:learning2/reports/SAP%20Reports/day_wise_summary.dart';
import 'package:learning2/reports/Sales%20Report/sales_growth.dart';
import 'package:learning2/reports/scheme_discount/rpl_outlet_tracker.dart';
import 'package:learning2/screens/Home_screen.dart';
import 'package:learning2/screens/login_screen.dart';
import 'package:learning2/screens/splash_screen.dart';

import 'dart:io'; // Import the dart:io library, which is necessary for HttpClient and HttpOverrides.
import 'package:flutter/material.dart'; // Import the Flutter material library.

void main() {
  // This is the entry point of your Flutter application.
  HttpOverrides.global = MyHttpOverrides();
  // It sets up the basic app structure and starts with the SplashScreen.
  runApp(const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen() // Sets SplashScreen as the initial screen
  ));
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    // Override the createHttpClient method to customize HTTP client behavior.
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port) =>
      true; // This is the crucial part: it accepts *any* certificate.
  }
}

