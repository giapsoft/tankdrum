import 'dart:math';

import 'package:flutter/material.dart';

class NoteIdxSign extends StatelessWidget {
  const NoteIdxSign(this.idx, {this.padding, Key? key}) : super(key: key);
  final int idx;
  final EdgeInsets? padding;

  static fromName(String name, {EdgeInsets? padding}) {
    final parts = name.split('');
    int idx = parts.isEmpty ? 0 : int.tryParse(parts.removeAt(0)) ?? 0;
    if (parts.isNotEmpty) {
      if (parts[0] == 'D') {
        idx -= 7 * parts.length;
      } else {
        idx += 7 * parts.length;
      }
    }
    return NoteIdxSign(
      idx,
      padding: padding,
    );
  }

  int get bottomCount {
    if (idx < 1) {
      return idx > 0
          ? idx % 7 == 0
              ? (idx ~/ 7).abs() - 1
              : (idx ~/ 7).abs()
          : (idx ~/ 7).abs() + 1;
    }
    return 0;
  }

  int get topCount {
    if (idx > 7) {
      return idx > 0
          ? idx % 7 == 0
              ? (idx ~/ 7).abs() - 1
              : (idx ~/ 7).abs()
          : (idx ~/ 7).abs() + 1;
    }
    return 0;
  }

  String get text {
    return (idx % 7 == 0 ? 7 : idx % 7).toString();
  }

  double get size => 6;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? const EdgeInsets.all(0),
      child: Builder(builder: (context) {
        final width = min(30, MediaQuery.of(context).size.width).toDouble();
        final height = min(40, MediaQuery.of(context).size.height).toDouble();
        return Center(
          child: SizedBox(
            width: width,
            height: height,
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ...buildDot(topCount),
                  Text(
                    text,
                    style: const TextStyle(fontSize: 16),
                  ),
                  ...buildDot(bottomCount, false),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }

  List<Widget> buildDot(int dot, [isTop = false]) {
    return List.generate(
        dot,
        (_) => Container(
              width: size,
              height: size,
              margin: EdgeInsets.all(size / 10),
              decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(size)),
            ));
  }
}
