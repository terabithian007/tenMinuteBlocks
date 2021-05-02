import 'dart:math';

import 'package:flutter/material.dart';
import '../objects/insane_date_time.dart';

import './segmented_circle_border.dart';

class TenMinuteBlocksAppBar extends StatefulWidget {
  @override
  _TenMinuteBlocksAppBarState createState() => _TenMinuteBlocksAppBarState();
}

class _TenMinuteBlocksAppBarState extends State<TenMinuteBlocksAppBar> {
  InsaneDate selectedDate;

  @override
  void initState() {
    selectedDate = InsaneDate.today();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      margin: EdgeInsets.all(0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.2 +
            MediaQuery.of(context).padding.top +
            1,
        width: MediaQuery.of(context).size.width,
        color: Colors.black,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: MediaQuery.of(context).padding.top,
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.1,
              width: MediaQuery.of(context).size.width * 0.96,
              padding: EdgeInsets.all(0.0),
              margin: EdgeInsets.all(0.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.02,
                  ),
                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: selectedDate.weekdayString + '  ',
                          style: TextStyle(
                            fontSize: MediaQuery.of(context).size.height * 0.06,
                            fontFamily: 'MagicOwl',
                            color: Colors.yellow[100],
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                        TextSpan(
                          text: selectedDate.dateString,
                          style: TextStyle(
                            fontSize: MediaQuery.of(context).size.height * 0.03,
                            fontFamily: 'MagicOwl',
                            color: Colors.yellow[100],
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: SizedBox(),
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.06,
                    width: MediaQuery.of(context).size.height * 0.06,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.yellow[100].withOpacity(0.15),
                      ),
                      color: Colors.yellow[100].withOpacity(0.15),
                      shape: BoxShape.circle,
                    ),
                    alignment: Alignment.center,
                    child: IconButton(
                      padding: EdgeInsets.all(0.0),
                      alignment: Alignment.center,
                      icon: Icon(
                        Icons.calendar_today_rounded,
                        color: Colors.yellow[100],
                        size: MediaQuery.of(context).size.height * 0.035,
                      ),
                      onPressed: () {
                        print('Open Calendar');
                      },
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.02,
                  ),
                ],
              ),
            ),
            Container(
              height: 1,
              width: MediaQuery.of(context).size.width * 0.96,
              color: Colors.yellow[100].withOpacity(0.15),
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.1,
              width: MediaQuery.of(context).size.width * 0.96,
              padding: EdgeInsets.all(0.0),
              margin: EdgeInsets.all(0.0),
              child: ListView.builder(
                  padding: EdgeInsets.all(0.0),
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: selectedDate.datesInWeek.length,
                  itemBuilder: (context, dayIndex) {
                    double boxSize = min(
                        MediaQuery.of(context).size.height * 0.09,
                        MediaQuery.of(context).size.width * 0.12);
                    double opacity =
                        ((selectedDate.weekday - dayIndex) % 7 == 0)
                            ? 1.0
                            : 0.45;
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedDate = selectedDate.datesInWeek[dayIndex];
                        });
                      },
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.1,
                        width: MediaQuery.of(context).size.width * 0.96 / 7,
                        alignment: Alignment.center,
                        child: Material(
                          shape: SegmentedCircleBorder(
                              offset: -pi / 2,
                              numberOfSegments: 8,
                              sides: <BorderSide>[
                                BorderSide(
                                    color:
                                        Color(0xFFFF0000).withOpacity(opacity),
                                    width: boxSize * 0.1),
                                BorderSide(
                                    color:
                                        Color(0xFFFF0000).withOpacity(opacity),
                                    width: boxSize * 0.1),
                                BorderSide(
                                    color:
                                        Color(0xFF0000FF).withOpacity(opacity),
                                    width: boxSize * 0.1),
                                BorderSide(
                                    color:
                                        Color(0xFFFF0000).withOpacity(opacity),
                                    width: boxSize * 0.1),
                                BorderSide(
                                    color:
                                        Color(0xFF00FF00).withOpacity(opacity),
                                    width: boxSize * 0.1),
                                BorderSide(
                                    color:
                                        Color(0xFF0000FF).withOpacity(opacity),
                                    width: boxSize * 0.1),
                                BorderSide(
                                    color:
                                        Color(0xFFFF00000).withOpacity(opacity),
                                    width: boxSize * 0.1),
                                BorderSide(
                                    color:
                                        Color(0xFF00FF00).withOpacity(opacity),
                                    width: boxSize * 0.1),
                              ]),
                          child: Container(
                            height: boxSize,
                            width: boxSize,
                            color: Colors.black,
                            child: Center(
                              child: Text(
                                selectedDate
                                    .datesInWeek[dayIndex].weekdayInitial,
                                style: TextStyle(
                                  fontSize: boxSize * 0.6,
                                  fontFamily: 'MagicOwl',
                                  color:
                                      Colors.yellow[100].withOpacity(opacity),
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
            )
          ],
        ),
      ),
    );
  }
}
