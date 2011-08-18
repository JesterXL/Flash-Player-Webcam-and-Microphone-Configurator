package com.jxl.webcamrecord.robotlegs.contexts
{
	import com.jxl.webcamrecord.controls.ConfigureWebCam2;
	import com.jxl.webcamrecord.controls.MainView2;
	import com.jxl.webcamrecord.events.ConfigureWebCamEvent;
	import com.jxl.webcamrecord.robotlegs.commands.LoadHardwareCommand;
	import com.jxl.webcamrecord.robotlegs.commands.UpdateCurrentCameraCommand;
	import com.jxl.webcamrecord.robotlegs.commands.UpdateCurrentMicrophoneCommand;
	import com.jxl.webcamrecord.robotlegs.events.HardwareEvent;
	import com.jxl.webcamrecord.robotlegs.mediators.ConfigureWebCamMediator;
	import com.jxl.webcamrecord.robotlegs.mediators.MainViewMediator;
	import com.jxl.webcamrecord.robotlegs.models.HardwareModel;
	
	import flash.display.DisplayObjectContainer;
	
	import org.robotlegs.mvcs.Context;


    public class MainContext extends Context
    {

        public function MainContext(app:DisplayObjectContainer = null, iForget:Boolean = true)
        {
            super(app, iForget);
		}

        override public function startup() : void
        {
            injector.mapSingleton(HardwareModel);
            
			commandMap.mapEvent(HardwareEvent.LOAD_HARDWARE, LoadHardwareCommand, HardwareEvent);
            commandMap.mapEvent(ConfigureWebCamEvent.SELECTED_CAMERA_CHANGED, UpdateCurrentCameraCommand, ConfigureWebCamEvent);
            commandMap.mapEvent(ConfigureWebCamEvent.SELECTED_MICROPHONE_CHANGED, UpdateCurrentMicrophoneCommand, ConfigureWebCamEvent);
            
			mediatorMap.mapView(MainView2, MainViewMediator);
            mediatorMap.mapView(ConfigureWebCam2, ConfigureWebCamMediator);
            
			dispatchEvent(new HardwareEvent(HardwareEvent.LOAD_HARDWARE));
         
			super.startup();
		}
    }
}
