import 'package:flutter/material.dart';
// import 'package:movie_recommendation_app/services/movie_service.dart';
import 'package:movie_recommendation_app/screens/results_screen.dart';
class MovieHomeScreen extends StatefulWidget {
  const MovieHomeScreen({super.key});

  @override
  _MovieHomeScreenState createState() => _MovieHomeScreenState();
}

class _MovieHomeScreenState extends State<MovieHomeScreen> {
  String? selectedLanguage;
  String? selectedAgeGroup;
  String? selectedDuration;

  final genres = [
    'Adventure',
    'Comedy',
    'Horror',
    'Drama',
    'Fantasy',
    'Thriller',
    'Action',
    'Documentary',
    'Science fiction',
    'Animation',
    'Romance',
    'Mystery',
  ];

  List<String> selectedGenres = [];

  List<Map<String, dynamic>> recommendations = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Movie Recommendation'),
        backgroundColor: Colors.orange,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Select Genre:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
        SizedBox(height: 20,),
          Wrap(
              spacing: 10.0,
              runSpacing: 10.0,
              children: genres.map((genre) {
                final isSelected = selectedGenres.contains(genre);
                return ChoiceChip(
                  label: Text(genre),
                  selected: isSelected,
                  onSelected: (selected) {
                    setState(() {
                      if (selected) {
                        selectedGenres.add(genre);
                      } else {
                        selectedGenres.remove(genre);
                      }
                    });
                  },
                  selectedColor: Colors.orange,
                  disabledColor: Color(0xFFFFD2A9),
                  backgroundColor: Color(0xFFFFD2A9),
                  labelStyle: TextStyle(
                    color: isSelected ? Colors.white : Colors.black,
                  ),
                );
              }).toList(),
            ),
            SizedBox(height: 20),
           SizedBox(height: 20,),
         DropdownButtonFormField<String>(
              decoration: InputDecoration(
                labelText: 'Select the Language',
                border: OutlineInputBorder(),
                fillColor: Color(0xFFFFD2A9),
                filled: true,
              ),
              value: selectedLanguage,
              items: ['English', 'Hindi', 'Spanish', 'French']
                  .map((language) => DropdownMenuItem(
                        value: language,
                        child: Text(language),
                      ))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  selectedLanguage = value;
                });
              },
            ),
            SizedBox(height: 30),
            DropdownButtonFormField<String>(
              decoration: InputDecoration(
                labelText: 'Select the Age Group',
                border: OutlineInputBorder(),
                fillColor: Color(0xFFFFD2A9),
                filled: true,
              ),
              value: selectedAgeGroup,
              items: ['Kids', 'Teens', 'Adults']
                  .map((ageGroup) => DropdownMenuItem(
                        value: ageGroup,
                        child: Text(ageGroup),
                      ))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  selectedAgeGroup = value;
                });
              },
            ),
            SizedBox(height: 30),
            DropdownButtonFormField<String>(
              decoration: InputDecoration(
                labelText: 'Select Time Duration',
                border: OutlineInputBorder(),
                fillColor: Color(0xFFFFD2A9),
                filled: true,
                hoverColor: Color(0xFFFFD2A9),
              ),
              value: selectedDuration,
              items: ['<1 hour', '1-2 hours', '>2 hours']
                  .map((duration) => DropdownMenuItem(
                        value: duration,
                        child: Text(duration),
                      ))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  selectedDuration = value;
                });
              },
            ),
            Spacer(),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  print('Selected Genres: $selectedGenres');
                  print('Selected Language: $selectedLanguage');
                  print('Selected Age Group: $selectedAgeGroup');
                  print('Selected Duration: $selectedDuration');

                  if ( selectedGenres.isEmpty || selectedLanguage == null || selectedAgeGroup == null || selectedDuration == null) {
                    print('Please select all options.');
                    return;
                  }

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MovieResultsPage(
                        genres: selectedGenres,
                        language: selectedLanguage,
                        ageGroup: selectedAgeGroup,
                        duration: selectedDuration,
                      ), 
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
                  child: Text(
                    'Submit',
                    style: TextStyle(fontSize: 18, color: Color(0xFFFFFFFF)),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
      backgroundColor: Color(0xFFFFEEDF),
    );
  }
}
