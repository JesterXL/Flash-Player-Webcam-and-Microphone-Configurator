package com.jxl.webcamrecord.vo
{

    public class CameraSettingsVO extends Object
    {
        public var cameraName:String;
        public var keyframeInterval:int;
        public var width:int;
        public var height:int;
        public var fps:Number;
        public var favorArea:Boolean = false;
        public var motionLevel:int;
        public var motionTimeout:int;
        public var bandwidth:int;
        public var quality:int;

        public function CameraSettingsVO()
        {
            return;
        }// end function

    }
}
