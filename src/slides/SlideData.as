package slides
{
	public class SlideData
	{
		private var _url	:String;//SlideBase;
		private var _duration	:Number;
		private var _cover	:String;//ImageSlide;
		private var _type:String;
		
		public function SlideData(type:String, slideurl:String, duration:Number, coverurl:String)
		{
			_type=type;
			_url = slideurl;//new SlideBase(slideurl);
			_duration = duration;
			_cover  = coverurl;//new ImageSlide(coverurl);
		}
		public function get type():String
		{
			return _type;
		}
		public function get url():String//SlideBase
		{
			return _url;
		}
		
		public function get duration():Number
		{
			return _duration;
		}
		
		public function get cover():String//ImageSlide
		{
			return _cover;
		}
		

	}
}