package com.jxl.webcamrecord.events
{
    import com.jxl.webcamrecord.vo.*;
    
    import flash.events.*;
    import flash.media.*;

    public class ConfigureWebCamEvent extends Event
    {
		public static const SELECTED_CAMERA_CHANGED:String 		= "selectedCameraChanged";
		public static const SELECTED_MICROPHONE_CHANGED:String 	= "selectedMicrophoneChanged";
		public static const SAVE_SETTINGS:String 				= "saveSettings";
		public static const LOAD_SETTINGS:String 				= "loadSettings";
		
        public var camera:Camera;
        public var microphone:Microphone;
        public var settings:SettingsVO;
		
        

        public function ConfigureWebCamEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false)
        {
            super(type, bubbles, cancelable);
		}
		
        override public function clone() : Event
        {
            var event:ConfigureWebCamEvent 			= new ConfigureWebCamEvent(type, bubbles, cancelable);
			event.camera 							= camera;
			event.microphone 						= microphone;
            return event;
		}

    }
}
