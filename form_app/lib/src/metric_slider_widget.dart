import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;

class MetricSliderWidget extends StatefulWidget {
  const MetricSliderWidget({
    Key key,
    this.hasValue = false,
    this.currentValue,
    this.onSliderMoved,
    this.sliderStartText = 'None',
    this.sliderEndText = 'Very\nSevere',
    this.sliderMin = 0,
    this.sliderMax = 10,
    this.sliderDivisions = 100,
    this.isTimeSlider = false,
    this.timeIncrement = 5,
    @required this.questionNumber,
    @required this.totalValue,
    @required this.questionText,
  }) : super(key: key);

  final bool hasValue;
  final double currentValue;
  final double totalValue;
  final ValueChanged<double> onSliderMoved;
  final String sliderStartText;
  final String sliderEndText;
  final int questionNumber;
  final String questionText;
  final double sliderMin;
  final double sliderMax;
  final int sliderDivisions;
  final bool isTimeSlider;
  final int timeIncrement;

  @override
  _MetricSliderWidgetState createState() => _MetricSliderWidgetState();
}

class _MetricSliderWidgetState extends State<MetricSliderWidget> {
  double _sliderValue;
  bool _userIsMovingSlider;

  @override
  void initState() {
    super.initState();
    _sliderValue = _getSliderValue();
    _userIsMovingSlider = false;
  }

  @override
  Widget build(BuildContext context) {
    if (!_userIsMovingSlider) {
      _sliderValue = _getSliderValue();
    }

    return Container(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildQuestionNumber(),
              _buildQuestion(),
            ],
          ),
          Row(
            children: [
              _buildSliderStart(),
              _buildSlider(),
              _buildSliderEnd(),
              SizedBox(
                width: 10,
              ),
              _buildSliderScore(context),
            ],
          ),
          Row(children: [
            SizedBox(
              height: 20,
            ),
          ]),
        ],
      ),
    );
  }

  Container _buildSliderScore(BuildContext context) {
    return Container(
      height: 30,
      width: 40,
      decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
      child: Center(
        child: Text(
          intl.NumberFormat('#.#', 'en_GB').format(_sliderValue),
          style: Theme.of(context).textTheme.subtitle1,
        ),
      ),
    );
  }

  Expanded _buildQuestion() {
    return Expanded(
      child: Text(widget.questionText),
    );
  }

  Expanded _buildSlider() {
    return Expanded(
      child: Slider(
        min: widget.sliderMin,
        max: widget.sliderMax,
        divisions: widget.sliderDivisions,
        label: _formatSliderLabel(),
        value: _sliderValue,
        // activeColor: Theme.of(context).textTheme.bodyText2.color,
        // inactiveColor: Theme.of(context).disabledColor,
        // 1
        onChangeStart: (value) {
          _userIsMovingSlider = true;
        },
        // 2
        onChanged: (value) {
          setState(() {
            _sliderValue = value;
          });
        },
        // 3
        onChangeEnd: (value) {
          _userIsMovingSlider = false;
          if (widget.onSliderMoved != null) {
            widget.onSliderMoved(value);
          }
        },
      ),
    );
  }

  String _formatSliderLabel() {
    if (widget.isTimeSlider) {
      final time = _sliderValue * 60 / widget.timeIncrement;
      Duration duration = Duration(minutes: time.round());

      String twoDigits(int n) {
        if (n >= 10) return "$n";
        return "0$n";
      }

      final hours = twoDigits(duration.inHours.remainder(Duration.hoursPerDay));
      final minutes = twoDigits(duration.inMinutes.remainder(Duration.minutesPerHour));

      return "$hours:$minutes";
    }

    return intl.NumberFormat('#.#', 'en_GB').format(_sliderValue);
  }

  Text _buildSliderEnd() {
    return Text(
      widget.sliderEndText,
      style: Theme.of(context).textTheme.bodyText1,
      softWrap: true,
    );
  }

  Text _buildSliderStart() {
    return Text(
      widget.sliderStartText,
      style: Theme.of(context).textTheme.bodyText1,
      textAlign: TextAlign.end,
      softWrap: true,
    );
  }

  Text _buildQuestionNumber() {
    if (widget.questionNumber > 0) {
      final question = widget.questionNumber.toString();

      return Text(
        "$question. ",
        style: Theme.of(context).textTheme.bodyText1,
      );
    }
    else {
      return Text("");
    }
  }

  double _getSliderValue() {
    if (widget.currentValue == null) {
      return 0;
    }
    return widget.currentValue / widget.totalValue;
  }
}
