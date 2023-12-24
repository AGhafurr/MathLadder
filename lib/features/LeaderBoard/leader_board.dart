// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';

class LeaderBoard extends StatefulWidget {
  const LeaderBoard({Key? key});

  @override
  State<LeaderBoard> createState() => _LeaderBoardState();
}

class _LeaderBoardState extends State<LeaderBoard> {
  final TextEditingController _searchController = TextEditingController();

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
                    hintText: 'Cari...',
                    prefixIcon: Icon(Icons.search),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(vertical: 10),
                  ),
                  onChanged: (value) {},
                ),
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Column(
                            children: [
                              Text(
                                'Username 2',
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: 8),
                              CircleAvatar(
                                backgroundImage: NetworkImage('url_to_image_1'),
                                radius: 40,
                              ),
                              Text('Point Juara 1'),
                            ],
                          ),
                          SizedBox(width: 20),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Username 1',
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: 8),
                              CircleAvatar(
                                backgroundImage: NetworkImage('url_to_image_2'),
                                radius: 40,
                              ),
                              Text('Point Juara 2'),
                            ],
                          ),
                          SizedBox(width: 20),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                'Username 3',
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: 8),
                              CircleAvatar(
                                backgroundImage: NetworkImage('url_to_image_3'),
                                radius: 40,
                              ),
                              Text('Point Juara 3'),
                            ],
                          ),
                          SizedBox(height: 20),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Text("Isi Halaman Leader Board"),
                    // Isi halaman Leader Board lainnya disini
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
