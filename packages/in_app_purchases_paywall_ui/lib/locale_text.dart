import 'package:auto_localization/auto_localization.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';

import 'lang_notifier.dart';

class LocaleText extends StatefulWidget {
   LocaleText(this.data, {this.style, this.textAlign, this.current="", this.translated=""});

   String data;
   String translated;
   String current;
   TextStyle? style;
   TextAlign? textAlign;

  @override
  State<LocaleText> createState() => _LocaleTextState();
}

class _LocaleTextState extends State<LocaleText> {

  @override
  void setState(fn) {
    if(mounted) {
      super.setState(fn);
    }
  }

  void translate(){
    if (widget.translated == ""){
       AutoLocalization.translate(widget.data).then((value) {
        setState(() {
          widget.translated = value;
        });
      });
    }
  }

  @override
  void didUpdateWidget(covariant LocaleText oldWidget) {
    if (widget.data != oldWidget.data) {
     translate();
    }
  }

  @override
  void initState() {
     translate();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(stream: context.watch<LangNotifier>().onLanguageChange,
    builder: (context, snapshot) {
      translate();
      return Visibility(visible: context.watch<LangNotifier>().isDefault,
      child: Text(widget.data, style: widget.style, textAlign: widget.textAlign,),
      replacement: Visibility(visible: widget.translated != "",
      child: Text(widget.translated, style: widget.style, textAlign: widget.textAlign,),
      replacement: LoadingAnimationWidget.staggeredDotsWave(
        color: Colors.black,
        size: 20
      ),));
    });
  }
} 

extension StringX on String {
  Future<String> translate() async {
    return await AutoLocalization.translate(this);
  }
}