package com.jxl.coreplay.core
{
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;
    import flash.media.*;
    import flash.net.*;
    import flash.utils.*;
    import mx.core.*;

    public class UIVideo extends UIComponent
    {
        protected var _video:Video;
        protected var _maintainAspectRatio:Boolean = true;
        protected var videoDebugOutline:Shape;
        protected var _showDebugVideoOutline:Boolean = false;
		
        private var _sizeToVideo:Boolean = false;
        private var sizeToVideoDirty:Boolean = false;
        private var videoTimer:Timer;
        private var sizeChanged:Boolean = true;
        private var lastSize:Rectangle;
        private var streamToAttach:NetStream;
        private var cameraToAttach:Camera;

        public function UIVideo() : void
        {
			super();
			init();
		}
		
		private function init():void
		{
			width = 320;
			height = 240;
		}

        public function get video() : Video
        {
            return _video;
		}

        public function get showDebugVideoOutline() : Boolean
        {
            return _showDebugVideoOutline;
        }

        public function set showDebugVideoOutline(value:Boolean) : void
        {
            _showDebugVideoOutline = value;
            invalidateSize();
		}
		
        public function get maintainAspectRatio() : Boolean
        {
            return _maintainAspectRatio;
        }

        public function set maintainAspectRatio(param1:Boolean) : void
        {
            _maintainAspectRatio = param1;
            invalidateSize();
		}
		
        public function get sizeToVideo() : Boolean
        {
            return _sizeToVideo;
        }

        public function set sizeToVideo(value:Boolean) : void
        {
            _sizeToVideo = value;
            sizeToVideoDirty = true;
            invalidateProperties();
		}
		
        override protected function createChildren() : void
        {
            super.createChildren();
            
			_video = new Video();
            _video.smoothing = false;
            addChild(_video);
			
            if (streamToAttach)
            {
                attachNetStream(streamToAttach);
                streamToAttach = null;
            }
            if (cameraToAttach)
            {
                _video.attachCamera(cameraToAttach);
                cameraToAttach = null;
            }
		}

        override protected function commitProperties() : void
        {
            super.commitProperties();
            if (sizeToVideoDirty)
            {
                sizeToVideoDirty = false;
                if (_sizeToVideo)
                {
                    startVideoWatcher();
                }
                else
                {
                    stopVideoWatcher();
                }
            }
		}
		
        override protected function updateDisplayList(unscaledWidth:Number, unscaledHeight:Number) : void
        {
            super.updateDisplayList(unscaledWidth, unscaledHeight);
			
            if (_video.videoWidth == 0 || _video.videoHeight == 0)
            {
                _video.width = width;
                _video.height = height;
                drawOutlines();
                return;
            }
			
			var vidWidth:Number;
			var vidHeight:Number;
            if (_sizeToVideo == false)
            {
                if (_maintainAspectRatio == true)
                {
                    if (_video.videoWidth >= _video.videoHeight)
                    {
						vidWidth = _video.videoWidth / _video.videoHeight;
                        vidHeight = Math.min(width / vidWidth, height);
                        if (vidHeight <= height)
                        {
                            _video.width = width;
                            _video.height = vidHeight;
                        }
                        else
                        {
                            _video.width = vidWidth * height;
                            _video.height = height;
                        }
                    }
                    else
                    {
                        vidWidth = _video.videoHeight / _video.videoWidth;
                        vidHeight = Math.min(height / vidWidth, width);
                        if (vidHeight <= width)
                        {
							// TODO: I can't remember what value this was,
							// the decompiler use some _loc3_ crap which isn't
							// helpful; confirm this still works.
                            _video.width = vidHeight;
                            _video.height = height;
                        }
                        else
                        {
                            _video.width = width;
                            _video.height = vidWidth * width;
                        }
                    }
                }
                else
                {
                    _video.width = width;
                    _video.height = height;
                }
            }
            drawOutlines();
		}
		
        private function drawOutlines() : void
        {
            var g:* = graphics;
            g.clear();
            g.lineStyle(0, 3342336);
            g.drawRect(_video.x, _video.y, _video.width, _video.height);
            g.moveTo(_video.x, _video.y);
            g.lineTo(_video.x + _video.width, _video.y + _video.height);
            g.moveTo(_video.x + _video.width, _video.y);
            g.lineTo(_video.x, _video.y + _video.height);
            g.endFill();
			
            drawDebugVideoOutline();
		}

        protected function drawDebugVideoOutline() : void
        {
            var g:Graphics;
            if (_showDebugVideoOutline == true)
            {
                if (videoDebugOutline == null)
                {
                    videoDebugOutline = new Shape();
                    addChild(videoDebugOutline);
                    setChildIndex(videoDebugOutline, (numChildren - 1));
                }
                g = videoDebugOutline.graphics;
                g.clear();
                g.lineStyle(4, 16711680);
                g.drawRect(_video.x, _video.y, _video.videoWidth, _video.videoHeight);
                g.lineStyle(2, 255);
                g.drawRect(_video.x, _video.y, _video.width, _video.height);
                g.endFill();
            }
            else if (videoDebugOutline != null)
            {
                videoDebugOutline.graphics.clear();
                if (contains(videoDebugOutline) == true)
                {
                    removeChild(videoDebugOutline);
                }
                videoDebugOutline = null;
            }
		}

        public function attachNetStream(stream:NetStream) : void
        {
            if (_video)
            {
                _video.attachNetStream(stream);
            }
            else
            {
                streamToAttach = stream;
            }
		}

        public function attachCamera(cam:Camera) : void
        {
            if (_video)
            {
                _video.attachCamera(cam);
                if (cam == null)
                {
                    _video.clear();
                }
            }
            else
            {
                cameraToAttach = cam;
            }
		}

        private function startVideoWatcher() : void
        {
            if (videoTimer == null)
            {
                videoTimer = new Timer(1000);
                videoTimer.addEventListener(TimerEvent.TIMER, onTick, false, 0, true);
            }
            videoTimer.reset();
            videoTimer.start();
		}
		
        private function stopVideoWatcher() : void
        {
            if (videoTimer)
            {
                videoTimer.stop();
                videoTimer.removeEventListener(TimerEvent.TIMER, onTick);
                videoTimer = null;
            }
		}

        private function onTick(event:TimerEvent) : void
        {
            if (lastSize == null)
            {
                lastSize = new Rectangle(0, 0, _video.videoWidth, _video.videoHeight);
                sizeChanged = true;
            }
            else if (lastSize.width != _video.videoWidth || lastSize.height != _video.videoHeight)
            {
                lastSize.width = _video.videoWidth;
                lastSize.height = _video.videoHeight;
                sizeChanged = true;
            }
            else
            {
                sizeChanged = false;
            }
			
            if (sizeChanged)
            {
                sizeChanged = false;
                width = _video.videoWidth;
                height = _video.videoHeight;
                _video.width = _video.videoWidth;
                _video.height = _video.videoHeight;
            }
		}

    }
}
