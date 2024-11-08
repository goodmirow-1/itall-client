import 'package:flutter/material.dart';
import 'package:itall_app/config/constants.dart';
import '../s_text_style.dart';
import 'global_widget.dart';

// ignore: must_be_immutable
class AnimatedTapBar extends StatelessWidget {
  AnimatedTapBar({Key? key, required this.barIndex, required this.listTabItemTitle, required this.listTabItemWidth, required this.onPageChanged}) : super(key: key);

  final int barIndex;
  final List<String> listTabItemTitle; //탭 이름 리스트
  final List<double> listTabItemWidth; //탭 width 리스트
  final Function(int index) onPageChanged;

  static const Duration duration = Duration(milliseconds: 400);
  static const Curve curve = Curves.fastOutSlowIn;

  final double horizontalPadding = 18 * sizeUnit;
  final double rightMargin = 24 * sizeUnit;

  double get  bottomLineWidth => listTabItemWidth[barIndex] + 2 * sizeUnit;
  int get itemCount => listTabItemTitle.length;

  double leftPadding = 0;

  @override
  Widget build(BuildContext context) {
    leftPadding = barIndex == 0 ? 0 : (listTabItemWidth[barIndex - 1] + rightMargin) * barIndex + (listTabItemWidth[barIndex] - bottomLineWidth) / 2;

    return SizedBox(
      height: 48 * sizeUnit,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Row(
              children: List.generate(
                  listTabItemTitle.length,
                  (index) => Padding(
                        padding: EdgeInsets.only(right: index != itemCount - 1 ? rightMargin : 0),
                        child: InkWell(
                          onTap: () => onPageChanged(index),
                          child: Text(
                            listTabItemTitle[index],
                            style: STextStyle.headline5().copyWith(
                              fontWeight: barIndex == index ? FontWeight.bold : FontWeight.w500,
                              color: barIndex == index ? iaColorRed : iaColorDarkGrey,
                            ),
                          ),
                        ),
                      )),
            ),
            SizedBox(height: 4 * sizeUnit),
            Row(
              children: [
                AnimatedContainer(
                  width: leftPadding,
                  duration: duration,
                  curve: curve,
                ),
                Container(
                  width: bottomLineWidth,
                  height: 1 * sizeUnit,
                  decoration: BoxDecoration(color: iaColorRed, borderRadius: BorderRadius.circular(3 * sizeUnit)),
                ),
              ],
            ),
            SizedBox(height: 9 * sizeUnit),
          ],
        ),
      ),
    );
  }
}
