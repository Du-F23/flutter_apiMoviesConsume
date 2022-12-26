import 'package:flutter/cupertino.dart';
import 'package:nameproject_movies/models/models.dart';
import 'package:nameproject_movies/providers/movies_provider.dart';
import 'package:provider/provider.dart';

class CastingCards extends StatelessWidget {
  final int movieId;

  const CastingCards(this.movieId, {super.key});

  @override
  Widget build(BuildContext context) {
    final moviesProvider = Provider.of<MoviesProvider>(context, listen: false);

    return FutureBuilder(
      future: moviesProvider.getMovieCast(movieId),
      builder: (_, AsyncSnapshot<List<Cast>> snapshot) {
        if (!snapshot.hasData) {
          return Container(
            constraints: const BoxConstraints(maxWidth: 150),
            height: 180,
            child: const CupertinoActivityIndicator(),
          );
        }

        final cast = snapshot.data!;

        return Container(
          margin: const EdgeInsets.only(bottom: 30),
          width: double.infinity,
          height: 180,
          child: ListView.builder(
            itemCount: 10,
            scrollDirection: Axis.horizontal,
            itemBuilder: (_, int index) => _Casting(cast: cast[index]),
          ),
        );
      },
    );
  }
}

class _Casting extends StatelessWidget {
  final Cast cast;

  const _Casting({required this.cast});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      width: 110,
      height: 100,
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: FadeInImage(
              placeholder: const AssetImage('assets/no-image.jpg'),
              image: NetworkImage(cast.fullProfilePath),
              height: 150,
              width: 100,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            cast.name,
            maxLines: 2,
            style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                overflow: TextOverflow.ellipsis),
            textAlign: TextAlign.center,
          ),
          // Text(cast.character, style: const TextStyle(fontSize: 12)),
        ],
      ),
    );
  }
}
