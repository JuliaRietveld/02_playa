package 
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.net.*;
	import flash.xml.*;
	
	import slides.ImageSlide;
	import slides.SlideBase;
	import slides.SlideData;
	import slides.SoundSlide;
	import slides.VideoSlide;
	
	public class XMLLoader extends EventDispatcher
	{
		public static const LOADED	:String = 'loaded';
		
		private var _loader: URLLoader;
		private var _slideDataVec:Vector.<SlideData>;
		private var _slideData:SlideData;
		
		public function XMLLoader(xmlUrl:String, slideDataVec:Vector.<SlideData>)
		{		
			this._slideDataVec=slideDataVec;
			
			this._loader = new URLLoader(new URLRequest(xmlUrl));
			this._loader.addEventListener(Event.COMPLETE, handleComplete);
			this._loader.addEventListener(IOErrorEvent.IO_ERROR, onIOError);
		}
		protected function handleComplete(event: Event): void
		{
			var data: XML = XML(_loader.data);
			for each(var slide: XML in data.slides.slide)
			{
				switch (slide.@type.toString()){
					case 'image':
						var imageUrlString:String = new String();
						var duration:Number;					
						imageUrlString = slide.url;				
						duration = slide.duration;	
						_slideData = new SlideData('image',  imageUrlString, Number(duration), '');
						_slideDataVec.push( _slideData);
						break;
					
					case 'video':
						var videoUrlString:String = new String();			
						videoUrlString = slide.url;	
						_slideData = new SlideData( 'video', videoUrlString, 0, '' );
						_slideDataVec.push( _slideData);
						break;
					
  					case 'sound':
						var soundUrlString:String = new String();
						var coverString:String = new String();						
						soundUrlString = slide.url;				
						coverString = slide.cover;	
						_slideData =new SlideData('sound', soundUrlString, 0, coverString);
						_slideDataVec.push( _slideData);
						break;
				}
			}
			dispatchEvent( new Event(LOADED));		
		}
		private function onIOError(e:IOErrorEvent):void
		{
			this._loader.removeEventListener(Event.COMPLETE, this.handleComplete);
			this._loader.removeEventListener(IOErrorEvent.IO_ERROR, this.onIOError);
			
		}
		public function get slideDataVec(): Vector.<SlideData>
		{
			return this._slideDataVec;
		}
	}
}