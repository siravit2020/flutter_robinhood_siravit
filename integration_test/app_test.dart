import 'package:flutter/material.dart';
import 'package:flutter_robinhood_siravit/app/modules/main/views/screens/main_screen.dart';
import 'package:flutter_robinhood_siravit/app/modules/main/views/widgets/main_app_bar.dart';
import 'package:flutter_robinhood_siravit/app/modules/main/views/widgets/todo_item.dart';
import 'package:flutter_robinhood_siravit/app/modules/passcode_lock/views/screens/passcode_lock_screen.dart';
import 'package:flutter_robinhood_siravit/app/widgets/custom_alert_dialog.dart';
import 'package:flutter_robinhood_siravit/core/utils/enum.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:flutter_robinhood_siravit/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('end-to-end test', () {
    testWidgets('test passcode invalid', (tester) async {
      await app.main();
      await tester.pumpAndSettle();
      expect(find.byType(PasscodeLockScreen), findsOneWidget);
      await tester.tap(find.byKey(const Key('numpad_1')));
      await tester.pumpAndSettle();
      await tester.tap(find.byKey(const Key('numpad_2')));
      await tester.pumpAndSettle();
      await tester.tap(find.byKey(const Key('numpad_4')));
      await tester.pumpAndSettle();
      await tester.tap(find.byKey(const Key('numpad_4')));
      await tester.pumpAndSettle();
      await tester.tap(find.byKey(const Key('numpad_5')));
      await tester.pumpAndSettle();
      await tester.tap(find.byKey(const Key('numpad_1')));
      await tester.pumpAndSettle();
      expect(find.byType(CustomAlertDialog), findsOneWidget);
      expect(find.text('Invalid passcode'), findsOneWidget);
    });
    testWidgets('test passcode valid', (tester) async {
      await app.main();
      await tester.pumpAndSettle();
      expect(find.byType(PasscodeLockScreen), findsOneWidget);
      await tester.tap(find.byKey(const Key('numpad_1')));
      await tester.pumpAndSettle();
      await tester.tap(find.byKey(const Key('numpad_2')));
      await tester.pumpAndSettle();
      await tester.tap(find.byKey(const Key('numpad_3')));
      await tester.pumpAndSettle();
      await tester.tap(find.byKey(const Key('numpad_cancel')));
      await tester.pumpAndSettle();
      await tester.tap(find.byKey(const Key('numpad_1')));
      await tester.pumpAndSettle();
      await tester.tap(find.byKey(const Key('numpad_2')));
      await tester.pumpAndSettle();
      await tester.tap(find.byKey(const Key('numpad_3')));
      await tester.pumpAndSettle();
      await tester.tap(find.byKey(const Key('numpad_4')));
      await tester.pumpAndSettle();
      await tester.tap(find.byKey(const Key('numpad_5')));
      await tester.pumpAndSettle();
      await tester.tap(find.byKey(const Key('numpad_remove')));
      await tester.pumpAndSettle();
      await tester.tap(find.byKey(const Key('numpad_5')));
      await tester.pumpAndSettle();
      await tester.tap(find.byKey(const Key('numpad_6')));
      await tester.pumpAndSettle();
      expect(find.byType(MainScreen), findsOneWidget);
    });
    testWidgets('test main screen', (tester) async {
      await app.main();
      await tester.pumpAndSettle();
      expect(find.byType(MainScreen), findsOneWidget);
      expect(find.byType(MainAppBar), findsOneWidget);
      expect(find.byType(TabBar), findsOneWidget);
      expect(find.byKey(const Key('sort')), findsOneWidget);
      expect(find.byType(TodoItem).at(0), findsOneWidget);
      await tester.drag(find.byType(Slidable).at(0), const Offset(-1500, 0));
      await tester.pumpAndSettle();
      await tester.drag(find.byType(Slidable).at(1), const Offset(-400, 0));
      await tester.pumpAndSettle();
      await tester.tap(find.byType(SlidableAction).at(0));
      await tester.pumpAndSettle();
      final listFinder = find.byKey(const Key('main_scroll'));
      final itemFinder = find.byKey(const Key('todo_date_index_last'));
      await tester.dragUntilVisible(
        itemFinder,
        listFinder,
        const Offset(0, -500),
      );
      await tester.tap(find.byKey(const ValueKey(TodoStatus.doing)));
      await tester.pumpAndSettle();
      await tester.dragUntilVisible(
        itemFinder,
        listFinder,
        const Offset(0, -500),
      );
      await tester.tap(find.byKey(const ValueKey(TodoStatus.done)));
      await tester.pumpAndSettle();
      await tester.dragUntilVisible(
        itemFinder,
        listFinder,
        const Offset(0, -500),
      );
      await tester.tap(find.byKey(const ValueKey(TodoStatus.todo)));
      await tester.pumpAndSettle();
      await tester.tap(find.byKey(const Key('sort')));
      await tester.pumpAndSettle();
      expect(find.byType(PopupMenuButton<TodoSortType>), findsOneWidget);
      expect(find.byKey(const ValueKey(TodoSortType.asc)), findsOneWidget);
      expect(find.byKey(const ValueKey(TodoSortType.desc)), findsOneWidget);
      await tester.tap(find.byKey(const ValueKey(TodoSortType.asc)));
      await tester.pumpAndSettle();
      await tester.tap(find.byKey(const Key('sort')));
      await tester.pumpAndSettle();
      await tester.tap(find.byKey(const ValueKey(TodoSortType.desc)));
      await tester.pumpAndSettle();
    });
  });
}
