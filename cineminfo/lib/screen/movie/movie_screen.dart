import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cineminfo/model/movie/movie_model.dart';
import 'package:cineminfo/screen/drawer_screen.dart';
import 'package:cineminfo/screen/genres/genres_movies_widgets.dart';
import 'package:cineminfo/screen/movie/movie_now_playing_view_model.dart';
import 'package:cineminfo/screen/movie/movie_popular_view_model.dart';
import 'package:cineminfo/screen/movie/movie_top_rated_view_model.dart';
import 'package:cineminfo/screen/movie/movie_widgets.dart';
import 'package:cineminfo/screen/movie_detail/movie_detail_screen.dart';
import 'package:cineminfo/screen/search/search_movie_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MovieScreen extends StatefulWidget {
  const MovieScreen({Key? key}) : super(key: key);

  @override
  State<MovieScreen> createState() => _MovieScreenState();
}

class _MovieScreenState extends State<MovieScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cineminfo'),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => SearchMovieScreen()));
              },
              icon: const Icon(Icons.search_rounded))
        ],
      ),
      // drawer: DrawerScreen(),
      body: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
        return SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: constraints.maxHeight),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(15),
                  child: Center(
                    child: Text(
                      'now playing movies'.toUpperCase(),
                      style: const TextStyle(fontSize: 15),
                    ),
                  ),
                ),
                NowPlayingWidgets(),
                Padding(
                  padding: const EdgeInsets.fromLTRB(15, 15, 0, 15),
                  child: Text(
                    'genres'.toUpperCase(),
                    style: const TextStyle(fontSize: 15),
                  ),
                ),
                ListMoviesGenre(),
                Padding(
                  padding: const EdgeInsets.fromLTRB(15, 15, 0, 15),
                  child: Text(
                    'Popular movies'.toUpperCase(),
                    style: const TextStyle(fontSize: 15),
                  ),
                ),
                PopularWidgets(),
                Padding(
                  padding: const EdgeInsets.fromLTRB(15, 15, 0, 15),
                  child: Text(
                    'top rated movies'.toUpperCase(),
                    style: const TextStyle(fontSize: 15),
                  ),
                ),
                TopRatedWidgets(),
                Padding(
                  padding: const EdgeInsets.fromLTRB(15, 15, 0, 15),
                  child: Text(
                    'upcoming movie'.toUpperCase(),
                    style: const TextStyle(fontSize: 15),
                  ),
                ),
                UpcomingWidgets(),
                const SizedBox(
                  height: 15,
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
