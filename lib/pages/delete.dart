import 'package:flutter/material.dart';
import 'package:myapp/widgets/drawer.dart';

class Delete extends StatelessWidget {
  const Delete({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const DrawerWidget(),
      appBar: AppBar(
        actions: const <Widget>[],
      ),
      body: const Center(
        child: Text("hello world"),
      ),
    );
  }
}
