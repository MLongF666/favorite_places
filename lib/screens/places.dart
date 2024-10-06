import 'package:favorite_places/providers/user_places.dart';
import 'package:favorite_places/widgets/places_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'add_place.dart';

class PlacesListScreen extends ConsumerWidget {
  const PlacesListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userPlaces= ref.watch(userPlacesProvider);
    return  Scaffold(
      appBar: AppBar(
        title: Text('Your Places',style: TextStyle(color: Colors.white),),
        actions: [
          IconButton(
            onPressed: (){
              Navigator.of(context).pushNamed(AddPlaceScreen().id);
            },
            icon: Icon(Icons.add),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: PlacesList(
          places: userPlaces,
        ),
      ),
    );
  }
}
