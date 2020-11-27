import 'package:flutter/foundation.dart';
import 'package:flutter_blog/models/blog.dart';
import 'package:flutter_blog/services/crud.dart';

class BlogProvider with ChangeNotifier {
  CrudMethods _crudMethods = CrudMethods();
  List<BlogModel> listOfBlogs = [];

  BlogProvider.initialize() {
    loadBlogs();
  }

  loadBlogs() async {
    listOfBlogs = await _crudMethods.getBlogs();
    notifyListeners();
  }
}
