import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_blog/models/blog.dart';

class CrudMethods {
  FirebaseFirestore accessFireStore = FirebaseFirestore.instance;
  static const String BLOG = 'blogs';

  Future<void> createBlog(Blog blogData) async {
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
}
