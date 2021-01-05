import 'package:flutter/material.dart';
import 'package:form_app/src/metric_slider_widget.dart';

class SvasDemo extends StatefulWidget {
  @override
  _SvasDemoState createState() => _SvasDemoState();
}

class _SvasDemoState extends State<SvasDemo> {
  final _formKey = GlobalKey<FormState>();
  double _svasScore = 0;
  double _svasLastWeek = 0;
  final double _svasLastWeekMax = 10;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SVAS'),
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
                      Row(
                        children: [
                          Expanded(
                            child: RichText(
                              text: new TextSpan(
                                // Note: Styles for TextSpans must be explicitly defined.
                                // Child text spans will inherit styles from parent
                                style: new TextStyle(
                                  fontSize: 14.0,
                                  color: Colors.black,
                                ),
                                children: <TextSpan>[
                                  new TextSpan(
                                      text:
                                          'How would you describe the overall level of pain you have experienced in your spine during the '),
                                  new TextSpan(
                                      text: 'past week',
                                      style: new TextStyle(
                                          fontWeight: FontWeight.bold)),
                                  new TextSpan(text: '?'),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      MetricSliderWidget(
                        questionNumber: 0,
                        questionText:
                            '',
                        totalValue: _svasLastWeekMax,
                        currentValue: _svasLastWeek * _svasLastWeekMax,
                        onSliderMoved: (double value) {
                          setState(() {
                            _svasLastWeek = value;
                            _calculateSvas();
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

  void _calculateSvas() {
    _svasScore = _svasLastWeek;
  }
}
