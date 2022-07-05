import 'package:uuid/uuid.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/todo_model.dart';
import '../widgets/info_widget.dart';
import '../providers/todo_list_provider.dart';

class AddEditTodoWidget extends StatelessWidget {
  final String title;
  final TodoModel? todo;
  const AddEditTodoWidget({
    Key? key,
    required this.title,
    this.todo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController _todoController = TextEditingController();
    {
      if (todo != null) {
        _todoController.text = todo!.todo;
      }

      return AlertDialog(
        title: Text(title),
        content: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: _todoController,
                textCapitalization: TextCapitalization.sentences,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  filled: true,
                  isDense: true,
                  fillColor: Colors.grey.shade100,
                  labelText: "Todo",
                  hintText: "Masukkan todo",
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text("Batal"),
          ),
          TextButton(
            onPressed: () {
              if (_todoController.text.isEmpty) {
                showDialog(
                  context: context,
                  builder: (context) {
                    return const InfoWidget(
                        title: "Error!",
                        content: "Error! Todo tidak boleh kosong.");
                  },
                );
              } else {
                if (todo != null) {
                  Provider.of<TodoListProvider>(context, listen: false)
                      .updateTodo(
                    TodoModel(
                      id: todo!.id,
                      todo: _todoController.text,
                    ),
                  );
                } else {
                  const uuid = Uuid();

                  Provider.of<TodoListProvider>(context, listen: false).addTodo(
                    TodoModel(
                      id: uuid.v4(),
                      todo: _todoController.text,
                    ),
                  );
                }

                Navigator.pop(context);
              }
            },
            child: const Text("Simpan"),
          ),
        ],
      );
    }
  }
}
