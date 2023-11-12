// Mocks generated by Mockito 5.4.2 from annotations
// in flutter_robinhood_siravit/test/units/todo/todo_repository_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i4;

import 'package:flutter_robinhood_siravit/app/modules/main/models/todo_response.dart'
    as _i2;
import 'package:flutter_robinhood_siravit/app/modules/main/repositories/todo_repository.dart'
    as _i3;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeTodoResponse_0 extends _i1.SmartFake implements _i2.TodoResponse {
  _FakeTodoResponse_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [TodoRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockTodoRepository extends _i1.Mock implements _i3.TodoRepository {
  @override
  _i4.Future<_i2.TodoResponse> getTodoList({
    int? offset,
    int? limit,
    String? sortBy,
    bool? isAsc,
    String? status,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #getTodoList,
          [],
          {
            #offset: offset,
            #limit: limit,
            #sortBy: sortBy,
            #isAsc: isAsc,
            #status: status,
          },
        ),
        returnValue: _i4.Future<_i2.TodoResponse>.value(_FakeTodoResponse_0(
          this,
          Invocation.method(
            #getTodoList,
            [],
            {
              #offset: offset,
              #limit: limit,
              #sortBy: sortBy,
              #isAsc: isAsc,
              #status: status,
            },
          ),
        )),
        returnValueForMissingStub:
            _i4.Future<_i2.TodoResponse>.value(_FakeTodoResponse_0(
          this,
          Invocation.method(
            #getTodoList,
            [],
            {
              #offset: offset,
              #limit: limit,
              #sortBy: sortBy,
              #isAsc: isAsc,
              #status: status,
            },
          ),
        )),
      ) as _i4.Future<_i2.TodoResponse>);
}