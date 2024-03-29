import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:phytomedicine_app/models/step_model.dart';
import 'package:phytomedicine_app/services/fire_storage_service.dart';
import 'package:string_extensions/string_extensions.dart';

class GuideExpansionTile extends StatefulWidget {
  // final String leadingText;
  final StepModel me;
  final List<StepModel>? childs;
  final Color color;
  final bool isIconOutlined;
  const GuideExpansionTile({
    Key? key,
    required this.me,
    //   required this.leadingText,
    this.color = const Color.fromRGBO(189, 189, 189, 1),
    required this.childs,
    this.isIconOutlined = false,
  }) : super(key: key);

  @override
  State<GuideExpansionTile> createState() => _GuideExpansionTileState();
}

class _GuideExpansionTileState extends State<GuideExpansionTile> {
  bool _isInit = true;
  bool loading = false;

  @override
  Future<void> didChangeDependencies() async {
    if (_isInit) {
      if (widget.me.image != null) {
        setState(() {
          loading = true;
        });
        widget.me.image = await FireStorageService.loadImage(
            '${widget.me.image}', '/conditions_other');
        setState(() {
          loading = false;
        });
      }
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 10,
        ),
        // const Divider(
        //   indent: 15,
        //   endIndent: 15,
        //   color: Color.fromRGBO(189, 189, 189, 0.22),
        // ),
        ExpansionTile(
          onExpansionChanged: (value) {},
          expandedAlignment: Alignment.topLeft,
          iconColor: widget.childs != null
              ? const Color.fromRGBO(26, 183, 168, 1)
              : Colors.transparent,
          collapsedIconColor: widget.childs != null
              ? const Color.fromRGBO(26, 183, 168, 1)
              : Colors.transparent,
          childrenPadding: const EdgeInsets.only(left: 16.0),
          // leading: Text(widget.leadingText,
          //     style: const TextStyle(
          //         color: Color.fromRGBO(26, 183, 168, 1), fontSize: 18.0)),
          subtitle: widget.me.image != null
              ? loading
                  ? const Padding(
                      padding: EdgeInsets.only(top: 16.0),
                      child: SizedBox(
                        height: 20,
                        width: 20,
                        child: SpinKitCubeGrid(
                          size: 20,
                          color: Colors.white,
                        ),
                      ),
                    )
                  : CachedNetworkImage(
                      fit: BoxFit.contain,
                      imageUrl: widget.me.image!,
                      errorWidget: (context, url, error) => const Image(
                          image:
                              AssetImage('assets/images/conditions/hiv.png')),
                    )
              : Container(),
          title: RichText(
            text: TextSpan(
              children: [
                WidgetSpan(
                  child: Icon(
                    widget.isIconOutlined
                        ? Icons.fiber_manual_record_outlined
                        : Icons.fiber_manual_record,
                    size: 16,
                  ),
                ),
                TextSpan(
                  text: widget.me.title == null
                      ? ''
                      : '    ${widget.me.title}'
                          .split(' ')
                          .map((word) => word.capitalize!)
                          .join(' '),
                  style: TextStyle(
                    color: widget.color,
                    fontSize: 18.0,
                  ),
                ),
              ],
            ),
          ),
          children: widget.childs != null && widget.childs!.isNotEmpty
              ? [
                  ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: widget.childs!.length,
                      itemBuilder: (ctx, i) {
                        return GuideExpansionTile(
                          me: widget.childs![i],
                          //     leadingText: '*',
                          childs: widget.childs![i].steps,
                          isIconOutlined: !widget.isIconOutlined,
                        );
                      }),
                ]
              : [],
        ),
      ],
    );
  }
}
