import 'package:flutter/material.dart';
import 'package:sidebarx/sidebarx.dart';

class SideBarTheme {
  static const canvasColor = Colors.white;
  static const white = Colors.black;
  static final actionColor =
      const Color.fromARGB(255, 67, 196, 216).withOpacity(0.6);

  static final divider = Divider(color: white.withOpacity(0.3), height: 1);

  static final sideBarTheme = SidebarXTheme(
    margin: const EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: canvasColor,
      borderRadius: BorderRadius.circular(20),
    ),
    textStyle: const TextStyle(color: Colors.black),
    selectedTextStyle:
        const TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
    itemTextPadding: const EdgeInsets.only(left: 30),
    selectedItemTextPadding: const EdgeInsets.only(left: 30),
    itemDecoration: BoxDecoration(
      border: Border.all(color: canvasColor),
    ),
    selectedItemDecoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      border: Border.all(
        color: Colors.blue,
      ),
    ),
    iconTheme: const IconThemeData(
      color: Colors.black,
      size: 20,
    ),
  );

  static const extendedTheme = SidebarXTheme(
    width: 200,
    decoration: BoxDecoration(
      color: canvasColor,
    ),
    margin: EdgeInsets.only(right: 10),
  );
}
