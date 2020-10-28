import 'package:advertisement/Screen/home_page.dart';
import 'package:advertisement/Screen/post.dart';
import 'package:flutter/material.dart';

class TabBars extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(60),
          child: AppBar(
            bottom: TabBar(
              tabs: [
                Text(
                  'Home',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Post',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
        body: TabBarView(
          children: [
            HomePage(),
            Post(),
          ],
        ),
      ),
    );
  }
}
