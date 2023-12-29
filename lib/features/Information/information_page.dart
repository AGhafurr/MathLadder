import 'package:flutter/material.dart';

class InformationPage extends StatefulWidget {
  const InformationPage({Key? key}) : super(key: key);

  @override
  State<InformationPage> createState() => _InformationPageState();
}

class _InformationPageState extends State<InformationPage> {
  List<Map<String, String>> studentData = [
    {'name': 'Eky Zakariah', 'nim': '202110370311101'},
    {'name': 'Ivan Ally Ramadhan', 'nim': '202110370311105'},
    {'name': 'Abdul Ghafur', 'nim': '202110370311109'},
    {'name': 'Ulil Fikri Warvana', 'nim': '202110370311131'},
    {'name': 'Akmal Shahib Maulana', 'nim': '202110370311135'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 70),
            Image.asset(
              'assets/images/Logo.png',
              height: 210,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                // Your existing text remains the same
                "MathLadder adalah sebuah inovasi dalam dunia pendidikan yang menggabungkan keasyikan permainan ular tangga dengan kecerdasan uji matematika. Dalam permainan ini, pada papan ular tangga secara random menghadirkan kesempatan bagi para pemain untuk menguji pengetahuan matematika mereka melalui beragam pertanyaan dan tantangan yang menantang. MathLadder tidak hanya sekadar menyuguhkan kegembiraan dalam bermain, tetapi juga menjadi wadah yang menginspirasi pemahaman mendalam tentang konsep-konsep matematika secara interaktif. Dengan suasana yang menyenangkan dan penuh kegembiraan, MathLadder menciptakan lingkungan belajar yang memotivasi tanpa membuat bosan.",
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 15,
                ),
                textAlign: TextAlign.justify,
              ),
            ),
            const SizedBox(height: 30),
            const Text(
              "Credit to:",
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            Center(
              child: ListView.builder(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                itemCount: studentData.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(
                      studentData[index]['name'] ?? '',
                      style: const TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    subtitle: Text(
                      studentData[index]['nim'] ?? '',
                      style: const TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 14,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
