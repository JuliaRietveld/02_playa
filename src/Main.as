package
{
	import components.ImageLoader;
	
	import events.SlideEvent;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.filters.DropShadowFilter;
	
	import gui.BackButton;
	import gui.NextButton;
	import gui.ProgressBar;
	
	import slides.ImageSlide;
	import slides.SlideBase;
	import slides.SlideData;
	import slides.SoundSlide;
	import slides.VideoSlide;
	

	[SWF(width="960", height="540", frameRate="24", backgroundColor="0xFFFFFF")]
	
	public class Main extends Sprite
	{
		private var _loader:XMLLoader;
		private var _xmlPath: String = 'http://dl.dropbox.com/u/1560087/fla11/02_playa/content.xml';
		private var _progressBar: ProgressBar;
		private var _track:Sprite;
		private var _container:Sprite;
		private var _slideDataVec	:Vector.<SlideData>;
		private var _slideData:SlideData;
		private var _slideVector	:Vector.<SlideBase>;
		private var _image:ImageSlide;
		private var _video:VideoSlide;
		private var _sound:SoundSlide;
		private var _index:int=0;
	
		public function Main()
		{	
			init();			
		}
		private function init():void
		{
			this._slideDataVec = new Vector.<SlideData>();
			this._slideVector	=new Vector.<SlideBase>();
			
			this._container = new Sprite();
			this.addChild(this._container);
			this._container.x = 150;
			
			this.addProgressBar();
			this.addButtons();
			
			this._loader = new XMLLoader(_xmlPath, _slideDataVec);
			this._loader.addEventListener(XMLLoader.LOADED, onXMLLoaded_addSlides);
		}
		
		private function onXMLLoaded_addSlides(e:Event):void
		{
			for (var i:int = 0; i < _slideDataVec.length; i++) 
			{
				switch (_slideDataVec[i].type){
					case 'image':
    					var image:ImageSlide = new ImageSlide(_slideDataVec[i].url, _slideDataVec[i].duration);
						_container.addChild(image);		
						_slideVector.push(image);
						image.deactivate();
						break;
					
					case 'video':
						var video:VideoSlide = new VideoSlide(_slideDataVec[i].url);
						video.scaleX = video.scaleY = 2;
						_container.addChild(video);
						_slideVector.push(video);
						video.deactivate();
						break;
					
					case 'sound':
						var sound:SoundSlide = new SoundSlide(_slideDataVec[i].url, _slideDataVec[i].cover);
						_container.addChild(sound);
						_slideVector.push(sound);
						sound.deactivate();
						break;
				}	
			}
			this._slideVector[_index].activate();
			this.stage.addEventListener(Event.ENTER_FRAME, handleEnterFrame);
		}

		private function handleEnterFrame(e:Event):void
		{
	        _progressBar.grawBar(_slideVector[_index].progress);
			if ((_slideVector[_index].progress) >= 0.99)
				{
				handleSlideComplete(); 
			}
		}
		private function addButtons():void
		{				
			var buttonContainer:Sprite = new Sprite();
			addChild(buttonContainer);
			buttonContainer.x = 60;
			buttonContainer.y = 200;
			buttonContainer.mouseEnabled = false;		
			buttonContainer.buttonMode = true;
			
			var backButton:BackButton=new BackButton();
			buttonContainer.addChild(backButton);
			backButton.x = backButton.y = 0;
			backButton.addEventListener(MouseEvent.CLICK,onBackButtonClick);
			
			var nextButton:NextButton=new NextButton();
			buttonContainer.addChild(nextButton);
			nextButton.x = 840;
			nextButton.y = 0;
			nextButton.addEventListener(MouseEvent.CLICK,onNextButtonClick);
		}
		private function onBackButtonClick(e:MouseEvent):void
		{	
			_slideVector[_index].deactivate();	
			_index--;
			if (_index < 0)
			{
				_index=_slideVector.length-1;
			}
			_slideVector[_index].activate();
			_container.addChild(_slideVector[_index]);
		}
		private function onNextButtonClick(e:MouseEvent):void
		{	
			_slideVector[_index].deactivate();	
			_index++;
			if (_index >_slideVector.length-1)
			{
				_index = 0;
			}
			_slideVector[_index].activate();
			_container.addChild(_slideVector[_index]);
		}
	protected function handleSlideComplete():void
		{
			_slideVector[_index].deactivate();	
			_index++;
			if (_index > _slideVector.length-1)
			{
				_index=0;
			}
			_slideVector[_index].activate();
			_container.addChild(_slideVector[_index]);
		}
		private function addProgressBar():void
		{	
			_track=new Sprite();
			_track.graphics.beginFill(0x353535,1);
			_track.graphics.drawRect(0, 0, 960, 6);
			_track.graphics.endFill();
			_track.y = 536;
			addChild(_track);

			_track.filters=[new DropShadowFilter(0,20,0xCCCCCC,0.5,12,12,1,1,false,false,false)];
			
			_progressBar=new ProgressBar();
			addChild(_progressBar);
			_progressBar.y = 536;
		}
	}
}