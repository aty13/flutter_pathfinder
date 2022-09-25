import 'dart:async';

import 'package:flutter/material.dart';
import 'package:pathfinder/services/api_service.dart';
import 'package:percent_indicator/percent_indicator.dart';

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
  final FindAPathService _pathService = FindAPathService();
  bool _isLoading = true;
  int _percent = 0;
  late Timer _timer;
  @override
  void initState() {
    _timer = Timer.periodic(const Duration(milliseconds: 400), (_) {
      setState(() {
        _percent += 10;
        if (_percent >= 100) {
          _timer.cancel();
        }
      });
    });

    if (_pathService.isLocalData) {
      _pathService.getTasksFromLocal();
    } else {
      _pathService.getTasksFromApi(widget.url).then((value) {
        FindAPathService.tasks = value;
        _isLoading = false;
      });
    }

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
            height: 200,
          ),
          Center(
            child: Text(
              _percent == 100
                  ? 'All calculations finished\n'
                  : 'Calculating... \n\n$_percent%\n',
              style: const TextStyle(fontSize: 20),
              textAlign: TextAlign.center,
            ),
          ),
          CircularPercentIndicator(
            radius: 60.0,
            lineWidth: 10.0,
            animation: false,
            percent: _percent / 100,
            backgroundColor: Colors.grey,
            circularStrokeCap: CircularStrokeCap.round,
            progressColor: Colors.blue,
          ),
          const Spacer(),
          BottomButton(
            label: 'Send results to server',
            onPressed: _isLoading
                ? null
                : () async {
                    setState(() {
                      _isLoading = true;
                      var body = [];
                      for (var task in FindAPathService.tasks) {
                        body.add(task.toMap());
                      }

                      ApiService().postResponse(body).then((_) {
                        setState(() {
                          _isLoading = false;
                        });

                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => ResultsPage(),
                          ),
                        );
                      });
                    });
                  },
          )
        ],
      ),
    );
  }
}
