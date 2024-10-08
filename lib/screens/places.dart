import 'package:favorite_places/providers/user_places.dart';
import 'package:favorite_places/widgets/places_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'add_place.dart';

class PlacesListScreen extends ConsumerStatefulWidget {
  const PlacesListScreen({super.key});
  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _PlacesListScreenState();
  }
}

class _PlacesListScreenState extends ConsumerState<PlacesListScreen> {
  late Future<void> _placesFuture;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _placesFuture= ref.read(userPlacesProvider.notifier).loadPlaces();
  }
  @override
  Widget build(BuildContext context) {
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
        child: FutureBuilder(future:_placesFuture ,builder: (context,snapshot)=>
        snapshot.connectionState==ConnectionState.waiting?const Center(child: CircularProgressIndicator()):
        PlacesList(places: userPlaces),
        ),
      ),
    );
  }
}
