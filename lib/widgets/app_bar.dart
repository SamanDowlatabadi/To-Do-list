import 'package:flutter/material.dart';

AppBar appBar(BuildContext context) {
  return AppBar(
    backgroundColor: Colors.white,
    surfaceTintColor: Colors.white,
    toolbarHeight: MediaQuery.of(context).size.height * 0.05,
    title: const Text(
      'To-Do List',
      style: TextStyle(
        fontSize: 25,
        fontWeight: FontWeight.w900,
      ),
    ),
  );
}
