import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      getPages: <GetPage>[
        GetPage(
            name: '/',
            page: () => const MyHomePage(title: 'Flutter Demo Home Page'),
            binding: BindingsBuilder(() {})),
        GetPage(
            name: '/detail',
            page: () =>  HomeDetail(),
            binding: BindingsBuilder(() {
              Get.put(HomeDetailController());
            })),
      ],
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: ListView.builder(
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            onTap: () {
              Get.toNamed('/detail',arguments: {
                'number':index+1
              });
            },
            title: Text('No. ${index + 1}'),
          );
        },
      ),
    );
  }
}

class HomeDetail extends GetView<HomeDetailController> {
   HomeDetail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Detail'),
        actions: [
          IconButton(onPressed: (){
            Get.offNamed('/detail',arguments: {
              'number':controller.number.value+1
            },preventDuplicates: false);
          }, icon: Icon(Icons.refresh),)
        ],
      ),
      body: Center(
        child: Obx(() => Text('Number is ${controller.number.value}')),
      ),
    );
  }
}

class HomeDetailController extends GetxController {
  RxInt number = 0.obs;

  @override
  void onInit() {
    super.onInit();
    print('--onInit--');
    number.call(Get.arguments['number']);
  }

  @override
  void onClose() {
    super.onClose();
    print('--onClose--');
  }
}
