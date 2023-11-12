import 'package:freezed_annotation/freezed_annotation.dart';

@JsonEnum(fieldRename: FieldRename.screamingSnake)
enum TodoStatus {
  todo,
  doing,
  done,
}

extension TodoStatusExtension on TodoStatus {
  String text() {
    switch (this) {
      case TodoStatus.todo:
        return 'To-do';
      case TodoStatus.doing:
        return 'Doing';
      case TodoStatus.done:
        return 'Done';
    }
  }
}

enum TodoSortBy {
  id,
  title,
  description,
  createdAt,
  status,
}

enum TodoSortType {
  asc,
  desc,
}
