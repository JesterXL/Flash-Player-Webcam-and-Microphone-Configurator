package com.jxl.webcamrecord.robotlegs.services
{
    import com.adobe.serialization.json.*;
    import com.jxl.webcamrecord.robotlegs.events.*;
    import com.jxl.webcamrecord.vo.*;
    import flash.events.*;
    import flash.net.*;

    public class SaveSettingsService extends EventDispatcher
    {
        private var settingsFileReference:FileReference;

        public function SaveSettingsService()
        {
			super();
		}

        public function saveSettings(settings:SettingsVO) : void
        {
            if (settingsFileReference == null)
            {
                settingsFileReference = new FileReference();
                settingsFileReference.addEventListener(Event.CANCEL, onCancelSavefSettings);
                settingsFileReference.addEventListener(IOErrorEvent.IO_ERROR, onSaveSettingsError);
                settingsFileReference.addEventListener(SecurityErrorEvent.SECURITY_ERROR, onSaveSettingsError);
                settingsFileReference.addEventListener(Event.COMPLETE, onSaveSettingsFileComplete);
            }
            var settingsJSON:* = JSON.encode(settings);
			
            try
            {
                settingsFileReference.save(settingsJSON, "settings.cms");
            }
            catch (err:Error)
            {
                Debug.error("SaveSettingsService::saveSettings: " + err);
                destroy();
                dispatchEvent(new ServiceEvent(ServiceEvent.SAVE_SETTINGS_ERROR));
            }
		}

        private function onCancelSavefSettings(event:Event) : void
        {
            destroy();
            dispatchEvent(new ServiceEvent(ServiceEvent.SAVE_SETTINGS_CANCEL));
		}

        private function onSaveSettingsError(event:Event) : void
        {
            Debug.error("SaveSettingsService::onLoadSettingsError: " + event);
            destroy();
            dispatchEvent(new ServiceEvent(ServiceEvent.SAVE_SETTINGS_ERROR));
		}

        private function onSaveSettingsFileComplete(event:Event) : void
        {
            destroy();
            dispatchEvent(new ServiceEvent(ServiceEvent.SAVE_SETTINGS_SUCCESS));
		}

        private function destroy() : void
        {
            if (settingsFileReference)
            {
                settingsFileReference.removeEventListener(Event.CANCEL, onCancelSavefSettings);
                settingsFileReference.removeEventListener(IOErrorEvent.IO_ERROR, onSaveSettingsError);
                settingsFileReference.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, onSaveSettingsError);
                settingsFileReference.removeEventListener(Event.COMPLETE, onSaveSettingsFileComplete);
                settingsFileReference = null;
            }
		}

    }
}
