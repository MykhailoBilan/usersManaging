import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Users",
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController textControllerName = TextEditingController();
  TextEditingController textControllerDescription = TextEditingController();
  void showAlertDialog(BuildContext context, int type, [int index = 1]) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Container(
            width: MediaQuery.of(context).size.width / 1.3,
            height: MediaQuery.of(context).size.height / 3,
            decoration: const BoxDecoration(
              shape: BoxShape.rectangle,
              color: Color(0xFFFFFF),
              borderRadius: BorderRadius.all(Radius.circular(32.0)),
            ),
            child: Column(
              children: [
                Container(
                  child: Column(
                    children: [
                      TextField(
                        controller: textControllerName,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Name',
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextField(
                        controller: textControllerDescription,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Description',
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  child: const Text("OK"),
                  onPressed: () {
                    setState(() {
                      if (type == 0 &&
                          textControllerName.text.isEmpty == false &&
                          textControllerDescription.text.isEmpty == false) {
                        list.add(convertToList(textControllerName.text,
                            textControllerDescription.text));
                      } else if (type == 1 &&
                          textControllerName.text.isEmpty == false &&
                          textControllerDescription.text.isEmpty == false) {
                        list[index] = convertToList(textControllerName.text,
                            textControllerDescription.text);
                      } else
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    });
                    Navigator.pop(context);
                    textControllerName.text = "";
                    textControllerDescription.text = "";
                  },
                )
              ],
            ),
          ),
        );
      },
    );
  }

  List<List> list = [];
  var snackBar = const SnackBar(
    content: Text('You have submitted empty field'),
  );
  @override
  void initState() {
    super.initState();
    list.addAll({
      ["one", "one one one one"],
      ["two", "two two two"]
    });
  }

  @override
  void dispose() {
    textControllerName.dispose();
    textControllerDescription.dispose();
    super.dispose();
  }

  dynamic convertToList(String name, String description) {
    List listZero = [name, description];
    return listZero;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Users'),
      ),
      body: ListView.builder(
        itemCount: list.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: Text(
              list[index][0],
              style: const TextStyle(fontSize: 30),
            ),
            subtitle: Text(
              list[index][1],
              style: const TextStyle(fontSize: 20),
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                    onPressed: () {
                      showAlertDialog(context, 1, index);
                    },
                    icon: const Icon(Icons.edit)),
                IconButton(
                    onPressed: () {
                      setState(() {
                        list.remove(list[index]);
                      });
                    },
                    icon: const Icon(Icons.delete)),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          showAlertDialog(context, 0);
        },
      ),
    );
  }
}
