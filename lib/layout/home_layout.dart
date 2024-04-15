import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:todo_list_app/shared/components/components.dart';
import 'package:todo_list_app/shared/cubit/cubit.dart';
import 'package:todo_list_app/shared/cubit/states.dart';

class HomeLayout extends StatelessWidget {
  @override
  var scaffoldKey = GlobalKey<ScaffoldState>();
  var formkey = GlobalKey<FormState>();

  var titController = TextEditingController();
  var timeController = TextEditingController();
  var dateController = TextEditingController();
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppCubit()..createDataBase(),
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (BuildContext context, AppStates state) {
          if (state is AppInsertDBState)
            {
              Navigator.pop(context);
              titController.clear();
              timeController.clear();
              dateController.clear();
            }
        },
        builder: (BuildContext context, AppStates state) {
          AppCubit cubit = AppCubit.get(context);
          return Scaffold(
              key: scaffoldKey,
              appBar: AppBar(
                backgroundColor: Colors.blue,
                title: Text(cubit.titles[cubit.curIndex],
                style: TextStyle(
                  fontWeight: FontWeight.bold
                ),),
              ),
              body: ConditionalBuilder(
                condition: state is! AppGetDBLoadingState,
                builder: (context) => cubit.screens[cubit.curIndex],
                fallback: (context) =>
                    Center(child: CircularProgressIndicator()),
              ),
              floatingActionButton:
              ConditionalBuilder(
                condition: cubit.curIndex==0,
                builder: (context)=>FloatingActionButton(
                  backgroundColor: Colors.blue,
                  onPressed: () {
                    if (cubit.isBottomSheet) {
                      if (formkey.currentState!.validate()) {
                        cubit.insertDataBase(
                          title: titController.text,
                          time: timeController.text,
                          date: dateController.text,
                        );
                      }
                    } else {
                      scaffoldKey.currentState!
                          .showBottomSheet(
                              (context) => Container(
                            color: Colors.grey[200],
                            child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Form(
                                key: formkey,
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    defaultFormFeild(
                                      controller: titController,
                                      prefixIcon: Icons.title,
                                      type: TextInputType.text,
                                      label: 'Task Title',
                                      validate: (value) {
                                        if (value!.isEmpty) {
                                          return 'title must not be empty';
                                        }
                                        return null;
                                      },
                                    ),
                                    SizedBox(
                                      height: 10.0,
                                    ),
                                    defaultFormFeild(
                                      readOnly: true,
                                      controller: timeController,
                                      prefixIcon: Icons.watch_later_outlined,
                                      type: TextInputType.none,
                                      label: 'Task time',
                                      onTap: () {
                                        showTimePicker(
                                          context: context,
                                          initialTime: TimeOfDay.now(),
                                          initialEntryMode:
                                          TimePickerEntryMode
                                              .dialOnly,
                                        ).then((value) {
                                          timeController.text = value!
                                              .format(context)
                                              .toString();
                                        });


                                      },
                                      validate: (value) {
                                        if (value!.isEmpty) {
                                          return 'time must not be empty';
                                        }
                                        return null;
                                      },
                                    ),
                                    SizedBox(
                                      height: 10.0,
                                    ),
                                    defaultFormFeild(
                                      readOnly: true,
                                      controller: dateController,
                                      prefixIcon: Icons.calendar_month,
                                      type: TextInputType.none,
                                      label: 'date time',
                                      onTap: () {
                                        showDatePicker(
                                            context: context,
                                            initialDate:
                                            DateTime.now(),
                                            firstDate: DateTime.now(),
                                            lastDate: DateTime.parse(
                                                '2024-12-31'))
                                            .then((value) {
                                          dateController.text =
                                              DateFormat.yMMMd()
                                                  .format(value!);
                                        });
                                      },
                                      validate: (value) {
                                        if (value!.isEmpty) {
                                          return 'Date must not be empty';
                                        }
                                        return null;
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          elevation: 20.0)
                          .closed
                          .then((value) {
                        cubit.changeBotSheet(isShow: false, icon: Icons.edit);
                      });
                      cubit.changeBotSheet(isShow: true, icon: Icons.add);
                    }
                  },
                  child: Icon(
                    cubit.fabIcon,
                  ),
                ),
                fallback: (context){
                  return Container();
                },
              ),
              bottomNavigationBar: BottomNavigationBar(
                type: BottomNavigationBarType.fixed,
                elevation: 5.0,
                currentIndex: cubit.curIndex,
                selectedItemColor: Colors.blue,
                onTap: (index) {
                  cubit.changeIndex(index);
                  // setState(() {
                  //   _index=index;
                  // });
                },
                items: [
                  BottomNavigationBarItem(
                    icon: Icon(Icons.menu),
                    label: 'Tasks',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.check_circle_outline),
                    label: 'Done',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.archive_outlined),
                    label: 'Archived',
                  )
                ],
              ),

          );
        },
      ),
    );
  }

  // Future<String> getName() async {
  //   return 'Mahmoud Mohamed';
  // }
}
