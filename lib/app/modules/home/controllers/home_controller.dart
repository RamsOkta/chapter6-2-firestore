import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomeController extends GetxController {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  // Method untuk mengambil data dari Firestore
  Stream<QuerySnapshot<Object?>> streamData() {
    CollectionReference data = firestore.collection('posts');
    return data.orderBy('time', descending: true).snapshots();
  }

  // Method untuk menghapus data dari Firestore berdasarkan docID
  void deleteData(String docID) {
    try {
      Get.defaultDialog(
          title: "Delete Post",
          middleText: "Are you sure you want to delete this post?",
          onConfirm: () async {
            await firestore.collection('posts').doc(docID).delete();
            Get.back();
            Get.snackbar('Success', 'Data deleted successfully');
          },
          textConfirm: "Yes, I'm sure",
          textCancel: "No");
    } catch (e) {
      print(e);
      Get.snackbar('Error', 'Cannot delete this post');
    }
  }
}
