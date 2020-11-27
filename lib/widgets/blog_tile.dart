import 'package:flutter/material.dart';
import 'package:flutter_blog/models/blog.dart';

class BlogTile extends StatelessWidget {
  Blog blogInfo;

  BlogTile({@required this.blogInfo});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      child: Stack(
        children: [
          ClipRRect(
              borderRadius: BorderRadius.circular(6), child: Image.network(blogInfo.imageUrl)),
          Container(
            height: 150,
            decoration: BoxDecoration(
              color: Colors.black45.withOpacity(0.3),
              borderRadius: BorderRadius.circular(6),
            ),
          ),
          Container(
            child: Column(
              children: [
                Text(blogInfo.titleName),
                SizedBox(height: 10),
                Text(blogInfo.authorName),
                SizedBox(height: 10),
                Text(blogInfo.timePosted.toString()),
              ],
            ),
          )
        ],
      ),
    );
  }
}
