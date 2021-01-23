import 'package:flutter/material.dart';
import 'package:school_wall_app/components/action_sheet.dart';
import 'package:school_wall_app/config/app_config.dart' as AppConfig;
import 'package:school_wall_app/myenum/type_enum.dart';
import 'package:school_wall_app/utils/login_util.dart' as LoginUtil;
import 'package:school_wall_app/views/publish/detail/ecard.dart';

class Publish extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("发布"),
      ),
      body: PublishContent(),
    );
  }
}

class PublishContent extends StatefulWidget {
  @override
  _PublishContentState createState() => _PublishContentState();
}

class _PublishContentState extends State<PublishContent> {

  @override
  Widget build(BuildContext context) {
    Widget publishButton = Container(
      margin: EdgeInsets.all(10),
      width: 400,
      decoration: BoxDecoration(
          border: Border.all(color: AppConfig.PRIMARY_COLOR)
      ),
      child: FlatButton(
        child: Text("我要发布"),
        onPressed: _selectTypeAction
      )
    );

    return publishButton;
  }

  _selectTypeAction() async {
    if (AppConfig.isLogin == false) {
      LoginUtil.showLoginDialog(context);
      return;
    }

    int indexNum = await showSelectTypeActionSheets(context: context, title: '发布类型');
    if (indexNum == TypeEnum.ECARD_7.index) {
      Navigator.push(context, MaterialPageRoute(builder: (context) => Ecard()));
    }
  }

  Future<int> showSelectTypeActionSheets({
    @required BuildContext context,
    @required String title,
  }) {
    return showCustomBottomSheet(
      titleColor: AppConfig.PRIMARY_COLOR,
      titleFontSize: 15,
      context: context,
      title: title,
      children: [
        actionItem(context: context, index: 4, title: '失物'),
        actionItem(context: context, index: 5, title: '求助'),
        actionItem(context: context, index: 6, title: '脱单'),
        actionItem(context: context, index: 1, title: '宣传栏'),
        actionItem(context: context, index: 7, title: '一卡通'),
        actionItem(context: context, index: 3, title: '感谢 / 吐槽', isLastOne: true),
      ]
    );
  }
}