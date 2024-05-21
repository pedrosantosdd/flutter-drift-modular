import 'package:app_b/di/dependency_injection.dart';
import 'package:feature_a/data/database.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  configureDependencies();
  runApp(MyHomePage(
    todoItemsDao: GetIt.I<TodoItemsDao>(),
  ));
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.todoItemsDao});
  final TodoItemsDao todoItemsDao;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  increaseDatabase() {
    widget.todoItemsDao.create('Todo: B:',
        '${DateTime.now().hour}:${DateTime.now().minute}:${DateTime.now().second}');
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('App B Database')),
        body: SafeArea(
          child: StreamBuilder(
              initialData: const [],
              stream: widget.todoItemsDao.getAllWatch(),
              builder: (context, snapshot) {
                if (![ConnectionState.active, ConnectionState.done]
                    .contains(snapshot.connectionState)) {
                  return const CircularProgressIndicator();
                }
                return GridView.builder(
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 200, mainAxisExtent: 100),
                  shrinkWrap: true,
                  itemCount: snapshot.data
                          ?.where((element) => element != null)
                          .length ??
                      1,
                  itemBuilder: (context, index) => GridTile(
                    child: Text(snapshot.data![index].title +
                        snapshot.data![index].content),
                  ),
                );
              }),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: increaseDatabase,
          child: const Text('Load'),
        ),
      ),
    );
  }
}
