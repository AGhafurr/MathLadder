import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'leader_board_controller.dart';

class LeaderBoard extends StatefulWidget {
  const LeaderBoard({super.key});

  @override
  State<LeaderBoard> createState() => _LeaderBoardState();
}

class _LeaderBoardState extends State<LeaderBoard> {
  final leaderBoardController = Get.put(LeaderBoardController());
  final _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: const Color(0xffFFFFFF),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: const Icon(
              Icons.question_mark_outlined,
              color: Color(0xff6FA6FF),
            ),
            iconSize: 36,
            onPressed: () {},
            color: Colors.black,
          ),
        ],
        title: const Text(
          "Leaderboard",
          style: TextStyle(
            color: Colors.black,
            fontSize: 13,
            fontFamily: 'Vollkorn',
          ),
        ),
        leading: Container(
            margin: const EdgeInsets.only(left: 16),
            child: Image.asset("assets/images/login.png")),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                width: MediaQuery.of(context).size.width * 0.86,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: TextField(
                  controller: _searchController,
                  decoration: const InputDecoration(
                    hintText: 'Find your rival ......',
                    prefixIcon: Icon(Icons.search),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(vertical: 10),
                  ),
                  onChanged: (value) {},
                ),
              ),
            ),
            const SizedBox(height: 20),
            Center(
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Column(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 20),
                            Obx(() {
                              return leaderBoardController.leaderBoard[0]
                                          ['id'] ==
                                      ''
                                  ? Text('0')
                                  : Text(
                                      '${leaderBoardController.leaderBoard[0]['users']['username']}',
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    );
                            }),
                            SizedBox(height: 8),
                            CircleAvatar(
                              backgroundImage: NetworkImage('url_to_image_2'),
                              radius: 40,
                            ),
                            SizedBox(height: 10),
                            Obx(() {
                              return leaderBoardController.leaderBoard[0]
                                          ['id'] ==
                                      ''
                                  ? Text('0')
                                  : Text(
                                      '${leaderBoardController.leaderBoard[0]['point']}');
                            }),
                          ],
                        ),
                        SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Column(
                              children: [
                                Obx(() {
                                  return leaderBoardController.leaderBoard[1]
                                              ['id'] ==
                                          ''
                                      ? Text('username')
                                      : Text(
                                          '${leaderBoardController.leaderBoard[1]['users']['username']}',
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold),
                                        );
                                }),
                                SizedBox(height: 8),
                                CircleAvatar(
                                  backgroundImage:
                                      NetworkImage('url_to_image_1'),
                                  radius: 40,
                                ),
                                SizedBox(height: 10),
                                Obx(() {
                                  return leaderBoardController.leaderBoard[1]
                                              ['id'] ==
                                          ''
                                      ? Text('0')
                                      : Text(
                                          '${leaderBoardController.leaderBoard[1]['point']}');
                                }),
                              ],
                            ),
                            SizedBox(width: 100),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(height: 40),
                                Obx(() {
                                  return leaderBoardController.leaderBoard[2]
                                              ['id'] ==
                                          ''
                                      ? Text('')
                                      : Text(
                                          '${leaderBoardController.leaderBoard[2]['users']['username']}',
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold),
                                        );
                                }),
                                SizedBox(height: 8),
                                CircleAvatar(
                                  backgroundImage:
                                      NetworkImage('url_to_image_3'),
                                  radius: 40,
                                ),
                                SizedBox(height: 10),
                                Obx(() {
                                  return leaderBoardController.leaderBoard[2]
                                              ['id'] ==
                                          ''
                                      ? Text('0')
                                      : Text(
                                          '${leaderBoardController.leaderBoard[2]['point']}',
                                        );
                                }),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: 20),
                      ],
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Padding(
                          padding: EdgeInsets.all(25),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment
                                .spaceBetween, // Menggunakan MainAxisAlignment.spaceBetween
                            children: [
                              Text(
                                "4. Rangga Ferdinand",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15,
                                  fontFamily: 'Vollkorn',
                                ),
                              ),
                              Text(
                                "500 point",
                                style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 15,
                                  fontFamily: 'Vollkorn',
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Padding(
                          padding: EdgeInsets.all(25),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment
                                .spaceBetween, // Menggunakan MainAxisAlignment.spaceBetween
                            children: [
                              Text(
                                "5. Ivan Ally",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15,
                                  fontFamily: 'Vollkorn',
                                ),
                              ),
                              Text(
                                "450 point",
                                style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 15,
                                  fontFamily: 'Vollkorn',
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Padding(
                          padding: EdgeInsets.all(25),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment
                                .spaceBetween, // Menggunakan MainAxisAlignment.spaceBetween
                            children: [
                              Text(
                                "6. Akmall",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15,
                                  fontFamily: 'Vollkorn',
                                ),
                              ),
                              Text(
                                "420 point",
                                style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 15,
                                  fontFamily: 'Vollkorn',
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Padding(
                          padding: EdgeInsets.all(25),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment
                                .spaceBetween, // Menggunakan MainAxisAlignment.spaceBetween
                            children: [
                              Text(
                                "7. Ekyy ",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15,
                                  fontFamily: 'Vollkorn',
                                ),
                              ),
                              Text(
                                "340 point",
                                style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 15,
                                  fontFamily: 'Vollkorn',
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
