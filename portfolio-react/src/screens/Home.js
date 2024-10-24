import React, {useState} from 'react';
import './style.css';
import './bubbles_background.css';
import './hover_effects.css';
import './sidebar_style.css';

export default () => {

	const Person = () => {
		const [person, setPerson] = useState({
		 name: 'John Doe',
		 age: 30,
		 job: 'Developer'
		});
	   
		return (
		 <div>
		  <p>Name: {person.name}</p>
		  <p>Age: {person.age}</p>
		  <p>Job: {person.job}</p>
		 </div>
		);
	   };

	const WorkItem = () => {
		const [workItem, setWorkItem] = useState({
		 title: 'Allianz VR FreeRoaming',
		 description: 'FreeRoaming Multiplayer VR Game, developed with Unreal Engine 5 for the 2024 Paris Olympic Games',
		 image: require('./images/allianzVR.jpg'),
		 link: 'https://maxenceoresteleandre.github.io/allianz_vr.html',
		 x_position: '25px',
		 is_selected: false
		});

		return (
			<button style={{backgroundImage:`url('${workItem.image}')`, borderRadius:'50%'}}>
				<img src={workItem.image} style={{maxWidth:'0%', position:'relative', top:0, left:0,zIndex:-1}} />
					<h3>{workItem.title}
						<p style={{fontSize:'14px'}}>
							{workItem.description}
						</p>
					</h3>
			</button>
		)
	}


    return (
<div>
	<div class="sidenav">
		<div class="sidewaviy">
			<span style={{'--i':1}}>M</span>
			<span style={{'--i':2}}>a</span>
			<span style={{'--i':3}}>x</span>
			<span style={{'--i':4}}>e</span>
			<span style={{'--i':5}}>n</span>
			<span style={{'--i':6}}>c</span>
			<span style={{'--i':7}}>e</span>
		</div>
		<div class="sidewaviy">
			<span style={{'--i':9, fontSize: '45px', marginLeft: '40px'}}> M</span>
			<span style={{'--i':10, fontSize: '45px'}}>a</span>
			<span style={{'--i':11, fontSize: '45px'}}>i</span>
			<span style={{'--i':12, fontSize: '45px'}}>r</span>
			<span style={{'--i':13, fontSize: '45px'}}>e</span>
		</div>
		<h3 class="jobs" >Software Engineer</h3>
		<h3 class="jobs" >Game Developer</h3>
		<h3 class="jobs" style={{marginBottom:'10px'}}> Computer Scientist</h3>

        <hr class="h-line" style={{marginTop: '12px', marginBottom: '0px', height: '3px'}} />

		<menu>
		<a class="work-list" href="#video_game_work">Video Game Work</a> 
		<a class="work-list-element" href="#allianz_vr">Allianz VR FreeRoaming</a> 
		<a class="work-list-element" href="#xyz_plugins">XYZ Godot Plugin Suite</a> 
		<a class="work-list-element" href="#play_sorbonne">Play Sorbonne U</a> 
		<a class="work-list-element" href="#feuille_morte">FeuilleMorte projects</a> 

		<a class="work-list" href="#academic_work">Academic Work</a> 
		<a class="work-list-element" href="#academic_work">Haptic Feedbacks in VR</a> 
		<a class="work-list-element" href="#academic_work">Swarm robotics</a> 
		<a class="work-list-element" href="#academic_work">OOC & Bioengineering</a> 

		<a class="work-list" href="#others">Others</a> 
		<a class="work-list-element" href="#others">Electronics</a> 
		<a class="work-list-element" href="#others">Stuff I like</a> 
		<a class="work-list-element" href="#others">This website!</a> 
		</menu>

        <hr class="h-line" style={{marginTop: '10px', marginBottom: '0px', height: '3px'}} />

        <div class="logos">
            <a class="logo_child_img" href="https://github.com/Maxenceoresteleandre" target="_blank" rel="noopener noreferrer">
                <img src={require("./images/logo_github.png")} />
            </a>
            <a class="logo_child_img" href="https://maxence-maire.itch.io/" target="_blank" rel="noopener noreferrer">
                <img src={require("./images/logo_itch.png")} />
            </a>
            <a class="logo_child_img" href="https://www.linkedin.com/in/maxence-maire-048930241/" target="_blank" rel="noopener noreferrer">
                <img src={require("./images/logo_linkedin.png")} />
            </a>
        </div>
	</div> 

	
	<div class="main">
	<div class="container">
		<div style={{height:'50px'}}></div>
		<div class="intro">
			<div class="intro-child-im">
				<img class="img-echoes" src={require("./images/echoes-p1.png")} title="That's Miner..." style={{marginTop: '20px', marginLeft: '-20px', rotate: '-30deg'}}/>
				<img class="img-scrambled" src={require("./images/scrambled-p2.png")} title="That's a chicken without a gun" style={{marginTop: '220px', marginLeft: '-50px', rotate: '240deg'}}/>
				<img class="img-scrambled" src={require("./images/scrambled-p3.png")} title="That's a chicken with a gun" style={{marginTop: '150px', marginLeft: '-100px', rotate: '270deg', scale:(-1, 1)}}/>
				<img class="img-olmo" src={require("./images/olmo-1.png")} title="That's Castano :D" style={{marginTop: '-90px', marginLeft: '-155px', rotate: '-20deg'}}/>
				<img class="img-pingu" src={require("./images/pingu-p1.png")} title="That's Pingu!!! By Cochon_Viking" style={{marginTop: '-47px', marginLeft: '-20px', rotate: '0deg'}}/>
				<img class="img-pingu" src={require("./images/pingu-p3.png")} title="That's a yeti... By Cochon_Viking" style={{marginTop: '-90px', marginLeft: '140px', rotate: '0deg'}}/>

				<img class="img-echoes" src={require("./images/echoes-p4.png")} title="That's the Boss..." style={{marginTop: '235px', marginLeft: '205px', rotate: '40deg'}}/>
				<img class="img-echoes" src={require("./images/echoes-p5.png")} title="That's an evil echo >:(" style={{marginTop: '145px', marginLeft: '195px', rotate: '5deg'}}/>
				<img class="img-echoes" src={require("./images/echoes-p5.png")} title="That's another evil echo >:(" style={{marginTop: '185px', marginLeft: '205px', rotate: '10deg'}}/>
				<img class="img-echoes" src={require("./images/echoes-p8.png")} title="That's your echo :o" style={{marginTop: '15px', marginLeft: '190px', rotate: '10deg', scale:(-1, 1)}}/>
				<img class="img-echoes" src={require("./images/echoes-p3.png")} title="That's you!" style={{marginTop: '65px', marginLeft: '195px', rotate: '20deg', scale:(-1, 1)}} />
				<img class="profile-picture" src={require("./images/profile-picture.jpg")} title="That's me!" />
			</div>
			<div class="intro-child-text">
				<div class="waviy">
					<span style={{'--i':1}}>M</span>
					<span style={{'--i':2}}>a</span>
					<span style={{'--i':3}}>x</span>
					<span style={{'--i':4}}>e</span>
					<span style={{'--i':5}}>n</span>
					<span style={{'--i':6}}>c</span>
					<span style={{'--i':7}}>e</span>
					<span style={{'--i':8}}>&nbsp;&nbsp;</span>
					<span style={{'--i':8}}>M</span>
					<span style={{'--i':9}}>a</span>
					<span style={{'--i':10}}>i</span>
					<span style={{'--i':11}}>r</span>
					<span style={{'--i':12}}>e</span>
				</div>

				   <hr class="h-line2"/>

				<ul class="z-text">
					<li>Computer scientist, game developer and game designer.</li>
					<li>Master's degree in Computer Science from Sorbonne University.</li>
					<li>All-around creative tinkerer!</li>
				</ul>
			</div>

		</div>

		<hr class="h-line" />

		<div class="intro-tab">
			<button type="button" class="button-l" onclick="location.href='Maxence Maire - CV.pdf';" >
				<div class="i-am">
					<h3>Resume</h3>
				</div>
			</button> 
			<button type="button" class="button-r" onclick="location.href='Maxence Maire - Portfolio.pdf';" >
				<div class="i-am">
					<h3>Portfolio</h3>
				</div>
			</button>
		</div>

	<section id="video_game_work">
		<h2 class="z-text" style={{marginTop: '60px'}}>Video Game Work:
			<img class="img-olmo" src={require("./images/olmo-4.png")} title="IS THAT A PIRATE CHICK???" style={{marginTop: '-170px', marginLeft: '-425px', rotate: '5deg', scale:(-1, 1)}}/>
		</h2>

		<WorkItem
			title="Allianz VR FreeRoaming"
			description="FreeRoaming Multiplayer VR Game, developed with Unreal Engine 5 for the 2024 Paris Olympic Games"
			image="./images/allianzVR.jpg"
			link="https://maxenceoresteleandre.github.io/allianz_vr.html"
			x_position="25px"
		/>

	</section>
		
		<section id="others">
		<div class="z-text" style={{marginBottom: '60px'}}>
			<h3 style={{marginTop: '60px'}}>Personal experiences
				<img class="img-pingu" src={require("./images/pingu-p2.png")} title="That's an alien pig. By Cochon_Viking"  style={{marginTop: '-55px', marginLeft: '20%', rotate: '0deg', zIndex:2}}/>
			</h3>
			<p>
				For years, I have been deeply passionate about game design, programming, and literature, and I have gained extensive experience in software and game development. 
				I am always trying to build impactful experiences and grow as a game designer!
			</p>
			<p>
				More recently, I have been exploring the fields of web development and animation, expanding my knowledge and skills to become more proficient 
				in these areas.
			</p>
			<p>
				In my spare time, I enjoy cooking, practicing fencing, and spending time with my cat. I like my cat. She's very cute. I will show you a picture of her if you ask. And probably also if you don't ask.
				<img class="img-echoes" src={require("./images/echoes-p6.png")} title="That's the Shark!"  style={{marginTop: '50px', marginLeft: '-57%', rotate: '-5deg', scale:(-1, 1)}}/>
			</p>
		</div>
		</section>

		<hr class="h-line"/>

		<h2 class="z-text">Latest game projects:
			<img class="img-echoes" src={require("./images/echoes-p7.png")} title="That's a security guard" style={{marginTop: '10px', marginLeft: '-350px', rotate: '-15deg', scale:(-1, 1)}}/>
		</h2>

		<iframe src={"https://itch.io/embed/1824207?bg_color=004140&amp;fg_color=ffffff&amp;link_color=9783f2&amp;border_color=354d51"} 
			width="552" height="167" frameborder="0">
			<a href="https://feuillemorteentertainment.itch.io/echoes-complete-edition">ECHOES - Complete edition by FeuilleMorte Entertainment</a>
		</iframe>

		<iframe src={"https://itch.io/embed/1579605?bg_color=221423&amp;fg_color=fff5eb&amp;link_color=ee4040&amp;border_color=682d73"}
			width="552" height="167" frameborder="0">
			<a href="https://feuillemorteentertainment.itch.io/flymetothesun">Fly me to the Sun by FeuilleMorte Entertainment, Talamh, Cochon_Viking, Pioure, Maureen Bst</a>
		</iframe>

		<iframe src={"https://itch.io/embed/2203248?linkback=true&amp;bg_color=000000&amp;fg_color=ffffff&amp;link_color=c9c9c9&amp;border_color=333ad6"} 
			width="552" height="167" frameborder="0">
			<a href="https://feuillemorteentertainment.itch.io/we-have-a-mole">We have a mole by FeuilleMorte Entertainment</a>
		</iframe>

		<iframe src={"https://itch.io/embed/1492024?bg_color=e08767&amp;fg_color=222222&amp;link_color=dc1a06&amp;border_color=b44242"} 
			frameborder="0">
			<a href="https://feuillemorteentertainment.itch.io/scrambled">Scrambled! by FeuilleMorte Entertainment</a>
		</iframe>

		<iframe src={"https://itch.io/embed/736364?bg_color=2f2f2f&amp;fg_color=ffffff&amp;link_color=858883&amp;border_color=979797"} 
			width="552" height="167" frameborder="0">
			<a href="https://feuillemorteentertainment.itch.io/dangerous-roads">Dangerous Roads by FeuilleMorte Entertainment</a>
		</iframe>

		<iframe src={"https://itch.io/embed/1054995?bg_color=860080&amp;fg_color=dbfbfd&amp;link_color=f70000&amp;border_color=333333"} 
			width="552" height="167" frameborder="0">
			<a href="https://feuillemorteentertainment.itch.io/cats-are-long-liquid">Cats are long liquid by FeuilleMorte Entertainment</a>
		</iframe>

		<hr class="h-line"/>
		<div style={{height:'20px'}}> 
			<img class="img-olmo" src={require("./images/olmo-6.png")} title="That's the mayor..." style={{marginTop: '-110px', marginLeft: '62%', rotate: '0deg', scale:2}}/>
			<img class="img-olmo" src={require("./images/olmo-cerez.png")} title="You found Olmo! :))" style={{marginTop:'-290px', marginLeft: '60px', rotate: '0deg', scale:2.5}}/>
			<img class="img-olmo" src={require("./images/olmo-building.png")} title="That's just Castano's place." style={{marginTop: '-463px', marginLeft: '62%', rotate: '0deg', scale:2.5}}/>
		</div>

		<div class="bubbles">
			<div class="bubble"></div>
		  <div class="bubble"></div>
		  <div class="bubble"></div>
		  <div class="bubble"></div>
		  <div class="bubble"></div>
		  <div class="bubble"></div>
		  <div class="bubble"></div>
		  <div class="bubble"></div>
		  <div class="bubble"></div>
		  <div class="bubble"></div>
		  
		</div>
		
	</div>
	</div>
	
</div>

    );
}