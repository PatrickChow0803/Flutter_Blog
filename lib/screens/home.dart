import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blog/models/blog.dart';
import 'package:flutter_blog/providers/blog.dart';
import 'package:flutter_blog/screens/create_blog.dart';
import 'package:flutter_blog/services/crud.dart';
import 'package:flutter_blog/widgets/blog_tile.dart';
import 'package:provider/provider.dart';

import '../utility.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  CrudMethods crudMethods = new CrudMethods();

  CollectionReference blogs = FirebaseFirestore.instance.collection('blogs');

  QuerySnapshot blogSnapshot;
  Stream<QuerySnapshot> blogStream;

  @override
  void initState() {
    super.initState();
    blogStream = crudMethods.getBlogsStream();
  }

  @override
  Widget build(BuildContext context) {
    final blogProvider = Provider.of<BlogProvider>(context);
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
          : StreamBuilder<QuerySnapshot>(
//              stream: blogs.snapshots(),
              stream: blogStream,
              builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  print('Something went wrong');
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  print("Loading");
                }

                return ListView.builder(
                  itemBuilder: (_, index) {
                    return BlogTile(blogInfo: blogProvider.listOfBlogs[index]);
                  },
                  itemCount: snapshot.data.docs.length,
                );
              },
            ),
    );
  }
}
