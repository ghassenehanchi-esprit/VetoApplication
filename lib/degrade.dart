import 'package:flutter/material.dart';
import 'package:adobe_xd/pinned.dart';
import 'package:flutter_svg/flutter_svg.dart';

class degrade extends StatelessWidget {
  degrade({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Pinned.fromPins(
            Pin(start: -133.1, end: -132.6),
            Pin(size: 921.2, start: -329.8),
            child: SvgPicture.string(
              _svg_dmezt,
              allowDrawingOutsideViewBox: true,
              fit: BoxFit.fill,
            ),
          ),
          Pinned.fromPins(
            Pin(start: -119.8, end: -119.8),
            Pin(size: 403.9, middle: 0.3593),
            child: SvgPicture.string(
              _svg_jripir,
              allowDrawingOutsideViewBox: true,
              fit: BoxFit.fill,
            ),
          ),
        ],
      ),
    );
  }
}

const String _svg_dmezt =
    '<svg viewBox="-133.1 -329.8 693.7 921.2" ><defs><radialGradient id="gradient" gradientTransform="matrix(1.0 0.0 0.0 1.0 0.0 0.0)" fx="0.5" fy="0.5" fr="0.0" cx="0.5" cy="0.5" r="0.5"><stop offset="0.0" stop-color="#6f76fc" /><stop offset="1.0" stop-color="#6f76fc" stop-opacity="0.0"/></radialGradient></defs><path transform="translate(-133.06, -188.11)" d="M 368.3119812011719 -141.6411437988281 C 559.8668823242188 -141.6411437988281 693.6820068359375 285.8843383789062 693.6820068359375 461.5424499511719 C 693.6820068359375 637.2006225585938 538.3960571289062 779.5996704101562 346.8410034179688 779.5996704101562 C 155.2860107421875 779.5996704101562 0 637.2006225585938 0 461.5424499511719 C 0 285.8843383789062 176.7570190429688 -141.6411437988281 368.3119812011719 -141.6411437988281 Z" fill="url(#gradient)" fill-opacity="0.67" stroke="none" stroke-width="1" stroke-opacity="0.67" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_jripir =
    '<svg viewBox="-119.8 187.6 667.5 403.9" ><defs><radialGradient id="gradient" gradientTransform="matrix(1.0 0.0 0.0 1.0 0.0 0.0)" fx="0.5" fy="0.5" fr="0.0" cx="0.5" cy="0.5" r="0.5"><stop offset="0.0" stop-color="#42f1a6" /><stop offset="1.0" stop-color="#42f1a6" stop-opacity="0.0"/></radialGradient></defs><path transform="translate(-119.75, 329.2)" d="M 354.4134216308594 -141.6411437988281 C 538.7398071289062 -141.6411437988281 667.5053100585938 45.81377410888672 667.5053100585938 122.8336868286133 C 667.5053100585938 199.8535919189453 518.0791625976562 262.2905883789062 333.7526550292969 262.2905883789062 C 149.4261627197266 262.2905883789062 0 199.8535919189453 0 122.8336868286133 C 0 45.81377410888672 170.0869445800781 -141.6411437988281 354.4134216308594 -141.6411437988281 Z" fill="url(#gradient)" fill-opacity="0.84" stroke="none" stroke-width="1" stroke-opacity="0.84" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
