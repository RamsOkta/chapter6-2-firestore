import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CreateController extends GetxController {
  late TextEditingController nameController;
  late TextEditingController cookTimeController;
  late TextEditingController ingredientsController;
  late TextEditingController instructionsController;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  void addData(String name, String cookTime, String ingredients,
      String instructions) async {
    try {
      await firestore.collection('recipes').add({
        'name': name,
        'cook_time': cookTime,
        'ingredients': ingredients,
        'instructions': instructions,
      });

      Get.back();
      Get.snackbar('Success', 'Recipe added successfully');
      nameController.clear();
      cookTimeController.clear();
      ingredientsController.clear();
      instructionsController.clear();
    } catch (e) {
      print(e);
      Get.snackbar('Error', 'Failed to add recipe');
    }
  }

  @override
  void onInit() {
    nameController = TextEditingController();
    cookTimeController = TextEditingController();
    ingredientsController = TextEditingController();
    instructionsController = TextEditingController();
    super.onInit();
  }

  @override
  void onClose() {
    nameController.dispose();
    cookTimeController.dispose();
    ingredientsController.dispose();
    instructionsController.dispose();
    super.onClose();
  }
}
