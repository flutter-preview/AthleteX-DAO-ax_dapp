import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ConnectWalletConnectDialog extends StatelessWidget {
    const ConnectWalletConnectDialog({super.key});

    @override
    Widget build(BuildContext context) {
        return Dialog(
            backgroundColor: Colors.transparent,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
            ),
            child: LayoutBuilder(
                builder: (context, constraints) => Container(
                    
                ),
            )
        )
    }
}