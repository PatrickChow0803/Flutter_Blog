import 'package:flutter/material.dart';
import 'package:flutter_blog/models/blog.dart';
import 'package:flutter_blog/utility.dart';

class BlogTile extends StatelessWidget {
  BlogModel blogInfo;

  BlogTile({@required this.blogInfo});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16),
      margin: EdgeInsets.only(bottom: 16.0),
      height: 150,
      child: Stack(
        children: [
          ClipRRect(
              borderRadius: BorderRadius.circular(16.0),
              child: Image.network(
                blogInfo.imageUrl,
                fit: BoxFit.fill,
                width: getScreenWidth(context),
              )),
          Container(
            height: 150,
            decoration: BoxDecoration(
              color: Colors.black45.withOpacity(0.3),
              borderRadius: BorderRadius.circular(6),
            ),
          ),
          Container(
            width: getScreenWidth(context),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  blogInfo.titleName,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.w500),
                ),
                SizedBox(height: 6),
                Text(
                  blogInfo.authorName,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 6),
                Text(blogInfo.timePosted.toString()),
              ],
            ),
          )
        ],
      ),
    );
  }
}
