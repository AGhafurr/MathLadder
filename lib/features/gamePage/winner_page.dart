import 'package:flutter/material.dart';

class WinnerPage extends StatefulWidget {
  const WinnerPage({super.key});

  @override
  State<WinnerPage> createState() => _WinnerPageState();
}

class _WinnerPageState extends State<WinnerPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Center(
          child: Column(
            children: [
              const SizedBox(height: 40),
              const Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "RED",
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 35,
                      fontFamily: 'Vollkorn',
                    ),
                  ),
                  SizedBox(width: 10),
                  Text(
                    "WINNER!",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 30,
                      fontFamily: 'Vollkorn',
                    ),
                  )
                ],
              ),
              Image.asset(
                "assets/images/winner.png",
                height: 330,
              ),
              const Text(
                "Take No Time",
                style: TextStyle(
                  color: Color(0xff6FA6FF),
                  fontSize: 34,
                  fontFamily: 'Vollkorn',
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                "you answered very quickly!",
                style: TextStyle(
                  color: Color(0xff9FAABD),
                  fontSize: 20,
                  fontFamily: 'Vollkorn',
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: const Color(0xffF75050),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        children: [
                          const Text(
                            "Point",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontFamily: 'Vollkorn',
                            ),
                          ),
                          Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 20, right: 20, bottom: 10, top: 10),
                                child: Row(
                                  children: [
                                    Image.asset(
                                      "assets/images/point.png",
                                      height: 30,
                                    ),
                                    const Text(
                                      "45",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 20,
                                        fontFamily: 'Vollkorn',
                                      ),
                                    )
                                  ],
                                ),
                              ))
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 20),
                  Container(
                    decoration: BoxDecoration(
                      color: const Color(0xff6FA6FF),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        children: [
                          const Text(
                            "Time",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontFamily: 'Vollkorn',
                            ),
                          ),
                          Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 20, right: 20, bottom: 10, top: 10),
                                child: Row(
                                  children: [
                                    Image.asset(
                                      "assets/images/time.png",
                                      height: 30,
                                    ),
                                    const SizedBox(width: 5),
                                    const Text(
                                      "2:26",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 20,
                                        fontFamily: 'Vollkorn',
                                      ),
                                    )
                                  ],
                                ),
                              ))
                        ],
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(height: 80),
              TextButton(
                onPressed: () {},
                style: ButtonStyle(
                  fixedSize: MaterialStateProperty.all<Size>(
                    const Size(280, 50),
                  ),
                  backgroundColor: MaterialStateProperty.resolveWith<Color?>(
                    (Set<MaterialState> states) {
                      if (states.contains(MaterialState.pressed)) {
                        return const Color(0xff6FA6FF);
                      }
                      return const Color(0xffF75050);
                    },
                  ),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                child: const Text(
                  "Back To Course",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontFamily: 'Vollkorn',
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
