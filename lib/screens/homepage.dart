import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rssfeed/models/rssResponceModel.dart';
import 'package:rssfeed/screens/webViewSceen.dart';
import 'package:rssfeed/services/api.dart';
import 'package:rssfeed/services/url.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {

   RssFeed? _feed;
  //  List<RssFeed> datas=[];
   @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(title: Text("RSS FEED",style:GoogleFonts.robotoSlab(fontWeight: FontWeight.w600) ,),backgroundColor: Colors.greenAccent,),

      body:_feed==null?
      Center(
        child: CircularProgressIndicator(),
      )
      
      :GridView.builder(
       itemCount:_feed!.items!.length ,
       gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 1,
          crossAxisSpacing: 16,
                       mainAxisSpacing: 12,
                       mainAxisExtent: 210,), itemBuilder: (context, index) {
                         final data=_feed!.items![index];
                           final image=data.media;
                           print("imagesss $image");
                         return InkWell(

                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>WebViewScreen(link: data.link!,)));
                          },
                           child:  Container(
                           height: 300,
                           
                           decoration: BoxDecoration(
                             borderRadius: const BorderRadius.all(
                               Radius.circular(5),
                             ),
                             image: DecorationImage(
                            
                               image: NetworkImage(
                                
                                 data.media!.contents![0].url!,
                                 
                               ),
                               
                               fit: BoxFit.cover,
                               
                             ),
                           ),
                           child: Padding(
                             padding: const EdgeInsets.all(8.0),
                             child: Container(
                               alignment: Alignment.bottomCenter,
                               child: Text(
                                 data.title!,
                                 maxLines: 3,
                                 style: GoogleFonts.robotoSlab(
                                   fontSize: 25,
                                   fontWeight: FontWeight.bold,
                                   color: Colors.white,
                                   backgroundColor: Colors.black26,
                                 ),
                               ),
                             ),
                         )));
                       },)
      
       
    );
  }


  Future getData()async{
    final dio=Dio();
    final url=Url();
    try {
      final responce= await dio.get(url.rssUrl);
      final result=responce.data;
      print("result : $result");

      return RssFeed.parse(result);
    } catch (e) {
      print("Error : $e");
    }
  }

  updateData(feed){
 setState(() {
      _feed=feed;
    });
  }

  loadData() async {
    getData().then((result) {
      if (null == result || result.toString().isEmpty) {
        return;
      }
      updateData(result);
    });
  }
}