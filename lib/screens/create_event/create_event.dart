import 'package:eventapp/firebase/firebase_manager.dart';
import 'package:eventapp/models/task_model.dart';
import 'package:eventapp/provider/create_event_provider.dart';
import 'package:eventapp/screens/tabs/category/event_item.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CreateEvent extends StatelessWidget {
  static const String routeName = 'create_event';
  CreateEvent({this.taskModel,super.key});
  final TaskModel? taskModel;
  var titleController = TextEditingController();
  var descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => CreateEventProvider(),
      builder: (context, child) {
        var provider = Provider.of<CreateEventProvider>(context);
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            backgroundColor: Colors.transparent,
            title: Text(
              'Create Event',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            iconTheme: IconThemeData(
              color: Theme.of(context).primaryColor,
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.asset(
                      'assets/images/${provider.imageName}.png',
                      width: double.infinity,
                      height: 205,
                      fit: BoxFit.fill,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    height: 45,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            provider.changeEvent(index);
                          },
                          child: EventItem(
                            eventType: provider.eventsCategories[index],
                            isSelected: provider.eventsCategories[index] ==
                                provider.selectEvent,
                          ),
                        );
                      },
                      separatorBuilder: (context, index) => const SizedBox(
                        width: 15,
                      ),
                      itemCount: provider.eventsCategories.length,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Text(
                        'Title',
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                    ],
                  ),
                  TextFormField(
                    controller:   titleController,
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.edit_note),
                      labelText: 'Event Title',
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Row(
                    children: [
                      Text(
                        'Description',
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                    ],
                  ),
                  TextFormField(
                    controller: descriptionController,
                    maxLines: 4,
                    decoration: const InputDecoration(
                      labelText: 'Event Description',
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Row(
                    children: [
                      const Icon(Icons.calendar_month),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        'Event Date',
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                      const Spacer(),
                      InkWell(
                        onTap: () async {
                          var chosenDate = await showDatePicker(
                            initialDate: DateTime.now(),
                            context: context,
                            firstDate: DateTime.now().subtract(
                              const Duration(days: 365),
                            ),
                            lastDate: DateTime.now().add(
                              const Duration(days: 365),
                            ),
                          );
                          if (chosenDate != null) {
                            provider.chosenSelectedDate(chosenDate);
                          }
                        },
                        child: Text(
                          provider.selectedDate.toString().substring(0, 10),
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 150,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: FilledButton(
                      onPressed: () {
                        TaskModel task = TaskModel(
                          userId: FirebaseAuth.instance.currentUser!.uid,
                          title: titleController.text,
                          date: provider.selectedDate.millisecondsSinceEpoch,
                          description: descriptionController.text,
                          category: provider.imageName,
                        );
                        FirebaseManager.addEvent(task).then(
                          (value) {
                            Navigator.pop(context);
                          },
                        );
                        // FirebaseManager.addEvent(task).then(
                        //   (value) => Navigator.pop(context),
                        // );
                      },
                      child: const Text(
                        'Add Event',
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
