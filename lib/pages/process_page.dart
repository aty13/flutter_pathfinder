import 'package:flutter/material.dart';
import 'package:pathfinder/pages/common/bottom_button.dart';
import 'package:pathfinder/pages/results_page/results_page.dart';
import 'package:pathfinder/services/find_a_path.dart';

class ProcessPage extends StatefulWidget {
  final String url;
  const ProcessPage({Key? key, required this.url}) : super(key: key);

  @override
  State<ProcessPage> createState() => _ProcessPageState();
}

class _ProcessPageState extends State<ProcessPage> {
  @override
  void initState() {
    FindAPathService()
        .getTasksFromApi(widget.url)
        .then((value) => FindAPathService.tasks = value);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Process page')),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            height: 250,
          ),
          const Center(
            child: Text(
              'All calculations finished\nTODO: Dynamic progress indication',
              style: TextStyle(fontSize: 20),
            ),
          ),
          const SizedBox(
            height: 20.0,
          ),
          const CircularProgressIndicator(),
          const Spacer(),
          BottomButton(
            label: 'Send results to server',
            onPressed: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => ResultsPage()));
            },
          )
        ],
      ),
    );
  }
}
