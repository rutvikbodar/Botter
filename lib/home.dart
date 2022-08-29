import 'package:botter/cubits/getfriendandbloclist_cubit.dart';
import 'package:botter/cubits/username_cubit.dart';
import 'package:botter/database/database.dart';
import 'package:botter/profilepage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'cubits/app_theme_cubit.dart';
import 'cubits/profilepagecubit_cubit.dart';

class home extends StatefulWidget{
  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {
  void refreshpage(){
    setState(()=>{});
  }
  @override
  Widget build(BuildContext context) {
    ProfilepagecubitCubit ppc = ProfilepagecubitCubit(db: (context).read<UsernameCubit>().db);
    TextEditingController searchcontroller = TextEditingController();
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
          body: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              Container(
                height: 60,
                child: Row(
                  children: <Widget>[
                    Container(
                      height: 45,
                      width: 45,
                      child: Image.asset("assets/bottericon.png"),
                    ),
                    Container(
                      height: 35,
                      width: 85,
                      child: Image.asset("assets/bottertxt.png"),
                    ),
                    Container(
                      width: 200,
                      height: 45,
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(15),border: Border.all(color: Colors.white,width: 2)),
                      child: TextField(
                        controller: searchcontroller,
                        style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,),
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          suffixIcon: IconButton(onPressed: null, icon: Icon(Icons.search,color: Colors.white,))
                          ,
                          hintText: "Search",
                          contentPadding: EdgeInsets.all(8),
                          hintStyle: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,),
                        ),
                        onChanged: (val){
                          (context).read<GetfriendandbloclistCubit>().searchspecificchat(searchcontroller.text);
                        },
                      ),
                    ),
                    BlocProvider(
                      create: (context) => ppc,
                      child: Container(
                        key: UniqueKey(),
                      height: 60,
                      width: 60,
                      padding: EdgeInsets.all(8),
                      child: FloatingActionButton(
                        child: Builder(
                          builder: (context) {
                            return BlocBuilder<ProfilepagecubitCubit, ProfilepagecubitState>(
                              builder: (context, state) {
                                imageCache.clear();
                                if(state is Profilepageretrived){
                                  return Container(
                                    key: UniqueKey(),
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.orange,
                                        image: DecorationImage(
                                            image : NetworkImage(state.url)
                                        )
                                    ),
                                  );
                                }
                                else{
                                  return Container(
                                    decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.white,
                                        image: DecorationImage(
                                            image : AssetImage('assets/defaultprofile.png') as ImageProvider<Object>
                                        )
                                    ),
                                  );
                                }
                              },);
                          }
                        ),
                        heroTag: UniqueKey(),
                        onPressed: ()=>Navigator.push(context, MaterialPageRoute(builder: (context) {
                          return BlocProvider.value(
                            value: ppc,
                            child: profilepage(),
                          );})
                        ),
                        )
                    ),
                  ),
                  ],
                ),
              ),
              Expanded(
                child: Stack(
                children: <Widget>[
                  Center(
                      child: Builder(
                      builder: (context) {
                      GetfriendandbloclistState stat = (context).watch<GetfriendandbloclistCubit>().state;
                      List<Widget> list = List<Widget>.empty(growable: true);
                      if(stat.chattilelistprovider(refreshpage).isNotEmpty){
                        for(Widget w in stat.chattilelistprovider(refreshpage)){
                          list.add(w);
                          list.add(Center(child: Container(height: 0.2,width: 350,color: (context).read<AppThemeCubit>().state.textcolor,)));
                        }
                      }
                      return ListView(
                          children: list,
                        );
                      }
                    )
                  ),
                  ]
                ),
              ),
            ],
          ),
            floatingActionButton: FloatingActionButton(onPressed: () => Navigator.pushNamed(context, '/search'),
              child: Image.asset('assets/bottle.png',alignment: Alignment.center,height: 57,width: 57,),
              backgroundColor: Colors.white,
            ),
        );
    }
}