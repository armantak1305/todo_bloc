import 'package:todo_bloc/todo_model.dart';

abstract class TodoState{}

class TodoInitalState extends TodoState{}
class TodoLoadingState extends TodoState{}
class TodoLoadedState extends TodoState{
  List<TodoModel> mTodo;
  TodoLoadedState({required this.mTodo});
}
class TodoErrorState extends TodoState{
  String errorMsg;
  TodoErrorState({required this.errorMsg});
}