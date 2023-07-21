import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class SeriesListWidget extends StatelessWidget {
  final String title;
  final String startYear;
  final String endYear;
  final Widget child;
  const SeriesListWidget({super.key, required this.title, required this.startYear,  required this.endYear, required this.child});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: MaterialButton(
          padding: const EdgeInsets.all(0),
          onPressed: () => Navigator.of(context)
              .push(MaterialPageRoute(builder: (ctx) => child)),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child:Card(
              elevation: 5,
              child: ListTile(
                title: Text(title),
                subtitle: Text('Start Year: $startYear, End Year: $endYear'),
              ),
            ),
          ),
        ));
  }
}
