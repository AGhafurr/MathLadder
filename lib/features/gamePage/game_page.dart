import 'package:flutter/material.dart';
import 'dart:math';

class GamePage extends StatefulWidget {
  const GamePage({Key? key}) : super(key: key);

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  int diceNumber = 1;
  int redPawnPosition = 0;
  int bluePawnPosition = 0;
  bool isRedTurn = true;
  int pointA = 352; // Poin pemain A
  int pointB = 352; // Poin pemain B

  void rollDice() {
    setState(() {
      diceNumber = Random().nextInt(6) + 1; // Angka acak antara 1 dan 6

      // Menggerakkan bidak sesuai angka dadu
      if (isRedTurn) {
        redPawnPosition = (redPawnPosition + diceNumber) % 64;
      } else {
        bluePawnPosition = (bluePawnPosition + diceNumber) % 64;
      }

      // Mengganti giliran
      isRedTurn = !isRedTurn;
    });
  }

  List<Widget> buildBoard() {
    List<Widget> rows = [];
    for (int i = 0; i < 8; i++) {
      List<Widget> squares = [];
      for (int j = 0; j < 8; j++) {
        squares.add(
          Container(
            width: 46.9,
            height: 46.9,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.blue, width: 1),
            ),
            child: (i * 8 + j) == redPawnPosition
                ? const Icon(Icons.circle, color: Colors.red, size: 20)
                : ((i * 8 + j) == bluePawnPosition
                    ? const Icon(Icons.circle, color: Colors.blue, size: 20)
                    : null),
          ),
        );
      }
      rows.add(Row(children: squares));
    }
    return rows;
  }

  String getCurrentPlayerLabel() {
    return isRedTurn ? 'Giliran: Merah' : 'Giliran: Biru';
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
                const SizedBox(height: 50),
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
                      child: Opacity(
                        opacity: !isRedTurn ? 0.3 : 1.0,
                        child: Text(
                          '$pointA',
                          style: const TextStyle(
                            fontSize: 45,
                            color: Colors.red,
                            fontFamily: 'Unlock',
                          ),
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
                      child: Opacity(
                        opacity: isRedTurn ? 0.3 : 1.0,
                        child: Text(
                          '$pointB',
                          style: const TextStyle(
                            fontSize: 45,
                            color: Colors.blue,
                            fontFamily: 'Unlock',
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 60),
                // Tabel ular tangga
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.blue, width: 8),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(children: buildBoard()),
                ),
                const SizedBox(height: 50),
                // Area dadu
                GestureDetector(
                  onTap: rollDice, // Panggil fungsi untuk mengubah angka dadu
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
