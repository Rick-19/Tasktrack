import 'package:flutter/material.dart';

class AlertBox extends StatelessWidget {
  final theme1 = ThemeData(
    primarySwatch: Colors.purple,
    colorScheme: const ColorScheme.light().copyWith(
      primary: Colors.purple,
      secondary: Colors.white,
    ),
  );
  final theme2 = ThemeData(
    //primarySwatch: Colors.purple,
    colorScheme: const ColorScheme.light().copyWith(
      primary: Colors.white,
    ),
  );
  final Function addItem;
  final Function replaceItem;
  final int flag;
  final String id;
  AlertBox(
      {super.key,
      required this.addItem,
      required this.flag,
      required this.replaceItem,
      required this.id});

  final activity = TextEditingController();

  void addActivity(BuildContext context) {
    final act = activity.text;
    (flag == 0) ? addItem(act) : replaceItem(act, id);
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: (flag == 0) ? theme1 : theme2,
      child: AlertDialog(
        backgroundColor: (flag == 1) ? Colors.purple : Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
        content: SizedBox(
          height: 160,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextField(
                controller: activity,
                decoration: InputDecoration(
                  label: Text(
                    (flag == 0) ? 'Add Task' : 'Update Task',
                    style: TextStyle(
                        color: (flag == 0)
                            ? theme1.colorScheme.copyWith().primary
                            : theme2.colorScheme.copyWith().primary),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('Cancel'),
                  ),
                  TextButton(
                    onPressed: () {
                      addActivity(context);
                      Navigator.of(context).pop();
                    },
                    child:
                        (flag == 1) ? const Text('Update') : const Text('Add'),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
