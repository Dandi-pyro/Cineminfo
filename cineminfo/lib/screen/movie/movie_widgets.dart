import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cineminfo/model/movie/movie_model.dart';
import 'package:cineminfo/screen/movie/movie_now_playing_view_model.dart';
import 'package:cineminfo/screen/movie/movie_popular_view_model.dart';
import 'package:cineminfo/screen/movie/movie_top_rated_view_model.dart';
import 'package:cineminfo/screen/movie/movie_upcoming_view_model.dart';
import 'package:cineminfo/screen/movie_detail/movie_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UpcomingWidgets extends StatefulWidget {
  const UpcomingWidgets({Key? key}) : super(key: key);

  @override
  State<UpcomingWidgets> createState() => _UpcomingWidgetsState();
}

class _UpcomingWidgetsState extends State<UpcomingWidgets> {
  @override
  void initState() {
    super.initState();
    Provider.of<UpcomingViewModel>(context, listen: false).getUpcomingMovies();
  }

  @override
  Widget build(BuildContext context) {
    final latestProvider = Provider.of<UpcomingViewModel>(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        body(latestProvider),
      ],
    );
  }

  Widget body(UpcomingViewModel viewModel) {
    final isLoading = viewModel.state == UpcomingViewState.loading;
    final isError = viewModel.state == UpcomingViewState.error;

    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (isError) {
      return const Center(
        child: Text("Can't get the data"),
      );
    }

    return _listMovies(viewModel);
  }

  Widget _listMovies(UpcomingViewModel viewModel) {
    return viewModel.moviesUpcoming.isEmpty
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Container(
              height: 200,
              child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    Movie movie = viewModel.moviesUpcoming[index];
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    MovieDetailScreen(movie: movie),
                              ),
                            );
                          },
                          child: ClipRRect(
                            child: CachedNetworkImage(
                              imageUrl:
                                  'https://image.tmdb.org/t/p/original/${movie.backdropPath}',
                              imageBuilder: (context, imageProvider) {
                                return Container(
                                  width: 100,
                                  height: 160,
                                  decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(12),
                                    ),
                                    image: DecorationImage(
                                      image: imageProvider,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                );
                              },
                              placeholder: (context, url) => Container(
                                width: 100,
                                height: 150,
                                child: const Center(
                                  child: CircularProgressIndicator(),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Container(
                          width: 100,
                          child: Text(
                            movie.title!.toUpperCase(),
                            style: const TextStyle(
                                fontSize: 12,
                                color: Colors.black45,
                                fontWeight: FontWeight.bold),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Container(
                          child: Row(
                            children: [
                              const Icon(
                                Icons.star,
                                color: Colors.yellow,
                                size: 14,
                              ),
                              const Icon(
                                Icons.star,
                                color: Colors.yellow,
                                size: 14,
                              ),
                              const Icon(
                                Icons.star,
                                color: Colors.yellow,
                                size: 14,
                              ),
                              const Icon(
                                Icons.star,
                                color: Colors.yellow,
                                size: 14,
                              ),
                              const Icon(
                                Icons.star,
                                color: Colors.yellow,
                                size: 14,
                              ),
                              Text(movie.voteAverage!,
                                  style: const TextStyle(
                                    color: Colors.black45,
                                  ))
                            ],
                          ),
                        )
                      ],
                    );
                  },
                  separatorBuilder: (context, index) => const VerticalDivider(
                        color: Colors.transparent,
                        width: 15,
                      ),
                  itemCount: viewModel.moviesUpcoming.length),
            ),
          );
  }
}

class NowPlayingWidgets extends StatefulWidget {
  const NowPlayingWidgets({Key? key}) : super(key: key);

  @override
  State<NowPlayingWidgets> createState() => _NowPlayingWidgetsState();
}

class _NowPlayingWidgetsState extends State<NowPlayingWidgets> {
  @override
  void initState() {
    super.initState();
    Provider.of<NowPlayingViewModel>(context, listen: false)
        .getNowPlayingMovies();
  }

  @override
  Widget build(BuildContext context) {
    final nowPlayProvider = Provider.of<NowPlayingViewModel>(context);
    return body(nowPlayProvider);
  }

  Widget body(NowPlayingViewModel viewModel) {
    final isLoading = viewModel.state == NowPlayingViewState.loading;
    final isError = viewModel.state == NowPlayingViewState.error;

    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (isError) {
      return const Center(
        child: Text("Can't get the data"),
      );
    }

    return _listMovies(viewModel);
  }

  Widget _listMovies(NowPlayingViewModel viewModel) {
    return viewModel.moviesNowPlay.isEmpty
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : CarouselSlider.builder(
            itemCount: viewModel.moviesNowPlay.length,
            itemBuilder: (BuildContext context, int index, int pageViewIndex) {
              Movie movie = viewModel.moviesNowPlay[index];
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MovieDetailScreen(movie: movie),
                    ),
                  );
                },
                child: Stack(
                  alignment: Alignment.bottomLeft,
                  children: <Widget>[
                    ClipRRect(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(10),
                      ),
                      child: CachedNetworkImage(
                        imageUrl:
                            'https://image.tmdb.org/t/p/original/${movie.backdropPath}',
                        height: MediaQuery.of(context).size.height / 3,
                        width: MediaQuery.of(context).size.width,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        bottom: 15,
                        left: 15,
                      ),
                      child: Text(
                        movie.title!.toUpperCase(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    )
                  ],
                ),
              );
            },
            options: CarouselOptions(
              enableInfiniteScroll: true,
              autoPlay: true,
              autoPlayInterval: const Duration(seconds: 5),
              autoPlayAnimationDuration: const Duration(milliseconds: 800),
              pauseAutoPlayOnTouch: true,
              viewportFraction: 0.8,
              enlargeCenterPage: true,
            ),
          );
  }
}

class PopularWidgets extends StatefulWidget {
  const PopularWidgets({Key? key}) : super(key: key);

  @override
  State<PopularWidgets> createState() => _PopularWidgetsState();
}

class _PopularWidgetsState extends State<PopularWidgets> {
  @override
  void initState() {
    super.initState();
    Provider.of<PopularViewModel>(context, listen: false).getPopularMovies();
  }

  @override
  Widget build(BuildContext context) {
    final popularProvider = Provider.of<PopularViewModel>(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        body(popularProvider),
      ],
    );
  }

  Widget body(PopularViewModel viewModel) {
    final isLoading = viewModel.state == PopularViewState.loading;
    final isError = viewModel.state == PopularViewState.error;

    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (isError) {
      return const Center(
        child: Text("Can't get the data"),
      );
    }

    return _listMovies(viewModel);
  }

  Widget _listMovies(PopularViewModel viewModel) {
    return viewModel.moviesPopular.isEmpty
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Container(
              height: 200,
              child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    Movie movie = viewModel.moviesPopular[index];
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    MovieDetailScreen(movie: movie),
                              ),
                            );
                          },
                          child: ClipRRect(
                            child: CachedNetworkImage(
                              imageUrl:
                                  'https://image.tmdb.org/t/p/original/${movie.backdropPath}',
                              imageBuilder: (context, imageProvider) {
                                return Container(
                                  width: 100,
                                  height: 160,
                                  decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(12),
                                    ),
                                    image: DecorationImage(
                                      image: imageProvider,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                );
                              },
                              placeholder: (context, url) => Container(
                                width: 100,
                                height: 150,
                                child: const Center(
                                  child: CircularProgressIndicator(),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Container(
                          width: 100,
                          child: Text(
                            movie.title!.toUpperCase(),
                            style: const TextStyle(
                                fontSize: 12,
                                color: Colors.black45,
                                fontWeight: FontWeight.bold),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Container(
                          child: Row(
                            children: [
                              const Icon(
                                Icons.star,
                                color: Colors.yellow,
                                size: 14,
                              ),
                              const Icon(
                                Icons.star,
                                color: Colors.yellow,
                                size: 14,
                              ),
                              const Icon(
                                Icons.star,
                                color: Colors.yellow,
                                size: 14,
                              ),
                              const Icon(
                                Icons.star,
                                color: Colors.yellow,
                                size: 14,
                              ),
                              const Icon(
                                Icons.star,
                                color: Colors.yellow,
                                size: 14,
                              ),
                              Text(movie.voteAverage!,
                                  style: const TextStyle(
                                    color: Colors.black45,
                                  ))
                            ],
                          ),
                        )
                      ],
                    );
                  },
                  separatorBuilder: (context, index) => const VerticalDivider(
                        color: Colors.transparent,
                        width: 15,
                      ),
                  itemCount: viewModel.moviesPopular.length),
            ),
          );
  }
}

class TopRatedWidgets extends StatefulWidget {
  const TopRatedWidgets({Key? key}) : super(key: key);

  @override
  State<TopRatedWidgets> createState() => _TopRatedWidgetsState();
}

class _TopRatedWidgetsState extends State<TopRatedWidgets> {
  @override
  void initState() {
    super.initState();
    Provider.of<TopRatedViewModel>(context, listen: false).getTopRatedMovies();
  }

  @override
  Widget build(BuildContext context) {
    final topRatedProvider = Provider.of<TopRatedViewModel>(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        body(topRatedProvider),
      ],
    );
  }

  Widget body(TopRatedViewModel viewModel) {
    final isLoading = viewModel.state == PopularViewState.loading;
    final isError = viewModel.state == PopularViewState.error;

    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (isError) {
      return const Center(
        child: Text("Can't get the data"),
      );
    }

    return _listMovies(viewModel);
  }

  Widget _listMovies(TopRatedViewModel viewModel) {
    return viewModel.moviesTopRated.isEmpty
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Container(
              height: 200,
              child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    Movie movie = viewModel.moviesTopRated[index];
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    MovieDetailScreen(movie: movie),
                              ),
                            );
                          },
                          child: ClipRRect(
                            child: CachedNetworkImage(
                              imageUrl:
                                  'https://image.tmdb.org/t/p/original/${movie.backdropPath}',
                              imageBuilder: (context, imageProvider) {
                                return Container(
                                  width: 100,
                                  height: 160,
                                  decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(12),
                                    ),
                                    image: DecorationImage(
                                      image: imageProvider,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                );
                              },
                              placeholder: (context, url) => Container(
                                width: 100,
                                height: 150,
                                child: const Center(
                                  child: CircularProgressIndicator(),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Container(
                          width: 100,
                          child: Text(
                            movie.title!.toUpperCase(),
                            style: const TextStyle(
                                fontSize: 12,
                                color: Colors.black45,
                                fontWeight: FontWeight.bold),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Container(
                          child: Row(
                            children: [
                              const Icon(
                                Icons.star,
                                color: Colors.yellow,
                                size: 14,
                              ),
                              const Icon(
                                Icons.star,
                                color: Colors.yellow,
                                size: 14,
                              ),
                              const Icon(
                                Icons.star,
                                color: Colors.yellow,
                                size: 14,
                              ),
                              const Icon(
                                Icons.star,
                                color: Colors.yellow,
                                size: 14,
                              ),
                              const Icon(
                                Icons.star,
                                color: Colors.yellow,
                                size: 14,
                              ),
                              Text(movie.voteAverage!,
                                  style: const TextStyle(
                                    color: Colors.black45,
                                  ))
                            ],
                          ),
                        )
                      ],
                    );
                  },
                  separatorBuilder: (context, index) => const VerticalDivider(
                        color: Colors.transparent,
                        width: 15,
                      ),
                  itemCount: viewModel.moviesTopRated.length),
            ),
          );
  }
}
