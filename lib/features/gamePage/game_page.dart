import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:math';

import 'package:math_ladder/features/gamePage/winner_page.dart';

class GamePage extends StatefulWidget {
  const GamePage({Key? key}) : super(key: key);

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  int diceNumber = 1;
  int pawnPosition = 0;
  int winningPosition = 63;
  List<int> questionBoxes = [];
  bool diceClicked = false;
  int timerValue = 0;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    generateQuestionBoxes();
  }

  void generateQuestionBoxes() {
    final random = Random();
    questionBoxes.clear();
    while (questionBoxes.length < 25) {
      final randomBox = random.nextInt(64);
      if (!questionBoxes.contains(randomBox) &&
          randomBox != 0 &&
          randomBox != winningPosition &&
          randomBox != 1 &&
          randomBox != 2 &&
          randomBox != 3) {
        // Hindari kotak 3
        questionBoxes.add(randomBox);
      }
    }
  }

  void showQuestionDialog(int boxNumber) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: Text('Pertanyaan Kotak $boxNumber'),
        content: Text('Ini adalah pertanyaan untuk kotak nomor $boxNumber.'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void rollDice() {
    setState(() {
      if (!diceClicked) {
        diceClicked = true;
        _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
          setState(() {
            timerValue++;
          });
        });
      }

      int maxDiceNumber = 6;
      if (pawnPosition >= 58) {
        maxDiceNumber = 63 - pawnPosition;
      }

      diceNumber = Random().nextInt(maxDiceNumber) + 1;
      pawnPosition = (pawnPosition + diceNumber) % 64;

      if (pawnPosition >= winningPosition) {
        pawnPosition = winningPosition - (pawnPosition - winningPosition);
        _timer.cancel();
        showGameEndDialog('Game Selesai!');
        return;
      }

      if (questionBoxes.contains(pawnPosition)) {
        showQuestionDialog(pawnPosition);
      }
    });
  }

  void showGameEndDialog(String winnerMessage) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: const Text('Game Selesai!'),
        content: Text(winnerMessage),
        actions: [
          TextButton(
            onPressed: () {
              resetGame();
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const WinnerPage()),
              );
            },
            style: ButtonStyle(
              fixedSize: MaterialStateProperty.all<Size>(
                const Size(80, 50),
              ),
              backgroundColor: MaterialStateProperty.resolveWith<Color?>(
                (Set<MaterialState> states) {
                  if (states.contains(MaterialState.pressed)) {
                    return const Color(0xffFFFFFF);
                  }
                  return const Color(0xff6FA6FF);
                },
              ),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void resetGame() {
    setState(() {
      diceNumber = 1;
      pawnPosition = 0;
      diceClicked = false;
      timerValue = 0;
    });
    _timer.cancel();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const GamePage()),
    );
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  String getTimerText(int seconds) {
    int minutes = seconds ~/ 60;
    int remainingSeconds = seconds % 60;
    return '$minutes:$remainingSeconds ';
  }

  List<Widget> buildBoard() {
    List<Widget> rows = [];
    for (int i = 7; i >= 0; i--) {
      List<Widget> squares = [];
      for (int j = 0; j < 8; j++) {
        final index = i * 8 + j;
        final isQuestionBox = questionBoxes.contains(index) && index > 2;

        squares.add(
          Container(
            width: 46.9,
            height: 46.9,
            decoration: BoxDecoration(
              border: Border.all(color: const Color(0xff6FA6FF), width: 1),
              color: isQuestionBox ? const Color(0xffFE9696) : null,
            ),
            child: (index == pawnPosition)
                ? const Icon(Icons.circle, color: Colors.blue, size: 20)
                : null,
          ),
        );
      }
      rows.add(Row(children: squares));
    }
    return rows;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Center(
            child: Column(
              children: [
                const SizedBox(height: 80),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      decoration: const BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: Colors.red, // Warna garis bawah
                            width: 2, // Ketebalan garis
                          ),
                        ),
                      ),
                      child: const Text(
                        '365',
                        style: TextStyle(
                          fontSize: 45,
                          color: Colors.red,
                          fontFamily: 'Unlock',
                        ),
                      ),
                    ),
                    // Container untuk poin pemain B
                    Container(
                      decoration: const BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: Colors.blue, // Warna garis bawah
                            width: 2, // Ketebalan garis
                          ),
                        ),
                      ),
                      // Gunakan Opacity untuk membuat poin B buram jika giliran A yang sedang main
                      child: Text(
                        getTimerText(timerValue),
                        style: const TextStyle(
                          fontSize: 45,
                          color: Colors.blue,
                          fontFamily: 'Unlock',
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 60),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.blue, width: 8),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(children: buildBoard()),
                ),
                const SizedBox(height: 50),
                GestureDetector(
                  onTap: rollDice,
                  child: Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Image.asset(
                        'assets/images/dice_$diceNumber.png',
                        width: 95,
                        height: 95,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
