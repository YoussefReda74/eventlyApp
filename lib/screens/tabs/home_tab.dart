import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eventapp/firebase/firebase_manager.dart';
import 'package:eventapp/models/task_model.dart';
import 'package:eventapp/provider/user_provider.dart';
import 'package:eventapp/screens/tabs/category/card_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeTab extends StatefulWidget {
  HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  bool isSelected = false;

  int selectedCategory = 0;

  List<String> eventsCategories = [
    'All',
    'Birthday',
    'Book',
    'Eating',
    'Exhibition',
    'Gaming',
    'Meeting',
    'Holiday',
    'Sport',
    'Work',
  ];

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
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
                              .copyWith(color: Colors.white, fontSize: 16),
                        ),
                        Text(
                          userProvider.userModel?.name??'null',
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
                          .copyWith(color: Colors.white, fontSize: 18),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 18,
                ),
                SizedBox(
                  height: 40,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: eventsCategories.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          selectedCategory=index;
                          setState(() {

                          });
                        },
                        child: Container(
                          alignment: Alignment.center,
                          margin: const EdgeInsets.symmetric(horizontal: 6) ,
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          decoration: BoxDecoration(
                            border: Border.all(
                              width: 2,
                              color: Theme.of(context).hintColor,
                            ),
                            borderRadius: BorderRadius.circular(30),
                            color: selectedCategory == index
                                ? Theme.of(context).hintColor
                                : Colors.transparent,

                            //isSelected ? Theme.of(context).hintColor : Colors.transparent,
                          ),
                          child: Text(
                            eventsCategories[index],
                            style:
                                Theme.of(context).textTheme.titleMedium!.copyWith(
                                      color: selectedCategory == index
                                          ? Theme.of(context).primaryColor
                                          : Colors.white,

                                  // isSelected
                                      //     ? Theme.of(context).primaryColor
                                      //     : Colors.white,
                                    ),
                          ),
                        ),
                      );
                    },
                  ),
                )
              ],
            ),
          ),
        ),
        body: StreamBuilder<QuerySnapshot<TaskModel>>(
          stream: FirebaseManager.getEvent(
            eventsCategories[selectedCategory]
          ),
          builder: (context, snapshot) {
            return ListView.builder(
              itemBuilder: (context, item) {
                return CardItem(
                  model: snapshot.data!.docs[item].data(),
                );
              },
              itemCount: snapshot.data?.docs.length ?? 0,
            );
          },
        ),
      ),
    );
  }
}
