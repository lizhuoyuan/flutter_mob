package zy.li.fluttermob;

import com.mob.MobSDK;

import io.flutter.app.FlutterApplication;

public class CustomApplication extends FlutterApplication {
    @Override
    public void onCreate() {
        super.onCreate();
//初始化MobSDK
        MobSDK.init(this);
    }


}