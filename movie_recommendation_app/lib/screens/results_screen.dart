import 'package:flutter/material.dart';
import 'package:movie_recommendation_app/services/movie_service.dart';

class MovieResultsPage extends StatelessWidget {
  final List<String> genres;
  final String? language;
  final String? ageGroup;
  final String? duration;

  const MovieResultsPage({super.key, required this.genres, this.language, this.ageGroup, this.duration});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Movie Recommendations'),
        backgroundColor: Colors.orange,
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: MovieService.fetchMovieRecommendations(genres, language, ageGroup, duration),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            final movies = snapshot.data!;
            return ListView.builder(
              itemCount: movies.length,
              itemBuilder: (context, index) {
                final movie = movies[index];
                return Card(
                  margin: EdgeInsets.all(10),
                  color: Color(0xFFF4D79F),
                  child: ListTile(
                    contentPadding: EdgeInsets.all(10),
                    leading: movie['posterUrl'] != null
                        ? Image.network(movie['posterUrl'], width: 50, height: 75, fit: BoxFit.cover)
                        : SizedBox(width: 50, height: 75), // Placeholder if no poster
                    title: Text(movie['title'] ?? 'No Title'),
                    subtitle: Text(movie['details'] ?? 'No Details'),
                  ),
                );
              },
            );
          } else {
            return Center(child: Text('No data available.'));
          }
        },
      ),
      backgroundColor: Color(0xFFFFEEDF),
    );
  }
}