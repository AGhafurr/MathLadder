import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Response, FormData, MultipartFile;
import 'package:image_picker/image_picker.dart';

class EditProfileController extends GetxController {
  final dio = Dio();
  Rx<File?> image = Rx<File?>(null);
  XFile? pick;

  Future<void> getImage(ImageSource source) async {
    final ImagePicker picker = ImagePicker();

    final XFile? pickedImage = await picker.pickImage(source: source);
    pick = await picker.pickImage(source: source);
    if (pickedImage != null) {
      image.value = File(pickedImage.path);
      print('path : ${pickedImage.name}');
    } else {
      Get.defaultDialog(
        title: 'No Image Selected',
        middleText: 'Please select an image to proceed.',
        barrierDismissible: false, // Pengguna harus menekan OK
        textConfirm: 'OK',
        confirmTextColor: Colors.white,
        onConfirm: () {
          Get.back(); // Menutup dialog
        },
      );
    }
  }

  Future<void> updateProfile({
    required String id,
    required String username,
  }) async {
    var data = FormData.fromMap({
      'profile_picture': [
        await MultipartFile.fromFile(
          '${image.value!.path}',
          filename: '${image.value!.path}',
        )
      ],
      'id': id
    });

    var response = await dio.request(
      'http://192.168.1.205:3000/api/user/update-profile-picture',
      options: Options(
        method: 'POST',
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
