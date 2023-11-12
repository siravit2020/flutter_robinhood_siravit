import 'package:flutter/material.dart';
import 'package:flutter_robinhood_siravit/app/modules/main/controllers/todo_controller.dart';
import 'package:flutter_robinhood_siravit/core/constants/constants.dart';
import 'package:flutter_robinhood_siravit/core/utils/enum.dart';
import 'package:get/get.dart';

class MainAppBar extends GetView<TodoController> {
  const MainAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      title: const Text('Todo List'),
      actions: [
        Obx(
          () => PopupMenuButton<TodoSortType>(
            key: const Key('sort'),
            initialValue: controller.sortType.value,
            onSelected: (TodoSortType item) {
              controller.changeSortType(item);
            },
            icon: const Icon(Icons.sort),
            itemBuilder: (BuildContext context) =>
                <PopupMenuEntry<TodoSortType>>[
              const PopupMenuItem<TodoSortType>(
                key: ValueKey(TodoSortType.asc),
                value: TodoSortType.asc,
                child: Text('Oldest'),
              ),
              const PopupMenuItem<TodoSortType>(
                key: ValueKey(TodoSortType.desc),
                value: TodoSortType.desc,
                child: Text('Latest'),
              ),
            ],
          ),
        )
      ],
      centerTitle: false,
      backgroundColor: Colors.white,
      floating: true,
      pinned: true,
      surfaceTintColor: Colors.transparent,
      shadowColor: Colors.grey.shade100.withOpacity(0.5),
      bottom: TabBar(
        onTap: (value) {
          controller.changeTab(TodoStatus.values[value]);
        },
        tabs: TodoStatus.values.map(
          (e) {
            return Tab(
              key: ValueKey(e),
              text: e.text(),
            );
          },
        ).toList(),
        dividerColor: Colors.transparent,
        overlayColor: MaterialStateProperty.all(Colors.transparent),
        padding: const EdgeInsets.symmetric(
          horizontal: Spacing.spacing16,
        ),
        indicatorSize: TabBarIndicatorSize.tab,
        indicatorPadding: const EdgeInsets.symmetric(
          horizontal: Spacing.spacing16,
        ),
        labelColor: ColorPalette.textPrimary,
        labelStyle: TextStyleSet.headline300,
        unselectedLabelStyle: TextStyleSet.paragraph300,
        indicator: UnderlineTabIndicator(
          borderSide: const BorderSide(
            width: 3,
            color: ColorPalette.colorPrimary,
          ),
          borderRadius: BorderRadius.circular(BorderRadiusSet.radius16),
        ),
      ),
    );
  }
}
