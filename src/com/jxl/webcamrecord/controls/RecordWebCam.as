package com.jxl.webcamrecord.controls
{
    import com.jxl.webcamrecord.constants.*;
    import flash.display.*;
    import flash.events.*;
    import flash.media.*;
    import flash.net.*;
    import mx.binding.*;
    import mx.containers.*;
    import mx.controls.*;
    import mx.core.*;
    import mx.events.*;
    import mx.states.*;
    import spark.components.*;

    public class RecordWebCam extends Group implements IStateClient2
    {
        public var _RecordWebCam_Form1:Form;
        private var _1904476342dudeForm:Form;
        private var _979950697videoNameTextInput:TextInput;
        private var __moduleFactoryInitialized:Boolean = false;
        private var _currentCamera:Camera;
        private var currentCameraDirty:Boolean = false;
        private var _currentMicrophone:Microphone;
        private var currentMicrophoneDirty:Boolean = false;
        private var microphoneTimer:Sprite;
        private var netConnection:NetConnection;
        private var netStream:NetStream;

        public function RecordWebCam()
        {
            this.width = 274;
            this.height = 136;
            this.mxmlContent = [];
            this.currentState = "main_state";
            var _loc_1:* = new DeferredInstanceFromFunction(this._RecordWebCam_Form1_i);
            var _loc_2:* = new DeferredInstanceFromFunction(this._RecordWebCam_Form2_i);
            states = [new State({name:"main_state", overrides:[new AddItems().initializeFromObject({itemsFactory:_loc_1, destination:null, propertyName:"mxmlContent", position:"first"})]}), new State({name:"recording_state", overrides:[new AddItems().initializeFromObject({itemsFactory:_loc_2, destination:null, propertyName:"mxmlContent", position:"first"})]})];
            return;
        }// end function

        override public function set moduleFactory(param1:IFlexModuleFactory) : void
        {
            super.moduleFactory = param1;
            if (this.__moduleFactoryInitialized)
            {
                return;
            }
            this.__moduleFactoryInitialized = true;
            return;
        }// end function

        override public function initialize() : void
        {
            super.initialize();
            return;
        }// end function

        public function get currentCamera() : Camera
        {
            return this._currentCamera;
        }// end function

        public function set currentCamera(param1:Camera) : void
        {
            this._currentCamera = param1;
            this.currentCameraDirty = true;
            invalidateProperties();
            return;
        }// end function

        public function get currentMicrophone() : Microphone
        {
            return this._currentMicrophone;
        }// end function

        public function set currentMicrophone(param1:Microphone) : void
        {
            this._currentMicrophone = param1;
            this.currentMicrophoneDirty = true;
            invalidateProperties();
            return;
        }// end function

        override protected function commitProperties() : void
        {
            super.commitProperties();
            if (this.currentCameraDirty)
            {
                this.currentCameraDirty = false;
                if (this.netStream)
                {
                    this.netStream.attachCamera(this._currentCamera);
                }
            }
            if (this.currentMicrophoneDirty)
            {
                this.currentMicrophoneDirty = false;
                if (this.netStream)
                {
                    this.netStream.attachAudio(this._currentMicrophone);
                }
            }
            return;
        }// end function

        private function onStartRecording() : void
        {
            try
            {
                currentState = "recording_state";
                validateNow();
                this.createNetConnection();
                if (this.netConnection.connected == false)
                {
                    this.netConnection.connect(Constants.RMTP_SERVER_URL);
                }
                else
                {
                    this.recordStream();
                }
            }
            catch (err:Error)
            {
                Debug.error("RecordWebCam::onStartRecording: " + err);
                currentState = "main_state";
            }
            return;
        }// end function

        private function createNetConnection() : void
        {
            if (this.netConnection == null)
            {
                this.netConnection = new NetConnection();
                this.netConnection.client = {};
                this.netConnection.addEventListener(AsyncErrorEvent.ASYNC_ERROR, this.onNetConnectionError);
                this.netConnection.addEventListener(IOErrorEvent.IO_ERROR, this.onNetConnectionError);
                this.netConnection.addEventListener(SecurityErrorEvent.SECURITY_ERROR, this.onNetConnectionError);
                this.netConnection.addEventListener(NetStatusEvent.NET_STATUS, this.onNetConnectionStatus);
            }
            return;
        }// end function

        private function onNetConnectionError(event:Event) : void
        {
            Debug.error("RecordWebCam::onNetConnectionError: " + event);
            currentState = "main_state";
            return;
        }// end function

        private function onNetConnectionStatus(event:NetStatusEvent) : void
        {
            Debug.log("RecordWebCam::onNetConnetionStatus: " + event.info.code);
            if (event.info.code == "NetConnection.Connect.Success")
            {
                this.recordStream();
            }
            return;
        }// end function

        private function recordStream() : void
        {
            this.createNetStream();
            this.netStream.publish(this.videoNameTextInput.text, "live");
            return;
        }// end function

        private function createNetStream() : void
        {
            if (this.netStream == null)
            {
                this.netStream = new NetStream(this.netConnection);
                this.netStream.client = {};
                this.netStream.addEventListener(AsyncErrorEvent.ASYNC_ERROR, this.onNetStreamError);
                this.netStream.addEventListener(IOErrorEvent.IO_ERROR, this.onNetStreamError);
                this.netStream.addEventListener(NetStatusEvent.NET_STATUS, this.onNetStreamStatus);
                this.netStream.attachAudio(this.currentMicrophone);
                this.netStream.attachCamera(this.currentCamera);
            }
            return;
        }// end function

        private function onNetStreamError(event:Event) : void
        {
            Debug.error("RecordWebCam::onNetStreamError: " + event);
            currentState = "main_state";
            return;
        }// end function

        private function onNetStreamStatus(event:NetStatusEvent) : void
        {
            Debug.log("RecordWebCam::onNetStreamStatus: " + event.info.code);
            return;
        }// end function

        private function onFinishedRecording() : void
        {
            this.netStream.close();
            currentState = "main_state";
            return;
        }// end function

        private function _RecordWebCam_Form1_i() : Form
        {
            var temp:* = new Form();
            temp.x = 10;
            temp.y = 10;
            temp.id = "_RecordWebCam_Form1";
            if (!temp.document)
            {
                temp.document = this;
            }
            mx_internal::_documentDescriptor = new UIComponentDescriptor({type:Form, id:"_RecordWebCam_Form1", propertiesFactory:function () : Object
            {
                return {childDescriptors:[new UIComponentDescriptor({type:FormItem, propertiesFactory:function () : Object
                {
                    return {label:"Name:", childDescriptors:[new UIComponentDescriptor({type:TextInput, id:"videoNameTextInput"})]};
                }// end function
                }), new UIComponentDescriptor({type:FormItem, propertiesFactory:function () : Object
                {
                    return {childDescriptors:[new UIComponentDescriptor({type:Button, events:{click:"___RecordWebCam_Button1_click"}, propertiesFactory:function () : Object
                    {
                        return {label:"Record", width:146, height:37};
                    }// end function
                    })]};
                }// end function
                })]};
            }// end function
            });
            mx_internal::_documentDescriptor.document = this;
            this._RecordWebCam_Form1 = temp;
            BindingManager.executeBindings(this, "_RecordWebCam_Form1", this._RecordWebCam_Form1);
            return temp;
        }// end function

        public function ___RecordWebCam_Button1_click(event:MouseEvent) : void
        {
            this.onStartRecording();
            return;
        }// end function

        private function _RecordWebCam_Form2_i() : Form
        {
            var temp:* = new Form();
            temp.x = 10;
            temp.y = 10;
            temp.id = "dudeForm";
            if (!temp.document)
            {
                temp.document = this;
            }
            mx_internal::_documentDescriptor = new UIComponentDescriptor({type:Form, id:"dudeForm", propertiesFactory:function () : Object
            {
                return {childDescriptors:[new UIComponentDescriptor({type:FormItem, propertiesFactory:function () : Object
                {
                    return {childDescriptors:[new UIComponentDescriptor({type:ProgressBar, propertiesFactory:function () : Object
                    {
                        return {label:"Recording...", indeterminate:true};
                    }// end function
                    })]};
                }// end function
                }), new UIComponentDescriptor({type:FormItem, propertiesFactory:function () : Object
                {
                    return {childDescriptors:[new UIComponentDescriptor({type:Button, events:{click:"___RecordWebCam_Button2_click"}, propertiesFactory:function () : Object
                    {
                        return {label:"Finished", width:200, height:38};
                    }// end function
                    })]};
                }// end function
                })]};
            }// end function
            });
            mx_internal::_documentDescriptor.document = this;
            this.dudeForm = temp;
            BindingManager.executeBindings(this, "dudeForm", this.dudeForm);
            return temp;
        }// end function

        public function ___RecordWebCam_Button2_click(event:MouseEvent) : void
        {
            this.onFinishedRecording();
            return;
        }// end function

        public function get dudeForm() : Form
        {
            return this._1904476342dudeForm;
        }// end function

        public function set dudeForm(param1:Form) : void
        {
            var _loc_2:* = this._1904476342dudeForm;
            if (_loc_2 !== param1)
            {
                this._1904476342dudeForm = param1;
                if (this.hasEventListener("propertyChange"))
                {
                    this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "dudeForm", _loc_2, param1));
                }
            }
            return;
        }// end function

        public function get videoNameTextInput() : TextInput
        {
            return this._979950697videoNameTextInput;
        }// end function

        public function set videoNameTextInput(param1:TextInput) : void
        {
            var _loc_2:* = this._979950697videoNameTextInput;
            if (_loc_2 !== param1)
            {
                this._979950697videoNameTextInput = param1;
                if (this.hasEventListener("propertyChange"))
                {
                    this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "videoNameTextInput", _loc_2, param1));
                }
            }
            return;
        }// end function

    }
}
