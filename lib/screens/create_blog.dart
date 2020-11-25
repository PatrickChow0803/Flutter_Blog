import 'package:flutter/material.dart';
import 'package:flutter_blog/services/crud.dart';
import 'package:flutter_blog/utility.dart';

class CreateBlog extends StatefulWidget {
  @override
  _CreateBlogState createState() => _CreateBlogState();
}

class _CreateBlogState extends State<CreateBlog> {
  String authorName, title, desc;
  bool canPost = false;

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
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16.0),
                height: 150,
                width: getScreenWidth(context),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16.0),
                ),
                child: Icon(
                  Icons.add_a_photo,
                  color: getPrimaryColor(context),
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
