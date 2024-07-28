import 'package:flutter/material.dart';

import '../../../../../core/widget/field_number_widget.dart';
import '../../manager/app_cubit.dart';

class FieldsViewWidget extends StatelessWidget {
  const FieldsViewWidget({Key? key, required this.cubit}) : super(key: key);
  final AppCubit cubit;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GridView.count(
        crossAxisCount: 3,
        padding: const EdgeInsets.all(15),
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        childAspectRatio: 1,
        children: List.generate(
          9,
          (index) => FieldNumberWidget(
            cubit: cubit,
            index: index,
          ),
        ),
      ),
    );
  }
}
