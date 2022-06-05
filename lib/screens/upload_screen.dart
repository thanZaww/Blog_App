import 'dart:io';
import 'package:dio/dio.dart' as d;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../controller/upload_controller.dart';
import '/custom_extension/custom_extension.dart';

class UploadScreen extends StatefulWidget {
  const UploadScreen({Key? key}) : super(key: key);

  @override
  State<UploadScreen> createState() => _UploadScreenState();
}

final UploadController _uplaodController = Get.put(UploadController());
final ImagePicker _imagePicker = ImagePicker();
final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
File? _image;
String? _title, _body;

class _UploadScreenState extends State<UploadScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Upload Post').center,
      ),
      body: Obx(
        () {
          UploadState uploadState = _uplaodController.uploadState.value;
          if (uploadState is UploadLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (uploadState is UploadError) {
            return const Center(child: Text('Something wrong!'));
          } else if (uploadState is UploadSuccess) {
            return Center(child: Text(uploadState.uploadResponse.result ?? ''));
          }
          return SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    const Text(
                      'Enter title',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 20,
                        color: Colors.blue,
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      onSaved: (title) {
                        _title = title;
                      },
                      validator: (title) {
                        if (title == null || title.isEmpty) {
                          return 'Enter your title';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                      ),
                    ),
                    // const Divider(),
                    const SizedBox(height: 10),
                    const Text(
                      'Enter body',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 20,
                        color: Colors.blue,
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      onSaved: (body) {
                        _body = body;
                      },
                      validator: (body) {
                        if (body == null || body.isEmpty) {
                          return 'Enter your body';
                        }
                        return null;
                      },
                      maxLines: 5,
                      minLines: 2,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                      ),
                    ),
                    // const Divider(),
                    const SizedBox(height: 10),
                    TextButton.icon(
                      onPressed: () async {
                        final XFile? image = await _imagePicker.pickImage(
                            source: ImageSource.gallery);

                        if (image != null) {
                          setState(() {
                            _image = File(image.path);
                          });
                        }
                      },
                      icon: const Icon(Icons.image),
                      label: const Text(
                        'Image picker',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 20,
                          color: Colors.blue,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    (_image == null)
                        ? const SizedBox()
                        : Image.file(
                            _image!,
                            height: 200,
                          ),
                    const SizedBox(height: 10),
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () async {
                          d.MultipartFile? multipartFile;
                          d.FormData? formData;
                          if (_image != null) {
                            multipartFile = await d.MultipartFile.fromFile(
                              _image!.path,
                              filename: 'image.png',
                            );
                          }
                          _formKey.currentState?.save();
                          if (_formKey.currentState != null &&
                              _formKey.currentState!.validate()) {
                            if (multipartFile != null) {
                              formData = d.FormData.fromMap(
                                {
                                  'photo': multipartFile,
                                },
                              );
                            }
                            _uplaodController.uploadPost(
                                _title ?? '', _body ?? '', formData);
                          }
                        },
                        child: const Text('Upload post'),
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
