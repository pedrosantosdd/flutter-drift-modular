import 'package:app_a/database.dart';
import 'package:app_a/di/dependency_injection.dart';
import 'package:drift_db_viewer/drift_db_viewer.dart';
import 'package:feature_a/data/dao/todo_items_dao.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  configureDependencies();
  runApp(MyHomePage(
    database: GetIt.I<AppADatabase>(),
    todoItemsDao: GetIt.I<TodoItemsDao>(),
  ));
}

class MyHomePage extends StatefulWidget {
  const MyHomePage(
      {super.key, required this.database, required this.todoItemsDao});
  final AppADatabase database;
  final TodoItemsDao todoItemsDao;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
    increaseDatabase();
  }

  increaseDatabase() {
    widget.todoItemsDao.create('Todo: drift:',
        '${DateTime.now().hour}:${DateTime.now().minute}:${DateTime.now().second}');
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('App A Database')),
        body: StreamBuilder(
            initialData: const [],
            stream: widget.todoItemsDao.getAllWatch(),
            builder: (context, snapshot) {
              if (![ConnectionState.active, ConnectionState.done]
                  .contains(snapshot.connectionState)) {
                return const CircularProgressIndicator();
              }
              return ListView.builder(
                shrinkWrap: true,
                itemCount:
                    snapshot.data?.where((element) => element != null).length ??
                        1,
                prototypeItem: FilledButton(
                    onPressed: () => Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (context) =>
                                DriftDbViewer(widget.database))),
                    child: const Text('See database')),
                itemBuilder: (context, index) {
                  return Text(snapshot.data![index].title +
                      snapshot.data![index].content);
                },
              );
            }),
        floatingActionButton: FloatingActionButton(
          onPressed: increaseDatabase,
          child: const Text('Load'),
        ),
      ),
    );
  }
}
