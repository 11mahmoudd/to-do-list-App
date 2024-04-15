# to-do-list-App
This project is a simple to-do list application built using Flutter. It consists of several components:

components.dart: This file contains reusable widget functions such as defaultFormFeild, taskBuilder, newTaskBuilder, doneTaskBuilder, and archivedTaskBuilder. These widgets are used to create form fields, display tasks, and build task items with various states (new, done, archived).

homelayout.dart: This file defines the main layout of the application. It contains a HomeLayout widget that displays a bottom navigation bar to switch between different task categories (new, done, archived). It also includes a floating action button to add new tasks, and a bottom sheet for adding tasks.

newtask.dart, donetasks.dart, archivedtasks.dart: These files contain screen widgets for displaying new tasks, done tasks, and archived tasks respectively. Each screen widget fetches tasks from the AppCubit state management class and uses the taskBuilder widget from components.dart to display the tasks.

cubit.dart: This file defines the AppCubit class, which extends Cubit from the Flutter Bloc package. It manages the application state and database operations such as creating, inserting, updating, and deleting tasks. It also contains methods to fetch tasks from the database and change the current screen index and bottom sheet visibility.

states.dart: This file defines various state classes used by the AppCubit class to represent different states of the application, such as initial, loading, success, error, etc.

bloc_observer.dart: This file contains a custom BlocObserver class to observe state changes in the application.

main.dart: This is the entry point of the application. It initializes the Flutter app and sets up the MyApp widget, which in turn sets up the HomeLayout as the home screen.

Overall, this application allows users to manage their tasks by adding, marking as done, archiving, and deleting them. It provides a simple and intuitive user interface for organizing tasks efficiently.
