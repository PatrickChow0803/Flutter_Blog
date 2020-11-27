import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blog/models/blog.dart';
import 'package:flutter_blog/screens/create_blog.dart';
import 'package:flutter_blog/services/crud.dart';
import 'package:flutter_blog/widgets/blog_tile.dart';

import '../utility.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  CrudMethods crudMethods = new CrudMethods();

  QuerySnapshot blogSnapshot;

  List<BlogModel> listOfBlogs = [];

  @override
  void initState() {
    super.initState();

//    listOfBlogs = await crudMethods.getBlogs();
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
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 16.0, left: 30.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FloatingActionButton(
              onPressed: () async {
//                Navigator.of(context).push(MaterialPageRoute(builder: (_) => CreateBlog()));
                changeScreen(context, CreateBlog());
              },
              child: Icon(Icons.add),
            ),
          ],
        ),
      ),
      body: blogSnapshot != null
          ? Container(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemBuilder: (_, index) {
                return BlogTile(blogInfo: listOfBlogs[index]);
              },
              itemCount: listOfBlogs.length,
            ),
    );
  }
}
