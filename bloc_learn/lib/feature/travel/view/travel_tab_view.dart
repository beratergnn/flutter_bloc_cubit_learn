import 'package:bloc_learn/feature/travel/view/travel_view.dart';
import 'package:flutter/material.dart';

enum _TravelPages { home, bookmark, notification, profile }

class TravelTabView extends StatelessWidget {
  const TravelTabView({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: _TravelPages.values.length,
      child: const Scaffold(
        bottomNavigationBar: BottomAppBar(
          child: TabBar(
            tabs: [
              Tab(icon: Icon(Icons.home), text: 'Home'),
              Tab(icon: Icon(Icons.bookmark), text: 'Bookmark'),
              Tab(icon: Icon(Icons.notifications), text: 'Notification'),
              Tab(icon: Icon(Icons.person), text: 'Profile'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            TravelView(),
            SizedBox(),
            SizedBox(),
            SizedBox(),
          ],
        ),
      ),
    );
  }
}
