import 'package:flutter/material.dart';
import 'package:adobe_xd/pinned.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:meta/meta.dart';

class XDComposant11 extends StatelessWidget {
  final String? myText;
  final Function() onPressed;

  const XDComposant11({
    Key? key,
    this.myText,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Stack(
        children: <Widget>[
          SizedBox(
            width: 157.0,
            height: 44.0,
            child: SvgPicture.string(
              _svg_ri69ga,
              allowDrawingOutsideViewBox: true,
            ),
          ),
          Pinned.fromPins(
            Pin(size: 147.0, middle: 1.0),
            Pin(size: 19.0, end: 13.0),
            child: SingleChildScrollView(
              primary: false,
              child: SizedBox(
                width: 132.0,
                height: 21.0,
                child: Stack(
                  children: <Widget>[
                    SizedBox(
                      width: 132.0,
                      child: Text(
                        myText ?? '',
                        style: TextStyle(
                          fontFamily: 'GothamMedium',
                          fontSize: 20,
                          color: const Color(0xffffffff),
                        ),
                      textAlign: TextAlign.center,
                        softWrap: true,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

const String _svg_ri69ga =
    '<svg viewBox="0.0 0.0 157.0 44.0" ><defs><linearGradient id="gradient" x1="0.846861" y1="0.5" x2="0.0" y2="0.5"><stop offset="0.0" stop-color="#42f1a6" /><stop offset="1.0" stop-color="#6f76fc" /></linearGradient></defs><path  d="M 21.72327041625977 0 L 135.2767486572266 0 C 147.2741851806641 0 157 8.667766571044922 157 19.36000061035156 L 157 24.63999938964844 C 157 35.33223342895508 147.2741851806641 44 135.2767486572266 44 L 21.72327041625977 44 C 9.72584056854248 44 0 35.33223342895508 0 24.63999938964844 L 0 19.36000061035156 C 0 8.667766571044922 9.72584056854248 0 21.72327041625977 0 Z" fill="url(#gradient)" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';



