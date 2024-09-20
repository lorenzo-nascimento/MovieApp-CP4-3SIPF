import 'dart:convert';

import 'package:movie_app/models/movie_model.dart';
import 'package:http/http.dart' as http;

const baseUrl = 'https://api.themoviedb.org/3/';
const apiKey = '5f9d4bd0608c0d8b303396a95e29c3a5'; // Coloque sua API Key correta aqui

class ApiServices {
  Future<Result> getTopRatedMovies() async {
    var endPoint = 'movie/top_rated';
    final url = '$baseUrl$endPoint?api_key=$apiKey';

    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      return Result.fromJson(jsonDecode(response.body));
    }
    throw Exception('Failed to load top rated movies');
  }

  Future<Result> getNowPlayingMovies() async {
    var endPoint = 'movie/now_playing';
    final url = '$baseUrl$endPoint?api_key=$apiKey';

    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      return Result.fromJson(jsonDecode(response.body));
    }
    throw Exception('Failed to load now playing movies');
  }

  Future<Result> getUpcomingMovies() async {
    var endPoint = 'movie/upcoming';
    final url = '$baseUrl$endPoint?api_key=$apiKey';

    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      return Result.fromJson(jsonDecode(response.body));
    }
    throw Exception('Failed to load upcoming movies');
  }

  Future<Result> getPopularMovies() async {
    var endPoint = 'movie/popular';
    final url = '$baseUrl$endPoint?api_key=$apiKey';

    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      return Result.fromJson(jsonDecode(response.body));
    }
    throw Exception('Failed to load popular movies');
  }
   String _buildUrl(String endpoint, [Map<String, String>? queryParams]) {
    final params = {'api_key': apiKey};
    if (queryParams != null) {
      params.addAll(queryParams);
    }
    return Uri.https('api.themoviedb.org', '/3/$endpoint', params).toString();
  }

 Future<List<Movie>> searchMovies(String query) async {
    final url = _buildUrl('search/movie', {'query': query});
    print('URL da API: $url'); // Para debug

    try {
      final response = await http.get(Uri.parse(url));
      
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        final List<dynamic> results = data['results'];
        return results.map((movieData) => Movie.fromJson(movieData)).toList();
      } else {
        throw Exception('Falha ao pesquisar filmes. Status: ${response.statusCode}');
      }
    } catch (e) {
      print('Erro ao pesquisar filmes: $e');
      rethrow;
    }
  }
}
