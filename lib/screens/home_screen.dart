import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/todo_list_provider.dart';
import '../widgets/add_edit_todo_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "TodoList",
          style: TextStyle(fontFamily: 'NunitoBold', fontSize: 25),
        ),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: <Color>[Colors.red, Colors.blue])),
        ),
      ),
      body: Consumer<TodoListProvider>(builder: (
        context,
        todoProvider,
        child,
      ) {
        return ListView(
          padding: const EdgeInsets.all(20.0),
          children: todoProvider.todolist.isNotEmpty
              ? todoProvider.todolist.map((todo) {
                  return Dismissible(
                    key: Key(todo.id),
                    background: Container(
                      color: Colors.red.shade300,
                      child: const Center(
                        child: Text(
                          "Hapus?",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      color: Color.fromARGB(255, 219, 209, 208),
                      child: ListTile(
                        title: Text(todo.todo),
                        onTap: () {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return AddEditTodoWidget(
                                  title: "Edit Todo",
                                  todo: todo,
                                );
                              });
                        },
                      ),
                    ),
                    onDismissed: (direction) {
                      Provider.of<TodoListProvider>(
                        context,
                        listen: false,
                      ).removeTodo(todo);
                    },
                  );
                }).toList()
              : [
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height - 100.0,
                    child: const Center(
                      child: Text(
                        "TodoList masih kosong!",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontFamily: 'NunitoSemiBold', fontSize: 15),
                      ),
                    ),
                  )
                ],
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (context) {
                return const AddEditTodoWidget(title: "Tambah Todo");
              });
        },
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_filled), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite), label: 'Favorite'),
        ],
      ),
    );
  }
}
