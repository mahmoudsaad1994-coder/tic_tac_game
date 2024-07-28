import 'package:flutter/material.dart';

import '../../../../../core/widget/custom_button.dart';
import '../../manager/app_cubit.dart';

class FooterView extends StatelessWidget {
  const FooterView({Key? key, required this.cubit}) : super(key: key);
  final AppCubit cubit;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            CustomButton(
              isSwitch: true,
              icon: Icons.person_rounded,
              playerName: 'FRIEND',
              onPress: () {
                cubit.playWithAiORFriend(true);
              },
            ),
            CustomButton(
              isSwitch: false,
              icon: Icons.computer_rounded,
              playerName: 'AI',
              onPress: () {
                cubit.playWithAiORFriend(false);
              },
            ),
          ],
        ),
        const SizedBox(
          height: 5,
        ),
        ElevatedButton.icon(
          onPressed: () {
            cubit.clearStack();
          },
          icon: const Icon(Icons.replay),
          label: const Text('Repeat the game'),
          style: ButtonStyle(
            backgroundColor:
                MaterialStateProperty.all(Theme.of(context).splashColor),
          ),
        )
      ],
    );
  }
}
