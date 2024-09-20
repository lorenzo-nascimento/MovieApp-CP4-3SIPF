import 'package:flutter/material.dart';
import 'package:movie_app/models/movie_model.dart';
import 'package:movie_app/common/utils.dart'; // Importar a constante imageUrl
import 'package:movie_app/pages/detalhes.dart'; // Importar a página de detalhes

class MovieHorizontalItem extends StatefulWidget {
  final Movie movie;

  const MovieHorizontalItem({super.key, required this.movie});

  @override
  State<MovieHorizontalItem> createState() => _MovieHorizontalItemState();
}

class _MovieHorizontalItemState extends State<MovieHorizontalItem> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 200,
          width: 140,
          margin: const EdgeInsets.symmetric(horizontal: 8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            image: DecorationImage(
              fit: BoxFit.cover,
              image: NetworkImage(
                widget.movie.posterPath.isNotEmpty
                    ? '$imageUrl${widget.movie.posterPath}'  // Concatena a URL base com o posterPath
                    : 'https://via.placeholder.com/140x200', // Coloca uma imagem padrão se não houver posterPath
              ),
            ),
          ),
        ),
        Positioned(
          top: 10,
          right: 10,
          child: Row(
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    widget.movie.isFavorite = !widget.movie.isFavorite;
                  });
                },
                child: Icon(
                  widget.movie.isFavorite ? Icons.favorite : Icons.favorite_border,
                  color: widget.movie.isFavorite ? Colors.red : Colors.white,
                ),
              ),
              const SizedBox(width: 10),
              GestureDetector(
                onTap: () {
                  // Navega para a página de detalhes do filme
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MovieDetailsPage(movie: widget.movie),
                    ),
                  );
                },
                child: const Icon(
                  Icons.info_outline,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
        Positioned(
          left: 15,
          right: 15,
          bottom: 0,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.movie.title,
                maxLines: 1,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                widget.movie.releaseDate?.year.toString() ?? '',
                style: const TextStyle(
                  color: Colors.white54,
                  fontWeight: FontWeight.w300,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
