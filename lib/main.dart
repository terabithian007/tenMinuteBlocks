import 'package:flutter/material.dart';

import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import './widgets/clockView.dart';
import './widgets/appBar.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final docDir = await getApplicationDocumentsDirectory();
  Hive.init(docDir.path);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'tenMinuteBlocks',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<List<ValueNotifier<bool>>> isSelected;
  ValueNotifier<bool> isSelectionStarted;
  ValueNotifier<int> startRowIndex;
  ValueNotifier<int> startColumnIndex;

  @override
  void initState() {
    isSelected = List<List<ValueNotifier<bool>>>.generate(
      12,
      (_) => List<ValueNotifier<bool>>.generate(
        12,
        (__) => ValueNotifier(false),
      ),
    );
    isSelectionStarted = ValueNotifier(false);
    startRowIndex = ValueNotifier(-1);
    startColumnIndex = ValueNotifier(-1);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SlidingUpPanel(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(MediaQuery.of(context).size.height * 0.03),
          topRight: Radius.circular(MediaQuery.of(context).size.height * 0.03),
        ),
        minHeight: MediaQuery.of(context).size.height * 0.1,
        maxHeight: MediaQuery.of(context).size.height * 0.75,
        color: Colors.black.withOpacity(0.87),
        backdropEnabled: true,
        panel: Container(),
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              TenMinuteBlocksAppBar(),
              Expanded(
                child: Center(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: 12,
                    physics: NeverScrollableScrollPhysics(),
                    padding: EdgeInsets.all(0.0),
                    itemBuilder: (_, rowIndex) => Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.width * 0.08,
                      child: Center(
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: 12,
                          physics: NeverScrollableScrollPhysics(),
                          padding: EdgeInsets.all(0.0),
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (__, columnIndex) => TenMinuteBlock(
                            rowIndex: rowIndex,
                            columnIndex: columnIndex,
                            isSelectedBlock: isSelected[rowIndex][columnIndex],
                            isSelectionStarted: isSelectionStarted,
                            startRowIndex: startRowIndex,
                            startColumnIndex: startColumnIndex,
                            isSelected: isSelected,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.1,
                width: MediaQuery.of(context).size.width,
                color: Colors.black.withOpacity(0.87),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TenMinuteBlock extends StatelessWidget {
  final int rowIndex;
  final int columnIndex;
  final ValueNotifier<bool> isSelectedBlock;
  final ValueNotifier<bool> isSelectionStarted;
  final ValueNotifier<int> startRowIndex;
  final ValueNotifier<int> startColumnIndex;
  final List<List<ValueNotifier<bool>>> isSelected;

  TenMinuteBlock({
    @required this.rowIndex,
    @required this.columnIndex,
    @required this.isSelectedBlock,
    @required this.isSelectionStarted,
    @required this.startRowIndex,
    @required this.startColumnIndex,
    @required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: isSelectedBlock,
      builder: (context, isSelectedFlag, child) => GestureDetector(
        onTap: () {
          if (!isSelectionStarted.value) {
            isSelected.forEach((row) {
              row.forEach((block) {
                block.value = false;
              });
            });
            isSelectedBlock.value = !isSelectedBlock.value;
            startRowIndex.value = rowIndex;
            startColumnIndex.value = columnIndex;
          } else {
            if ((rowIndex * 12 + columnIndex) >
                (startRowIndex.value * 12 + startColumnIndex.value)) {
              for (var indexIter =
                      (startRowIndex.value * 12 + startColumnIndex.value);
                  indexIter <= (rowIndex * 12 + columnIndex);
                  indexIter++) {
                int _rowIndex = (indexIter / 12).floor();
                int _columnIndex = indexIter - _rowIndex * 12;
                isSelected[_rowIndex][_columnIndex].value = true;
              }
            } else {
              for (var indexIter =
                      (startRowIndex.value * 12 + startColumnIndex.value);
                  indexIter >= (rowIndex * 12 + columnIndex);
                  indexIter--) {
                int _rowIndex = (indexIter / 12).floor();
                int _columnIndex = indexIter - _rowIndex * 12;
                isSelected[_rowIndex][_columnIndex].value = true;
              }
            }
            startRowIndex.value = -1;
            startColumnIndex.value = -1;
          }
          isSelectionStarted.value = !isSelectionStarted.value;
        },
        child: Stack(
          children: [
            Container(
              width: MediaQuery.of(context).size.width * 0.08,
              height: MediaQuery.of(context).size.width * 0.08,
              alignment: Alignment.center,
              child: Container(
                width: MediaQuery.of(context).size.width * 0.075,
                height: MediaQuery.of(context).size.width * 0.075,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(
                      'lib/assets/emptyButton.png',
                    ),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ),
            if (isSelectedFlag)
              Container(
                width: MediaQuery.of(context).size.width * 0.08,
                height: MediaQuery.of(context).size.width * 0.08,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(
                      'lib/assets/selectedButton.png',
                    ),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
