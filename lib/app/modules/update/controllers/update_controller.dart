import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UpdateController extends GetxController {
  late TextEditingController nameController;
  late TextEditingController cookTimeController;
  late TextEditingController ingredientsController;
  late TextEditingController instructionsController;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<DocumentSnapshot<Object?>> getData(String docID) async {
    DocumentReference docRef = firestore.collection('recipes').doc(docID);
    return docRef.get();
  }

  void updateData(String docID, String name, String cookTime,
      String ingredients, String instructions) async {
    try {
      await firestore.collection('recipes').doc(docID).update({
        'name': name,
        'cook_time': cookTime,
        'ingredients': ingredients,
        'instructions': instructions,
      });

      Get.back();
      Get.snackbar('Success', 'Recipe updated successfully');
    } catch (e) {
      print(e);
      Get.snackbar('Error', 'Failed updating recipe');
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
