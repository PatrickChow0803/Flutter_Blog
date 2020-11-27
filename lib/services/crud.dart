import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_blog/models/blog.dart';
import 'package:image_picker/image_picker.dart';
import 'package:random_string/random_string.dart';

class CrudMethods {
  FirebaseFirestore accessFireStore = FirebaseFirestore.instance;
  static const String BLOG = 'blogs';

  Future<void> createBlog(BlogModel blogData) async {
    // Go to FireStore and go to the collection called 'blogs' and then add a snapshot with blogData as the fields
    accessFireStore.collection(BLOG).add({
      'imageUrl': blogData.imageUrl,
      'autherName': blogData.authorName,
      'titleName': blogData.titleName,
      'blogDescription': blogData.description,
      'timePosted': blogData.timePosted,
    }).catchError((error) {
      print(error.toString());
    });
  }

  Future<void> uploadAndCreateBlog(
      String imageFilePath, String authorName, String title, String desc) async {
    try {
      // Go to Firebase Storage's root directory and create a folder called blogImage
      // Then make the file's name a random 9 character and make a reference to this file
      // A reference is a pointer to a file within your specified storage bucket.
      // This can be a file that already exists, or one that does not exist.
      String randomSuffix = randomAlphaNumeric(9) + '.jpg';
      Reference firebaseStorage = FirebaseStorage.instance.ref('blogImage/$randomSuffix');

      // Upload the file to FireBase Storage
      final UploadTask task = firebaseStorage.putFile(File(imageFilePath));
      // Wait for the file to finish upload before attempting to get the downloadURL from the file
      String downloadUrl = await (await task).ref.getDownloadURL();
      print("This is the download URL: $downloadUrl");

      // Now upload the Blog information to FireBase FireStore
      BlogModel blogData = new BlogModel(
        imageUrl: downloadUrl,
        authorName: authorName,
        titleName: title,
        description: desc,
        timePosted: DateTime.now().millisecondsSinceEpoch,
      );

      createBlog(blogData);
    } catch (e) {
      print(e.toString());
    }
  }

  Future<List<BlogModel>> getBlogs() async {
    List<BlogModel> blogs = [];
    // go to FireStore and get all the documents in the BLOG collection, then for each DocumentSnapshot,
    // convert them into a BlogModel so that they can be used.
    accessFireStore.collection(BLOG).get().then((value) {
      for (DocumentSnapshot blog in value.docs) {
        blogs.add(BlogModel.fromSnapshot(blog));
      }
    });
    return blogs;
  }

  Stream getBlogsStream() {
    return accessFireStore.collection(BLOG).snapshots();
  }
}
