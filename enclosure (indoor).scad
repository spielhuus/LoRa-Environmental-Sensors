// Enclosure for the LoRA environmental sensor.

l=52;
w=27;
th=5;
h=12;

board_w=25;
board_l=50;
board_h=2;

lidText = "4";  // Text on lid    
lidTextSize = 20;   // Size of text on Lid
lidTextFont = "Droid Sans:style=Bold";  // Font for lid text

// the text
translate([0,-l/2+5,-th-w/2+1])
    rotate(0) linear_extrude(height = 3)
        mirror([1,0,0]) 
            text(lidText, font = lidTextFont, size = lidTextsize, valign = "center", halign = "center");

//the slider for the pcb
difference() {
    translate([-w/2,-l/2,-h/2+board_h-1]) cube([board_w+3,board_l,board_h+2] );
    translate([0,th/2,-h/2+3]) cube([board_w+1,board_l+2*th,board_h], center=true);
    translate([0,th/2,-h/2+3]) cube([board_w-2,board_l+2*th,board_h+2], center=true);
}


translate([-w/2-th/4,0,-h/2+3+th]) cube([th/2,l,th], center=true);
translate([+w/2+th/4,0,-h/2+3+th]) cube([th/2,l,th], center=true);

translate([0,0,0]) {
    difference() {
        rotate(a=[0,270,90]) cylinder(h=l,d=w+th,center=true,$fn=100);
        rotate(a=[0,270,90]) cylinder(h=l+th,d=w,center=true,$fn=100);
        translate([0,0,h]) cube([w*2,l,h*2], center=true);

        //vents
        translate([0, -10,-w]) rotate([120,0,0]) cube([w*2,l,2], center=true);
        translate([0, -5,-w]) rotate([120,0,0]) cube([w*2,l,2], center=true);
        translate([0, 0,-w]) rotate([120,0,0]) cube([w*2,l,2], center=true);
        translate([0, 5,-w]) rotate([120,0,0]) cube([w*2,l,2], center=true);
        translate([0, 10,-w]) rotate([120,0,0]) cube([w*2,l,2], center=true);
        translate([0, 15,-w]) rotate([120,0,0]) cube([w*2,l,2], center=true);
        translate([0, 20,-w]) rotate([120,0,0]) cube([w*2,l,2], center=true);
        translate([0, 25,-w]) rotate([120,0,0]) cube([w*2,l,2], center=true);
        translate([0, 30,-w]) rotate([120,0,0]) cube([w*2,l,2], center=true);
    }
}
