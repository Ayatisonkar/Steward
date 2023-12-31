import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:Steward_flutter/models/models.dart';
import 'package:Steward_flutter/repositories/account_repository.dart';
import './bloc.dart';

class AccountTypesBloc extends Bloc<AccountTypesEvent, AccountTypesState> {
  AccountTypesBloc({required this.accountRepository})
      : super(AccountTypesLoading());

  final AccountRepository accountRepository;

  @override
  Stream<AccountTypesState> mapEventToState(
    AccountTypesEvent event,
  ) async* {
    if (event is AccountTypesLoad) {
      yield AccountTypesLoading();
      try {
        final List<AccountType> accountTypes =
            await accountRepository.getAccountTypes();
        yield AccountTypesLoaded(accountTypes: accountTypes);
      } catch (error) {
        yield AccountTypesError();
      }
    }
  }
}
