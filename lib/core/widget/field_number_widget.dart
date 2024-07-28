import 'package:flutter/material.dart';

import '../../feature/home/presentation/manager/app_cubit.dart';

class FieldNumberWidget extends StatelessWidget {
  const FieldNumberWidget({Key? key, required this.cubit, required this.index})
      : super(key: key);
  final AppCubit cubit;
  final int index;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: cubit.gameOver
          ? null
          : (cubit.playerO.contains(index) || cubit.playerX.contains(index))
              ? null
              : () => cubit.onTap(index, context),
      borderRadius: BorderRadius.circular(16),
      child: Container(
        child: Center(
          child: Text(
            cubit.playerX.contains(index)
                ? 'X'
                : cubit.playerO.contains(index)
                    ? 'O'
                    : '',
            style: TextStyle(
              color: cubit.playerX.contains(index) ? Colors.blue : Colors.pink,
              fontSize: 50,
            ),
          ),
        ),
        decoration: BoxDecoration(
          color: Theme.of(context).shadowColor,
          borderRadius: BorderRadius.circular(16),
        ),
      ),
    );
  }
}
