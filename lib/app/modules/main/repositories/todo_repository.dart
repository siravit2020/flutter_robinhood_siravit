import 'package:dio/dio.dart';
import 'package:flutter_robinhood_siravit/app/modules/main/models/todo_response.dart';
import 'package:retrofit/retrofit.dart';

part 'todo_repository.g.dart';

@RestApi()
abstract class TodoRepository {
  factory TodoRepository(Dio dio, {String baseUrl}) = _TodoRepository;

  @GET('/todo-list')
  Future<TodoResponse> getTodoList({
    @Query('offset') int? offset,
    @Query('limit') int? limit,
    @Query('sortBy') String? sortBy,
    @Query('isAsc') bool? isAsc,
    @Query('status') String? status,
  });
}
