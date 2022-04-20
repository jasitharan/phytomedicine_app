import 'package:flutter/material.dart';
import 'package:phytomedicine_app/models/step_model.dart';

class GuideExpansionTile extends StatefulWidget {
  final String leadingText;
  final String title;
  final List<StepModel>? childs;
  const GuideExpansionTile(
      {Key? key,
      required this.title,
      required this.leadingText,
      required this.childs})
      : super(key: key);

  @override
  State<GuideExpansionTile> createState() => _GuideExpansionTileState();
}

class _GuideExpansionTileState extends State<GuideExpansionTile> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 10,
        ),
        const Divider(
          indent: 15,
          endIndent: 15,
          color: Color.fromRGBO(189, 189, 189, 0.22),
        ),
        ExpansionTile(
          onExpansionChanged: (value) {},
          expandedAlignment: Alignment.topLeft,
          iconColor: widget.childs != null ? Colors.blue : Colors.transparent,
          collapsedIconColor:
              widget.childs != null ? Colors.blue : Colors.transparent,
          childrenPadding: const EdgeInsets.only(left: 16.0),
          leading: Text(widget.leadingText,
              style: const TextStyle(
                  color: Color.fromRGBO(26, 183, 168, 1), fontSize: 18.0)),
          title: Text(widget.title,
              style: const TextStyle(
                  color: Color.fromRGBO(189, 189, 189, 1), fontSize: 18.0)),
          children: widget.childs != null && widget.childs!.isNotEmpty
              ? [
                  ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: widget.childs!.length,
                      itemBuilder: (ctx, i) {
                        return GuideExpansionTile(
                            title: widget.childs![i].title ?? '',
                            leadingText: '*',
                            childs: widget.childs![i].steps);
                      })
                ]
              : [],
        ),
      ],
    );
  }
}
