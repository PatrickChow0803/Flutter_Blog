import 'package:cloud_firestore/cloud_firestore.dart';

class CrudMethods {
  FirebaseFirestore accessFireStore = FirebaseFirestore.instance;
  static const String BLOG = 'blogs';

  Future<void> createBlog(Map<String, String> blogData) async {
    // Go to FireStore and go to the collection called 'blogs' and then add a snapshot with blogData as the fields
    accessFireStore.collection(BLOG).add(blogData).catchError((error) {
      print(error.toString());
    });
  }
}
