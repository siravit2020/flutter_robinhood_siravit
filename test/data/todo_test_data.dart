import 'package:flutter_robinhood_siravit/app/modules/main/models/todo_response.dart';
import 'package:flutter_robinhood_siravit/core/utils/enum.dart';

const testTodoJson = {
  'tasks': [
    {
      'id': '1',
      'title': 'Task 1',
      'description': 'Description 1',
      'createdAt': '2022-01-01T00:00:00.000Z',
      'status': 'TODO',
    },
    {
      'id': '2',
      'title': 'Task 2',
      'description': 'Description 2',
      'createdAt': '2022-01-02T00:00:00.000Z',
      'status': 'DONE',
    },
    {
      'id': '3',
      'title': 'Task 3',
      'description': 'Description 3',
      'createdAt': '2022-01-02T00:00:00.000Z',
      'status': 'DOING',
    },
  ],
  'pageNumber': 0,
  'totalPages': 10,
};
const testTodoJsonStatusTodo = {
  "tasks": [
    {
      "id": "119a8c45-3f3d-41da-88bb-423c5367b81a",
      "title": "Exercise",
      "description": "Go for a run or do a workout at home",
      "createdAt": "2023-03-25T09:00:00Z",
      "status": "TODO"
    },
    {
      "id": "ab7e3eb3-058d-44de-bb97-01b35d2b2c29",
      "title": "Pay bills",
      "description": "Pay monthly bills and schedule future payments",
      "createdAt": "2023-03-25T14:00:00Z",
      "status": "TODO"
    },
    {
      "id": "67cbf4e4-c81e-4c8e-aa1e-6efc7e75b0a8",
      "title": "Write a letter",
      "description": "Write a letter to a family member or friend",
      "createdAt": "2023-03-27T15:45:00Z",
      "status": "TODO"
    },
  ],
  "pageNumber": 0,
  "totalPages": 3
};
final testTodoResponse = TodoResponse(
  tasks: [
    Task(
      id: '1',
      title: 'Task 1',
      description: 'Description 1',
      createdAt: DateTime.parse('2022-01-01T00:00:00.000Z'),
      status: TodoStatus.todo,
    ),
    Task(
      id: '2',
      title: 'Task 2',
      description: 'Description 2',
      createdAt: DateTime.parse('2022-01-02T00:00:00.000Z'),
      status: TodoStatus.done,
    ),
    Task(
      id: '3',
      title: 'Task 3',
      description: 'Description 3',
      createdAt: DateTime.parse('2022-01-02T00:00:00.000Z'),
      status: TodoStatus.doing,
    ),
  ],
  pageNumber: 0,
  totalPages: 10,
);
final testTodoResponseStatusTodo = TodoResponse(
  tasks: [
    Task(
      id: '119a8c45-3f3d-41da-88bb-423c5367b81a',
      title: 'Exercise',
      description: 'Go for a run or do a workout at home',
      createdAt: DateTime.parse('2023-03-25T09:00:00Z'),
      status: TodoStatus.todo,
    ),
    Task(
      id: 'ab7e3eb3-058d-44de-bb97-01b35d2b2c29',
      title: 'Pay bills',
      description: 'Pay monthly bills and schedule future payments',
      createdAt: DateTime.parse('2023-03-25T14:00:00Z'),
      status: TodoStatus.todo,
    ),
    Task(
      id: '67cbf4e4-c81e-4c8e-aa1e-6efc7e75b0a8',
      title: 'Write a letter',
      description: 'Write a letter to a family member or friend',
      createdAt: DateTime.parse('2023-03-27T15:45:00Z'),
      status: TodoStatus.todo,
    ),
  ],
  pageNumber: 0,
  totalPages: 3,
);
