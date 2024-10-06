import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../constents/constants.dart';

class ImageInput extends StatefulWidget {
  final void Function(File image) onPickedImage;

  const ImageInput({super.key, required this.onPickedImage});
  @override
  State<ImageInput> createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  File? _selectedImageFile;
  void _takePicture() async {
    final imagePicker = ImagePicker();
    final pickedImage = await imagePicker.pickImage(source: ImageSource.camera,maxWidth: 600);
    if(pickedImage == null){
      return;
    }else{
      //设置图像文件
      setState(() {
        _selectedImageFile = File(pickedImage.path);
      });
      widget.onPickedImage(_selectedImageFile!);
    }
  }
  @override
  Widget build(BuildContext context) {
    Widget content = TextButton.icon(
      icon: const Icon(Icons.camera),
      onPressed: _takePicture,
      label: const Text('Take Picture'),
    );
    if (_selectedImageFile != null) {
      content = GestureDetector(
        onTap: _takePicture,
        child: Image.file(
          _selectedImageFile!,
          fit: BoxFit.cover,
          width: double.infinity,
          height: double.infinity,
        ),
      );
    }
    return kFrameWidget(content: content);
  }
}


