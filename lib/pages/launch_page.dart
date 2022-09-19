import 'package:flutter/material.dart';
import 'package:pathfinder/pages/common/bottom_button.dart';
import 'package:pathfinder/pages/process_page.dart';

class LaunchPage extends StatelessWidget {
  LaunchPage({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormState>();
  final _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home screen')),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 25,
              ),
              const Text(
                'Set valid API base URL in order to continue',
                style: TextStyle(fontSize: 16),
              ),
              TextFormField(
                controller: _textController,
                validator: (value) =>
                    Uri.parse(value!).isAbsolute ? null : 'Incorrect value!',
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.swap_horiz),
                ),
              ),
              const Spacer(),
              BottomButton(
                label: 'Start counting process',
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: ((context) => ProcessPage(
                              url: _textController.text,
                            )),
                      ),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
