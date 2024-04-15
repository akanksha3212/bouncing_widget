import 'package:consumer_flutter_app/screens/cart_summary_section_screen/controller/cart_summary_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../../../styles.dart';
import '../../../themes.dart';

class BuildBouncingButtonWidget extends StatefulWidget {
  const BuildBouncingButtonWidget(
      {Key? key, required this.parentScrollController})
      : super(key: key);
  final ScrollController parentScrollController;
  @override
  State<BuildBouncingButtonWidget> createState() =>
      _BuildBouncingButtonWidgetState();
}

class _BuildBouncingButtonWidgetState extends State<BuildBouncingButtonWidget>
    with SingleTickerProviderStateMixin {
  CartSummaryController cartSummaryController = Get.find();
  late AnimationController controller;
  late Animation<double> animationRadiusIn;
  late Animation<double> animationRadiusOut;
  final double initialRadius = 55.0;
  double radius = 0.0;
  @override
  void initState() {
    initZoom();
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void initZoom() {
    controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 3));

    animationRadiusIn = Tween<double>(begin: 1.0, end: 0.5).animate(
        CurvedAnimation(
            parent: controller,
            curve: const Interval(0.75, 1.0, curve: Curves.elasticIn)));
    animationRadiusOut = Tween<double>(begin: 0.5, end: 1.0).animate(
        CurvedAnimation(
            parent: controller,
            curve: const Interval(0.0, 0.25, curve: Curves.elasticOut)));

    controller.addListener(() {
      setState(() {
        if (controller.value >= 0.75 && controller.value <= 1.0) {
          radius = animationRadiusIn.value * initialRadius;
        } else if (controller.value >= 0.0 && controller.value <= 0.25) {
          radius = animationRadiusOut.value * initialRadius;
        }
      });
    });

    controller.repeat();
  }

  @override
  Widget build(BuildContext context) {
    return //Stack(alignment: Alignment.topRight, children: [
        Transform.translate(
            offset: Offset(0, radius - 55),
            child: FloatingActionButton(
                mini: true,
                backgroundColor: AppTheme.buttonColor,
                child: Icon(
                  MdiIcons.chevronDown,
                  size: Insets.xl,
                ),
                onPressed: () {
                 // if (cartSummaryController.goneToCart.value == false) {
                    widget.parentScrollController.animateTo(
                        widget.parentScrollController.position.maxScrollExtent,
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.linear);
                // //  }
                //   setState(() {
                //     cartSummaryController.goneToCart.value = true;
                //   });
                }));
    // Positioned(
    //   child: Stack(children: <Widget>[
    //     Container(
    //       width: Insets.lg * 1.3,
    //       height: Insets.lg,
    //       decoration: const BoxDecoration(
    //           color: AppTheme.buttonColor,
    //           borderRadius: Corners.lgBorder,
    //           border: Border.fromBorderSide(BorderSide(
    //               width: 2, color: AppTheme.containerWhite))),
    //     ),
    // Positioned(
    //     top: 4.0,
    //     right: 6.0,
    //     child: Center(
    //       child: Text(
    //         ,
    //         style: const TextStyle(
    //             color: Colors.white,
    //             fontSize: 8.0,
    //             fontWeight: FontWeight.w500),
    //       ),
    //     )),
    // ]),
    // ),
    //]);
  }
}
