import 'package:flutter/material.dart';

class BoardingPage extends StatelessWidget {
  const BoardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Expanded(child: SizedBox()),
            Image.asset(
              "assets/images/boarding1.png",
              height: 300,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 40, right: 100),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Lorem Ipsum",
                    style: TextStyle(fontSize: 30),
                  ),
                  SizedBox(height: 20),
                  Text(
                    "Lorem ipsum dolor sit amet consectetur. Nisl eget et id dolor varius feugiat velit venenatis. Lorem vitae vitae arcu proin eleifend. In dui non dignissim sodales platea. Proin imperdiet fermentum habitant amet velit quis.",
                    style: TextStyle(
                      fontSize: 15,
                    ),
                  )
                ],
              ),
            ),
            Expanded(child: SizedBox()),
          ],
        ),
      ),
    );
  }
}
