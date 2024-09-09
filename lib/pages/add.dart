import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Add extends StatelessWidget {
  const Add({super.key});

  @override
  Widget build(BuildContext context) {
    RxString date = "Choose Date".obs;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.keyboard_arrow_left_sharp),
          onPressed: () => Get.toNamed("/home"),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(50.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                children: [
                  TextButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) => Dialog.fullscreen(
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                CalendarDatePicker(
                                    initialDate: DateTime(2024),
                                    firstDate: DateTime(1900),
                                    lastDate: DateTime(3000),
                                    onDateChanged: (DateTime d) {
                                      date.value = d.toString();
                                      Get.back();
                                    }),
                                TextButton(
                                  onPressed: () {
                                    Get.back();
                                  },
                                  child: const Text("Close"),
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                    child: Row(
                      children: [
                        const Icon(Icons.calendar_today),
                        Obx(() => Text(date.value))
                      ],
                    ),
                  )
                ],
              ),
              const TextField(
                decoration: InputDecoration(labelText: "Name"),
              ),
              const TextField(),
              const TextField(),
              const SizedBox(width: 10, height: 10),
              TextButton(
                onPressed: () {},
                style: TextButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50),
                  backgroundColor: Colors.orange,
                  foregroundColor: Colors.white,
                ),
                child: const Text("Submit"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
