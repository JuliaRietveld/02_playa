package slides
{
	import events.SlideEvent;
	import flash.display.Sprite;
	
	public class SlideBase extends Sprite
	{
		public function SlideBase(url:String)
		{
			super();
		}
		public function activate(): void
		{
			this.visible = true;
		}
		public function deactivate(): void
		{
			this.visible = false;
			trace('deactivate BASE');
		}
		protected function complete(): void
		{
			dispatchEvent(new SlideEvent(SlideEvent.COMPLETED));
		}
		public function get progress(): Number
		{
			return 0;
		}
	}
}