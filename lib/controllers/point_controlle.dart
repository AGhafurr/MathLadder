import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:get/get.dart';

class PointController extends GetxController {
  String ip = '192.168.1.1';
  final dio = Dio();

  Future<void> updateUserPoint({
    required String id,
    required int point,
  }) async {
    var headers = {'Content-Type': 'application/json'};
    var data = json.encode({"id": id, "point": point});
    var response = await dio.request(
      'http://$ip:3000/api/point/update-point',
      options: Options(
        method: 'POST',
        headers: headers,
      ),
      data: data,
    );

    if (response.statusCode == 200) {
      print(json.encode(response.data));
    } else {
      print(response.statusMessage);
    }
  }
}
