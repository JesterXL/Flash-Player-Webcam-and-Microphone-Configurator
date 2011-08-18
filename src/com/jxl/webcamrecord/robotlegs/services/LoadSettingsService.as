package com.jxl.webcamrecord.robotlegs.services
{
    import com.adobe.serialization.json.*;
    import com.jxl.webcamrecord.robotlegs.events.*;
    import com.jxl.webcamrecord.vo.*;
    import flash.events.*;
    import flash.net.*;

    public class LoadSettingsService extends EventDispatcher
    {
        private var settingsFileReference:FileReference;
        private var settingsFileFilter:FileFilter;
		
        public var loadedSettings:SettingsVO;

        public function LoadSettingsService()
        {
			super();
		}

        public function loadSettingsFile() : void
        {
            if (settingsFileReference == null)
            {
                settingsFileReference = new FileReference();
                settingsFileReference.addEventListener(Event.CANCEL, onCancelLoadSettings);
                settingsFileReference.addEventListener(Event.SELECT, onLoadSettingsFileSelected);
                settingsFileReference.addEventListener(IOErrorEvent.IO_ERROR, onLoadSettingsError);
                settingsFileReference.addEventListener(SecurityErrorEvent.SECURITY_ERROR, onLoadSettingsError);
                settingsFileReference.addEventListener(Event.COMPLETE, onLoadSettingsFileComplete);
            }
			
            if (settingsFileFilter == null)
            	settingsFileFilter = new FileFilter("Camera Microphone Configuration", "*.cms;*.json;", "cms");
            
            try
            {
                settingsFileReference.browse([settingsFileFilter]);
            }
            catch (err:Error)
            {
                Debug.error("ConfigureWebCam::onLoadSettings: " + err);
                destroy();
                dispatchEvent(new ServiceEvent(ServiceEvent.LOAD_SETTINGS_ERROR));
            }
		}

        private function onCancelLoadSettings(event:Event) : void
        {
            destroy();
            dispatchEvent(new ServiceEvent(ServiceEvent.LOAD_SETTINGS_CANCEL));
		}

        private function onLoadSettingsFileSelected(event:Event) : void
        {
            try
            {
                settingsFileReference.load();
            }
            catch (err:Error)
            {
                Debug.error("ConfigureWebCam::onLoadSettingsFileSelected: " + err);
                destroy();
                dispatchEvent(new ServiceEvent(ServiceEvent.LOAD_SETTINGS_ERROR));
            }
		}

        private function onLoadSettingsError(event:Event) : void
        {
            Debug.error("ConfigureWebCam::onLoadSettingsError: " + event);
            destroy();
            dispatchEvent(new ServiceEvent(ServiceEvent.LOAD_SETTINGS_ERROR));
		}

        private function onLoadSettingsFileComplete(event:Event) : void
        {
            var jsonString:String;
            var json:Object;
            var settings:SettingsVO;
            var cameraSettings:CameraSettingsVO;
            var microphoneSettings:MicrophoneSettingsVO;
            var cameraProp:String;
            var microphoneProp:String;
			var index:int;
			
            if (settingsFileReference.data)
            {
                try
                {
                    settingsFileReference.data.position = 0;
                    jsonString = settingsFileReference.data.readUTFBytes(settingsFileReference.data.length);
                    json = JSON.decode(jsonString);
                    if (json)
                    {
                        settings = new SettingsVO();
                        if (json.cameraSettings)
                        {
                            cameraSettings = new CameraSettingsVO();
							index = 0;
                            var camSettingsObj:* = json.cameraSettings;
                            while (camSettingsObj in index)
                            {
                                
                                cameraProp = camSettingsObj[index];
                                cameraSettings[cameraProp] = json.cameraSettings[cameraProp];
                            }
                        }
						
                        if (json.microphoneSettings)
                        {
                            microphoneSettings = new MicrophoneSettingsVO();
							index = 0;
                            var micSettingsObj:* = json.microphoneSettings;
                            while (micSettingsObj in index)
                            {
                                
                                microphoneProp = micSettingsObj[index];
                                microphoneSettings[microphoneProp] = json.microphoneSettings[microphoneProp];
                            }
                        }
						
                        settings.cameraSettings = cameraSettings;
                        settings.microphoneSettings = microphoneSettings;
                        if (settings.cameraSettings || settings.microphoneSettings)
                        {
                            loadedSettings = settings;
                            destroy();
                            dispatchEvent(new ServiceEvent(ServiceEvent.LOAD_SETTINGS_SUCCESS));
                        }
                        else
                        {
                            destroy();
                            dispatchEvent(new ServiceEvent(ServiceEvent.LOAD_SETTINGS_ERROR));
                        }
                    }
                    else
                    {
                        destroy();
                        dispatchEvent(new ServiceEvent(ServiceEvent.LOAD_SETTINGS_ERROR));
                    }
                }
                catch (err:Error)
                {
                    Debug.error("LoadSettingsService::onLoadSettingsFileComplete: " + err);
                    destroy();
                    dispatchEvent(new ServiceEvent(ServiceEvent.LOAD_SETTINGS_ERROR));
                }
            }
            else
            {
                destroy();
                dispatchEvent(new ServiceEvent(ServiceEvent.LOAD_SETTINGS_ERROR));
            }
		}

        private function destroy() : void
        {
            if (settingsFileReference)
            {
                settingsFileReference.removeEventListener(Event.CANCEL, onCancelLoadSettings);
                settingsFileReference.removeEventListener(Event.SELECT, onLoadSettingsFileSelected);
                settingsFileReference.removeEventListener(IOErrorEvent.IO_ERROR, onLoadSettingsError);
                settingsFileReference.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, onLoadSettingsError);
                settingsFileReference.removeEventListener(Event.COMPLETE, onLoadSettingsFileComplete);
                settingsFileReference = null;
            }
            settingsFileFilter = null;
		}

    }
}
