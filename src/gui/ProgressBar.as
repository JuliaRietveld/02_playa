package gui
{
	import flash.display.Sprite;
	import flash.filters.DropShadowFilter;
	
	public class ProgressBar extends Sprite
	{
		private var _bar:Sprite;
		
		public function ProgressBar()
		{
			super();
			
			_bar = new Sprite();
			_bar.graphics.beginFill(0xD2D2D2,1);
			_bar.graphics.drawRect(0, 0, 1, 6);
			_bar.graphics.endFill();
			addChild(_bar);
		
			this.filters=[new DropShadowFilter(0,20,0xCCCCCC,0.5,12,12,1,1,
												false,false,false)];
		}
        public function grawBar(distance:Number):void
		{
			width = distance * 960;
		}
	}
}