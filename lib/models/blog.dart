import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class BlogModel {
  String imageUrl;
  String authorName;
  String titleName;
  String description;
  int timePosted;

  BlogModel({
    this.imageUrl,
    this.authorName,
    this.titleName,
    this.description,
    this.timePosted,
  });

  BlogModel.fromSnapshot(DocumentSnapshot snapshot) {
    imageUrl = snapshot.data()['imageUrl'];
    authorName = snapshot.data()['autherName'];
    titleName = snapshot.data()['titleName'];
    description = snapshot.data()['description'];
    timePosted = snapshot.data()['timePosted'];
  }
}
