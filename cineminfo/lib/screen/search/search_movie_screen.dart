import 'package:cached_network_image/cached_network_image.dart';
import 'package:cineminfo/screen/movie_detail/movie_detail_screen.dart';
import 'package:cineminfo/screen/search/search_movie_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchMovieScreen extends StatefulWidget {
  const SearchMovieScreen({Key? key}) : super(key: key);

  @override
  State<SearchMovieScreen> createState() => _SearchMovieScreenState();
}

class _SearchMovieScreenState extends State<SearchMovieScreen> {
  final _formKey = GlobalKey<FormState>();

  final searchController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    searchController.dispose();
  }

  @override
  void initState() {
    super.initState();
    Provider.of<SearchMovieViewModel>(context, listen: false).movies.clear();
  }

  @override
  Widget build(BuildContext context) {
    final searchProvider = Provider.of<SearchMovieViewModel>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search Movie'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Form(
                  key: _formKey,
                  child: TextFormField(
                    controller: searchController,
                    decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.search_rounded),
                        hintText: 'Movie Title',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        )),
                    textInputAction: TextInputAction.go,
                    onChanged: (value) {
                      searchProvider.movies.clear();
                      searchProvider.getMovies(searchController.text);
                    },
                  ),
                ),
              ],
            ),
          ),
          Expanded(child: body(searchProvider))
        ],
      ),
    );
  }

  Widget body(SearchMovieViewModel viewModel) {
    final isLoading = viewModel.state == SearchMovieViewState.loading;
    final isError = viewModel.state == SearchMovieViewState.error;

    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (isError) {
      return const Center(
        child: Text("Can't get the data"),
      );
    }

    return _searchWidget(viewModel);
  }

  Widget _searchWidget(SearchMovieViewModel viewModel) {
    return viewModel.movies.isEmpty
        ? const Center(
            child: Text('No Data'),
          )
        : ListView.builder(
            itemBuilder: (context, index) {
              final movie = viewModel.movies[index];
              return ListTile(
                leading: movie.backdropPath == null
                    ? Container(
                        height: 50,
                        width: 50,
                        decoration: const BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage('assets/images/noImage.png'),
                                fit: BoxFit.contain)),
                      )
                    : ClipPath(
                        child: ClipRRect(
                          child: CachedNetworkImage(
                            imageUrl:
                                'https://image.tmdb.org/t/p/original/${movie.backdropPath}',
                            height: 50,
                            width: 50,
                            fit: BoxFit.cover,
                            placeholder: (context, url) =>
                                CircularProgressIndicator(),
                          ),
                        ),
                      ),
                title: Text(movie.title!),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MovieDetailScreen(movie: movie),
                    ),
                  );
                },
              );
            },
            itemCount: viewModel.movies.length);
  }
}
