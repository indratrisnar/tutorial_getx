import 'package:d_input/d_input.dart';
import 'package:d_method/d_method.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:person_getx/person_controller.dart';

class PersonPage extends StatefulWidget {
  const PersonPage({super.key});

  @override
  State<PersonPage> createState() => _PersonPageState();
}

class _PersonPageState extends State<PersonPage> {
  final personController = Get.put(PersonController());
  final edtName = TextEditingController();
  final edtAge = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Person'),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Row(
            children: [
              Expanded(
                child: DInput(
                  title: 'Name',
                  controller: edtName,
                ),
              ),
              IconButton(
                onPressed: () {
                  personController.name = edtName.text;
                },
                icon: const Icon(Icons.save),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: DInput(
                  title: 'Age',
                  controller: edtAge,
                  inputType: TextInputType.number,
                ),
              ),
              IconButton(
                onPressed: () {
                  personController.age = int.parse(edtAge.text);
                },
                icon: const Icon(Icons.save),
              ),
            ],
          ),
          const SizedBox(height: 30),
          Obx(() {
            DMethod.log('Build Name');
            String name = personController.name;
            return Text('Name: $name');
          }),
          Obx(() {
            DMethod.log('Build Age');
            int age = personController.age;
            return Text('Age: $age');
          }),
        ],
      ),
    );
  }
}
