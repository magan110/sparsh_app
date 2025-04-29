import 'package:flutter/material.dart';

class TextModel {
  //Text
  MediaQuery buildText(BuildContext context, String str) {
    return MediaQuery(
        data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
        child: Text(
          str,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ));
  }

//
}
