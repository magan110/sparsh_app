import 'package:flutter/material.dart';
import 'package:learning2/dsr_entry_screen/dsr_entry.dart';
import 'package:learning2/dsr_entry_screen/dsr_retailer_in_out.dart';
import 'package:learning2/dsr_entry_screen/phone_call_with_builder.dart';
import 'package:learning2/screens/splash_screen.dart';

void main() {
  runApp(const MaterialApp(debugShowCheckedModeBanner:false,
      home: PhoneCallWithBuilder()));
}

