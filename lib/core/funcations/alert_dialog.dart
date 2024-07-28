import 'package:flutter/material.dart';

void buildAlertDialog({
  required String title,
  required Widget widget,
  required context,
  required Function clearStack,
}) {
  showDialog(
    context: context,
    builder: (_) => AlertDialog(
      elevation: 5,
      title: Text(title),
      content: SizedBox(
        height: 90,
        child: Column(
          children: [
            const Divider(
              color: Colors.black,
            ),
            widget,
            const SizedBox(
              height: 7,
            ),
          ],
        ),
      ),
    ),
    barrierDismissible: true,
    barrierColor: Colors.grey.withOpacity(.3),
  ).then((_) {
    clearStack();
  });
}
