import 'package:flutter/material.dart';
import 'package:mem_stuff/core/app_const.dart';

class StuffListView extends StatelessWidget {
  final int itemCount;
  final Widget Function(BuildContext context, int) itemBuilder;
  final bool loading;

  const StuffListView({
    Key key,
    this.itemCount,
    this.itemBuilder,
    this.loading,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (loading)
      return Center(
        child: CircularProgressIndicator(),
      );

    if (itemCount == 0) {
      return Center(
        child: Text(
          kLabelNoItem,
          style: TextStyle(
            color: Colors.black26,
          ),
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      itemCount: itemCount,
      itemBuilder: itemBuilder,
    );
  }
}
