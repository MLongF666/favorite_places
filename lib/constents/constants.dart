import 'package:flutter/material.dart';

class kFrameWidget extends StatelessWidget {
  const kFrameWidget({
    super.key,
    required this.content,
  });

  final Widget content;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: double.infinity,
      height: 200,
      decoration: BoxDecoration(
        border: Border.all(width: 1, color: Colors.grey),
      ),
      child: content,
    );
  }
}

