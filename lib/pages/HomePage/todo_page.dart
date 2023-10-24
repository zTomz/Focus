import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:pomodoro_timer/extensions/build_context_ext.dart';
import 'package:pomodoro_timer/models/todo.dart';
import 'package:pomodoro_timer/provider/todo_provider.dart';
import 'package:provider/provider.dart';

class TodoPage extends HookWidget {
  const TodoPage({super.key});

  @override
  Widget build(BuildContext context) {
    final todoTextController = useTextEditingController();

    return Scaffold(
      body: Center(
        child: Container(
          width: min(MediaQuery.of(context).size.width * 0.8, 700),
          height: min(MediaQuery.of(context).size.height * 0.65, 800),
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(
            color: context.colorScheme.secondary,
            borderRadius: BorderRadius.circular(30),
          ),
          child: Column(
            children: [
              const Text(
                "Todos",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Consumer<TodoProvider>(
                    builder: (context, todos, _) {
                      return ReorderableListView.builder(
                        itemCount: todos.lenght,
                        onReorder: (oldIndex, newIndex) {
                          todos.reorderTodos(oldIndex, newIndex);
                        },
                        itemBuilder: (context, index) {
                          final todo = todos.todos[index];

                          return Container(
                            key: ValueKey(todo.uuid),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 10,
                            ),
                            margin: const EdgeInsets.only(
                              bottom: 10,
                            ),
                            decoration: BoxDecoration(
                              color: context.colorScheme.background,
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Row(
                              children: [
                                Checkbox(
                                  value: todo.isDone,
                                  onChanged: (value) {
                                    todos.toggleTodo(todo);
                                  },
                                ),
                                const SizedBox(width: 5),
                                Expanded(
                                  child: Text(
                                    todo.title,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                                Text(
                                  "${todo.createdAt.hour.toString().padLeft(2, '0')}:${todo.createdAt.minute.toString().padLeft(2, '0')}",
                                ),
                                const SizedBox(width: 20),
                              ],
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
              ),
              Container(
                height: 60,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  color: context.colorScheme.background,
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(
                    color: context.colorScheme.secondary,
                    width: 3,
                  ),
                ),
                alignment: Alignment.centerLeft,
                child: TextSelectionTheme(
                  data: TextSelectionThemeData(
                    selectionColor: context.colorScheme.secondary,
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                          cursorColor: context.colorScheme.secondary,
                          cursorWidth: 5,
                          cursorOpacityAnimates: true,
                          controller: todoTextController,
                          onSubmitted: (value) {
                            if (value.isEmpty) return;

                            context.read<TodoProvider>().addTodo(
                                  Todo.fromTitle(value),
                                );

                            todoTextController.clear();
                          },
                          decoration: const InputDecoration.collapsed(
                            hintText: "New todo",
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          final text = todoTextController.text;

                          if (text.isEmpty) return;

                          context.read<TodoProvider>().addTodo(
                                Todo.fromTitle(text),
                              );

                          todoTextController.clear();
                        },
                        color: context.colorScheme.primary,
                        icon: const Icon(Icons.add_rounded),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
