package slides
{
	import fl.video.FLVPlayback;
	import fl.video.VideoEvent;
	
	import flash.display.Sprite;
	import flash.events.Event;
	
	import events.SlideEvent;
	
	public class VideoSlide extends SlideBase
	{
		private var _video: FLVPlayback;
		private var _videourl:String;
		private var _container:Sprite;
		
		public function VideoSlide(url:String)
		{
			super(url);
			
			_container=new Sprite();
			addChild(_container);
			
			_videourl=url;
			_video = new FLVPlayback();
			_video.load(_videourl);
			_container.addChild(_video);
			
			_video.addEventListener(VideoEvent.COMPLETE, handleComplete);
			
		}
		override public function get progress(): Number
		{
			return _video.playheadTime / _video.totalTime;
		}
		override public function activate(): void
		{
			this.visible = true;
		_video.play();
		}		
		override public function deactivate(): void
		{
			this.visible = false;
			_video.stop();
		}		
		protected function handleComplete(event: VideoEvent): void
		{
			complete();
		}
	}
}