import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:todo/model/todo.dart';
import 'package:intl/intl.dart';

class Contents extends StatefulWidget {
  final Todo works;
  final Function removeItems;
  final Function showDialog;
  const Contents(
      {super.key,
      required this.works,
      required this.removeItems,
      required this.showDialog});

  @override
  State<Contents> createState() => _ContentsState();
}

class _ContentsState extends State<Contents> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Slidable(
            endActionPane: ActionPane(
              motion: const StretchMotion(),
              children: [
                SlidableAction(
                  onPressed: (context) {
                    (!widget.works.ischecked!)
                        ? widget.showDialog(1, widget.works.id)
                        : null;
                  },
                  icon: Icons.edit,
                  backgroundColor: const Color.fromARGB(255, 129, 217, 132),
                  borderRadius: BorderRadius.circular(15),
                ),
                SlidableAction(
                  onPressed: (context) {
                    widget.removeItems(widget.works.id);
                  },
                  icon: Icons.delete,
                  backgroundColor: const Color.fromARGB(255, 243, 82, 71),
                  borderRadius: BorderRadius.circular(15),
                ),
              ],
            ),
            child: Container(
              height: 75,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: const Color.fromARGB(255, 204, 126, 220),
              ),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: (widget.works.ischecked)!
                      ? Colors.grey.withOpacity(0.5)
                      : Colors.transparent,
                ),
                child: ListTile(
                  title: (!widget.works.ischecked!)
                      ? Text(widget.works.title)
                      : Text(
                          widget.works.title,
                          style: const TextStyle(
                            decoration: TextDecoration.lineThrough,
                            decorationThickness: 1.5,
                          ),
                        ),
                  subtitle: Text(
                    DateFormat('dd, MMMM yyyy').format(widget.works.date),
                  ),
                  leading: Checkbox(
                      activeColor: Colors.purple,
                      value: widget.works.ischecked,
                      onChanged: (!widget.works.ischecked!)
                          ? (value) {
                              setState(() {
                                widget.works.ischecked = value;
                              });
                            }
                          : null),
                  trailing: const Icon(Icons.arrow_back),
                ),
              ),
            ),
          ),
        ),
        const Divider(
          height: 4,
          thickness: 2,
        ),
      ],
    );
  }
}
