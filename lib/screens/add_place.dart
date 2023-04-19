import 'dart:io';

import 'package:favorite_place_app/providers/user_places_provider.dart';
import 'package:favorite_place_app/widgets/image_input.dart';
import 'package:favorite_place_app/widgets/location_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddPlaceScreen extends ConsumerStatefulWidget {
  const AddPlaceScreen({super.key});

  @override
  ConsumerState<AddPlaceScreen> createState() => _AddPlaceScreenState();
}

class _AddPlaceScreenState extends ConsumerState<AddPlaceScreen> {
  final _titleController = TextEditingController();
  File? _selectedImage;

  void _saveItem() async {
    final enteredTitle = _titleController.text;

    if (enteredTitle.isEmpty || _selectedImage == null) {
      return;
    }
    ref.read(placesProvider.notifier).addPlace(enteredTitle, _selectedImage!);
    Navigator.of(context).pop(
        // Place(
        //   title: enteredTitle,
        //   image: _selectedImage!,
        // ),
        );
  }

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New Place'),
      ),
      body: SingleChildScrollView(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              TextField(
                controller: _titleController,
                decoration: const InputDecoration(label: Text('Title')),
                style: TextStyle(
                    color: Theme.of(context).colorScheme.onBackground),
              ),
              const SizedBox(height: 16),
              ImageInput(onPickImage: (image) => {_selectedImage = image}),
              const SizedBox(height: 16),
              const LocationInput(),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton.icon(
                    onPressed: _saveItem,
                    label: const Text('Add Place'),
                    icon: const Icon(Icons.add),
                  )
                ],
              )
            ],
          )),
    );
  }
}
