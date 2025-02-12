import 'package:eventapp/firebase/firebase_manager.dart';
import 'package:eventapp/models/task_model.dart';
import 'package:eventapp/screens/create_event/create_event.dart';
import 'package:flutter/material.dart';

class EventDetailsScreen extends StatelessWidget {
  static const String routeName = 'eventDetails';

  const EventDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TaskModel model =
        ModalRoute.of(context)!.settings.arguments as TaskModel;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(color: Theme.of(context).primaryColor),
        centerTitle: true,
        title: Text(
          'Event Details',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CreateEvent(),
                ),
              );
            },
            icon: const Icon(Icons.edit, color: Color(0xff5669FF)),
          ),
          IconButton(
            onPressed: () async {
              await FirebaseManager.deleteTask(model.id);
              Navigator.pop(context); // Pass the task ID
            },
            icon: const Icon(Icons.delete_forever_outlined,
                color: Colors.red, size: 30),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.asset(
                'assets/images/${model.category}.png',
                width: double.infinity,
                height: 200,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              model.title,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                      width: 2, color: Theme.of(context).primaryColor)),
              child: Row(
                children: [
                  const Icon(Icons.calendar_month, color: Color(0xff5669FF)),
                  const Spacer(),
                  Text(
                    DateTime.fromMillisecondsSinceEpoch(model.date)
                        .toString()
                        .substring(0, 10),
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'Description',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 10),
            Text(
              model.description,
              style: Theme.of(context)
                  .textTheme
                  .headlineSmall!
                  .copyWith(fontWeight: FontWeight.w500, fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
