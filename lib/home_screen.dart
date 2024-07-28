import 'package:flutter/material.dart';

import 'game_logic.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String activePlayer = 'X';
  bool gameOver = false;
  int turn = 0;
  String result = '';
  Game game = Game();

  bool isSwitched = false;

  _onTap(int index) async {
    if (Player.playerX.isEmpty && Player.playerO.isEmpty ||
        !Player.playerO.contains(index) ||
        !Player.playerX.contains(index)) {
      game.playGame(index, activePlayer);
      _updateState();

      if (!isSwitched && !gameOver && turn != 9) {
        await game.autoPlay(activePlayer);
        _updateState();
      }
    }
  }

  void _updateState() {
    setState(() {
      activePlayer = activePlayer == 'X' ? 'O' : 'X';
      turn++;
      String winnerPlayer = game.checkWinner();

      if (winnerPlayer != '') {
        gameOver = true;

        buildAlertDialog(
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
          widget: Column(
            children: const [
              Text(
                'Draw, try again',
                style: TextStyle(
                    fontSize: 30, color: Color.fromARGB(255, 3, 141, 254)),
              ),
            ],
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    bool _isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;
    var playerActive = Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        buildPlayersTitles(
          'X',
          isSwitched ? 'Player 1' : 'Player',
        ),
        const Text(
          'vs',
          style:
              TextStyle(fontSize: 25, color: Color.fromARGB(255, 3, 141, 254)),
        ),
        buildPlayersTitles(
          'O',
          isSwitched ? 'Player 2' : 'AI',
        ),
      ],
    );
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tic Tac'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () => showDialog(
              context: context,
              builder: (context) => StatefulBuilder(
                  builder: (context, setState) => AlertDialog(
                        title: Text('Settings'),
                        content: Column(
                          children: [
                            Divider(),
                            RadioListTile(
                                value: isSwitched,
                                groupValue: isSwitched,
                                onChanged: (val) {
                                  setState(() {
                                    isSwitched = val as bool;
                                  });
                                }),
                            RadioListTile(
                                value: isSwitched,
                                groupValue: isSwitched,
                                onChanged: (val) {
                                  setState(() {
                                    isSwitched = val as bool;
                                  });
                                }),
                          ],
                        ),
                      )),
            ),
            icon: const Icon(
              Icons.settings_rounded,
            ),
          ),
        ],
        backgroundColor: Theme.of(context).primaryColor,
        elevation: 0,
      ),
      backgroundColor: Theme.of(context).primaryColor,
      body: SafeArea(
        child: _isPortrait
            ? Column(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.18,
                    child: playerActive,
                  ),
                  _expandedButtons(context),
                  _lastBlock(),
                  const SizedBox(
                    height: 5,
                  ),
                ],
              )
            : Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: MediaQuery.of(context).size.height * 0.30,
                          margin: const EdgeInsets.only(bottom: 40),
                          child: playerActive,
                        ),
                        _lastBlock(),
                      ],
                    ),
                  ),
                  _expandedButtons(context),
                ],
              ),
      ),
    );
  }

  Expanded _expandedButtons(BuildContext context) {
    return Expanded(
        child: GridView.count(
            crossAxisCount: 3,
            padding: const EdgeInsets.all(15),
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            childAspectRatio: 1,
            children: List.generate(
                9,
                (index) => InkWell(
                      onTap: gameOver
                          ? null
                          : (Player.playerO.contains(index) ||
                                  Player.playerX.contains(index))
                              ? null
                              : () => _onTap(index),
                      borderRadius: BorderRadius.circular(16),
                      child: Container(
                        child: Center(
                          child: Text(
                            Player.playerX.contains(index)
                                ? 'X'
                                : Player.playerO.contains(index)
                                    ? 'O'
                                    : '',
                            style: TextStyle(
                              color: Player.playerX.contains(index)
                                  ? Colors.blue
                                  : Colors.pink,
                              fontSize: 50,
                            ),
                          ),
                        ),
                        decoration: BoxDecoration(
                          color: Theme.of(context).shadowColor,
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                    ))));
  }

  Column _lastBlock() {
    return Column(children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          buildIsSwitch(true, Icons.person_rounded, 'FRIEND'),
          buildIsSwitch(false, Icons.computer_rounded, 'AI'),
        ],
      ),
      const SizedBox(
        height: 5,
      ),
      ElevatedButton.icon(
        onPressed: () {
          setState(() {
            clearStack();
          });
        },
        icon: const Icon(Icons.replay),
        label: const Text('Repeat the game'),
        style: ButtonStyle(
          backgroundColor:
              MaterialStateProperty.all(Theme.of(context).splashColor),
        ),
      )
    ]);
  }

  void clearStack() {
    activePlayer = 'X';
    gameOver = false;
    turn = 0;
    result = '';

    Player.playerX = [];
    Player.playerO = [];
  }

  TextButton buildPlayersTitles(
    String title,
    String player,
  ) {
    return TextButton(
      onPressed: () {},
      child: Column(
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
      ),
    );
  }

  Column buildIsSwitch(bool isSwitch, IconData icon, String playerName) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: () {
            setState(() {
              isSwitched = isSwitch;
              clearStack();
            });
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

  void buildAlertDialog({
    required String title,
    required Widget widget,
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
      setState(() {
        clearStack();
      });
    });
  }
}
