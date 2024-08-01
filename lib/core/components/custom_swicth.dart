import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:flutter/material.dart';

class CustomSwitch extends StatefulWidget {
  final Function swicthCallback;
  const CustomSwitch({required this.swicthCallback, super.key});

  @override
  State<CustomSwitch> createState() => _CustomSwitchState();
}

class _CustomSwitchState extends State<CustomSwitch> {
  late bool currentSwitch;

  @override
  void initState() {
    super.initState();
    currentSwitch = true;
  }

  @override
  Widget build(BuildContext context) {
    return CustomAnimatedToggleSwitch<bool>(
      current: currentSwitch,
      values: const [false, true],
      spacing: 0.0,
      indicatorSize: const Size.fromRadius(13.0),
      animationDuration: const Duration(milliseconds: 200),
      animationCurve: Curves.linear,
      onChanged: (b) {
        setState(() => currentSwitch = b);
        widget.swicthCallback.call();
      },
      iconBuilder: (context, local, global) {
        return const SizedBox();
      },
      cursors: const ToggleCursors(defaultCursor: SystemMouseCursors.click),
      onTap: (_) {
        setState(() => currentSwitch = !currentSwitch);
        widget.swicthCallback.call();
      },
      iconsTappable: false,
      wrapperBuilder: (context, global, child) {
        return Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
                left: 10.0,
                right: 10.0,
                height: 20.0,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: Color.lerp(Colors.black26,
                        const Color(0xFF007FBA).withOpacity(0.5), global.position),
                    borderRadius: const BorderRadius.all(Radius.circular(50.0)),
                  ),
                )),
            child,
          ],
        );
      },
      foregroundIndicatorBuilder: (context, global) {
        return SizedBox.fromSize(
          size: global.indicatorSize,
          child: DecoratedBox(
            decoration: BoxDecoration(
              color:
                  Color.lerp(Colors.white, const Color(0xFF007FBA), global.position),
              borderRadius: const BorderRadius.all(Radius.circular(50.0)),
              boxShadow: const [
                BoxShadow(
                    color: Colors.black38,
                    spreadRadius: 0.05,
                    blurRadius: 1.1,
                    offset: Offset(0.0, 0.8))
              ],
            ),
          ),
        );
      },
    );
  }
}
