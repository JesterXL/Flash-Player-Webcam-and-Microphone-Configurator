package com.jxl.webcamrecord.vo
{

    public class MicrophoneSettingsVO extends Object
    {
        public var microphoneName:String;
        public var silenceLevel:Number;
        public var silenceTimeout:int;
        public var echoSuppression:Boolean;
        public var codec:String;
        public var enableVAD:Boolean = true;
        public var speexQuality:int;
        public var framesPerPacket:int;
        public var noiseSuppressionLevel:int;
        public var gain:int;
        public var rate:int;

        public function MicrophoneSettingsVO()
        {
            return;
        }// end function

    }
}
