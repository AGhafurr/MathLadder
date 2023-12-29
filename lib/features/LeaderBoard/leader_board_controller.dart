import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:get/get.dart';

class LeaderBoardController extends GetxController {
  final leaderBoard = [].obs;
  final dio = Dio();

  @override
  void onInit() {
    super.onInit();
    getLeaderBoardData();
  }

  Future<void> getLeaderBoardData() async {
    var response = await dio.request(
      'http://192.168.1.205:3000/api/point/leader-board',
      options: Options(
        method: 'GET',
      ),
    );

    if (response.statusCode == 200) {
      print(json.encode(response.data));
      leaderBoard.addAll(response.data);
    } else {
      print(response.statusMessage);
    }
  }
}
