import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../controllers/image_picker_controller.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final ImagePickerController _imagePickerController =
      Get.put(ImagePickerController());
  final TextEditingController _userNameController = TextEditingController();

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
              Stack(
                alignment: Alignment.bottomRight,
                children: [
                  GestureDetector(
                    onTap: () async {
                      await _imagePickerController.getImage(ImageSource.camera);
                    },
                    child: Obx(() {
                      return _imagePickerController.image.value != null
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(100),
                              child: Image.file(
                                _imagePickerController.image.value!,
                                width: 250,
                                height: 250,
                              ),
                            )
                          : const Text('Pick Your Gorgeous Picture');
                    }),
                  ),
                  IconButton(
                    onPressed: () {
                      _showImageSourceDialog();
                    },
                    icon: const Icon(
                      Icons.camera_alt,
                      color: Colors.blue,
                      size: 40,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              const Text(
                'Username',
                style: TextStyle(
                  fontSize: 15,
                  fontFamily: 'Vollkorn',
                ),
                textAlign: TextAlign.left,
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: _userNameController,
                decoration: InputDecoration(
                  hintText: 'Username',
                  labelText: 'Username',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                keyboardType: TextInputType.text,
              ),
              const SizedBox(height: 50),
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(const Color(0xff6FA6FF)),
                  side: MaterialStateProperty.all(
                      const BorderSide(color: Color(0xff01294D), width: 1)),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                    const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                  ),
                  elevation: MaterialStateProperty.all<double>(5),
                ),
                onPressed: () {},
                child: const Text(
                  "Submit",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontFamily: 'Vollkorn',
                  ),
                ),
              ),
              const SizedBox(height: 10),
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
          title: const Text('Select Image Source'),
          content: SingleChildScrollView(
            child: ListBody(
              children: [
                GestureDetector(
                  onTap: () {
                    _imagePickerController.getImage(ImageSource.camera);
                    Navigator.pop(context);
                  },
                  child: const Text('Camera'),
                ),
                const SizedBox(height: 20),
                GestureDetector(
                  onTap: () {
                    _imagePickerController.getImage(ImageSource.gallery);
                    Navigator.pop(context);
                  },
                  child: const Text('Gallery'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
