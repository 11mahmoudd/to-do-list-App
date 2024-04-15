import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo_list_app/shared/cubit/cubit.dart';

Widget defaultFormFeild({
  required TextEditingController controller,
  required TextInputType type,
  Function(void)? onSubmit,
  Function(void)? onChange,
  GestureTapCallback? onTap,
  bool isPassword = false,
  required FormFieldValidator<String>? validate,
  required String label,
  required IconData prefixIcon,
  IconData? suffixIcon,
  GestureDetector? suffixPressed,
  bool readOnly= false,
}) =>
    TextFormField(
      controller: controller,
      keyboardType: type,
      obscureText: isPassword,
      readOnly: readOnly,
      onFieldSubmitted: onSubmit,
      onChanged: onChange,
      onTap: onTap,
      validator: validate,
      decoration: InputDecoration(
        prefixIcon: Icon(prefixIcon),
        labelText: label,
        border: OutlineInputBorder(),
        suffixIcon: Icon(suffixIcon),
        suffix: suffixPressed,
      ),
    );



Widget taskBuilder({
  required List<Map>tasks,
  required var itemBuilderType,
})=>ConditionalBuilder(
    condition: tasks.length > 0,
    builder: (context) => ListView.separated(
      itemBuilder: (context, index) =>itemBuilderType(tasks[index],context),
      separatorBuilder: (context, index) => Padding(
        padding: const EdgeInsets.all(10.0),
        child: Container(
          width: double.infinity,
          color: Colors.grey[300],
          height: 0.7,
        ),
      ),
      itemCount: tasks.length,
    ),
    fallback: (context) => Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.menu,
            size: 100,
            color: Colors.grey,
          ),
          Text('No Tasks Yet, Please Add Some Tasks',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          )
        ],
      ),
    ));


Widget newTaskBuilder(Map model , context ) =>
    Dismissible(
      direction:DismissDirection.endToStart ,
      background: Container(
        color: Colors.red,
        width: double.infinity,
        alignment: Alignment.centerRight,
        child:Icon(Icons.delete,
          size: 50.0,),
      ),
      key: Key(model['id'].toString()),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Row(
          children: [
            CircleAvatar(
              radius: 45.0,
              child:Text(
                '${model['time']}',
                style: TextStyle(
                  fontSize:20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(
              width: 20,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                // mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    '${model['title']}',
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '${model['date']}',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
                width: 20.0
            ),
            IconButton(
                onPressed: () {
                  AppCubit.get(context).updateData(
                      status: 'done',
                      id: model['id']
                  );
                },
                icon: Icon(
                  size: 30,
                  Icons.check_box,
                  color: Colors.green,
                )
            ),
            SizedBox(
                width: 20.0
            ),

            IconButton(
                onPressed: () {
                  AppCubit.get(context).updateData(
                      status: 'archived',
                      id: model['id']
                  );
                },
                icon: Icon(
                  size: 30,
                  Icons.archive,
                  color: Colors.black45,
                )
            ),
          ],
        ),
      ),
      onDismissed: (direction)
      {
        AppCubit.get(context).deleteData(id: model['id']);
      },
    );


Widget doneTaskBuilder(Map model , context ) =>
    Dismissible(
      direction:DismissDirection.endToStart ,
      background: Container(
        color: Colors.red,
        width: double.infinity,
        alignment: Alignment.centerRight,
        child:Icon(Icons.delete,
          size: 50.0,),
      ),
      key: Key(model['id'].toString()),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Row(
          children: [
            CircleAvatar(
              radius: 45.0,
              child:Text(
                '${model['time']}',
                style: TextStyle(
                  fontSize:20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(
              width: 20,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                // mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    '${model['title']}',
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '${model['date']}',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: 20.0,
            ),
            IconButton(
                onPressed: () {
                  AppCubit.get(context).updateData(
                      status: 'new',
                      id: model['id']
                  );
                },
                icon: Icon(
                  size: 30,
                  Icons.undo,
                  color: Colors.green,
                )
            ),
          ],
        ),
      ),
      onDismissed: (direction)
      {
        AppCubit.get(context).deleteData(id: model['id']);
      },
    );

Widget archivedTaskBuilder(Map model , context ) =>
    Dismissible(
      direction:DismissDirection.endToStart ,
      background: Container(
        color: Colors.red,
        width: double.infinity,
        alignment: Alignment.centerRight,
        child:Icon(Icons.delete,
          size: 50.0,),
      ),
      key: Key(model['id'].toString()),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Row(
          children: [
            CircleAvatar(
              radius: 45.0,
              child:Text(
                '${model['time']}',
                style: TextStyle(
                  fontSize:20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(
              width: 20,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                // mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    '${model['title']}',
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '${model['date']}',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
                width: 20.0
            ),
            IconButton(
                onPressed: () {
                  AppCubit.get(context).updateData(
                      status: 'done',
                      id: model['id']
                  );
                },
                icon: Icon(
                  size: 30,
                  Icons.check_box,
                  color: Colors.green,
                )
            ),
            SizedBox(
                width: 20.0
            ),

            IconButton(
                onPressed: () {
                  AppCubit.get(context).updateData(
                      status: 'new',
                      id: model['id']
                  );
                },
                icon: Icon(
                  size: 30,
                  Icons.unarchive,
                  color: Colors.black45,
                )
            ),
          ],
        ),
      ),
      onDismissed: (direction)
      {
        AppCubit.get(context).deleteData(id: model['id']);
      },
    );
