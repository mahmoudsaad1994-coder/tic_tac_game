import 'package:flutter/material.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tic Tac'),
        centerTitle: true,
        backgroundColor: Theme.of(context).primaryColor,
      ),
      resizeToAvoidBottomInset: false,
      // body: const HomeScreen(),
    );
  }
}
