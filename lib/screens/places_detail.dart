import 'package:favorite_places/models/place.dart';
import 'package:flutter/material.dart';


class PlaceholderWidget extends StatelessWidget {
  const PlaceholderWidget({super.key,required this.place});
  final Place place;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Placeholder details'),
      ),
      body: Center(
        child: Text(place.title,style: Theme.of(context).textTheme.titleMedium!.copyWith(
    color: Theme.of(context).colorScheme.onBackground),
      ),
    ));
  }
}
