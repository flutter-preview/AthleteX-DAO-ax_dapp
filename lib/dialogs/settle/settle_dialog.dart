import 'package:ax_dapp/scout/models/athlete_scout_model.dart';
import 'package:flutter/foundation.dart';

import 'package:flutter/material.dart';

class SettleDialog extends StatefulWidget {
    const SettleDialog({
      required this.athlete,
    });

      final AthleteScoutModel athlete;
      

    @override
    State<StatefulWidget> createState() => _SettleDialogState();
}

class _SettleDialogState extends State<SettleDialog> {
    double paddingHorizontal = 20;
    double hgt = 500;

    @override
    Widget build(BuildContext context) {
    final isWeb =
        kIsWeb && (MediaQuery.of(context).orientation == Orientation.landscape);
    final _height = MediaQuery.of(context).size.height;
    final wid = isWeb ? 400.0 : 355.0;

    // This will be refactored... soon!
    return Container();
    }


  @override
  void dispose() {

    super.dispose();
  }
}
