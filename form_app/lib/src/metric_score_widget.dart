import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;

class MetricScoreWidget extends StatelessWidget {
  const MetricScoreWidget({
    Key key,
    this.score: 0,
    @required this.textSpan,
  }) : super(key: key);

  final double score;
  final TextSpan textSpan;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                child: RichText(
                  text: textSpan,
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Container(
                height: 30,
                width: 40,
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.blue)),
                child: Center(
                  child: Text(
                    intl.NumberFormat('#.##', 'en_GB')
                        .format(score),
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                ),
              )
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
}
