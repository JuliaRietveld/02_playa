package gui
{
	import flash.display.Sprite;
	import flash.filters.DropShadowFilter;
	
	public class Button extends Sprite
	{
		private var _buttonBody:Sprite;
		
		public function Button()
		{
			super();
			_buttonBody = new Sprite();
			draw();
     		addChild(_buttonBody);
			
			this.filters=[new DropShadowFilter(0,20,0xCCCCCC,0.5,12,12,1,1,
						false,false,false)];
			
		}
	  protected function draw():void
		{
		     graphics.clear();
		     graphics.beginFill(0xD2D2D2,1);
		     graphics.lineStyle(1, 0xD2D2D2);
	     	 graphics.moveTo(0,22);
			 graphics.lineTo(22, 0);
			 graphics.lineTo(0, -22);
	         graphics.endFill();
		}
	}
}