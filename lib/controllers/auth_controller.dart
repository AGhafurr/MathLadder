import 'dart:convert';

import 'package:get/get.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:dio/dio.dart';

class AuthController extends GetxController {
  String ip = 'https://math-ladder-api-39c64285572b.herokuapp.com';
  late IO.Socket socket;
  final dio = Dio();
  final isLoggedIn = false.obs;
  final user = {}.obs;

  @override
  void onInit() {
    super.onInit();
    initSocket();
  }

  void initSocket() {
    socket = IO.io('$ip', <String, dynamic>{
      'autoConnect': false,
      'transports': ['websocket'],
    });

    socket.on('INITIAL_SESSION', (data) {
      print('INITIAL_SESSION : $data');
      if (data['session'] != null) {
        isLoggedIn.value = true;
        getUserData(id: data['session']['user']['id']);
      }
    });

    socket.on('SIGNED_IN', (data) {
      print('SIGNED_IN : $data');
      if (data['session'] != null) {
        isLoggedIn.value = true;
        getUserData(id: data['session']['user']['id']);
      }
    });

    socket.on('SIGNED_OUT', (data) {
      print('SIGNED_OUT : $data');
      isLoggedIn.value = false;
      user.value = {};
    });

    socket.connect();
  }

  Future<void> getUserData({required String id}) async {
    var headers = {'Content-Type': 'application/json'};
    var data = json.encode({"id": id});
    var response = await dio.request(
      '$ip:3000/api/user/me',
      options: Options(
        method: 'POST',
        headers: headers,
      ),
      data: data,
    );

    if (response.statusCode == 200) {
      user.value = response.data[0];
      print(user);
    } else {
      print(response.statusMessage);
    }
  }

  Future<void> signUp({
    required String username,
    required String email,
    required String password,
  }) async {
    var headers = {'Content-Type': 'application/json'};
    var data = json.encode({
      "username": username,
      "email": email,
      "password": password,
    });
    var response = await dio.request(
      '$ip/api/auth/sign-up',
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

  Future<void> signIn({
    required String email,
    required String password,
  }) async {
    var headers = {'Content-Type': 'application/json'};
    var data = json.encode({
      "email": email,
      "password": password,
    });
    var response = await dio.request(
      '$ip/api/auth/sign-in',
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

  Future<void> signOut() async {
    var response = await dio.request(
      '$ip/api/auth/sign-out',
      options: Options(
        method: 'POST',
      ),
    );

    if (response.statusCode == 200) {
      print(json.encode(response.data));
    } else {
      print(response.statusMessage);
    }
  }

  @override
  void onClose() {
    socket.disconnect();
    super.onClose();
  }
}
