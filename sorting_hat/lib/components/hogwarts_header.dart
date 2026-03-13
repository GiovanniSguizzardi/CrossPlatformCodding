import 'package:flutter/material.dart';
import 'package:sorting_hat/components/hogwarts_logo.dart';

class HogwartsHeader extends StatelessWidget {
  const HogwartsHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        HogwartsLogo(),
        Text("e o chapéu seletor",
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold
        ),)
      ],
    );
  }
}