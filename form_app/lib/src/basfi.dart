import 'package:flutter/material.dart';
import 'package:form_app/src/metric_score_widget.dart';
import 'package:form_app/src/metric_slider_widget.dart';
import 'package:intl/intl.dart' as intl;

class BasfiDemo extends StatefulWidget {
  @override
  _BasfiDemoState createState() => _BasfiDemoState();
}

class _BasfiDemoState extends State<BasfiDemo> {
  final _formKey = GlobalKey<FormState>();
  double _basfiScore = 0;
  double _basfiDressingWithoutAids = 0;
  final double _basfiDressingWithoutAidsMax = 10;
  double _basfiBendingForwards = 0;
  final double _basfiBendingForwardsMax = 10;
  double _basfiReachingUp = 0;
  final double _basfiReachingUpMax = 10;
  double _basfiGettingUpFromChair = 0;
  final double _basfiGettingUpFromChairMax = 10;
  double _basfiGettingUpFromFloor = 0;
  final double _basfiGettingUpFromFloorMax = 10;
  double _basfiStandingUnsupported = 0;
  final double _basfiStandingUnsupportedMax = 10;
  double _basfiClimbingSteps = 0;
  final double _basfiClimbingStepsMax = 10;
  double _basfiLookingOverShoulder = 0;
  final double _basfiLookingOverShoulderMax = 10;
  double _basfiPhysicallyDemanding = 0;
  final double _basfiPhysicallyDemandingMax = 10;
  double _basfiFullDayOfActivities = 0;
  final double _basfiFullDayOfActivitiesMax = 10;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('BASFI'),
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
                          score: _basfiScore,
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
                                  'Please drag the box on each slider below to indicate your level of ability for each of the following activities during the '),
                              new TextSpan(
                                  text: 'past week',
                                  style: new TextStyle(
                                      fontWeight: FontWeight.bold)),
                            ],
                          )),
                      MetricSliderWidget(
                        questionNumber: 1,
                        questionText:
                        'Putting on your socks or tights without help or aids (eg sock aid)?',
                        totalValue: _basfiDressingWithoutAidsMax,
                        currentValue: _basfiDressingWithoutAids * _basfiDressingWithoutAidsMax,
                        sliderStartText: 'Easy',
                        sliderEndText: 'Impossible',
                        onSliderMoved: (double value) {
                          setState(() {
                            _basfiDressingWithoutAids = value;
                            _calculateBasfi();
                          });
                        },
                      ),
                      MetricSliderWidget(
                        questionNumber: 2,
                        questionText:
                        'Bending forward from the waist to pick up a pen from the floor without an aid?',
                        totalValue: _basfiBendingForwardsMax,
                        currentValue: _basfiBendingForwards * _basfiBendingForwardsMax,
                        sliderStartText: 'Easy',
                        sliderEndText: 'Impossible',
                        onSliderMoved: (double value) {
                          setState(() {
                            _basfiBendingForwards = value;
                            _calculateBasfi();
                          });
                        },
                      ),
                      MetricSliderWidget(
                        questionNumber: 3,
                        questionText:
                        'Reaching up to a high shelf without help or aids (eg helping hand)?',
                        totalValue: _basfiReachingUpMax,
                        currentValue: _basfiReachingUp * _basfiReachingUpMax,
                        sliderStartText: 'Easy',
                        sliderEndText: 'Impossible',
                        onSliderMoved: (double value) {
                          setState(() {
                            _basfiReachingUp = value;
                            _calculateBasfi();
                          });
                        },
                      ),
                      MetricSliderWidget(
                        questionNumber: 4,
                        questionText:
                        'Getting out of an armless dining chair without using your hands or any help?',
                        totalValue: _basfiGettingUpFromChairMax,
                        currentValue: _basfiGettingUpFromChair * _basfiGettingUpFromChairMax,
                        sliderStartText: 'Easy',
                        sliderEndText: 'Impossible',
                        onSliderMoved: (double value) {
                          setState(() {
                            _basfiGettingUpFromChair = value;
                            _calculateBasfi();
                          });
                        },
                      ),
                      MetricSliderWidget(
                        questionNumber: 5,
                        questionText:
                        'Getting up off the floor without help from lying on your back?',
                        totalValue: _basfiGettingUpFromFloorMax,
                        currentValue: _basfiGettingUpFromFloor * _basfiGettingUpFromFloorMax,
                        sliderStartText: 'Easy',
                        sliderEndText: 'Impossible',
                        onSliderMoved: (double value) {
                          setState(() {
                            _basfiGettingUpFromFloor = value;
                            _calculateBasfi();
                          });
                        },
                      ),
                      MetricSliderWidget(
                        questionNumber: 6,
                        questionText:
                        'Standing unsupported for 10 minutes without discomfort?',
                        totalValue: _basfiStandingUnsupportedMax,
                        currentValue: _basfiStandingUnsupported * _basfiStandingUnsupportedMax,
                        sliderStartText: 'Easy',
                        sliderEndText: 'Impossible',
                        onSliderMoved: (double value) {
                          setState(() {
                            _basfiStandingUnsupported = value;
                            _calculateBasfi();
                          });
                        },
                      ),
                      MetricSliderWidget(
                        questionNumber: 7,
                        questionText:
                        'Climbing 12-15 steps without using a handrail or walking aid (one foot on each step)?',
                        totalValue: _basfiClimbingStepsMax,
                        currentValue: _basfiClimbingSteps * _basfiClimbingStepsMax,
                        sliderStartText: 'Easy',
                        sliderEndText: 'Impossible',
                        onSliderMoved: (double value) {
                          setState(() {
                            _basfiClimbingSteps = value;
                            _calculateBasfi();
                          });
                        },
                      ),
                      MetricSliderWidget(
                        questionNumber: 8,
                        questionText:
                        'Looking over your shoulder without turning your body?',
                        totalValue: _basfiLookingOverShoulderMax,
                        currentValue: _basfiLookingOverShoulder * _basfiLookingOverShoulderMax,
                        sliderStartText: 'Easy',
                        sliderEndText: 'Impossible',
                        onSliderMoved: (double value) {
                          setState(() {
                            _basfiLookingOverShoulder = value;
                            _calculateBasfi();
                          });
                        },
                      ),
                      MetricSliderWidget(
                        questionNumber: 9,
                        questionText:
                        'Doing physically demanding activities (eg physiotherapy exercises, gardening, sport)?',
                        totalValue: _basfiPhysicallyDemandingMax,
                        currentValue: _basfiPhysicallyDemanding * _basfiPhysicallyDemandingMax,
                        sliderStartText: 'Easy',
                        sliderEndText: 'Impossible',
                        onSliderMoved: (double value) {
                          setState(() {
                            _basfiPhysicallyDemanding = value;
                            _calculateBasfi();
                          });
                        },
                      ),
                      MetricSliderWidget(
                        questionNumber: 10,
                        questionText:
                        "Doing a full day's activities at home or at work?",
                        totalValue: _basfiStandingUnsupportedMax,
                        currentValue: _basfiStandingUnsupported * _basfiStandingUnsupportedMax,
                        sliderStartText: 'Easy',
                        sliderEndText: 'Impossible',
                        onSliderMoved: (double value) {
                          setState(() {
                            _basfiStandingUnsupported = value;
                            _calculateBasfi();
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

  void _calculateBasfi() {
    _basfiScore = (
        _basfiPhysicallyDemanding + _basfiLookingOverShoulder + _basfiClimbingSteps + _basfiStandingUnsupported + _basfiGettingUpFromFloor + _basfiGettingUpFromChair + _basfiReachingUp + _basfiBendingForwards + _basfiDressingWithoutAids + _basfiFullDayOfActivities
    ) / 10;
  }
}
