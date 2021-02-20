import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:school_wall_app/components/my_alert_dialog.dart';
import 'package:school_wall_app/components/my_button.dart';
import 'package:school_wall_app/myenum/type_enum.dart';
import 'package:school_wall_app/utils/http_request.dart';
import 'package:school_wall_app/utils/type_util.dart';
import 'package:school_wall_app/utils/uuid_util.dart';
import 'package:school_wall_app/views/publish/components/publish_others_picture.dart';
import 'package:school_wall_app/views/publish/components/text_form_field.dart';

class PublishOthers extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    int typeIndex = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(title: Text("发布 ${obtainTypeNameByTypeIndex(typeIndex)}")),
      body: PublishOthersContent(typeIndex),
    );
  }
}

class PublishOthersContent extends StatefulWidget {
   final int typeIndex;

  PublishOthersContent(this.typeIndex);

  @override
  _PublishOthersContentState createState() => _PublishOthersContentState();
}

class _PublishOthersContentState extends State<PublishOthersContent> {

   TextEditingController _titleEditingController = TextEditingController();
   TextEditingController _heightEditingController = TextEditingController();
   TextEditingController _weightEditingController = TextEditingController();
   TextEditingController _specialityEditingController = TextEditingController();
   TextEditingController _interestEditingController = TextEditingController();
   TextEditingController _descriptionEditingController = TextEditingController();
   TextEditingController _msgEditingController = TextEditingController();

   GlobalKey _formKey= GlobalKey<FormState>();

   String _id;
   bool _isAnonymous;
   PublishOthersPicture picturesWidget;

   @override
   void initState() {
     _id = uuid();
     _isAnonymous = false;
     picturesWidget  = PublishOthersPicture(id: _id, typeId: widget.typeIndex);
   }

   @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
      child: Form(
        key: _formKey,
        child: ListView(children: _buildWidgetsOfForm()),
      ),
    );
  }

  List<Widget> _buildWidgetsOfForm() {
    List<Widget> widgets = [];

    Function validatorFunc = (value) => value.length > 0 ? null : "请填写内容";
    String textOfTitleTextFormField = widget.typeIndex == TypeEnum.LOST_AND_FOUND_4.index ? "物品名" : "主题";

    if (widget.typeIndex == TypeEnum.SINGLE_6.index) {
      _buildWidgetsOfSingleForm(widgets);
    } else {
      TextFormField titleTextFormField =
          buildTextFormField(_titleEditingController, textOfTitleTextFormField, validatorFunc: validatorFunc);
      widgets.add(titleTextFormField);
    }

    TextFormField descriptionTextFormField =
      buildTextFormField(_descriptionEditingController, "具体的内容",
          maxLength: 300, maxLines: 4, validatorFunc: validatorFunc);
    widgets.add(descriptionTextFormField);

    _buildMsgWidgetForTypeSingleOrLostAndFound(widgets, validtorFunc: validatorFunc);

    widgets.add(picturesWidget);

    widgets.add(_buildAnonymousButton());

    widgets.add(myButton("发布", _processDataOfForm));

    return widgets;
  }

  Widget _buildAnonymousButton() {
    return Row(
      children: <Widget>[
        Text("匿名："),
        Radio(
          value: true,
          groupValue: _isAnonymous,
          onChanged: (value) => setState(() => _isAnonymous = true)
        ),
        SizedBox(width: 20),
        Text("不匿名："),
        Radio(
          value: false,
          groupValue: _isAnonymous,
          onChanged: (value) => setState(() => _isAnonymous = false)
        )
      ],
    );
  }


  void _buildWidgetsOfSingleForm(List<Widget> widgets) {
    //    TextFormField heightTextFormField = widget.typeIndex == TypeEnum.SINGLE_6.index ?
    //        buildTextFormField(_heightEditingController, "身高", validatorFunc: null) : null;
    //    TextFormField weightTextFormField = widget.typeIndex == TypeEnum.SINGLE_6.index ?
    //        buildTextFormField(_weightEditingController, "体重", validatorFunc: null) : null;
    TextFormField specialityTextFormField =
        buildTextFormField(_specialityEditingController, "特长",
            maxLength: 50, maxLines: 2, validatorFunc: null);
    TextFormField interestTextFormField =
        buildTextFormField(_interestEditingController, "兴趣",
            maxLength: 50, maxLines: 2, validatorFunc: null);
    widgets.add(specialityTextFormField);
    widgets.add(interestTextFormField);
  }

   void _buildMsgWidgetForTypeSingleOrLostAndFound(List<Widget> widgets, {Function validtorFunc = null}) {
     if (widget.typeIndex == TypeEnum.LOST_AND_FOUND_4.index) {
       TextFormField titleTextFormField =
          buildTextFormField(_msgEditingController, "认领信息", maxLength: 20, validatorFunc: validtorFunc);
       widgets.add(titleTextFormField);
     }
     if (widget.typeIndex == TypeEnum.SINGLE_6.index) {
       TextFormField titleTextFormField =
          buildTextFormField(_msgEditingController, "联系方式", maxLength: 20, validatorFunc: null);
       widgets.add(titleTextFormField);
     }
   }

   void _processDataOfForm() async {
     if (!(_formKey.currentState as FormState).validate()) {
       return;
     }

     _deliverToServerAndObtainResponse().then((resultMap) => {
       if (resultMap["data"]) {
         showAlertDialog(context, resultMap["msg"],
             showCancel: false, funcOfSureButton: () => Navigator.pop(context))
       } else {
         showAlertDialog(context, resultMap["msg"],
             showCancel: false, funcOfSureButton: null)
       }
     });
   }

   Future<Map<String, dynamic>> _deliverToServerAndObtainResponse() async {
     return picturesWidget.obtainPictures().then((pictures) async {
       Map<String, dynamic> params = {
         "id": _id,
         "typeId": widget.typeIndex,
         "title": _titleEditingController.text,
         "height": _heightEditingController.text,
         "weight": _weightEditingController.text,
         "speciality": _specialityEditingController.text,
         "interest": _interestEditingController.text,
         "description": _descriptionEditingController.text,
         "msg": _msgEditingController.text,
         "pictureNum": pictures.length,
         "anonymous": _isAnonymous,
         "pictures": pictures
       };
       String result = await HttpRequest.request("/login/others/publish", method: "post", params: params);
       return json.decode(result);
     });
   }
}
