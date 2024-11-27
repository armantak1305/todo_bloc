import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_bloc/bloc/todo_event.dart';
import 'package:todo_bloc/bloc/todo_state.dart';

import '../data/dbhelper.dart';

class TodoBloc extends Bloc<TodoEvents,TodoState>{
  DBhelper dBhelper;
  TodoBloc({required this.dBhelper}):super(TodoInitalState()){
    on<TodoAddEvent>((event,state)async{
      emit(TodoLoadingState());
      bool isAdd =await dBhelper.insertTodo(event.addtodo);
      if(isAdd){
        var mTodo =await dBhelper.fetchTodo();
        emit(TodoLoadedState(mTodo: mTodo));
      }
      else{
        emit(TodoErrorState(errorMsg: "No Todo Add!!"));
      }
    });
    on<TodoUpdateEvent>((event,state)async{
      emit(TodoLoadingState());
      bool isUpdate =await dBhelper.updateTod(event.updatetodo, event.sno);
      if(isUpdate){
        var mTodo = await dBhelper.fetchTodo();
        emit(TodoLoadedState(mTodo: mTodo));
      }
      else{
        emit(TodoErrorState(errorMsg: "Todo is Note Updated!!"));
      }
    });
    on<TodoDeleteEvent>((event,state)async{
      bool isDelete =await dBhelper.deleteTodo(event.sno);
      if(isDelete){
        var mTodo =await dBhelper.fetchTodo();
        emit(TodoLoadedState(mTodo: mTodo));
      }
      else{
        emit(TodoErrorState(errorMsg: "Todo is No Deleted"));
      }
    });
    on<TodoGetEvent>((event,state)async{
      var mTodo = await dBhelper.fetchTodo();
      emit(TodoLoadedState(mTodo: mTodo));
    });
  }
}