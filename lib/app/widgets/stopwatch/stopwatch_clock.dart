import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vector_math/vector_math.dart' show radians;

import '../../../context/context.dart';
import '../../../utils/utils.dart';
import '../app_widgets.dart';

class StopWatchClock extends StatefulWidget {
  const StopWatchClock({Key? key, required this.controller}) : super(key: key);
  final AnimationController controller;

  @override
  State<StopWatchClock> createState() => _StopWatchClockState();
}

class _StopWatchClockState extends State<StopWatchClock>
    with SingleTickerProviderStateMixin {
  late Animation<double> _rotate;

  @override
  void initState() {
    super.initState();

    _rotate = Tween<double>(
      begin: 0.0,
      end: 360,
    ).animate(widget.controller);
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final CurrentStopWatchTime time =
        Provider.of<CurrentStopWatchTime>(context);

    return Container(
      height: size.height * 0.35,
      alignment: Alignment.center,
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          SizedBox.square(
            dimension: size.width * .6,
            child: Container(
              decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                        color: Colors.grey,
                        offset: Offset(2, 2),
                        blurRadius: 2,
                        spreadRadius: .1),
                    BoxShadow(
                        color: Colors.white,
                        offset: Offset(1, 1),
                        blurRadius: 4,
                        spreadRadius: .1),
                  ]),
            ),
          ),
          AnimatedBuilder(
              animation: widget.controller,
              builder: (BuildContext context, Widget? animation) {
                return Transform.rotate(
                  angle: radians(_rotate.value),
                  child: SizedBox.square(
                    dimension: size.width * 0.56,
                    child: CustomPaint(
                      painter: StopWatchPainter(),
                    ),
                  ),
                );
              }),
          SizedBox.square(
            dimension: size.width * .45,
            child: Container(
                decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: <BoxShadow>[
                  BoxShadow(
                      color: Colors.grey, blurRadius: 1, spreadRadius: .1),
                  BoxShadow(
                      color: Colors.white,
                      offset: Offset(1, 1),
                      blurRadius: 1,
                      spreadRadius: .1)
                ])),
          ),
          SizedBox.square(
            dimension: size.width * .35,
            child: Container(
                decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: <BoxShadow>[
                  BoxShadow(
                      color: Colors.grey, blurRadius: 1, spreadRadius: .1),
                  BoxShadow(
                      color: Colors.white,
                      offset: Offset(-1, -1),
                      blurRadius: 1,
                      spreadRadius: .1)
                ])),
          ),
          SizedBox.square(
            dimension: size.width * .45,
            child: AnimatedBuilder(
              animation: widget.controller,
              builder: (BuildContext context, Widget? animation) {
                return Transform(
                  alignment: FractionalOffset.center,
                  transform: Matrix4.identity()
                    ..rotateZ(radians(_rotate.value * -1)),
                  child: CustomPaint(
                    painter: Sprinkle(),
                  ),
                );
              },
            ),
          ),
          Text(
            stopWatchFormat(time),
            style: Theme.of(context).textTheme.headline4!.copyWith(
                  letterSpacing: 1.2,
                  fontWeight: FontWeight.bold,
                  // fontFamily: 'Technology',
                  color: Colors.black,
                ),
          ),
        ],
      ),
    );
  }
}
