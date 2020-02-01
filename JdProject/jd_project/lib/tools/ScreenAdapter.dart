import 'package:flutter_screenutil/flutter_screenutil.dart';

class ScreenUtilAdapter{
  static init(context){
    ScreenUtil.instance = ScreenUtil(width: 1080, height: 1920)..init(context);
  }
  static setHeight(double height){
    return ScreenUtil.getInstance().setHeight(height);
  }
  static setWidth(double width){
    return ScreenUtil.getInstance().setWidth(width);
  }
  static getScreenHeight(){
    return ScreenUtil.screenHeightDp;
  }
  static getScreenWidth(){
    return ScreenUtil.screenWidthDp;
  }
  static size(double value){
    return ScreenUtil.getInstance().setSp(value);
  }
}