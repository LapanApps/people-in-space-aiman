import 'package:anim_app/model/astros_model.dart';
import 'package:flutter/material.dart';

class SpacePage extends StatefulWidget {
  const SpacePage({Key? key}) : super(key: key);
  @override
  _SpacePageState createState() => _SpacePageState();
}

class _SpacePageState extends State<SpacePage> {
  late Future<List<Astros>> fetch_astros;
  @override
  void initState() {
    super.initState();
    fetch_astros = Astros.getAstros();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            FutureBuilder<List<Astros>>(
                future: fetch_astros,
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const CircularProgressIndicator();
                  }
                  return Container(
                    height: 70,
                    width: double.infinity,
                    decoration: const BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(20),
                            bottomRight: Radius.circular(20))),
                    child: Center(
                        child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        "${snapshot.data!.length } Astronauts in Space"  ,
                        style:
                            const TextStyle(fontSize: 20, color: Colors.white),
                      ),
                    )),
                  );
                }),
            FutureBuilder<List<Astros>>(
                future: fetch_astros,
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const CircularProgressIndicator();
                  }
                  return GridView.builder(
                      itemCount: snapshot.data!.length,
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2),
                      itemBuilder: (context, index) {
                        return Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          color: Colors.blue[100],
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Expanded(
                                child: Column(children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: Image.network(
                                  snapshot.data![index].imgUrl,
                                  fit: BoxFit.cover,
                                  height: 100,
                                  width: 100,
                                ),
                              ),
                              Text(
                                snapshot.data![index].name,
                                style: TextStyle(fontSize: 20),
                              ),
                              Text(snapshot.data![index].craft),
                            ])),
                          ),
                        );
                      });
                })
          ],
        ),
      ),
    );
  }
}
