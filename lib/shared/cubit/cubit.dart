import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list_app/modules/archived_tasks/archived_tasks_screen.dart';
import 'package:todo_list_app/modules/done_tasks/done_tasks_screen.dart';
import 'package:todo_list_app/modules/new_tasks/new_tasks_screen.dart';
import 'package:sqflite/sqflite.dart';
import 'states.dart';


class AppCubit extends Cubit<AppStates>
{
  AppCubit() : super(AppInitialState());

  static AppCubit get (context)=> BlocProvider.of(context);

  int curIndex=0;
  late Database database;
  var fabIcon= Icons.edit;
  bool isBottomSheet = false;


  List<Widget> screens=[
    NewTasksScreen(),
    DoneTasksScreen(),
    ArchivedTasksScreen()
  ];
  List<String> titles=[
    "New Tasks",
    'Done Tasks',
    "Archived Tasks"
  ];

  List<Map> newTasks=[];
  List<Map> doneTasks=[];
  List<Map> archivedTasks=[];

void  updateData({
    required String status,
    required int id,
})async
  {
    database.rawUpdate(
        'UPDATE Test SET status = ? WHERE id = ?',
        ['$status', id]).then((value) {
          getDataBase(database);
          emit(AppUpdateDBState());
          emit(AppGetDBState());
    });
  }
  void  deleteData({
    required int id,
  })async
  {
    database.rawDelete('DELETE FROM Test WHERE id = ?', [id]).
    then((value) {
      getDataBase(database);
      emit(AppDeleteDBState());
    });
  }

  void createDataBase() {
    openDatabase(
      'todo.db',
      version: 1,
      onCreate: ( database, version) {
        // When creating the db, create the table
        print('DataBase Created');
        database.execute(
            'CREATE TABLE Test ('
                'id INTEGER PRIMARY KEY,'
                ' title TEXT,'
                ' date TEXT,'
                ' time TEXT,'
                'status TEXT)'
        );
        print ('Table Created');
      },
      onOpen: (database)
      {
        getDataBase(database);
        print('database opened');
      },
    ).then((value) {
      database = value;
      emit(AppCreateDBState());
    });
  }


  insertDataBase({
    required String title,
    required String time,
    required String date,
  }) async{
    await database.transaction((txn) async{
      txn.rawInsert('insert into test(title,date,time,status) values("$title","$date","$time","new")')
          .then((value) {
        print('$value insert successfully');
        emit(AppInsertDBState());
        getDataBase(database);
      }).catchError((error) {
        print('Error inserting new record ${error.toString()}');
      });
      return null;
    });
  }

  void  getDataBase(database) {
    newTasks = [];
    doneTasks = [];
    archivedTasks = [];

    emit(AppGetDBLoadingState());
    database.rawQuery('SELECT * FROM Test').then((value){

      value.forEach((element)
      {
        if(element['status']=='new')
            newTasks.add(element);
        else if(element['status']=='done')
            doneTasks.add(element);
        else
            archivedTasks.add(element);
      });

      emit(AppGetDBState());
    });
  }

  void changeIndex(int index)
  {
    curIndex=index;
    emit(AppChangeBotNavBarState());
  }
  void changeBotSheet({
    required bool isShow,
    required IconData icon,
  })
  {
    isBottomSheet=isShow;
    fabIcon=icon;
    emit(AppChangeBotSheetState());
  }


}


