// Box for the LoRA environmental sensor.

wi=27;	// inner width, length & heigth
li=52;
h=10;
th=2;	// wall thickness
vh=1; //size of the vent grid.
r=2;	// radius of rounded corners
opening_help=false;	// make a gap to ease opening of the cover.

e=0.01;
ri=(r>th)?r-th:e;	// needed for the cover - needs to be larger than 0 for proper results
l=li-2*r;
w=wi-2*r;
vents=floor( w  / ( vh * 2 ) );
vent_border=(wi-((vents*2+1)*vh))/2;
echo("vent size", ((vents*2+1)*vh));
module box(){


	difference(){

			translate([0,0,-th]) hull() {
  				translate([-w/2,l/2,r+th]) rotate(a=[0,90,0]) cylinder(r=r+th,h=h+wi/2,$fn=100);
				translate([-w/2,-l/2])cylinder(r=r+th,h=h+th,$fn=100);
				translate([-w/2,l/2,r+th])cylinder(r=r+th,h=h-r,$fn=100);
				translate([w/2,-l/2])cylinder(r=r+th,h=h+th,$fn=100);
				translate([w/2,l/2,r+th])cylinder(r=r+th,h=h-r,$fn=100);
//				translate([-w/2,l/2]) rotate(a=[0,90,0]) cylinder(r=r,h=wi+2*th,w*2);
//				for (i=[[-w/2,-l/2],[-w/2,l/2],[w/2,-l/2],[w/2,l/2]]){
//					translate(i)cylinder(r=r+th,h=h+th,$fn=10);
//				}
			}
			
			hull(){
				for (i=[[-w/2,-l/2],[-w/2,l/2,],[w/2,-l/2],[w/2,l/2]]){
					translate(i)cylinder(r=r,h=h,$fn=10*r);
				}
			}

        //create the vent
        for (i = [0:vents+1]){
         	translate([wi/2-vent_border-(i*vh*2),vh,-th])
         	cube([vh, li/2, th]);
            
			translate([wi/2-vent_border-(i*vh*2),l/2+r,-1])
			cube([vh, th, h-5]);
        }

        //hole for antenna
        translate([-wi/2+6, -li/2-th, 2]) rotate(a=[0,90,90]) cylinder([th, 10, 0], $fn=100);

        //create snap
		translate([-w/2,l/2+r,h-2])rotate([0,90,0])cylinder(d=1.2,h=w,$fn=12);
		translate([-w/2,-l/2-r,h-2])rotate([0,90,0])cylinder(d=1.2,h=w,$fn=12);
		translate([w/2+r,l/2,h-2])rotate([90,0,0])cylinder(d=1.2,h=l,$fn=12);
		translate([-w/2-r,l/2,h-2])rotate([90,0,0])cylinder(d=1.2,h=l,$fn=12);

		// if you need some adjustment for the opening helper size or position,
		// this is the right place
		if (opening_help)translate([w/2-10,l/2+13.5,h-1.8])cylinder(d=20,h=10,$fn=32);
	}
}

module cover(){
	translate([0,0,-th])hull(){
		for (i=[[-w/2,-l/2],[-w/2,l/2],[w/2,-l/2],[w/2,l/2]]){
			translate(i)cylinder(r=r+th,h=th,$fn=100*r);
		}
	}
	difference(){
		translate([0,0,-th])hull(){
			for (i=[[-w/2,-l/2],[-w/2,l/2],[w/2,-l/2],[w/2,l/2]]){
				translate(i)cylinder(r=r,h=th+3,$fn=100*r);
			}
		}
		hull(){
			for (i=[[-w/2,-l/2],[-w/2,l/2],[w/2,-l/2],[w/2,l/2]]){
				if (r>th){
					translate(i)cylinder(r=r-th,h=3,$fn=100*r);
				}else{
					translate(i)cylinder(r=e,h=3,$fn=100*r);
				}
			}
		}
	}
	translate([-w/2+1,l/2+r-0.2,2])rotate([0,90,0])cylinder(d=1.2,h=w-2,$fn=12);
	translate([-w/2+1,-l/2-r+0.2,2])rotate([0,90,0])cylinder(d=1.2,h=w-2,$fn=12);
	translate([w/2+r-0.2,l/2-1,2])rotate([90,0,0])cylinder(d=1.2,h=l-2,$fn=12);
	translate([-w/2-r+0.2,l/2-1,2])rotate([90,0,0])cylinder(d=1.2,h=l-2,$fn=12);

}

box();
translate([0,li+3+2*th,0])
cover();
