import 'package:flutter/material.dart';

class EventItem extends StatelessWidget {
  String eventType;
  bool isSelected;
  EventItem({required this.isSelected, required this.eventType, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        border: Border.all(
          width: 2,
          color: Theme.of(context).primaryColor,
        ),
        borderRadius: BorderRadius.circular(30),
        color: isSelected ? Theme.of(context).primaryColor : Colors.transparent,
      ),
      child: Text(
        eventType,
        style: Theme.of(context).textTheme.titleMedium!.copyWith(
              color: isSelected ? Colors.white : Theme.of(context).primaryColor,
            ),
      ),
    );
  }
}
