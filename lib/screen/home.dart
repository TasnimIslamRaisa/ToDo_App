import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:to_do_app/constant/color.dart';
import 'package:to_do_app/model/todo.dart';
import 'package:to_do_app/widgets/todoItem.dart';

class Home extends StatefulWidget {
  Home({Key? key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final todoList = ToDo.todoList();
  final todoController = TextEditingController();
  List<ToDo> foundToDo = [];

  @override
  void initState() {
    foundToDo = todoList;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //var appBar2 =
    return Scaffold(
      backgroundColor: AppColors.tdBGColor,
      appBar: buildAppBar(),
      body: Stack(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            child: Column(
              children: [
                searchBox(),
                Expanded(
                  child: ListView(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 20,
                        ),
                        margin: EdgeInsets.only(
                          top: 30,
                          bottom: 20,
                        ),
                        child: Text(
                          "All ToDos",
                          style: TextStyle(
                              fontSize: 35, fontWeight: FontWeight.w400),
                        ),
                      ),
                      for (ToDo todo in foundToDo)
                        ToDoItem(
                          todo: todo,
                          onToDoChanged: handleToDoChange,
                          onDeleteItem: delete,
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Row(
              children: [
                Expanded(
                    child: Container(
                  margin: EdgeInsets.only(
                    bottom: 20,
                    right: 20,
                    left: 20,
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.grey,
                        offset: Offset(0.0, 0.0),
                        blurRadius: 10.0,
                        spreadRadius: 0.0,
                      ),
                    ],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextField(
                    controller: todoController,
                    decoration: InputDecoration(
                      hintText: "Add A New ToDo Item",
                      border: InputBorder.none,
                    ),
                  ),
                )),
                Container(
                  margin: EdgeInsets.only(
                    bottom: 20,
                    right: 20,
                  ),
                  child: ElevatedButton(
                    onPressed: () {
                      addToDoitem(todoController.text);
                    },
                    child: Text(
                      "+",
                      style: TextStyle(
                        fontSize: 40,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      //minimumSize: Size(60, 60),
                      elevation: 10,
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  void handleToDoChange(ToDo todo) {
    setState(() {
      todo.isDone = !todo.isDone;
    });
  }

  void delete(String id) {
    setState(() {
      todoList.removeWhere((item) => item.id == id);
    });
  }

  void addToDoitem(String text) {
    setState(() {
      //for unique id DateTime.now().millisecondsSinceEpoch.toString()
      todoList.add(ToDo(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          todoText: text));
    });
    todoController.clear();
  }

  void runfilter(String enterKey) {
    List<ToDo> result = [];
    if (enterKey.isEmpty) {
      result = todoList;
    } else {
      result = todoList
          .where((item) =>
              item.todoText!.toLowerCase().contains(enterKey.toLowerCase()))
          .toList();
    }
    setState(() {
      foundToDo = result;
    });
  }

  Widget searchBox() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
      ),
      child: TextField(
        onChanged: (value) => runfilter(value),
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(0),
          prefixIcon: Icon(
            Icons.search,
            color: AppColors.tdBlack,
            size: 25,
          ),
          border: InputBorder.none,
          hintText: 'Search',
          hintStyle: TextStyle(
              color: Color.fromARGB(255, 208, 206, 206),
              fontSize: 25,
              fontWeight: FontWeight.normal),
        ),
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      backgroundColor: AppColors.tdBGColor,
      //foregroundColor: Colors.white,
      title: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Icon(
          Icons.menu,
          size: 30,
        ),
        Container(
          height: 40,
          width: 40,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: Image.asset('assets/images/dp.jpg'),
          ),
        )
      ]),
    );
  }
}
