import 'package:flutter/material.dart';
import 'package:nameproject_movies/models/models.dart';
import 'package:nameproject_movies/providers/movies_provider.dart';
import 'package:provider/provider.dart';

class SearchDelegateInput extends SearchDelegate {
  @override
  String get searchFieldLabel => 'Buscar...';

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(onPressed: () => query = '', icon: const Icon(Icons.clear))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () => close(context, null),
        icon: const Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    return const Text('buildResults');
  }

  Widget _emptyContainer() {
    return const Center(
      child:
          Icon(Icons.movie_creation_outlined, size: 100, color: Colors.black26),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isEmpty) {
      return _emptyContainer();
    }

    final moviesProvider = Provider.of<MoviesProvider>(context, listen: false);

    moviesProvider.getSuggestionsByQuery(query);

    return StreamBuilder(
      stream: moviesProvider.suggestionStream,
      builder: (_, AsyncSnapshot<List<Movie>> snapshot) {
        if (!snapshot.hasData) {
          return _emptyContainer();
        }

        final movies = snapshot.data!;

        return ListView.builder(
          itemBuilder: (_, int index) => _MovieItem(movie: movies[index]),
          itemCount: movies.length,
        );
      },
    );
  }
}

class _MovieItem extends StatelessWidget {
  final Movie movie;
  const _MovieItem({required this.movie});

  @override
  Widget build(BuildContext context) {
    movie.heroId = 'search-${movie.id}';

    return Hero(
      tag: movie.heroId!,
      child: ListTile(
          leading: FadeInImage(
            image: NetworkImage(movie.fullUrlImg),
            placeholder: const AssetImage('assets/no-image.jpg'),
            width: 80,
            height: 50,
            fit: BoxFit.contain,
          ),
          title: Text(movie.title),
          subtitle: Text(movie.originalTitle),
          onTap: () =>
              Navigator.pushNamed(context, 'details', arguments: movie)),
    );
  }
}
