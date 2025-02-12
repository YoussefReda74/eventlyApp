import 'package:flutter/cupertino.dart';

class CreateEventProvider extends ChangeNotifier{

  int selectedEventIndex = 0;
  var selectedDate=DateTime.now();
  List<String> eventsCategories = [
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
    String get imageName=>eventsCategories[selectedEventIndex];
    String get selectEvent=>eventsCategories[selectedEventIndex];


  void setSelectedCategory(String category) {
    selectedEventIndex = eventsCategories.indexOf(category);
    notifyListeners();
  }
    chosenSelectedDate(DateTime date){
      selectedDate=date;
      notifyListeners();
    }

  changeEvent(index){
    selectedEventIndex=index;
    notifyListeners();
  }

}