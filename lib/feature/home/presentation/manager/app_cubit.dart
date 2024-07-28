import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tic_tac_app/core/funcations/extension_contains.dart';

import '../../../../core/funcations/alert_dialog.dart';
import 'app_states.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppStatesInitial());

  static AppCubit get(context) => BlocProvider.of(context);

  String activePlayer = 'X';
  int turn = 0;
  bool gameOver = false;
  bool isSwitched = false;
  String result = '';

  onTap(int index, context) async {
    if (playerX.isEmpty && playerO.isEmpty ||
        !playerO.contains(index) ||
        !playerX.contains(index)) {
      playGame(index, activePlayer);
      updateState(context);
      emit(OnTapDoneAppStates());
      if (!isSwitched && !gameOver && turn != 9) {
        await autoPlay(activePlayer);
        updateState(context);
        emit(OnTapDoneAppStates());
      }
    }
  }

  updateState(context) {
    activePlayer = activePlayer == 'X' ? 'O' : 'X';
    turn++;
    String winnerPlayer = checkWinner();

    if (winnerPlayer != '') {
      gameOver = true;

      buildAlertDialog(
        clearStack: clearStack(),
        context: context,
        title: 'Result',
        widget: Column(
          children: [
            Text(
              isSwitched
                  ? winnerPlayer == 'X'
                      ? 'Player 1 are the Winner!!'
                      : 'Player 2 are the Winner!!'
                  : winnerPlayer == 'X'
                      ? 'You are the Winner!!'
                      : 'Loser, try again',
              style: const TextStyle(
                  fontSize: 30, color: Color.fromARGB(255, 3, 141, 254)),
            ),
          ],
        ),
      );
    } else if (!gameOver && turn == 9) {
      gameOver = true;
      buildAlertDialog(
        title: 'Opps!',
        widget: const Column(
          children: [
            Text(
              'Draw, try again',
              style: TextStyle(
                  fontSize: 30, color: Color.fromARGB(255, 3, 141, 254)),
            ),
          ],
        ),
        context: context,
        clearStack: clearStack(),
      );
    }
  }

  playWithAiORFriend(bool isSwitch) {
    isSwitched = isSwitch;
    emit(ChangeSwitchAppStates());
  }

  // players
  List playerX = [];
  List playerO = [];

  clearStack() {
    activePlayer = 'X';
    gameOver = false;
    turn = 0;
    result = '';

    playerX = [];
    playerO = [];
    emit(ClearAppAppStates());
  }

  //game play with fiernd
  void playGame(int index, String activePlayer) {
    if (activePlayer == 'X') {
      playerX.add(index);
      emit(AddIndexToplayerAppStates());
    } else {
      playerO.add(index);
      emit(AddIndexToplayerAppStates());
    }
  }

  //get winner
  String checkWinner() {
    String winner = '';
    if (playerX.containsAll(0, 1, 2) ||
        playerX.containsAll(3, 4, 5) ||
        playerX.containsAll(6, 7, 8) ||
        playerX.containsAll(0, 3, 6) ||
        playerX.containsAll(1, 4, 7) ||
        playerX.containsAll(2, 5, 8) ||
        playerX.containsAll(0, 4, 8) ||
        playerX.containsAll(2, 4, 6)) {
      winner = 'X';
    } else if (playerO.containsAll(0, 1, 2) ||
        playerO.containsAll(3, 4, 5) ||
        playerO.containsAll(6, 7, 8) ||
        playerO.containsAll(0, 3, 6) ||
        playerO.containsAll(1, 4, 7) ||
        playerO.containsAll(2, 5, 8) ||
        playerO.containsAll(0, 4, 8) ||
        playerO.containsAll(2, 4, 6)) {
      winner = 'O';
    } else {
      winner = '';
    }
    return winner;
  }

  //play with ai
  Future<void> autoPlay(activePlayer) async {
    int index = 0;
    List<int> emptyCells = [];

    for (var i = 0; i < 9; i++) {
      if (!(playerO.contains(i) || playerX.contains(i))) {
        emptyCells.add(i);
      }
    }
    //attacks
    //start - center
    if (playerO.containsAll(0, 1) && emptyCells.contains(2))
      index = 2;
    else if (playerO.containsAll(3, 4) && emptyCells.contains(5))
      index = 5;
    else if (playerO.containsAll(6, 7) && emptyCells.contains(8))
      index = 8;
    else if (playerO.containsAll(0, 3) && emptyCells.contains(6))
      index = 6;
    else if (playerO.containsAll(1, 4) && emptyCells.contains(7))
      index = 7;
    else if (playerO.containsAll(2, 5) && emptyCells.contains(8))
      index = 8;
    else if (playerO.containsAll(0, 4) && emptyCells.contains(8))
      index = 8;
    else if (playerO.containsAll(2, 4) && emptyCells.contains(6))
      index = 8;
    // start - end
    else if (playerO.containsAll(0, 2) && emptyCells.contains(1))
      index = 1;
    else if (playerO.containsAll(3, 5) && emptyCells.contains(4))
      index = 4;
    else if (playerO.containsAll(6, 8) && emptyCells.contains(7))
      index = 7;
    else if (playerO.containsAll(0, 6) && emptyCells.contains(3))
      index = 3;
    else if (playerO.containsAll(1, 7) && emptyCells.contains(4))
      index = 4;
    else if (playerO.containsAll(2, 8) && emptyCells.contains(5))
      index = 5;
    else if (playerO.containsAll(0, 8) && emptyCells.contains(4))
      index = 4;
    else if (playerO.containsAll(2, 6) && emptyCells.contains(4))
      index = 4;

    //center - end
    else if (playerO.containsAll(1, 2) && emptyCells.contains(0))
      index = 0;
    else if (playerO.containsAll(4, 5) && emptyCells.contains(3))
      index = 3;
    else if (playerO.containsAll(7, 8) && emptyCells.contains(6))
      index = 6;
    else if (playerO.containsAll(3, 6) && emptyCells.contains(0))
      index = 0;
    else if (playerO.containsAll(4, 7) && emptyCells.contains(1))
      index = 1;
    else if (playerO.containsAll(5, 8) && emptyCells.contains(2))
      index = 2;
    else if (playerO.containsAll(4, 8) && emptyCells.contains(0))
      index = 0;
    else if (playerO.containsAll(4, 6) && emptyCells.contains(2))
      index = 2;
    //defense
    //start - center
    else if (playerX.containsAll(0, 1) && emptyCells.contains(2))
      index = 2;
    else if (playerX.containsAll(3, 4) && emptyCells.contains(5))
      index = 5;
    else if (playerX.containsAll(6, 7) && emptyCells.contains(8))
      index = 8;
    else if (playerX.containsAll(0, 3) && emptyCells.contains(6))
      index = 6;
    else if (playerX.containsAll(1, 4) && emptyCells.contains(7))
      index = 7;
    else if (playerX.containsAll(2, 5) && emptyCells.contains(8))
      index = 8;
    else if (playerX.containsAll(0, 4) && emptyCells.contains(8))
      index = 8;
    else if (playerX.containsAll(2, 4) && emptyCells.contains(6))
      index = 6;
    // start - end
    else if (playerX.containsAll(0, 2) && emptyCells.contains(1))
      index = 1;
    else if (playerX.containsAll(3, 5) && emptyCells.contains(4))
      index = 4;
    else if (playerX.containsAll(6, 8) && emptyCells.contains(7))
      index = 7;
    else if (playerX.containsAll(0, 6) && emptyCells.contains(3))
      index = 3;
    else if (playerX.containsAll(1, 7) && emptyCells.contains(4))
      index = 4;
    else if (playerX.containsAll(2, 8) && emptyCells.contains(5))
      index = 5;
    else if (playerX.containsAll(0, 8) && emptyCells.contains(4))
      index = 4;
    else if (playerX.containsAll(2, 6) && emptyCells.contains(4))
      index = 4;

    //center - end
    else if (playerX.containsAll(1, 2) && emptyCells.contains(0))
      index = 0;
    else if (playerX.containsAll(4, 5) && emptyCells.contains(3))
      index = 3;
    else if (playerX.containsAll(7, 8) && emptyCells.contains(6))
      index = 6;
    else if (playerX.containsAll(3, 6) && emptyCells.contains(0))
      index = 0;
    else if (playerX.containsAll(4, 7) && emptyCells.contains(1))
      index = 1;
    else if (playerX.containsAll(5, 8) && emptyCells.contains(2))
      index = 2;
    else if (playerX.containsAll(4, 8) && emptyCells.contains(0))
      index = 0;
    else if (playerX.containsAll(4, 6) && emptyCells.contains(2))
      index = 2;
    else {
      Random random = Random();

      int randomIndex = random.nextInt(emptyCells.length);
      index = emptyCells[randomIndex];
    }
    playGame(index, activePlayer);
  }
}
