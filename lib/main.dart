import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

late Box box;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  box = await Hive.openBox("flutter");
  runApp(MaterialApp(
    home: MyApp(),
    debugShowCheckedModeBanner: false,
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  TextEditingController txtController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Color(0xFF4DB6AC),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 300),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: txtController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(), labelText: "Enter text"),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            MaterialButton(
              onPressed: () {
                box.add(txtController.text);
                txtController.text = "";
              },
              color: Color(0xFF64FFDA),
              child: Text("Save"),
            ),
            ValueListenableBuilder(
                valueListenable: box.listenable(),
                builder: (context, child, value) {
                  return Expanded(
                      child: ListView.builder(
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                            alignment: Alignment.center,
                            color: Color(0xFF4DD0E1),
                            child: Text(
                              box.getAt(index),
                              style: TextStyle(fontSize: 20),
                            )),
                      );
                    },
                    itemCount: box.length,
                  ));
                })
          ],
        ),
      ),
    );
  }
}
