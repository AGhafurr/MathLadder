import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:math_ladder/controllers/auth_controller.dart';
import 'package:math_ladder/controllers/point_controlle.dart';
import 'dart:async';
import 'dart:math';
import 'package:math_ladder/features/gamePage/winner_page.dart';

class GamePage extends StatefulWidget {
  final String dificuty;

  const GamePage({Key? key, required this.dificuty}) : super(key: key);

  Future<Map<String, dynamic>> loadQuestions() async {
    final String questionsJson =
        await rootBundle.loadString('assets/datas/questions.json');
    Map<String, dynamic> questions = json.decode(questionsJson);
    return questions;
  }

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  final authController = Get.put(AuthController());
  final pointController = Get.put(PointController());
  final player = AudioPlayer();

  var loadedQuestions = [];
  int diceNumber = 1;
  int pawnPosition = 0;
  int winningPosition = 63;
  List<int> questionBoxes = [];
  bool diceClicked = false;
  int timerValue = 0;
  late Timer _timer;
  List<int> randomNumbers = [];
  String yourAnswer = '';
  int point = 0;

  @override
  void initState() {
    super.initState();
    generateQuestionBoxes();
    loadQuestions();
  }

  void playMusic() async {
    player.setAsset('assets/sounds/pop up quest.mp3');
    player.play();
  }

  void playMusic1() async {
    player.setAsset('assets/sounds/wrong answer.mp3');
    player.play();
  }

  void playMusic2() async {
    player.setAsset('assets/sounds/Dice Roll Sound Effects.mp3');
    player.play();
  }

  void playMusic3() async {
    player.setAsset('assets/sounds/right answer.mp3');
    player.play();
  }

  void playMusic4() async {
    player.setAsset('assets/sounds/Sound effect yeay.mp3');
    player.play();
  }

  int generateRandomNumber() {
    final random = Random();
    return random.nextInt(32);
  }

  Future<void> loadQuestions() async {
    Map<String, dynamic> questions = await widget.loadQuestions();
    var selectedDificulty = widget.dificuty == 'Beginner'
        ? questions['questions']['beginner']
        : widget.dificuty == 'Intermediate'
            ? questions['questions']['intermediate']
            : questions['questions']['advance'];
    setState(() {
      loadedQuestions = selectedDificulty;
    });
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
        questionBoxes.add(randomBox);
      }
    }
  }

  void showQuestionDialog(int boxNumber) {
    int index = generateRandomNumber();
    playMusic();
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: Text(
          'Quiz BOX $boxNumber',
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontFamily: 'Poppins',
          ),
        ),
        content: SingleChildScrollView(
          child: Container(
            decoration: const BoxDecoration(
                color: Color(0xffFE9696),
                borderRadius: BorderRadius.all(Radius.circular(10))),
            padding: const EdgeInsets.all(15),
            child: Text(
              '${loadedQuestions[index]['question']}',
              style: const TextStyle(
                fontSize: 24,
                color: Colors.white,
                fontFamily: 'Poppins',
              ),
            ),
          ),
        ),

        actions: [
          Row(
            children: [
              const Expanded(child: SizedBox()),
              TextButton(
                onPressed: () {
                  setState(() {
                    yourAnswer = loadedQuestions[index]['options']['a'];
                  });
                  if (yourAnswer == loadedQuestions[index]['answer']) {
                    playMusic3();
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: const Text('Jawaban Benar'),
                          content: Text('Maju $diceNumber langkah'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                                Navigator.of(context).pop();
                              },
                              child: const Text('Ok'),
                            ),
                          ],
                        );
                      },
                    );
                    setState(() {
                      point += 40;
                    });
                    setState(() {
                      pawnPosition = (pawnPosition + diceNumber) % 64;
                    });
                  } else {
                    playMusic1();
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: const Text('Jawaban Salah'),
                          content: Text('Mundur $diceNumber langkah'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                                Navigator.of(context).pop();
                              },
                              child: const Text('Ok'),
                            ),
                          ],
                        );
                      },
                    );
                    setState(() {
                      pawnPosition = (pawnPosition - diceNumber) % 64;
                    });
                  }
                  setState(() {
                    yourAnswer = '';
                  });
                },
                style: ButtonStyle(
                  padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                    const EdgeInsets.all(10),
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
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                ),
                child: Text(
                  '${loadedQuestions[index]['options']['a']}',
                  style: const TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontFamily: 'Poppins',
                  ),
                ), // Ganti teks sesuai kebutuhan
              ),
              const Expanded(child: SizedBox()),
              TextButton(
                onPressed: () {
                  setState(() {
                    yourAnswer = loadedQuestions[index]['options']['b'];
                  });
                  if (yourAnswer == loadedQuestions[index]['answer']) {
                    playMusic3();
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: const Text('Jawaban Benar'),
                          content: Text('Maju $diceNumber langkah'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                                Navigator.of(context).pop();
                              },
                              child: const Text('Ok'),
                            ),
                          ],
                        );
                      },
                    );
                    setState(() {
                      point += 40;
                    });
                    setState(() {
                      pawnPosition = (pawnPosition + diceNumber) % 64;
                    });
                  } else {
                    playMusic1();
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: const Text('Jawaban Salah'),
                          content: Text('Mundur $diceNumber langkah'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                                Navigator.of(context).pop();
                              },
                              child: const Text(
                                'Ok',
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    );
                    setState(() {
                      pawnPosition = (pawnPosition - diceNumber) % 64;
                    });
                  }
                  setState(() {
                    yourAnswer = '';
                  });
                  // Logika saat memilih pilihan 1
                },
                style: ButtonStyle(
                  padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                    const EdgeInsets.all(10),
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
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                ),
                child: Text(
                  '${loadedQuestions[index]['options']['b']}',
                  style: const TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontFamily: 'Poppins',
                  ),
                ), // Ganti teks sesuai kebutuhan
              ),
              const Expanded(child: SizedBox()),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              const Expanded(child: SizedBox()),
              TextButton(
                onPressed: () {
                  setState(() {
                    yourAnswer = loadedQuestions[index]['options']['c'];
                  });
                  if (yourAnswer == loadedQuestions[index]['answer']) {
                    playMusic3();
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: const Text('Jawaban Benar'),
                          content: Text('Maju $diceNumber langkah'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                                Navigator.of(context).pop();
                              },
                              child: const Text(
                                'Ok',
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    );
                    setState(() {
                      point += 40;
                    });
                    setState(() {
                      pawnPosition = (pawnPosition + diceNumber) % 64;
                    });
                  } else {
                    playMusic1();
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: const Text('Jawaban Salah'),
                          content: Text('Mundur $diceNumber langkah'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                                Navigator.of(context).pop();
                              },
                              child: const Text('Ok'),
                            ),
                          ],
                        );
                      },
                    );
                    setState(() {
                      pawnPosition = (pawnPosition - diceNumber) % 64;
                    });
                  }
                  setState(() {
                    yourAnswer = '';
                  });
                  // Logika saat memilih pilihan 1
                },
                style: ButtonStyle(
                  padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                    const EdgeInsets.all(10),
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
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                ),
                child: Text(
                  '${loadedQuestions[index]['options']['c']}',
                  style: const TextStyle(
                      fontSize: 20, color: Colors.white, fontFamily: 'Poppins'),
                ), // Ganti teks sesuai kebutuhan
              ),
              const Expanded(child: SizedBox()),
              TextButton(
                onPressed: () {
                  setState(() {
                    yourAnswer = loadedQuestions[index]['options']['d'];
                  });
                  if (yourAnswer == loadedQuestions[index]['answer']) {
                    playMusic3();
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: const Text('Jawaban Benar'),
                          content: Text('Maju $diceNumber langkah'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                                Navigator.of(context).pop();
                              },
                              child: const Text('Ok'),
                            ),
                          ],
                        );
                      },
                    );
                    setState(() {
                      point += 40;
                    });
                    setState(() {
                      pawnPosition = (pawnPosition + diceNumber) % 64;
                    });
                  } else {
                    playMusic1();
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: const Text('Jawaban Salah'),
                          content: Text('Mundur $diceNumber langkah'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                                Navigator.of(context).pop();
                              },
                              child: const Text('Ok'),
                            ),
                          ],
                        );
                      },
                    );
                    setState(() {
                      pawnPosition = (pawnPosition - diceNumber) % 64;
                    });
                  }
                  setState(() {
                    yourAnswer = '';
                  });
                  // Logika saat memilih pilihan 1
                },
                style: ButtonStyle(
                  padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                    const EdgeInsets.all(10),
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
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                ),
                child: Text(
                  '${loadedQuestions[index]['options']['d']}',
                  style: const TextStyle(
                      fontSize: 20, color: Colors.white, fontFamily: 'Poppins'),
                ), // Ganti teks sesuai kebutuhan
              ),
              const Expanded(child: SizedBox()),
            ],
          )
        ],
        // Gaya AlertDialog
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        backgroundColor: Colors.white,
        elevation: 10,
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
        playMusic();
        showQuestionDialog(pawnPosition);
      }
    });
  }

  void showGameEndDialog(String winnerMessage) {
    if (timerValue <= 180) {
      if (widget.dificuty == 'Beginner') {
        setState(() {
          point += 40;
        });
      } else if (widget.dificuty == 'Intermediate') {
        setState(() {
          point += 50;
        });
      } else if (widget.dificuty == 'Advanced') {
        setState(() {
          point += 60;
        });
      }
    } else if (timerValue <= 500) {
      if (widget.dificuty == 'Beginner') {
        setState(() {
          point += 30;
        });
      } else if (widget.dificuty == 'Intermediate') {
        setState(() {
          point += 40;
        });
      } else if (widget.dificuty == 'Advanced') {
        setState(() {
          point += 50;
        });
      }
    } else if (timerValue <= 420) {
      if (widget.dificuty == 'Beginner') {
        setState(() {
          point += 20;
        });
      } else if (widget.dificuty == 'Intermediate') {
        setState(() {
          point += 30;
        });
      } else if (widget.dificuty == 'Advanced') {
        setState(() {
          point += 40;
        });
      }
    }
    pointController.updateUserPoint(
      id: authController.user['id'],
      point: point,
    );
    playMusic4();

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: const Text('Game Selesai!'),
        content: Text(winnerMessage),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => WinnerPage(
                    point: point,
                    timerValue: timerValue,
                  ),
                ),
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
            child: const Text(
              'OK',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontFamily: 'Poppins',
              ),
            ),
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
                      child: Text(
                        '$point',
                        style: const TextStyle(
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
