import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../controllers/auth_controller.dart';
import 'edit_profile_controller.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final authController = Get.put(AuthController());
  final editProfileController = Get.put(EditProfileController());
  final userNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffEDF6FF),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              const SizedBox(height: 90),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.white, // Ganti dengan warna yang diinginkan
                    ),
                    child: IconButton(
                      icon: const Icon(
                        Icons.arrow_back_ios_outlined,
                        color: Colors.blue,
                      ),
                      iconSize: 36,
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              Stack(
                alignment: Alignment.center,
                children: [
                  GestureDetector(
                    onTap: () async {
                      await editProfileController.getImage(ImageSource.camera);
                    },
                    child: Container(
                      width: 230,
                      height: 230,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: const Color(0xffEDF6FF),
                          width: 3, // Ketebalan border
                        ),
                      ),
                      child: Obx(() {
                        return editProfileController.image.value != null
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(100),
                                child: Image.file(
                                  editProfileController.image.value!,
                                  width: 250,
                                  height: 250,
                                ),
                              )
                            : Container();
                      }),
                    ),
                  ),
                  Positioned(
                    top: 180,
                    left: 150,
                    child: GestureDetector(
                      onTap: () {
                        _showImageSourceDialog();
                      },
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                        ),
                        child: Image.asset(
                          'assets/images/camera.png',
                          width: 30,
                          height: 30,
                          color: Colors.blue,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 50),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 35),
                child: TextFormField(
                  controller: userNameController,
                  decoration: InputDecoration(
                    hintText: 'Username',
                    labelText: 'Change Name',
                    filled: true, // Mengaktifkan background berwarna
                    fillColor: Colors.white, // Warna background
                    border: InputBorder.none, // Menghilangkan border
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 14,
                        horizontal: 12), // Atur ukuran padding konten
                  ),
                  keyboardType: TextInputType.text,
                ),
              ),
              const SizedBox(height: 50),
              TextButton(
                onPressed: () {
                  editProfileController.updateProfile(
                    id: authController.user['id'],
                    username: userNameController.text,
                  );
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.resolveWith<Color?>(
                    (Set<MaterialState> states) {
                      if (states.contains(MaterialState.pressed)) {
                        return const Color(0xff5F54A3);
                      }
                      return const Color(0xff6FA6FF);
                    },
                  ),
                  padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                    const EdgeInsets.symmetric(
                      horizontal: 80,
                      vertical: 10,
                    ),
                  ),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
                child: const Text(
                  "Edit Profil",
                  style: TextStyle(
                    color: Color(0xffFDFDFD),
                    fontSize: 20,
                    fontFamily: 'Poppins',
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showImageSourceDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            'Image Source',
            textAlign: TextAlign.center,
          ),
          content: SingleChildScrollView(
              child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                onPressed: () {
                  editProfileController.getImage(ImageSource.camera);
                  Navigator.pop(context);
                },
                style: ButtonStyle(
                  padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                    const EdgeInsets.all(10),
                  ),
                  backgroundColor: MaterialStateProperty.resolveWith<Color?>(
                    (Set<MaterialState> states) {
                      if (states.contains(MaterialState.pressed)) {
                        return const Color(0xffFFFFFF);
                      }
                      return const Color(0xff6FA6FF);
                    },
                  ),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                ),
                child: const Text(
                  'Camera',
                  style: TextStyle(
                      fontSize: 15, color: Colors.white, fontFamily: 'Poppins'),
                ), // Ganti teks sesuai kebutuhan
              ),
              const SizedBox(width: 20),
              TextButton(
                onPressed: () {
                  editProfileController.getImage(ImageSource.gallery);
                  Navigator.pop(context);
                },
                style: ButtonStyle(
                  padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                    const EdgeInsets.all(10),
                  ),
                  backgroundColor: MaterialStateProperty.resolveWith<Color?>(
                    (Set<MaterialState> states) {
                      if (states.contains(MaterialState.pressed)) {
                        return const Color(0xffFFFFFF);
                      }
                      return const Color(0xff6FA6FF);
                    },
                  ),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                ),
                child: const Text(
                  'Galerry',
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.white,
                    fontFamily: 'Poppins',
                  ),
                ), // Ganti teks sesuai kebutuhan
              ),
            ],
          )),
        );
      },
    );
  }
}
