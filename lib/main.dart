import 'package:botter/cubits/addblockfriends_cubit.dart';
import 'package:botter/cubits/app_theme_cubit.dart';
import 'package:botter/cubits/getfriendandbloclist_cubit.dart';
import 'package:botter/cubits/searchpeople_cubit.dart';
import 'package:botter/database/database.dart';
import 'package:botter/cubits/username_cubit.dart';
import 'package:botter/service.dart';
import 'package:botter/user.dart';
import 'package:botter/wrapper.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'cubits/setusername_cubit.dart';
import 'search.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final Storage = await HydratedStorage.build(storageDirectory: await getApplicationDocumentsDirectory());
  await Firebase.initializeApp();
  HydratedBlocOverrides.runZoned((){
    runApp(MaterialApp(
      theme: ThemeData(backgroundColor: Colors.teal[900],),
      home: MyApp(),
    ),);
  },
  storage: Storage
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return StreamProvider<user?>.value(
      value: Authservice().us,
      initialData: null,
      child: Builder(
          builder: (context) {
            databaseservice db = databaseservice(uid: Provider.of<user?>(context)?.uid);
            return MultiBlocProvider(
              providers: [
                BlocProvider(
                  create: (context) => AppThemeCubit(),
                ),
                BlocProvider(
                  create: (context) => UsernameCubit(db : db),
                ),
                BlocProvider(
                  create: (context) => SetusernameCubit(db: db),
                ),
                BlocProvider(
                  create: (context) => SearchpeopleCubit(db: db),
                ),
                BlocProvider(
                  create: (context) => AddblockfriendsCubit(db: db),
                ),
                BlocProvider(
                  create: (context) => GetfriendandbloclistCubit(db: db),
                )
              ],
              child: Builder(
                builder: (context) {
                  return MaterialApp(
                    theme: ThemeData(backgroundColor: context.watch<AppThemeCubit>().state.background),
                    routes: {
                      '/' : (context) => wrapper(),
                      '/search' : (context) => BlocProvider(
                          create: (context) => SearchpeopleCubit(db: db),
                           child: search(),
                      ),
                    },
                  );
                }
              ),
            );
          }
      ),
    );
  }
}
