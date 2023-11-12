// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

class CustomAlertDialog extends StatelessWidget {
  final String title;
  final String content;
  final List<Widget>? actions;
  const CustomAlertDialog({
    Key? key,
    required this.title,
    required this.content,
    this.actions,
  }) : super(key: key);

  factory CustomAlertDialog.error({
    required String content,
  }) {
    return CustomAlertDialog(
      title: 'Sorry',
      content: content,
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(content),
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.transparent,
      actions: [
        TextButton(
          onPressed: () {
            Get.back();
          },
          child: const Text('OK'),
        )
      ],
    );
  }
}
