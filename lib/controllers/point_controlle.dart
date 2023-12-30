import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:get/get.dart';

class PointController extends GetxController {
  String ip = 'https://math-ladder-api-39c64285572b.herokuapp.com';
  final dio = Dio();

  Future<void> updateUserPoint({
    required String id,
    required int point,
  }) async {
    var headers = {'Content-Type': 'application/json'};
    var data = json.encode({"id": id, "point": point});
    var response = await dio.request(
      '$ip/api/point/update-point',
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
