import 'package:flutter/material.dart';
import 'package:flutter_robinhood_siravit/app/modules/main/controllers/todo_controller.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_robinhood_siravit/app/modules/main/models/todo_response.dart';
import 'package:flutter_robinhood_siravit/core/constants/color_palette.dart';
import 'package:flutter_robinhood_siravit/core/constants/text_style.dart';
import 'package:get/get.dart';

class TodoItem extends GetView<TodoController> {
  final Task task;
  final int dateIndex;
  const TodoItem({
    Key? key,
    required this.task,
    required this.dateIndex,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Slidable(
      key: ValueKey(task.id),
      endActionPane: ActionPane(
        motion: const ScrollMotion(),
        dismissible: DismissiblePane(onDismissed: () {
          controller.removeTask(index: dateIndex, task: task);
        }),
        extentRatio: 0.4,
        children: [
          SlidableAction(
            onPressed: (context) {
              final SlidableController? c = Slidable.of(context);
              c?.dismiss(
                ResizeRequest(
                  const Duration(milliseconds: 300),
                  () async {
                    controller.removeTask(index: dateIndex, task: task);
                  },
                ),
              );
            },
            autoClose: false,
            backgroundColor: const Color(0xFFFE4A49),
            borderRadius: BorderRadius.circular(16),
            foregroundColor: Colors.white,
            icon: Icons.delete,
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            task.title,
            style: TextStyleSet.paragraph300.copyWith(
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(
            task.description,
            style: TextStyleSet.paragraph200.copyWith(
              color: ColorPalette.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}
