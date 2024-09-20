import 'package:flutter/material.dart';
import 'package:movie_app/models/movie_model.dart';
import 'package:movie_app/pages/home/widgets/movie_horizontal_item.dart';

class FavoriteMoviesPage extends StatelessWidget {
  final List<Movie> favoriteMovies;

  const FavoriteMoviesPage({super.key, required this.favoriteMovies});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Filmes Favoritos'),
      ),
      body: favoriteMovies.isNotEmpty
          ? ListView.builder(
              itemCount: favoriteMovies.length,
              itemBuilder: (context, index) {
                return MovieHorizontalItem(movie: favoriteMovies[index]);
              },
            )
          : const Center(
              child: Text(
                'Nenhum filme favoritado ainda.',
                style: TextStyle(color: Colors.white),
              ),
            ),
    );
  }
}
