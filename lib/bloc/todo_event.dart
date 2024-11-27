import 'package:todo_bloc/todo_model.dart';

abstract class TodoEvents{}

class TodoAddEvent extends TodoEvents{
  TodoModel addtodo;
  TodoAddEvent({required this.addtodo});
}
class TodoUpdateEvent extends TodoEvents{
  TodoModel updatetodo;
  int sno;
  TodoUpdateEvent({required this.updatetodo,required this.sno});
}
class TodoDeleteEvent extends TodoEvents{
  int sno;
  TodoDeleteEvent({required this.sno});
}
class TodoGetEvent extends TodoEvents{}