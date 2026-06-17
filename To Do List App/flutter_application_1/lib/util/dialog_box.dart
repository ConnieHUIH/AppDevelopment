import 'package:flutter/material.dart';
import 'package:flutter_application_1/util/my_button.dart';

class DialogBox extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onSave;
  final VoidCallback onCancel;
  const DialogBox({
    super.key, 
    required this.controller,
    required this.onSave,
    required this.onCancel,
    });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: const Color.fromARGB(255, 90, 122, 149),
      content: SizedBox(
        height: 120,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
          // get user input
          TextField(
            controller: controller,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: "Add a new task",
              ),
          ),

          //button -> save + cancel
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
            // save button
            MyButton(text: "Save", onPressed: onSave),

            //space
            const SizedBox(width: 8),

            // cancel button
            MyButton(text: "Cancel", onPressed: onCancel),
          ],)
        ]),
      ),
    );
  }
}