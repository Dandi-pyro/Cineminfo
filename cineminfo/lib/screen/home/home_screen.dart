import 'package:cineminfo/screen/actor/actor_screen.dart';
import 'package:cineminfo/screen/movie/movie_screen.dart';
import 'package:cineminfo/screen/tv/tv_screen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentIndex = 0;
  final screens = [
    MovieScreen(),
    TvScreen(),
    ActorScreen(),
    Center(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: currentIndex,
          onTap: (index) {
            setState(() {
              currentIndex = index;
            });
          },
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.blue,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.white70,
          showUnselectedLabels: false,
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.movie_rounded), label: 'Movie'),
            BottomNavigationBarItem(
                icon: Icon(Icons.tv_rounded), label: 'TV Shows'),
            BottomNavigationBarItem(
                icon: Icon(Icons.group_rounded), label: 'Actors'),
            BottomNavigationBarItem(
                icon: Icon(Icons.person_rounded), label: 'Profile'),
          ]),
      body: screens[currentIndex],
    );
  }
}
