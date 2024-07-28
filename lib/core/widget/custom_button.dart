import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton(
      {Key? key,
      required this.onPress,
      this.icon,
      required this.playerName,
      required this.isSwitch})
      : super(key: key);
  final Function onPress;
  final IconData? icon;
  final String playerName;
  final bool isSwitch;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: () {
            onPress(isSwitch);
          },
          child: Row(
            children: [
              const Icon(Icons.person_rounded),
              const Text(' & '),
              const SizedBox(
                width: 5,
              ),
              Icon(icon),
            ],
          ),
        ),
        Text(
          playerName,
          style: const TextStyle(
            color: Color.fromARGB(255, 3, 141, 254),
          ),
        ),
      ],
    );
  }
}
