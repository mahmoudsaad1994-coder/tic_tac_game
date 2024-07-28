import 'package:flutter/material.dart';

import '../../../../../core/widget/title_game_text_widget.dart';

class TitleGame extends StatelessWidget {
  const TitleGame({Key? key, required this.isSwitched}) : super(key: key);
  final bool isSwitched;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.18,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          TitleGameTextWidget(
            title: 'X',
            player: isSwitched ? 'Player 1' : 'Player',
          ),
          const Text(
            'vs',
            style: TextStyle(
                fontSize: 25, color: Color.fromARGB(255, 3, 141, 254)),
          ),
          TitleGameTextWidget(
            title: 'O',
            player: isSwitched ? 'Player 2' : 'AI',
          ),
        ],
      ),
    );
  }
}
