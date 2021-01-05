import 'package:flutter/material.dart';
import 'package:form_app/src/metric_score_widget.dart';
import 'package:form_app/src/metric_slider_widget.dart';
import 'package:intl/intl.dart' as intl;

class BasdaiDemo extends StatefulWidget {
  @override
  _BasdaiDemoState createState() => _BasdaiDemoState();
}

class _BasdaiDemoState extends State<BasdaiDemo> {
  final _formKey = GlobalKey<FormState>();
  double _basdaiScore = 0;
  double _basdaiFatigue = 4;
  final double _basdaiFatigueMax = 10;
  double _basdaiNeckBackHipPain = 0;
  final double _basdaiNexkBackHipPainMax = 10;
  double _basdaiOtherPain = 0;
  final double _basdaiOtherPainMax = 10;
  double _basdaiDiscomfort = 0;
  final double _basdaiDiscomfortMax = 10;
  double _basdaiStiffness = 0;
  final double _basdaiStiffnessMax = 10;
  double _basdaiStiffnessDuration = 2.5;
  final double _basdaiStiffnessDurationMax = 10;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('BASDAI'),
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
                          score: _basdaiScore,
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
                                      'Please drag the box below to indicate your answer to the questions relating to the '),
                              new TextSpan(
                                  text: 'past week',
                                  style: new TextStyle(
                                      fontWeight: FontWeight.bold)),
                            ],
                          )),
                      MetricSliderWidget(
                        questionNumber: 1,
                        questionText:
                            'How would you describe the overall level of fatigue/tiredness you have experienced?',
                        totalValue: _basdaiFatigueMax,
                        currentValue: _basdaiFatigue * _basdaiFatigueMax,
                        onSliderMoved: (double value) {
                          setState(() {
                            _basdaiFatigue = value;
                            _calculateBasdai();
                          });
                        },
                      ),
                      MetricSliderWidget(
                        questionNumber: 2,
                        questionText:
                            'How would you describe the overall level of Ankylosing Spondylitis neck, back or hip pain you have had?',
                        totalValue: _basdaiNexkBackHipPainMax,
                        currentValue: _basdaiNeckBackHipPain * _basdaiNexkBackHipPainMax,
                        onSliderMoved: (double value) {
                          setState(() {
                            _basdaiNeckBackHipPain = value;
                            _calculateBasdai();
                          });
                        },
                      ),
                      MetricSliderWidget(
                        questionNumber: 3,
                        questionText:
                            'How would you describe the overall level of pain/swelling you have had in joints other than your neck, back or hips?',
                        totalValue: _basdaiOtherPainMax,
                        currentValue: _basdaiOtherPain * _basdaiOtherPainMax,
                        onSliderMoved: (double value) {
                          setState(() {
                            _basdaiOtherPain = value;
                            _calculateBasdai();
                          });
                        },
                      ),
                      MetricSliderWidget(
                        questionNumber: 4,
                        questionText:
                            'How would you describe the overall level of discomfort you have had from any areas tender to touch or pressure?',
                        totalValue: _basdaiDiscomfortMax,
                        currentValue: _basdaiDiscomfort * _basdaiDiscomfortMax,
                        onSliderMoved: (double value) {
                          setState(() {
                            _basdaiDiscomfort = value;
                            _calculateBasdai();
                          });
                        },
                      ),
                      MetricSliderWidget(
                        questionNumber: 5,
                        questionText:
                            'How would you describe the overall level of morning stiffness you have had from the time you wake up?',
                        totalValue: _basdaiStiffnessMax,
                        currentValue: _basdaiStiffness * _basdaiStiffnessMax,
                        onSliderMoved: (double value) {
                          setState(() {
                            _basdaiStiffness = value;
                            _calculateBasdai();
                          });
                        },
                      ),
                      MetricSliderWidget(
                        questionNumber: 6,
                        questionText:
                            'How long does your morning stiffness last from the time you wake up?',
                        totalValue: _basdaiStiffnessDurationMax,
                        sliderStartText: '0\nhours',
                        sliderEndText: '2 or more\nhours',
                        sliderDivisions: 24,
                        isTimeSlider: true,
                        currentValue: _basdaiStiffnessDuration * _basdaiStiffnessDurationMax,
                        onSliderMoved: (double value) {
                          setState(() {
                            _basdaiStiffnessDuration = value;
                            _calculateBasdai();
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

  void _calculateBasdai() {
    _basdaiScore = (
        _basdaiFatigue + _basdaiNeckBackHipPain + _basdaiOtherPain + _basdaiDiscomfort + ((_basdaiStiffness + _basdaiStiffnessDuration) / 2)
    ) / 5;
  }
}
