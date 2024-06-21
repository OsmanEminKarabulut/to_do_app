import 'package:flutter/material.dart';

class CardButton extends StatelessWidget {
  const CardButton({super.key, required this.onPressed, required this.text});

  final VoidCallback onPressed;
  final String text;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Material(
        borderRadius: BorderRadius.circular(30),
        elevation: 5,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            gradient: const LinearGradient(
              begin: Alignment.centerRight,
              end: Alignment.centerLeft,
              colors: [Color(0xFFD8605B), Color(0xFFF4C27F)],
            ),
          ),
          child: Card(
            elevation: 0,
            color: Colors.transparent,
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(30))),
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 85 / 100,
              height: 70,
              child: Center(
                child: Text(
                  text,
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      color: Colors.white, fontWeight: FontWeight.w600),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
