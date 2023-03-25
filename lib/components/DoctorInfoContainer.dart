import 'package:flutter/material.dart';

class DoctorInfoContainer extends StatefulWidget {
  final Widget? child;

  const DoctorInfoContainer({Key? key, this.child}) : super(key: key);

  @override
  _DoctorInfoContainerState createState() => _DoctorInfoContainerState();
}

class _DoctorInfoContainerState extends State<DoctorInfoContainer> {
  bool _isTapped = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _isTapped = !_isTapped;
        });
      },
      child: AnimatedContainer(
        margin: EdgeInsets.symmetric(horizontal: 50, vertical: 10),
        duration: Duration(milliseconds: 500),
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 1,
              blurRadius: 5,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: widget.child,
      ),
    );
  }
}
