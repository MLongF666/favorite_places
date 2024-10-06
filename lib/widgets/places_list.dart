import 'package:favorite_places/screens/places_detail.dart';
import 'package:flutter/material.dart';

import '../models/place.dart';

class PlacesList extends StatelessWidget {
  final List<Place> places;

  PlacesList({required this.places});

  @override
  Widget build(BuildContext context) {
    if (places.isEmpty) {
      return Center(
        child: Text('No places added yet!',
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: Theme.of(context).colorScheme.onBackground,
                )),
      );
    }
    return ListView.builder(
      padding: EdgeInsets.all(8.0),
      itemCount: places.length,
      itemBuilder: (ctx, index) => Container(
        margin: const EdgeInsets.only(top: 12.0),
        child: ListTile(
          leading: CircleAvatar(
            radius: 30,
            backgroundImage: FileImage(places[index].image),
          ),
          title: Text(
            places[index].title,
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: Theme.of(context).colorScheme.onBackground,
                ),
          ),
          subtitle: Text(places[index].location.address,style: TextStyle(color: Theme.of(context).colorScheme.onBackground),),
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (ctx) => PlaceholderWidget(place: places[index])));
          },
        ),
      ),
    );
  }
}
