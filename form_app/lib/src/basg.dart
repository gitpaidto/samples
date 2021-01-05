import 'package:flutter/material.dart';
import 'package:form_app/src/metric_score_widget.dart';
import 'package:form_app/src/metric_slider_widget.dart';
import 'package:intl/intl.dart' as intl;

class BasgDemo extends StatefulWidget {
  @override
  _BasgDemoState createState() => _BasgDemoState();
}

class _BasgDemoState extends State<BasgDemo> {
  final _formKey = GlobalKey<FormState>();
  double _basgScore = 0;
  double _basgLastWeek = 0;
  final double _basgLastWeekMax = 10;
  double _basgLastSixMonths = 0;
  final double _basgLastSixMonthsMax = 10;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('BASG'),
        actions: [
          Padding(
            padding: EdgeInsets.all(8),
            child: FlatButton(
              textColor: Colors.white,
              child: Text('Submit'),
              onPressed: () {
                // Validate the form by getting the FormState from the GlobalKey
                // and calling validate() on it.
                var valid = _formKey.currentState.validate();
                if (!valid) {
                  return;
                }
              },
            ),
          ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: Scrollbar(
          child: Align(
            alignment: Alignment.topCenter,
            child: Card(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(16),
                child: ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: 400),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      MetricScoreWidget(
                          score: _basgScore,
                          textSpan: new TextSpan(
                            // Note: Styles for TextSpans must be explicitly defined.
                            // Child text spans will inherit styles from parent
                            style: new TextStyle(
                              fontSize: 14.0,
                              color: Colors.black,
                            ),
                            children: <TextSpan>[
                              new TextSpan(
                                  text:
                                  'Please drag the box on each slider below to indicate how well you have felt during the specified times\n\n'),
                              new TextSpan(
                                  text: 'What effect has your disease had on your well-being:',
                                  style: new TextStyle(
                                      fontWeight: FontWeight.bold)),
                            ],
                          )),
                      MetricSliderWidget(
                        questionNumber: 1,
                        questionText:
                        'Over the last week?',
                        totalValue: _basgLastWeekMax,
                        currentValue: _basgLastWeek * _basgLastWeekMax,
                        onSliderMoved: (double value) {
                          setState(() {
                            _basgLastWeek = value;
                            _calculateBasg();
                          });
                        },
                      ),
                      MetricSliderWidget(
                        questionNumber: 2,
                        questionText:
                        'Over the last 6 months?',
                        totalValue: _basgLastSixMonthsMax,
                        currentValue: _basgLastSixMonths * _basgLastSixMonthsMax,
                        onSliderMoved: (double value) {
                          setState(() {
                            _basgLastSixMonths = value;
                            _calculateBasg();
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _calculateBasg() {
    _basgScore = (
        _basgLastWeek + _basgLastSixMonths
    ) / 2;
  }
}
