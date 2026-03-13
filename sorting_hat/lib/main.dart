import 'dart:math';

import 'package:flutter/material.dart';
import 'package:sorting_hat/components/sorting_button.dart';

void main() {
  runApp(SortingHatApp());
}

class SortingHatApp extends StatelessWidget {
  const SortingHatApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Chapéu Seletor",
      debugShowCheckedModeBanner: false,
      home: SortingHatScreen(),
    );
  }
}

class SortingHatScreen extends StatefulWidget {
  const SortingHatScreen({super.key});

  @override
  State<SortingHatScreen> createState() => _SortingHatScreenState();
}

class _SortingHatScreenState extends State<SortingHatScreen> {
  SortingState state = SortingState.idle;
  List<String> houses = ["Grifinória", "Sonserina", "Lufa-Lufa", "Corvinal"];

  String houseSelected = "";

  Future<void> sortHouse() async {
    final random = Random();

    setState(() {
      houseSelected = "";
      state = SortingState.sorting;
    });

    await Future.delayed(const Duration(seconds: 3));

    setState(() {
      houseSelected = houses[random.nextInt(houses.length)];
      state = SortingState.result;
    });

    await Future.delayed(const Duration(seconds: 3));

    setState(() {
      houseSelected = houses[random.nextInt(houses.length)];
      state = SortingState.idle;
    });

  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [SortingButton(state: state, onPressed: sortHouse)],
    );
  }
}
