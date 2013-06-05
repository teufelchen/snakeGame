<%@ Page Language="vb" AutoEventWireup="false" Codebehind="WebForm1.aspx.vb" Inherits="SnakeGame.WebForm1"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
	<HEAD>
		<script type="text/javascript">

				function $(id){
					return document.getElementById(id);
				}

			var snake = new cbsnake();
			function cbsnake(){

			}
				cbsnake.prototype.setup = function(setspeed){
					var thisObj = this;
					//Snake Direction
					this.sdir = 'none';
					this.sdirb = 'none'; 
					this.sdirp = 'none';
					//Snake arrays
					this.ctop = new Array();
					this.cleft = new Array();
					//Top of snake class
					this.ctop[0] = 250;
					this.ctop[1] = -10;
					//Left of Snake class
					this.cleft[0] = 250;
					this.cleft[1] = -10;
					//current top of apple
					this.atop = 0;
					//current left of apple
					this.aleft = 0;
					//Milliseconds between move
					this.speed = setspeed;
					//Pixels to move at once
					this.jump = 9;
					//Size of snake. Make this one less than jump. Doesn't have to be,but adds good effect
					this.sos = 8;
					//Size of board
					this.sofb = 500;
					//Score...
					this.score = 0;
					//Set things up
					this.inloop++;
					this.daway = this.sofb - this.sos;
					$('instruc').style.display = 'none';
					$('board').innerHTML = '<div id="apple"></div><div id="snake0" class="snake"></div><div id="snake1" class="snake"></div>';
					this.moveapple();
					this.stopgame = false;
					setTimeout(function(){ thisObj.msnake(this.inloop) },this.speed);
					document.onkeydown = function(e){ thisObj.snakedir(e) };
				}
				cbsnake.prototype.slow = function(){
					this.setup(100);
					$('slow').disabled = 'disabled';
					$('slow').blur();
					$('medium').disabled = 'disabled';
					$('fast').disabled = 'disabled';
				}
				cbsnake.prototype.medium = function(){
					this.setup(70);
					$('slow').disabled = 'disabled';
					$('medium').disabled = 'disabled';
					$('medium').blur();
					$('fast').disabled = 'disabled';
				}
				cbsnake.prototype.fast = function(){
					this.setup(30);
					$('slow').disabled = 'disabled';
					$('medium').disabled = 'disabled';
					$('fast').disabled = 'disabled';
					$('fast').blur();
				}
				cbsnake.prototype.rannum = function(num1,num2){
					num1 = parseInt(num1);
					num2 = parseInt(num2);
					var generator = Math.random()*(Math.abs(num2-num1));
					generator = Math.round(num1+generator);
					return generator;
				}
				cbsnake.prototype.moveapple = function(){
					var usethis = false;
					while(!usethis){
						this.atop = this.rannum(0,this.daway);
						this.aleft = this.rannum(0,this.daway);
						if(this.numInArray(this.ctop,this.cleft,this.atop,this.aleft) == 0){
							usethis = true;
						}
					}
					$('apple').style.top = this.atop+"px";
					$('apple').style.left = this.aleft+"px";
				}
				cbsnake.prototype.snakedir = function(e){  
						if(!e){							
							e = window.event;
						}
						switch(e.keyCode){
							case 38:
								if(this.sdir != 'down' && this.sdirp != 'down'){
									this.sdirb = 'up';
									this.sdirp = 'up';
								}
								break;
							case 40:
								if(this.sdir != 'up' && this.sdirp != 'up'){
								this.sdirb = 'down';
								this.sdirp = 'down';
								}
								break;
							case 37:
								if(this.sdir != 'right' && this.sdirp != 'right'){
								this.sdirb = 'left';
								this.sdirp = 'left';
								}
								break;
							case 39:
								if(this.sdir != 'left' && this.sdirp != 'left'){
								this.sdirb = 'right';
								this.sdirp = 'right';
								}
								break;
							case 32:
								if(this.sdir == 'none' && this.sdirp != 'none'){
									this.sdirb = this.sdirp;
									this.sdirp = 'none';
								}
								else{
								this.sdirp = this.sdir;
								this.sdirb = 'none';
								}
								break;
						}
						
				}
				cbsnake.prototype.msnake = function(){
					if(this.stopgame === false){
						if(this.sdir != 'none'){
							this.moveall();
						}
						thisObj = this;
						switch(this.sdir){
								case 'up':
									if(this.ctop[0] <= 0){
										this.gover();
										break;
									}
									this.ctop[0] = this.ctop[0] - this.jump;
									$('snake0').style.top = this.ctop[0]+"px";
									setTimeout(function(){ thisObj.msnake() },this.speed);
									break;
								case 'down':
									if(this.ctop[0] >= this.daway){
										this.gover();
										break;
									}
									this.ctop[0] = this.ctop[0] + this.jump;
									$('snake0').style.top = this.ctop[0]+"px";
									setTimeout(function(){ thisObj.msnake() },this.speed);
									break;
								case 'left':
									if(this.cleft[0] <= 0){
										this.gover();
										break;
									}
									this.cleft[0] = this.cleft[0] - this.jump;
									$('snake0').style.left = this.cleft[0]+"px";
									setTimeout(function(){ thisObj.msnake() },this.speed);
									break;
								case 'right':
									if(this.cleft[0] >= this.daway){
										this.gover();
										break;
									}
									this.cleft[0] = this.cleft[0] + this.jump;
									$('snake0').style.left = this.cleft[0]+"px";
									setTimeout(function(){ thisObj.msnake() },this.speed);
									break;
								case 'none':
									setTimeout(function(){ thisObj.msnake() },this.speed);
									break;
						}
						if(this.sdir != 'none'){
							this.hitself();
							this.happle();
						}
					this.sdir = this.sdirb
					}
				}
				cbsnake.prototype.gover = function(){
					if(!this.stopgame){
						this.stopgame = true;
						alert('Your Score was '+this.score);
						$('slow').disabled = '';
						$('medium').disabled = '';
						$('fast').disabled = '';
						$('instruc').style.display = 'block';
					}
				}
				cbsnake.prototype.happle = function(){
					var thisObj = this;
					var tdiff = Math.abs(this.atop - this.ctop[0]);
					var ldiff = Math.abs(this.aleft - this.cleft[0]);
					if(tdiff >= 0 && tdiff <= this.sos && ldiff >= 0 && ldiff <= this.sos){
				
						this.score++;
						$('cscore').innerHTML = this.score;
						this.moveapple();
						this.addsnake();
					}
				
				}
				cbsnake.prototype.addsnake = function(){
				
				var newsnake = document.createElement('div');
				var newid = 'snake'+this.cleft.length;
				newsnake.setAttribute('id',newid);				
				newsnake.style.position = 'absolute';
				newsnake.style.top = '-10px';
				newsnake.style.left = '-10px';
				newsnake.style.backgroundColor = 'black';
				newsnake.style.height = '8px';
				newsnake.style.width = '8px';
				newsnake.style.overflow = 'hidden';
				$('board').appendChild(newsnake);
				this.cleft[this.cleft.length] = -10;
				this.ctop[this.ctop.length] = -10;
				}
				cbsnake.prototype.moveall = function(){
					var i = this.ctop.length - 1;
					while(i != 0){
						$('snake'+i).style.top = $('snake'+(i-1)).style.top;
						$('snake'+i).style.left = $('snake'+(i-1)).style.left;
						this.ctop[i] = this.ctop[i-1];
						this.cleft[i] = this.cleft[i-1];
						i = i - 1;
					}
				}
				cbsnake.prototype.numInArray = function(array,array2,value,value2){
					var n = 0;
					for (var i=0; i < array.length; i++) {
						if (array[i] === value && array2[i] === value2) {
							n++;
						}
					}
					return n;
				}
				cbsnake.prototype.hitself = function(){
					if(this.numInArray(this.ctop,this.cleft,this.ctop[0],this.cleft[0]) > 1){
						this.gover();
					}
				}
		</script>
		<style type="text/css"> body{ margin: 0; padding: 0; }
	.board{ width: 500px; background-color: lightgrey; border: 1px solid grey; }
	#board{ height: 500px; }
	#apple{ position: absolute; background-color: red; height: 8px; width: 8px; overflow: hidden; }
	.snake{ position: absolute; top: 250px; left: 250px; background-color: black; height: 8px; width: 8px; overflow: hidden; }
	.snake2{ position: absolute; top: -10px; left: -10px; background-color: black; height: 8px; width: 8px; overflow: hidden; }
	#score{ height: 50px; }
	#cscore{ color: black; padding-left: 10px; float: left; width: 25%; font-size: xx-large; }
	#buttons{ float: right; width: 50%; text-align: right; padding-top: 10px; }
	#instruc{ margin-top: 1em; clear: both; width: 500px; }
		</style>
	</HEAD>
	<body>
		<div class="board" id="board">
		</div>
		<div class="board" id="score">
			<span id="cscore">0</span> <span id="buttons"><button type="button" onClick="snake.slow()" id="slow">
					Slow</button> <button type="button" onClick="snake.medium()" id="medium">Medium</button>
				<button type="button" onClick="snake.fast()" id="fast">Fast</button> </span>
		</div>
		<div id="instruc">
			Above is a simple game of Snake. Select a speed then use your arrow keys to 
			attempt and eat the apple(red block), but watch out for the walls and yourself. 
			At any time you can pause the game by pressing the space bar.
		</div>
		<p>
			<a href="http://www.devasp.com" target="_top">Click Here</a>&nbsp;to visit 
			devasp</p>
	</body>
</HTML>
