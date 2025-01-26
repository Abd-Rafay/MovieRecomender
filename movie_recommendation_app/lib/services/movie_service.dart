import 'dart:convert';
import 'package:http/http.dart' as http;

class MovieService {
  static const String _apiKey = '33ae9654b54640e6eba1785e6520d49c'; // Replace with your actual API key
  static const String _baseUrl = 'https://api.themoviedb.org/3/discover/movie'; // TMDB's discover endpoint

  static const Map<String, String> genreMap = {
    'Adventure': '12',
    'Comedy': '35',
    'Horror': '27',
    'Drama': '18',
    'Fantasy': '14',
    'Thriller': '53',
    'Action': '28',
    'Documentary': '99',
    'Science fiction': '878',
    'Animation': '16',
    'Romance': '10749',
    'Mystery': '9648',
  };

  static Future<List<Map<String, dynamic>>> fetchMovieRecommendations(
      List<String> genres, String? language, String? ageGroup, String? duration) async {
    // Convert genre names to genre IDs
    final genreIds = genres.map((genre) => genreMap[genre]).where((id) => id != null).join(',');

    // Convert duration to maximum runtime in minutes
    String? maxRuntime;
    if (duration != null) {
      if (duration == '<1 hour') {
        maxRuntime = '60';
      } else if (duration == '1-2 hours') {
        maxRuntime = '120';
      } else if (duration == '>2 hours') {
        maxRuntime = '180'; // You can adjust this value as needed
      }
    }

    // Prepare query parameters for TMDB API
    final queryParams = {
      'api_key': _apiKey,
      'with_genres': genreIds, // Comma-separated genre IDs
      if (language != null) 'language': language,
      if (maxRuntime != null) 'with_runtime.lte': maxRuntime, // TMDB uses runtime for duration
      // TMDB does not have an age group parameter; you may use certification_country & certification.
    };

    final uri = Uri.parse(_baseUrl).replace(queryParameters: queryParams);
    print('Request URI: $uri');

    final response = await http.get(uri, headers: {'Content-Type': 'application/json'});
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      print('Parsed data: $data');

      return (data['results'] as List).map((movie) {
        final posterPath = movie['poster_path'];
        final posterUrl = posterPath != null ? 'https://image.tmdb.org/t/p/w500$posterPath' : null;

        return {
          'title': movie['title'],
          'details': movie['overview'],
          'posterUrl': posterUrl, // Add poster URL
        };
      }).toList();
    } else {
      throw Exception('Failed to fetch movie recommendations: ${response.statusCode}');
    }
  }
}
