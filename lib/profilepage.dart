import 'package:botter/cubits/getfriendandbloclist_cubit.dart';
import 'package:botter/cubits/profilepagecubit_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class profilepage extends StatefulWidget {
  const profilepage({Key? key}) : super(key: key);

  @override
  State<profilepage> createState() => _profilepageState();
}

class _profilepageState extends State<profilepage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Column(
          children: <Widget>[
            Container(
              color: Colors.green.shade900,
              height: 200,
              child: Stack(
                children: [
                  Container(
                    height: 140,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.purple.shade700,Colors.green.shade900],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter
                      )
                    ),
                  ),
                  BlocBuilder<ProfilepagecubitCubit, ProfilepagecubitState>(
                    builder: (context, state) {
                      if(state is Profilepageretrived){
                        return Container(
                          key: UniqueKey(),
                          height: 140,
                          width: 140,
                          margin: EdgeInsets.only(top: 40,left: 10),
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              boxShadow: [BoxShadow(color: Colors.white,blurRadius: 10)],
                              color: Colors.orange,
                              image: DecorationImage(
                                  image : NetworkImage(state.url)
                              )
                          ),
                        );
                      }
                      else{
                        return Container(
                          height: 140,
                          width: 140,
                          margin: EdgeInsets.only(top: 40,left: 10),
                          decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              //borderRadius: BorderRadius.circular(70),
                              boxShadow: [BoxShadow(color: Colors.white,blurRadius: 10)],
                              color: Colors.white,
                              image: DecorationImage(
                                  image : AssetImage('assets/defaultprofile.png') as ImageProvider<Object>
                              )
                          ),
                        );
                      }
                },),
                  Container(
                    margin: EdgeInsets.only(top: 150,left: 120),
                    child: IconButton(
                      onPressed: (context).read<ProfilepagecubitCubit>().selectfile,
                      icon: Icon(Icons.camera_alt_outlined,color: Colors.white),
                    ),
                  ),
                  Container(
                    height: 30,
                    width: 200,
                    margin: EdgeInsets.only(left: 170,top: 155),
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text("Madara",style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold,color: Colors.white),),
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              child: Container(
                color: Colors.green.shade900,
                child: Column(
                  children: <Widget>[
                    Container(
                      height: 40,
                      color: Colors.white,
                      child: Row(
                        children: <Widget>[
                          Container(
                            width: 200,
                            color: Colors.green.shade900,
                            child: Container(
                              margin: EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.blueGrey.shade400
                              ),
                              padding: EdgeInsets.all(7),
                              child: Text("   Friends : "+(context).read<GetfriendandbloclistCubit>().state.friendslist.length.toString(),style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color: Colors.white,),),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              width: 200,
                              color: Colors.green.shade900,
                              child: Container(
                                margin: EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.blueGrey.shade400
                                ),
                                padding: EdgeInsets.all(7),
                                child: Text("   Creeps : "+(context).read<GetfriendandbloclistCubit>().state.blocklist.length.toString(),style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color: Colors.white),),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                )
              ),
            ),
            Container(
              height: 40,
              color: Colors.indigo,
            )
          ],
        ),
      ),
    );
  }
}
