package com.jxl.webcamrecord.robotlegs.events
{
    import flash.events.*;

    public class ServiceEvent extends Event
    {
        public static const LOAD_SETTINGS_SUCCESS:String 		= "loadSettingsSuccess";
        public static const LOAD_SETTINGS_ERROR:String 			= "loadSettingsError";
        public static const LOAD_SETTINGS_CANCEL:String 		= "loadSettingsCancel";
        public static const SAVE_SETTINGS_SUCCESS:String 		= "saveSettingsSuccess";
        public static const SAVE_SETTINGS_ERROR:String 			= "saveSettingsError";
        public static const SAVE_SETTINGS_CANCEL:String 		= "saveSettingsCancel";

        public function ServiceEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false)
        {
            super(type, bubbles, cancelable);
		}

    }
}
