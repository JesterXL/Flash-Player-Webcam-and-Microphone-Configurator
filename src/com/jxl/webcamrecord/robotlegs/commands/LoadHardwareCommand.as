package com.jxl.webcamrecord.robotlegs.commands
{
    import com.jxl.webcamrecord.robotlegs.models.*;
    
    import flash.media.*;
    import flash.system.Capabilities;
    import flash.system.System;
    
    import mx.collections.*;
    
    import org.robotlegs.mvcs.*;

    public class LoadHardwareCommand extends Command
    {
		[Inject]
        public var hardwareModel:HardwareModel;

        public function LoadHardwareCommand()
        {
			super();
		}

        override public function execute() : void
        {
			// TODO: reload hardware, forget the method
			
            if (hardwareModel.cameras)
            	hardwareModel.cameras.removeAll();
            
            hardwareModel.cameras = new ArrayCollection(Camera.names);
            
			if (hardwareModel.microphones)
                hardwareModel.microphones.removeAll();
            
            hardwareModel.microphones = new ArrayCollection(Microphone.names);
		}
    }
}
