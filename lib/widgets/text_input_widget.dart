import 'package:flutter/material.dart';

class TextInputWidget extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onPressed;

  TextInputWidget({required this.controller, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          controller: controller,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Enter article text',
          ),
          maxLines: 6,
        ),
        SizedBox(height: 16),
        ElevatedButton(
          onPressed: onPressed,
          child: Text('Get Summary'),
        ),
      ],
    );
  }
}
