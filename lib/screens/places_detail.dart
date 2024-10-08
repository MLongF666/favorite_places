import 'dart:async';

import 'package:favorite_places/models/place.dart';
import 'package:favorite_places/screens/map.dart';
import 'package:favorite_places/services/location.dart';
import 'package:flutter/material.dart';

class PlaceholderWidget extends StatelessWidget {
  const PlaceholderWidget({super.key, required this.place});
  final Place place;
  @override
  Widget build(BuildContext context) {
    Future mockLocationImage() async {
      LocationModel locationModel = LocationModel(
        latitude: place.location.latitude,
        longitude: place.location.longitude,
      );
      return await locationModel.getPositionImageData();
    }
    return Scaffold(
        appBar: AppBar(
          title: const Text('Placeholder details'),
        ),
        body: Stack(children: [
          Image.file(
            place.image,
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Column(
                children: [
                  FutureBuilder(
                      future: mockLocationImage(),
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        if (snapshot.connectionState == ConnectionState.done) {
                          if (snapshot.hasError) {
                            // 请求失败，显示错误
                            return Text("Error: ${snapshot.error}");
                          } else {
                            // 请求成功，显示数据
                            return GestureDetector(
                              onTap: (){
                                Navigator.of(context).push(MaterialPageRoute(builder: (ctx)=>
                                    MapScreen(
                                  location: place.location,
                                  isSelected: false,
                                    )
                                ));
                              },
                              child: CircleAvatar(
                                radius: 70,
                                backgroundImage: MemoryImage(snapshot.data),
                              ),
                            );
                          }
                        } else {
                          // 请求未结束，显示loading
                          return const CircularProgressIndicator();
                        }
                      }),
                  Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 16,
                    ),
                    decoration: const BoxDecoration(
                        gradient: LinearGradient(
                      colors: [Colors.transparent, Colors.black54],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    )),
                    child: Text(
                      place.location.address,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          color: Theme.of(context).colorScheme.onBackground),
                    ),
                  ),
                ],
              ))
        ]));
  }
}
