import 'package:flutter/material.dart';
import 'package:nameproject_movies/providers/movies_provider.dart';
import 'package:nameproject_movies/search/search_delegate.dart';
import 'package:nameproject_movies/widgets/widgets.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final moviesProvider = Provider.of<MoviesProvider>(context);

    return Scaffold(
        appBar: AppBar(
          title: const Center(
            child: Text('NameProject Movies'),
          ),
          elevation: 0,
          actions: [
            IconButton(
              icon: const Icon(Icons.search),
              onPressed: () =>
                  showSearch(context: context, delegate: SearchDelegateInput()),
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              CardSwiper(
                movies: moviesProvider.moviesResponse,
              ),
              // Listado de peliculas
              MovieSlider(
                movies: moviesProvider.popularMovies,
                title: 'Populares!',
                onNextPage: () => moviesProvider.getPoupularMovies(),
              ),
            ],
          ),
        ));
  }
}
