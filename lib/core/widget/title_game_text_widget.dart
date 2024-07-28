import 'package:flutter/material.dart';

class TitleGameTextWidget extends StatelessWidget {
  const TitleGameTextWidget(
      {Key? key, required this.title, required this.player})
      : super(key: key);
  final String title;
  final String player;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 80,
              color: Color.fromARGB(255, 3, 141, 254),
              shadows: [
                Shadow(
                    blurRadius: 15,
                    color: Color.fromARGB(255, 90, 170, 226),
                    offset: Offset(0, 0)),
              ],
            ),
          ),
        ),
        Text(player),
      ],
    );
  }
}
