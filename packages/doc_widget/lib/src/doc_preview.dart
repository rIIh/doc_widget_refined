import 'package:doc_widget/doc_widget.dart';
import 'package:doc_widget/src/styles/colors.dart';
import 'package:doc_widget/src/styles/spaces.dart';
import 'package:doc_widget/src/widgets/item.dart';
import 'package:doc_widget/src/widgets/title.dart';
import 'package:flutter/material.dart';

/// Flutter application responsible to show all elements that are generated.
class DocPreview extends StatefulWidget {
  DocPreview({
    required this.elements,
  });

  final List<ElementPreview> elements;

  @override
  _DocPreviewState createState() => _DocPreviewState();
}

class _DocPreviewState extends State<DocPreview> {
  late ElementPreview _selectedItem;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    _selectedItem = widget.elements.first;
    super.initState();
  }

  void setSelectedItem(ElementPreview selectedItem) {
    setState(() {
      _selectedItem = selectedItem;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(scaffoldBackgroundColor: ColorsDoc.white),
      home: Scaffold(
        key: _scaffoldKey,
        drawer: Drawer(
          child: Container(
            color: ColorsDoc.ghostWhite,
            child: ListView(
              physics: const ClampingScrollPhysics(),
              padding: EdgeInsets.zero,
              children: <Widget>[
                Container(
                  height: 110,
                  child: DrawerHeader(
                    child: TextPreview(text: 'Doc Widget'),
                    decoration: const BoxDecoration(
                      color: ColorsDoc.white,
                    ),
                  ),
                ),
                ...List.generate(
                  widget.elements.length,
                  (index) => Column(
                    children: [
                      ListTile(
                        onTap: () {
                          setSelectedItem(widget.elements[index]);
                          if (_scaffoldKey.currentState!.isDrawerOpen) {
                            _scaffoldKey.currentState!.openEndDrawer();
                          }
                        },
                        title: Text(widget.elements[index].document.name),
                      ),
                      const Divider(),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
        appBar: AppBar(
          leading: Builder(
            builder: (BuildContext context) {
              return IconButton(
                icon: const Icon(
                  Icons.menu,
                  color: ColorsDoc.darkGray,
                ),
                onPressed: Scaffold.of(context).openDrawer,
              );
            },
          ),
          centerTitle: false,
          title: Text(
            _selectedItem.document.name,
            style: const TextStyle(color: ColorsDoc.darkSlateGray),
          ),
          backgroundColor: ColorsDoc.white,
          elevation: 2,
          brightness: Brightness.light,
          shadowColor: ColorsDoc.ghostWhite,
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: Spaces.goldenDream,
              vertical: Spaces.geraldine,
            ),
            child: Item(_selectedItem),
          ),
        ),
      ),
    );
  }
}
