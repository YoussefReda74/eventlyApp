import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eventapp/firebase/firebase_manager.dart';
import 'package:eventapp/models/task_model.dart';
import 'package:eventapp/screens/tabs/category/card_item.dart';
import 'package:flutter/material.dart';

class HomeTab extends StatelessWidget {
  const HomeTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 170,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(24),
              bottomLeft: Radius.circular(24),
            ),
          ),
          flexibleSpace: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Welcome Back ✨',
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall!
                              .copyWith(color: Colors.white, fontSize: 14),
                        ),
                        Text(
                          'Youssef Reda',
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall!
                              .copyWith(color: Colors.white, fontSize: 24),
                        ),
                      ],
                    ),
                    const Spacer(),
                    const SizedBox(
                      height: 30,
                      child: Icon(
                        Icons.sunny,
                        color: Colors.white,
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 10),
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                      ),
                      child: Text(
                        'En',
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                              color: Theme.of(context).primaryColor,
                              fontSize: 14,
                            ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 8,
                ),
                Row(
                  children: [
                    const Icon(
                      Icons.location_on_outlined,
                      color: Colors.white,
                    ),
                    Text(
                      'Cairo , Egypt',
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall!
                          .copyWith(color: Colors.white, fontSize: 14),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
        body: StreamBuilder<QuerySnapshot<TaskModel>>(
          stream:  FirebaseManager.getEvent(),
          builder: (context, snapshot) {
            return ListView.builder(
              itemBuilder: (context, item) {
                return  CardItem(model: snapshot.data!.docs[item].data() ,);
              },
              itemCount: snapshot.data?.docs.length??0,
            );
          },
        ),
      ),
    );
  }
}
