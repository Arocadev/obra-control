package com.example.obra_control

import android.app.Application
import dev.fluttercommunity.plus.androidalarmmanager.AndroidAlarmManagerPlugin

class Application : Application() {
    override fun onCreate() {
        super.onCreate()
        AndroidAlarmManagerPlugin.setPluginRegistrantCallback { registry ->
        }
    }
}