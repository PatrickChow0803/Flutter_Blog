import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blog/models/blog.dart';
import 'package:flutter_blog/services/crud.dart';
import 'package:flutter_blog/utility.dart';
import 'package:image_picker/image_picker.dart';
import 'package:random_string/random_string.dart';

class CreateBlog extends StatefulWidget {
  @override
  _CreateBlogState createState() => _CreateBlogState();
}

class _CreateBlogState extends State<CreateBlog> {
  final authorName = TextEditingController();
  final title = TextEditingController();
  final desc = TextEditingController();

  bool canPost = false;
  bool _isLoading = false;

  PickedFile _imageFile;
  CrudMethods _crudMethods = new CrudMethods();

  Future getImage() async {
    final pickedFile = await ImagePicker().getImage(source: ImageSource.gallery);

    setState(() {
      _imageFile = pickedFile;
    });
  }

  void uploadBlog() async {
    // Uploading to FireBase Storage
    if (_imageFile != null) {
      setState(() {
        _isLoading = !_isLoading;
      });

      _crudMethods.uploadAndCreateBlog(_imageFile.path, authorName.text, title.text, desc.text);

      setState(() {
        _isLoading = !_isLoading;
      });
      Navigator.pop(context);
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Flutter',
              style: TextStyle(fontSize: 22),
            ),
            Text(
              'Blog',
              style: TextStyle(fontSize: 22, color: Colors.blue),
            ),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: InkWell(
                onTap: () {
                  setState(() {
                    canPost = !canPost;
                    uploadBlog();
                  });
                },
                child: Text(
                  "POST",
                  style: TextStyle(color: canPost ? Colors.white : Colors.orange),
                )),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: _isLoading
            ? Container(
                width: getScreenWidth(context),
                height: getScreenHeight(context),
                alignment: Alignment.center,
                child: CircularProgressIndicator(),
              )
            : (Container(
                child: Column(
                  children: [
                    SizedBox(height: 10.0),
                    GestureDetector(
                      onTap: () {
                        getImage();
                      },
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 16.0),
                        height: 150,
                        width: getScreenWidth(context),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16.0),
                        ),
                        // Determine whether or not to display the selected image  or the Icon
                        child: _imageFile != null
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(16.0),
                                child: Image.file(
                                  // Converts PickedFile data type into a File data type that can be used
                                  File(_imageFile.path),
                                  fit: BoxFit.fill,
                                ),
                              )
                            : Icon(
                                Icons.add_a_photo,
                                color: getPrimaryColor(context),
                              ),
                      ),
                    ),
                    SizedBox(height: 10),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Column(
                        children: [
                          TextField(
                            decoration: InputDecoration(hintText: "Author's Name"),
                            controller: authorName,
                          ),
                          TextField(
                            decoration: InputDecoration(hintText: "Title"),
                            controller: title,
                          ),
                          TextField(
                            decoration: InputDecoration(hintText: "Description"),
                            controller: desc,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              )),
      ),
    );
  }
}
