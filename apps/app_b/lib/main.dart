import 'package:app_b/database.dart';
import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyHomePage(database: AppBDatabase()));
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.database});
  final AppBDatabase database;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  increaseDatabase() {
    widget.database
        .into(widget.database.todoItems)
        .insert(TodoItemsCompanion.insert(
          title: 'todo',
          content:
              '${DateTime.now().hour}:${DateTime.now().minute}:${DateTime.now().second}',
        ));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('App B Database')),
        body: StreamBuilder(
            initialData: const [],
            stream: widget.database.select(widget.database.todoItems).watch(),
            builder: (context, snapshot) {
              if (![ConnectionState.active, ConnectionState.done]
                  .contains(snapshot.connectionState)) {
                return const CircularProgressIndicator();
              }
              return ListView.builder(
                shrinkWrap: true,
                itemCount: snapshot.data?.length,
                itemBuilder: (context, index) {
                  return Text(snapshot.data?[index].title + snapshot.data?[index].content);
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
