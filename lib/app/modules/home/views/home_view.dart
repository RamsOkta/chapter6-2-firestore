import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crud_firebase/app/modules/home/controllers/home_controller.dart'; // Sesuaikan dengan nama proyek Anda
import 'package:crud_firebase/app/routes/app_pages.dart';

class HomeView extends StatelessWidget {
  final HomeController controller = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: StreamBuilder<QuerySnapshot<Object?>>(
        stream: controller.streamData(),
        builder: (context, AsyncSnapshot<QuerySnapshot<Object?>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.data!.docs.isEmpty) {
            return Center(child: Text('No data'));
          } else {
            var data = snapshot.data!.docs;
            return ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) {
                return ListTile(
                  onTap: () {
                    Get.toNamed(Routes.UPDATE, arguments: data[index].id);
                  },
                  title: Text(data[index]['name']),
                  subtitle: Text(data[index]['cook_time']),
                  trailing: IconButton(
                    onPressed: () => controller.deleteData(data[index].id),
                    icon: Icon(Icons.delete),
                  ),
                );
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.toNamed(Routes.CREATE);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
