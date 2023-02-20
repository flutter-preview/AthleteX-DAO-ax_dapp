


class SettleDialog extends StatefulWidget {
    const SettleDialog(
        this.athlete,
        this.aptName,
        this.inputLongApt,
        this.inputShortApt,
        this.valueInAX, {
            super.key,
    });

    final AthleteScoutModel athlete;
    final String athleteName;
    final double aptPrice;
    final bool isLongApt;
    final int athleteId;

    @override
    State<StatefulWidget> createState() => _SettleDialogState();
}

class _SettleDialogState extends State<SettleDialog> {
    double paddingHorizontal = 20;
    double hgt = 500;

    final TextEditingController _aptAmountController = TextEditingController;

    Widget build(BuildContext context) {
    final isWeb =
        kIsWeb && (MediaQuery.of(context).orientation == Orientation.landscape);
    final _height = MediaQuery.of(context).size.height;
    final wid = isWeb ? 400.0 : 355.0;
    if (_height < 505) hgt = _height;
    final usdValue = context.read<WalletBloc>().state.axData.price;
    final price = usdValue ?? 0;
    
    return BlocConsumer<SettleDialogBloc, SettleDialogState>(
        listenWhen: (_, current) => 
        current.status == BlocStatus.error ||
        current.status == BlocStatus.noData,

        listener: (context, state) {},
        builder: (context, state) {
            final bloc = context.read<SettleDialogBloc>();
            final shortBalance = state.shortBalance;
            final longBalance = state.longBalance;

            // probably important context is missing here

            return Dialog(
                insetPadding: EdgeInsets.zero,
                backgroundColor: Colors.transparent,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                ),
                child: Container(
                    // Stuff goes in here
                );
            )
        }

    )
    }


  @override
  void dispose() {
    _longInputController.dispose();
    _shortInputController.dispose();
    super.dispose();
  }
}