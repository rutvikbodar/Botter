import 'package:cloud_firestore/cloud_firestore.dart';

class generator{
  String generateid(String s1,String s2){
    List<String> set = [s1,s2];
    set.sort();
    return set[0]+set[1];
  }
}
class generatedatetime{
  static String generatedatetimestring(Timestamp stamp){
    DateTime currentdatetime = DateTime.now();
    int diff_in_days = currentdatetime.difference(stamp.toDate()).inDays;
    if(diff_in_days!=0){
      return diff_in_days.toString()+" days ago";
    }
    else{
      int hours =  stamp.toDate().hour;
      if(hours>12){
        return (hours-12).toString()+":"+stamp.toDate().minute.toString()+" pm";
      }
      else{
        return hours.toString()+":"+stamp.toDate().minute.toString()+" am";
      }
    }
  }
}