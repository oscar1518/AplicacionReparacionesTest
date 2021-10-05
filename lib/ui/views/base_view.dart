import 'package:app_reparaciones/core/viewmodels/base_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import '../../locator.dart';

class BaseView<T extends BaseModel> extends StatelessWidget {
  final Widget Function(BuildContext context, T value, Widget? child) builder;

  BaseView({required this.builder});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<T>(
      create: (context) => locator<T>(),
      child: Consumer<T>(builder: builder),
    );
  }
}