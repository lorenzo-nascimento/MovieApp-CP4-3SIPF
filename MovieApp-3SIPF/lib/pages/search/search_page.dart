import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/pages/search/widgets/movie_details_screen.dart';
import 'dart:async';
import 'package:movie_app/services/api_services.dart';
import 'package:movie_app/models/movie_model.dart';


class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final ApiServices _apiServices = ApiServices();
  Future<List<Movie>>? _searchFuture;
  Timer? _debounce;

  void _onSearchChanged(String query) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      if (query.isNotEmpty) {
        setState(() {
          _searchFuture = _apiServices.searchMovies(query);
        });
      } else {
        setState(() {
          _searchFuture = null;
        });
      }
    });
  }

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: CupertinoSearchTextField(
                padding: const EdgeInsets.all(10.0),
                prefixIcon: const Icon(CupertinoIcons.search, color: Colors.grey),
                suffixIcon: const Icon(Icons.cancel, color: Colors.grey),
                style: const TextStyle(color: Colors.white),
                backgroundColor: Colors.grey.withOpacity(0.3),
                onChanged: _onSearchChanged,
              ),
            ),
            Expanded(
              child: _searchFuture == null
                  ? Center(child: Text('Digite para buscar filmes'))
                  : FutureBuilder<List<Movie>>(
                      future: _searchFuture,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return Center(child: CircularProgressIndicator());
                        } else if (snapshot.hasError) {
                          return Center(child: Text('Erro: ${snapshot.error}'));
                        } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                          return ListView.builder(
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, index) {
                              final movie = snapshot.data![index];
                              return ListTile(
                                title: Text(movie.title),
                                subtitle: Text(movie.releaseDate?.year.toString() ?? 'N/A'),
                                leading: movie.posterPath.isNotEmpty
                                    ? Image.network('https://image.tmdb.org/t/p/w92${movie.posterPath}')
                                    : Icon(Icons.movie),
                                onTap: () {
                                  //Navigator.push(
                                    //context,
                                   // MaterialPageRoute(
                                      //builder: (context) =>  MovieDetailsScreen(movieId: movie.id),
                                   // ),
                                  //);
                                },
                              );
                            },
                          );
                        } else {
                          return Center(child: Text('Nenhum resultado encontrado'));
                        }
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}