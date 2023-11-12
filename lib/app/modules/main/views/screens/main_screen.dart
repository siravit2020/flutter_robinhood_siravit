import 'package:flutter/material.dart';
import 'package:flutter_robinhood_siravit/app/controllers/user_controller.dart';
import 'package:flutter_robinhood_siravit/app/modules/main/controllers/todo_controller.dart';
import 'package:flutter_robinhood_siravit/app/modules/main/views/widgets/main_app_bar.dart';
import 'package:flutter_robinhood_siravit/app/modules/main/views/widgets/todo_list.dart';
import 'package:flutter_robinhood_siravit/core/constants/spacing.dart';
import 'package:flutter_robinhood_siravit/core/utils/enum.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = UserController.to..onUserActivity();
    return Listener(
      onPointerDown: (_) => controller.onUserActivity(),
      onPointerUp: (_) => controller.onUserActivity(),
      onPointerMove: (_) => controller.onUserActivity(),
      child: DefaultTabController(
        length: TodoStatus.values.length,
        child: Scaffold(
          body: CustomScrollView(
            key: const Key('main_scroll'),
            controller: TodoController.to.scrollController,
            slivers: const [
              MainAppBar(),
              SliverToBoxAdapter(
                child: SizedBox(
                  height: Spacing.spacing32,
                ),
              ),
              TodoList(),
            ],
          ),
        ),
      ),
    );
  }
}
