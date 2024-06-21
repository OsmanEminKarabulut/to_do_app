import 'package:flutter/material.dart';

class TextfieldCard extends StatelessWidget {
  const TextfieldCard(
      {super.key, required this.controller, required this.label});

  final TextEditingController controller;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 85 / 100,
        height: 60,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 20),
          child: TextField(
            controller: controller,
            decoration: InputDecoration(
              labelText: label,
              border: InputBorder.none,
            ),
          ),
        ),
      ),
    );
  }
}
