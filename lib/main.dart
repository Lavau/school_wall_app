//flutter项目安装步骤
//点击vsCode提示的“get packages”或者在pubspec.yaml中按住control+s手动Get packages
//输入flutter pub get回车
//输入flutter packages pub run build_runner build回车
//输入flutter packages pub run build_runner build回车
//输入flutter packages pub run json_model回车
//输入keytool -genkey -v -keystore ~/key.jks -keyalg RSA -keysize 2048 -validity 10000 -alias key回车
//输入keytool -importkeystore -srckeystore /home/koishi/key.jks -destkeystore /home/koishi/key.jks -deststoretype pkcs12回车
//在hua/client/app(delivery)/android/key.properties配置密码和路径
//storePassword=你自己设置的密码
//keyPassword=还是你自己设置的密码，我反正从来都是123456
//keyAlias=key
//storeFile=key.jks在你电脑上的路径
import 'package:flutter/material.dart';
import 'app.dart';

void main() => runApp(MyApp());

