import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class ImagePickerController extends GetxController {
  Rx<File?> image = Rx<File?>(null);

  Future<void> getImage(ImageSource source) async {
    final ImagePicker picker = ImagePicker();

    final XFile? pickedImage = await picker.pickImage(source: source);
    if (pickedImage != null) {
      image.value = File(pickedImage.path);
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
}
