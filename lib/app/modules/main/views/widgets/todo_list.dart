import 'package:flutter/material.dart';
import 'package:flutter_robinhood_siravit/app/modules/main/controllers/todo_controller.dart';
import 'package:flutter_robinhood_siravit/app/modules/main/models/todo_response.dart';
import 'package:flutter_robinhood_siravit/app/modules/main/views/widgets/todo_item.dart';
import 'package:flutter_robinhood_siravit/core/constants/constants.dart';
import 'package:flutter_robinhood_siravit/core/gen/assets.gen.dart';
import 'package:flutter_robinhood_siravit/core/utils/formatter.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class TodoList extends StatelessWidget {
  const TodoList({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: EdgeInsets.only(
        left: Spacing.spacing16,
        right: Spacing.spacing16,
        bottom: Spacing.spacing16 + Get.mediaQuery.padding.bottom,
      ),
      sliver: GetBuilder<TodoController>(
        builder: (controller) =>
            PagedSliverList<int, MapEntry<DateTime, List<Task>>>(
          pagingController: controller.pagingController,
          builderDelegate:
              PagedChildBuilderDelegate<MapEntry<DateTime, List<Task>>>(
            itemBuilder: (context, item, dateIndex) {
              return Column(
                key: (dateIndex !=
                        (controller.pagingController.itemList?.length ?? 0) - 1)
                    ? Key('todo_date_index_$dateIndex')
                    : const Key('todo_date_index_last'),
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    dateFormatter.format(item.key),
                    style: TextStyleSet.headline300,
                  ),
                  const SizedBox(
                    height: Spacing.spacing12,
                  ),
                  ListView.separated(
                    itemBuilder: (context, index) => TodoItem(
                      task: item.value[index],
                      dateIndex: dateIndex,
                    ),
                    shrinkWrap: true,
                    padding: EdgeInsets.zero,
                    physics: const NeverScrollableScrollPhysics(),
                    separatorBuilder: (context, index) => const SizedBox(
                      height: Spacing.spacing12,
                    ),
                    itemCount: item.value.length,
                  ),
                  if (dateIndex !=
                      (controller.pagingController.itemList?.length ?? 0) - 1)
                    const SizedBox(
                      height: Spacing.spacing40,
                    ),
                ],
              );
            },
            animateTransitions: true,
            transitionDuration: const Duration(milliseconds: 150),
            firstPageProgressIndicatorBuilder: (BuildContext context) {
              return Center(
                child: Assets.lotties.loading.lottie(
                  alignment: Alignment.center,
                  width: 100,
                  height: 100,
                ),
              );
            },
            newPageProgressIndicatorBuilder: (BuildContext context) {
              return Center(
                child: Assets.lotties.loading.lottie(
                  alignment: Alignment.center,
                  width: 50,
                  height: 50,
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
