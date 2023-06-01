import 'package:ax_dapp/predict/models/prediction_model.dart';
import 'package:ax_dapp/prediction/widgets/buttons/buttons.dart';
import 'package:ax_dapp/prediction/widgets/prompt_details.dart';
import 'package:ax_dapp/service/global.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class DesktopPrediction extends StatelessWidget {
  const DesktopPrediction({
    required this.predictionModel,
    required this.minTeamWidth,
    required this.minViewWidth,
    super.key,
  });

  final PredictionModel predictionModel;
  final double minTeamWidth;
  final double minViewWidth;

  @override
  Widget build(BuildContext context) {
    final _width = MediaQuery.of(context).size.width;
    return SizedBox(
      height: 70,
      child: OutlinedButton(
        onPressed: () {
          final id = predictionModel.id;
          FirebaseFirestore.instance
              .collection('EventMarket')
              .doc(id)
              .get()
              .then((DocumentSnapshot documentSnapshot) {
            if (documentSnapshot.exists) {
              // ignore: cast_nullable_to_non_nullable
              final data = documentSnapshot.data() as Map<String, dynamic>;
              final yesAddr = data['YesAddress'].toString();
              final noAddr = data['NoAddress'].toString();
              Global().updatePrediction(id, yesAddr, noAddr);
            }
            context.goNamed(
              'prediction',
              params: {
                'id': id,
              },
            );
          }).catchError((error) {
            print('Error: $error');
          });
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            // prompt, probability
            Row(
              children: <Widget>[
                PromptDetails(
                  model: predictionModel,
                ).promptDetailsCardforWeb(),
                // Probability(prompt: _prompt)
              ],
            ),
            // yes, no
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                YesButton(
                  prompt: predictionModel,
                  isPortraitMode: false,
                  containerWdt: _width,
                ),
                NoButton(
                  prompt: predictionModel,
                  isPortraitMode: false,
                  containerWdt: _width,
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
