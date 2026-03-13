import 'package:flutter/material.dart';

enum SortingState {idle, sorting, result}

class SortingButton extends StatelessWidget {
  const SortingButton({super.key, required this.state, required this.onPressed});

  final SortingState state;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {

    String text;
    switch(state) {
      case SortingState.idle:
        text = "Descobrir minha casa";
        break;
      case SortingState.sorting:
        text = "Pensando...";
      case SortingState.result:
        text = "Sua casa foi escolhida!";
        break;
    }

    return Padding(
      padding: EdgeInsetsGeometry.symmetric(horizontal: 40),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Color(0xFF5D4037),
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18)
          )
        ),
        onPressed: state == SortingState.idle ? onPressed : null, 
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("assets/images/icone_chapeu_seleto.png",
            height: 40,
            color: Colors.white
            ),
            SizedBox(width: 12,),
            Text(text, style: TextStyle(fontSize: 18),)
          ],
        ),
        ),
      );
  }
}