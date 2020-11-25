import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_blog/services/crud.dart';
import 'package:flutter_blog/utility.dart';
import 'package:image_picker/image_picker.dart';

class CreateBlog extends StatefulWidget {
  @override
  _CreateBlogState createState() => _CreateBlogState();
}

class _CreateBlogState extends State<CreateBlog> {
  String authorName, title, desc;
  bool canPost = false;

  PickedFile _imageFile;
  CrudMethods _crudMethods = new CrudMethods();

  Future getImage() async {
    final pickedFile = await ImagePicker().getImage(source: ImageSource.gallery);

    setState(() {
      _imageFile = pickedFile;
    });
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
        child: (Container(
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
                      ? Image.file(
                          // Converts PickedFile data type into a file data type that can be used
                          File(_imageFile.path),
                          fit: BoxFit.fill,
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
                      onChanged: (input) {
                        authorName = input;
                      },
                    ),
                    TextField(
                      decoration: InputDecoration(hintText: "Title"),
                      onChanged: (input) {
                        title = input;
                      },
                    ),
                    TextField(
                      decoration: InputDecoration(hintText: "Description"),
                      onChanged: (input) {
                        desc = input;
                      },
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
