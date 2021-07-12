import 'package:flutter/material.dart';
import 'package:localstorage/modules/home/home_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late HomeController controller = HomeController(onUpdate: () {
    setState(() {});
  });

  @override
  void initState() {
    controller.getCount();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Local Storage"),
      ),
      body: Center(
          child: controller.isLoading
              ? CircularProgressIndicator()
              : Text("CONTADOR: ${controller.countModel.value}")),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: controller.increment,
      ),
    );
  }
}
