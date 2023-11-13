import 'package:flutter/material.dart';
import 'package:Steward_flutter/blocs/accounts/accounts_bloc.dart';
import 'package:Steward_flutter/blocs/accounts/accounts_state.dart';
import 'package:Steward_flutter/blocs/auth/auth.dart';
import 'package:Steward_flutter/blocs/categories/categories_bloc.dart';
import 'package:Steward_flutter/blocs/categories/categories_state.dart';
import 'package:Steward_flutter/models/models.dart';
import 'package:Steward_flutter/screens/category/category_list.dart';
import 'package:Steward_flutter/screens/home/home_screen.dart';
import 'package:Steward_flutter/screens/reports/reports_screen.dart';
import 'package:Steward_flutter/screens/settings/settings_screen.dart';
import 'package:Steward_flutter/widgets/about_tile.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CommonDrawer extends StatelessWidget {
  final TextStyle menuTextStyle =
      const TextStyle(fontWeight: FontWeight.w700, fontSize: 18.0);
  final AnimationController? animationController;

  const CommonDrawer({super.key, required this.animationController});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          drawerHeader(),
          ListTile(
            title: Text(
              "Home",
              style: menuTextStyle,
            ),
            leading: const Icon(
              Icons.home,
              color: Colors.blue,
            ),
            onTap: (() => Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => const HomeScreen()))),
          ),
          ListTile(
            title: Text(
              "Accounts",
              style: menuTextStyle,
            ),
            leading: const Icon(
              Icons.account_balance_wallet,
              color: Colors.green,
            ),
            onTap: (() => Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const HomeScreen(
                      startpage: StartPage.Accounts,
                    ),
                  ),
                )),
            trailing: BlocBuilder<AccountsBloc, AccountsState>(
                builder: (context, state) {
              if (state is AccountsLoaded) {
                return Chip(
                  backgroundColor: Colors.green,
                  label: Text(state.userAccounts!.length.toString()),
                );
              }
              return const Chip(
                label: Icon(Icons.hourglass_empty),
              );
            }),
          ),
          categoriesTile(context),
          ListTile(
            title: Text(
              'Reports',
              style: menuTextStyle,
            ),
            leading: const Icon(
              Icons.insert_chart,
              color: Colors.amber,
            ),
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (BuildContext context) => ReportsScreen(
                  animationController: animationController,
                ),
              ),
            ),
          ),
          ListTile(
            title: Text(
              "Settings",
              style: menuTextStyle,
            ),
            leading: const Icon(Icons.settings, color: Colors.brown),
            onTap: (() => Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => SettingsScreen(
                        animationController: animationController),
                  ),
                )),
          ),
          const Divider(),
          ListTile(
            title: const Text(
              "Logout",
            ),
            leading: const Icon(
              Icons.exit_to_app,
              color: Colors.red,
            ),
            onTap: (() {
              Navigator.popUntil(context, (ModalRoute.withName('/')));
              BlocProvider.of<AuthBloc>(context).add(LoggedOut());
            }),
          ),
          const Divider(),
          MyAboutTile()
        ],
      ),
    );
  }

  Widget categoriesTile(BuildContext context) {
    return ListTile(
      title: Text(
        "Categories",
        style: menuTextStyle,
      ),
      leading: const Icon(
        Icons.category,
        color: Colors.cyan,
      ),
      onTap: (() => Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => CategoryListPage(
                animationController: animationController,
              ),
            ),
          )),
      trailing: BlocBuilder<CategoriesBloc, CategoriesState>(
          builder: (context, state) {
        if (state is CategoriesLoaded) {
          return Chip(
            backgroundColor: Colors.cyan,
            label: Text(state.categories.length.toString()),
          );
        }
        return const Chip(
          label: Icon(Icons.hourglass_empty),
        );
      }),
    );
  }

  Widget drawerHeader() {
    return BlocBuilder<AuthBloc, AuthState>(builder: (context, state) {
      if (state is AuthAuthenticated) {
        return UserAccountsDrawerHeader(
          accountName: Text(
            '${state.user!.name} ${state.user!.surname}',
          ),
          accountEmail: Text(
            state.user!.emailAddress!,
          ),
          currentAccountPicture: const CircleAvatar(
//              backgroundImage: new AssetImage(UIData.pkImage),
              ),
        );
      }

      return const DrawerHeader(
        child: Text('User not logged in'),
      );
    });
  }
}
