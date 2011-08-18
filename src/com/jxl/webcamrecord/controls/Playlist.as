package com.jxl.webcamrecord.controls
{
    import com.jxl.coreplay.core.*;
    import com.jxl.webcamrecord.constants.*;
    import flash.display.*;
    import flash.events.*;
    import flash.net.*;
    import flash.utils.*;
    import mx.binding.*;
    import mx.collections.*;
    import mx.controls.*;
    import mx.core.*;
    import mx.events.*;
    import mx.states.*;
    import spark.components.*;

    public class Playlist extends Group implements IBindingClient, IStateClient2
    {
        public var _Playlist_Button1:Button;
        public var _Playlist_Button2:Button;
        public var _Playlist_LinkButton1:LinkButton;
        public var _Playlist_ProgressBar1:ProgressBar;
        private var _232496570bufferProgressBar:ProgressBar;
        private var _447540665uiVideo:UIVideo;
        private var _1600572394videosList:List;
        private var __moduleFactoryInitialized:Boolean = false;
        private var _816678056videos:ArrayCollection;
        private var nc:NetConnection;
        private var ns:NetStream;
        private var so:SharedObject;
        private var firstSync:Boolean = true;
        private var bufferSprite:Sprite;
        var _bindings:Array;
        var _watchers:Array;
        var _bindingsByDestination:Object;
        var _bindingsBeginWithWord:Object;
        private static var _watcherSetupUtil:IWatcherSetupUtil2;

        public function Playlist()
        {
            var target:Object;
            var watcherSetupUtilClass:Object;
            this._bindings = [];
            this._watchers = [];
            this._bindingsByDestination = {};
            this._bindingsBeginWithWord = {};
            var bindings:* = this._Playlist_bindingsSetup();
            var watchers:Array;
            target;
            if (_watcherSetupUtil == null)
            {
                watcherSetupUtilClass = getDefinitionByName("_com_jxl_webcamrecord_controls_PlaylistWatcherSetupUtil");
                var _loc_2:* = watcherSetupUtilClass;
                _loc_2.watcherSetupUtilClass["init"](null);
            }
            _watcherSetupUtil.setup(this, function (param1:String)
            {
                return target[param1];
            }// end function
            , function (param1:String)
            {
                return Playlist[param1];
            }// end function
            , bindings, watchers);
            mx_internal::_bindings = mx_internal::_bindings.concat(bindings);
            mx_internal::_watchers = mx_internal::_watchers.concat(watchers);
            this.width = 530;
            this.height = 512;
            this.currentState = "connecting_state";
            this.mxmlContent = [];
            this.addEventListener("creationComplete", this.___Playlist_Group1_creationComplete);
            var _Playlist_Button1_factory:* = new DeferredInstanceFromFunction(this._Playlist_Button1_i);
            var _Playlist_Button2_factory:* = new DeferredInstanceFromFunction(this._Playlist_Button2_i);
            var _Playlist_LinkButton1_factory:* = new DeferredInstanceFromFunction(this._Playlist_LinkButton1_i);
            var _Playlist_List1_factory:* = new DeferredInstanceFromFunction(this._Playlist_List1_i);
            var _Playlist_ProgressBar1_factory:* = new DeferredInstanceFromFunction(this._Playlist_ProgressBar1_i);
            var _Playlist_ProgressBar2_factory:* = new DeferredInstanceFromFunction(this._Playlist_ProgressBar2_i);
            var _Playlist_UIVideo1_factory:* = new DeferredInstanceFromFunction(this._Playlist_UIVideo1_i);
            states = [new State({name:"main_state", overrides:[new AddItems().initializeFromObject({itemsFactory:_Playlist_LinkButton1_factory, destination:null, propertyName:"mxmlContent", position:"first"}), new AddItems().initializeFromObject({itemsFactory:_Playlist_ProgressBar2_factory, destination:null, propertyName:"mxmlContent", position:"first"}), new AddItems().initializeFromObject({itemsFactory:_Playlist_Button2_factory, destination:null, propertyName:"mxmlContent", position:"first"}), new AddItems().initializeFromObject({itemsFactory:_Playlist_Button1_factory, destination:null, propertyName:"mxmlContent", position:"first"}), new AddItems().initializeFromObject({itemsFactory:_Playlist_UIVideo1_factory, destination:null, propertyName:"mxmlContent", position:"first"}), new AddItems().initializeFromObject({itemsFactory:_Playlist_List1_factory, destination:null, propertyName:"mxmlContent", position:"first"})]}), new State({name:"connecting_state", overrides:[new AddItems().initializeFromObject({itemsFactory:_Playlist_ProgressBar1_factory, destination:null, propertyName:"mxmlContent", position:"first"})]})];
            var i:uint;
            while (i < bindings.length)
            {
                
                Binding(bindings[i]).execute();
                i = (i + 1);
            }
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

        private function init() : void
        {
            this.nc = new NetConnection();
            this.nc.client = {};
            this.nc.addEventListener(AsyncErrorEvent.ASYNC_ERROR, this.onError);
            this.nc.addEventListener(IOErrorEvent.IO_ERROR, this.onError);
            this.nc.addEventListener(SecurityErrorEvent.SECURITY_ERROR, this.onError);
            this.nc.addEventListener(NetStatusEvent.NET_STATUS, this.onNetStatus);
            try
            {
                this.nc.connect(Constants.RMTP_SERVER_URL);
            }
            catch (err:Error)
            {
                Debug.error("Playlist::init, err: " + err);
            }
            return;
        }// end function

        private function onError(event:Event) : void
        {
            Debug.error("Playlist::onError: " + event);
            return;
        }// end function

        private function onNetStatus(event:NetStatusEvent) : void
        {
            Debug.log("Playlist::onNetStatus: " + event.info.code);
            if (event.info.code == "NetConnection.Connect.Success")
            {
                this.connectPlaylist();
            }
            return;
        }// end function

        private function connectPlaylist() : void
        {
            this.so = SharedObject.getRemote("playlist", this.nc.uri, true);
            this.so.client = {};
            this.so.addEventListener(AsyncErrorEvent.ASYNC_ERROR, this.onError);
            this.so.addEventListener(SyncEvent.SYNC, this.onSync);
            this.so.connect(this.nc);
            return;
        }// end function

        private function onSync(event:SyncEvent) : void
        {
            var _loc_2:Array = null;
            var _loc_3:String = null;
            if (this.firstSync)
            {
                this.firstSync = false;
                currentState = "main_state";
            }
            if (this.videos == null)
            {
                this.videos = new ArrayCollection();
            }
            else
            {
                this.videos.removeAll();
            }
            if (this.so.data.playlist)
            {
                _loc_2 = [];
                for (_loc_3 in this.so.data.playlist)
                {
                    
                    _loc_2.push(_loc_3);
                }
                _loc_2.sort();
                this.videos.source = _loc_2;
            }
            return;
        }// end function

        private function onPlay() : void
        {
            if (this.videosList.selectedItem == null)
            {
                return;
            }
            if (this.ns == null)
            {
                this.ns = new NetStream(this.nc);
                this.ns.client = {};
                this.ns.addEventListener(AsyncErrorEvent.ASYNC_ERROR, this.onError);
                this.ns.addEventListener(IOErrorEvent.IO_ERROR, this.onError);
                this.ns.addEventListener(NetStatusEvent.NET_STATUS, this.onNetStreamNetStatus);
                this.ns.bufferTime = 10;
                this.uiVideo.attachNetStream(this.ns);
            }
            this.ns.play(this.videosList.selectedItem as String);
            if (this.bufferSprite == null)
            {
                this.bufferSprite = new Sprite();
                this.bufferSprite.addEventListener(Event.ENTER_FRAME, this.onBufferCheck);
            }
            return;
        }// end function

        private function onStop() : void
        {
            this.ns.play(false);
            return;
        }// end function

        private function onNetStreamNetStatus(event:NetStatusEvent) : void
        {
            Debug.log("Playlist::onNetStreamNetStatus: " + event.info.code);
            return;
        }// end function

        private function onBufferCheck(event:Event) : void
        {
            this.bufferProgressBar.setProgress(this.ns.bufferLength, this.ns.bufferTime);
            this.bufferProgressBar.label = "Buffer: " + Math.round(this.ns.bufferLength) + " seconds.";
            return;
        }// end function

        private function onDelete() : void
        {
            var _loc_1:String = null;
            if (this.videosList.selectedItem != null)
            {
                _loc_1 = this.videosList.selectedItem;
                Alert.yesLabel = "Delete";
                Alert.noLabel = "No";
                Alert.show("Delete stream \'" + _loc_1 + "\'?", "Confirm Delete", Alert.NO | Alert.YES, this, this.onConfirmDelete, null, Alert.NO);
            }
            return;
        }// end function

        private function onConfirmDelete(event:CloseEvent) : void
        {
            if (event.detail == Alert.YES)
            {
                this.nc.call("deleteStreamName", null, this.videosList.selectedItem as String);
            }
            return;
        }// end function

        private function _Playlist_List1_i() : List
        {
            var _loc_1:* = new List();
            _loc_1.width = 180;
            _loc_1.bottom = 39;
            _loc_1.x = 10;
            _loc_1.top = 10;
            _loc_1.id = "videosList";
            if (!_loc_1.document)
            {
                _loc_1.document = this;
            }
            this.videosList = _loc_1;
            BindingManager.executeBindings(this, "videosList", this.videosList);
            return _loc_1;
        }// end function

        private function _Playlist_UIVideo1_i() : UIVideo
        {
            var _loc_1:* = new UIVideo();
            _loc_1.x = 198;
            _loc_1.y = 10;
            _loc_1.sizeToVideo = true;
            _loc_1.id = "uiVideo";
            if (!_loc_1.document)
            {
                _loc_1.document = this;
            }
            this.uiVideo = _loc_1;
            BindingManager.executeBindings(this, "uiVideo", this.uiVideo);
            return _loc_1;
        }// end function

        private function _Playlist_Button1_i() : Button
        {
            var _loc_1:* = new Button();
            _loc_1.x = 198;
            _loc_1.y = 331;
            _loc_1.label = "Play";
            _loc_1.addEventListener("click", this.___Playlist_Button1_click);
            _loc_1.id = "_Playlist_Button1";
            if (!_loc_1.document)
            {
                _loc_1.document = this;
            }
            this._Playlist_Button1 = _loc_1;
            BindingManager.executeBindings(this, "_Playlist_Button1", this._Playlist_Button1);
            return _loc_1;
        }// end function

        public function ___Playlist_Button1_click(event:MouseEvent) : void
        {
            this.onPlay();
            return;
        }// end function

        private function _Playlist_Button2_i() : Button
        {
            var _loc_1:* = new Button();
            _loc_1.x = 276;
            _loc_1.y = 331;
            _loc_1.label = "Stop";
            _loc_1.addEventListener("click", this.___Playlist_Button2_click);
            _loc_1.id = "_Playlist_Button2";
            if (!_loc_1.document)
            {
                _loc_1.document = this;
            }
            this._Playlist_Button2 = _loc_1;
            BindingManager.executeBindings(this, "_Playlist_Button2", this._Playlist_Button2);
            return _loc_1;
        }// end function

        public function ___Playlist_Button2_click(event:MouseEvent) : void
        {
            this.onStop();
            return;
        }// end function

        private function _Playlist_ProgressBar1_i() : ProgressBar
        {
            var _loc_1:* = new ProgressBar();
            _loc_1.x = 165;
            _loc_1.y = 174;
            _loc_1.label = "Connecting...";
            _loc_1.indeterminate = true;
            _loc_1.id = "_Playlist_ProgressBar1";
            if (!_loc_1.document)
            {
                _loc_1.document = this;
            }
            this._Playlist_ProgressBar1 = _loc_1;
            BindingManager.executeBindings(this, "_Playlist_ProgressBar1", this._Playlist_ProgressBar1);
            return _loc_1;
        }// end function

        private function _Playlist_ProgressBar2_i() : ProgressBar
        {
            var _loc_1:* = new ProgressBar();
            _loc_1.x = 198;
            _loc_1.y = 290;
            _loc_1.indeterminate = false;
            _loc_1.mode = "manual";
            _loc_1.minimum = 0;
            _loc_1.maximum = 1;
            _loc_1.id = "bufferProgressBar";
            if (!_loc_1.document)
            {
                _loc_1.document = this;
            }
            this.bufferProgressBar = _loc_1;
            BindingManager.executeBindings(this, "bufferProgressBar", this.bufferProgressBar);
            return _loc_1;
        }// end function

        private function _Playlist_LinkButton1_i() : LinkButton
        {
            var _loc_1:* = new LinkButton();
            _loc_1.x = 10;
            _loc_1.y = 481;
            _loc_1.label = "Delete";
            _loc_1.addEventListener("click", this.___Playlist_LinkButton1_click);
            _loc_1.id = "_Playlist_LinkButton1";
            if (!_loc_1.document)
            {
                _loc_1.document = this;
            }
            this._Playlist_LinkButton1 = _loc_1;
            BindingManager.executeBindings(this, "_Playlist_LinkButton1", this._Playlist_LinkButton1);
            return _loc_1;
        }// end function

        public function ___Playlist_LinkButton1_click(event:MouseEvent) : void
        {
            this.onDelete();
            return;
        }// end function

        public function ___Playlist_Group1_creationComplete(event:FlexEvent) : void
        {
            this.init();
            return;
        }// end function

        private function _Playlist_bindingsSetup() : Array
        {
            var result:Array;
            result[0] = new Binding(this, function () : IList
            {
                return videos;
            }// end function
            , null, "videosList.dataProvider");
            return result;
        }// end function

        public function get bufferProgressBar() : ProgressBar
        {
            return this._232496570bufferProgressBar;
        }// end function

        public function set bufferProgressBar(param1:ProgressBar) : void
        {
            var _loc_2:* = this._232496570bufferProgressBar;
            if (_loc_2 !== param1)
            {
                this._232496570bufferProgressBar = param1;
                if (this.hasEventListener("propertyChange"))
                {
                    this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "bufferProgressBar", _loc_2, param1));
                }
            }
            return;
        }// end function

        public function get uiVideo() : UIVideo
        {
            return this._447540665uiVideo;
        }// end function

        public function set uiVideo(param1:UIVideo) : void
        {
            var _loc_2:* = this._447540665uiVideo;
            if (_loc_2 !== param1)
            {
                this._447540665uiVideo = param1;
                if (this.hasEventListener("propertyChange"))
                {
                    this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "uiVideo", _loc_2, param1));
                }
            }
            return;
        }// end function

        public function get videosList() : List
        {
            return this._1600572394videosList;
        }// end function

        public function set videosList(param1:List) : void
        {
            var _loc_2:* = this._1600572394videosList;
            if (_loc_2 !== param1)
            {
                this._1600572394videosList = param1;
                if (this.hasEventListener("propertyChange"))
                {
                    this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "videosList", _loc_2, param1));
                }
            }
            return;
        }// end function

        private function get videos() : ArrayCollection
        {
            return this._816678056videos;
        }// end function

        private function set videos(param1:ArrayCollection) : void
        {
            var _loc_2:* = this._816678056videos;
            if (_loc_2 !== param1)
            {
                this._816678056videos = param1;
                if (this.hasEventListener("propertyChange"))
                {
                    this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "videos", _loc_2, param1));
                }
            }
            return;
        }// end function

        public static function set watcherSetupUtil(param1:IWatcherSetupUtil2) : void
        {
            Playlist._watcherSetupUtil = param1;
            return;
        }// end function

    }
}
