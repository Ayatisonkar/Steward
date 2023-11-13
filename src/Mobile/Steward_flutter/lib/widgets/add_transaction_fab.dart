import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:Steward_flutter/blocs/transaction/transaction.dart';
import 'package:Steward_flutter/models/account.dart';
import 'package:Steward_flutter/screens/transaction/transaction_form.dart';
import 'package:Steward_flutter/theme/Steward_app_theme.dart';
import 'package:Steward_flutter/utils/common.dart';

class AddTransactionFab extends StatelessWidget {
  const AddTransactionFab({super.key, this.account});
  final Account? account;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
        key: ValueKey<Color>(Theme.of(context).primaryColor),
        tooltip: 'Add new transaction',
        backgroundColor: StewardAppTheme.nearlyDarkBlue,
        child: Icon(
          Icons.add,
          color: StewardAppTheme.buildLightTheme().indicatorColor,
        ),
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute<DismissDialogAction>(
              builder: (BuildContext context) => TransactionFormPage(
                transactionsBloc: BlocProvider.of<TransactionBloc>(context),
                account: account,
              ),
              fullscreenDialog: true,
            ),
          );
        });
  }
}
