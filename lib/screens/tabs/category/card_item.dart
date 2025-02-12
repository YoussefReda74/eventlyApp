import 'package:easy_localization/easy_localization.dart';
import 'package:eventapp/firebase/firebase_manager.dart';
import 'package:eventapp/models/task_model.dart';
import 'package:eventapp/screens/eventDetails_screen.dart';
import 'package:flutter/material.dart';

class CardItem extends StatelessWidget {
  TaskModel model;
  CardItem({required this.model, super.key});

  String getMonthFromMilliseconds(int milliseconds) {
    DateTime date = DateTime.fromMillisecondsSinceEpoch(milliseconds);
    String month = DateFormat.MMM().format(date);
    return month;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8),
      child: Stack(
        children: [
          Container(
            height: 200,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: Theme.of(context).primaryColor,
                width: 2,
              ),
            ),
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  EventDetailsScreen.routeName,
                  arguments: model,
                );
              },
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.asset(
                  'assets/images/${model.category}.png',
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                margin: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  children: [
                    Text(
                      DateTime.fromMillisecondsSinceEpoch(model.date)
                          .toString()
                          .substring(8, 10),
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    Text(
                      getMonthFromMilliseconds(model.date),
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.07,
              ),
              Container(
                padding: const EdgeInsets.all(8),
                margin: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    Text(
                      model.title,
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    const Spacer(),
                    GestureDetector(
                      onTap: () {
                        bool newFavoriteStatus = !model.isDone; // Toggle favorite
                        var task = TaskModel(
                          id: model.id,
                          title: model.title,
                          userId: model.userId,
                          date: model.date,
                          description: model.description,
                          category: model.category,
                          isDone: newFavoriteStatus,
                        );

                        // Update in Firebase
                        FirebaseManager.updateTask(task);
                      },
                      child: Icon(
                        model.isDone
                            ? Icons.favorite
                            : Icons.favorite_border_outlined,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
