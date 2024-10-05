import 'package:favorite_places/providers/user_places.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddPlaceScreen extends ConsumerStatefulWidget {
  final String id='add_place';

  @override
  ConsumerState<AddPlaceScreen> createState() => _AddPlaceScreenState();
}

class _AddPlaceScreenState extends ConsumerState<AddPlaceScreen> {
  final _titleController = TextEditingController();
  @override
  void dispose() {
    // TODO: implement dispose
    _titleController.dispose();
    super.dispose();
  }
  void _savePlace() {
    final enteredTitle = _titleController.text;
    if (enteredTitle.isEmpty) {
      return;
    }
    else{
      ref.read(userPlacesProvider.notifier).addPlace(enteredTitle);
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add a new place'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              TextField(
                decoration: const InputDecoration(label: Text('place title')),
                controller: _titleController,
                style: TextStyle(color: Theme.of(context).colorScheme.onBackground),
              ),
              const SizedBox(
                height: 16,
              ),
              ElevatedButton.icon(
                  icon: const Icon(Icons.add),
                  onPressed: () {
                    _savePlace();
                  },
                  label: Text('Add Place'))
            ],
          ),
        ),
      ),
    );
  }
}
