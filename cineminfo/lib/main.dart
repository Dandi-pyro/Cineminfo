import 'package:cineminfo/screen/actor/actor_popular_view_model.dart';
import 'package:cineminfo/screen/actor/actor_trending_day_view_model.dart';
import 'package:cineminfo/screen/actor/actor_trending_week_view_model.dart';
import 'package:cineminfo/screen/genres/genres_view_model.dart';
import 'package:cineminfo/screen/home/home_screen.dart';
import 'package:cineminfo/screen/movie/movie_top_rated_view_model.dart';
import 'package:cineminfo/screen/movie/movie_upcoming_view_model.dart';
import 'package:cineminfo/screen/movie/movie_now_playing_view_model.dart';
import 'package:cineminfo/screen/movie/movie_popular_view_model.dart';
import 'package:cineminfo/screen/movie_detail/movie_detail_view_model.dart';
import 'package:cineminfo/screen/search/search_movie_view_model.dart';
import 'package:cineminfo/screen/search/search_tv_view_model.dart';
import 'package:cineminfo/screen/tv%20detail/tv_detail_view_model.dart';
import 'package:cineminfo/screen/tv/tv_airing_today_view_model.dart';
import 'package:cineminfo/screen/tv/tv_on_the_air_view_model.dart';
import 'package:cineminfo/screen/tv/tv_popular_view_model.dart';
import 'package:cineminfo/screen/tv/tv_top_rated.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (_) => ActorPopularViewModel(),
      ),
      ChangeNotifierProvider(
        create: (_) => ActorDayViewModel(),
      ),
      ChangeNotifierProvider(
        create: (_) => ActorWeekViewModel(),
      ),
      ChangeNotifierProvider(
        create: (_) => NowPlayingViewModel(),
      ),
      ChangeNotifierProvider(
        create: (_) => SearchMovieViewModel(),
      ),
      ChangeNotifierProvider(
        create: (_) => SearchTvViewModel(),
      ),
      ChangeNotifierProvider(
        create: (_) => DetailMovieViewModel(),
      ),
      ChangeNotifierProvider(
        create: (_) => DetailTvViewModel(),
      ),
      ChangeNotifierProvider(
        create: (_) => GenreViewModel(),
      ),
      ChangeNotifierProvider(
        create: (_) => UpcomingViewModel(),
      ),
      ChangeNotifierProvider(
        create: (_) => PopularViewModel(),
      ),
      ChangeNotifierProvider(
        create: (_) => TopRatedViewModel(),
      ),
      ChangeNotifierProvider(
        create: (_) => TvAiringViewModel(),
      ),
      ChangeNotifierProvider(
        create: (_) => TvOnTheAirViewModel(),
      ),
      ChangeNotifierProvider(
        create: (_) => TvPopularViewModel(),
      ),
      ChangeNotifierProvider(
        create: (_) => TvTopRatedViewModel(),
      ),
    ],
    child: const MaterialApp(
      title: "Movie App",
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    ),
  ));
}
