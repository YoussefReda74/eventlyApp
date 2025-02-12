import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eventapp/firebase/firebase_manager.dart';
import 'package:eventapp/models/task_model.dart';
import 'package:eventapp/screens/tabs/category/card_item.dart';
import 'package:flutter/material.dart';

class LoveTap extends StatelessWidget {
  LoveTap({super.key});
  var searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              TextFormField(
                controller: searchController,
                decoration: InputDecoration(
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                  prefixIcon: const Icon(Icons.search),
                  labelText: 'Search For Event',
                  labelStyle: const TextStyle(color: Color(0xff5669FF)),
                  prefixIconColor: const Color(0xff5669FF),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: const BorderSide(color: Color(0xff5669FF)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide:
                        const BorderSide(width: 2, color: Color(0xff5669FF)),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: StreamBuilder<QuerySnapshot<TaskModel>>(
                  stream: FirebaseManager.getEvent('All'),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    var filteredDocs = snapshot.data!.docs.where((doc) {
                      var eventTitle = doc.data().title.toLowerCase();
                      return eventTitle
                          .contains(searchController.text.toLowerCase());
                    }).toList();

                    return ListView.builder(
                      itemCount: filteredDocs.length,
                      itemBuilder: (context, index) {
                        return CardItem(
                          model: filteredDocs[index].data(),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
