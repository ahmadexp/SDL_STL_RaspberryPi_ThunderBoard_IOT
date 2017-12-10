//
// Raspberry Pi ThunderBoard IOT Case

//
// SwitchDoc Labs November 2017
//
 include <write.scad>
include <lightning2.scad>
include <RoundedRect.scad>
$fn = 50;
/*
$TOLERANCE=0.20;

$SNAPTOLERANCE=0.25;
$TUBETOLERANCE=0.2;
*/

$TOLERANCE=0;

$SNAPTOLERANCE=0;
$TUBETOLERANCE=0;

module rcube(size=[30, 20, 10], radius=[3, 2, 1], center=true)
    hull() {
        translate( center ? [0,0,0] : size/2 ) {
            cube(size-2*radius+[2*radius[0],0,0],center=true);
            cube(size-2*radius+[0,2*radius[1],0],center=true);
            cube(size-2*radius+[0,0,2*radius[2]],center=true);
 
            for(x = [-0.5,0.5], y = [-0.5,0.5], z = [-0.5,0.5])
                translate([x * ( size[0] - 2*radius[0]),
                           y * ( size[1] - 2*radius[1]),
                           z * ( size[2] - 2*radius[2])])
                    scale([radius[0], radius[1], radius[2]])
 //                       sphere(1.0,$fn=4*4);
                       sphere(1.0,$fn=6*6);
        }
    }
    
    
    module ourWeatherPylon()
    {
        
        difference()
        {
      cylinder(h=10,r1=3, r2=2.5/2, $fn=100);
            
            translate([0,0,5])
            cylinder(h=5,r1=0.8, r2=0.8, $fm=100);
            
        }
 
    }


    module stand()
    {
        difference()
        {
            cylinder(h=15,r1=5,r2=5, center=true);
            
            translate([0,0,4])
            cylinder(h=15,r1=3.5,r2=3.5, center=true);
        }
            
        
    }


module bottomBox()
{
   
    union()
    {
        difference()
        {
        
            rcube([190, 80, 68], center=false);   // 3 mm walls (it will be in the sun)
                
        
            
                
            translate([3,3,2])
            cube([184, 74, 75]);
            
           // now take cuts out for plugs
            
            // power plug
            #translate([30,55,7])            
            cube([145,40, 100]);
            
            // take out 2mm for top lip
            #translate([1,1,66])
         cube([188, 78, 35], center=false);
            
            // put the characters on the front
            
             

            
               #translate([100,1,10])
              rotate([90,0,0]) 
            write("Thunder Board IOT",h=5,t=2,center=true);
        
  //          #translate([15,5,2])   
  //          write("110417-001",h=3,t=2,center=true);
            
            
            
        }


            
            // slots for I2C Hub
     
        translate([35,-30,0])
        rotate([0,0,90])
            union()
            {
            translate([40-2,2,0])
            cube([30-2,1.5,8]);
            translate([40-2,20.5+.025 + 3.0,0])
            cube([30-2.5,1.5,8]);
            }
            
      // Pi stand
//


        translate([100,15,0])
        {
     
                    
            translate([0,0,8])
            stand();
            translate([57,0,8])
            stand();
            translate([0,48,8])
            stand();
            translate([57,48,8])
            stand();
        }
    }
}


module sensorPylon()
{
    
    // tube
    
    difference()
    {
        union()
        {
            cylinder(120, r=12);

    

        }
    
        translate([0,0,-10])
        cylinder(150, r=10.5-$TUBETOLERANCE/2);
        
 
        
    }
    
    
   
    
    
    
    
}



module sensorBox()
{

    difference()
    {
        translate([-16.5,-16.5,0])
        rcube([43,43,33], center=false);
    
        translate([-15,-15,-2])
        cube([40,40,32]);
        
        translate([-15.5,-15.5,-1])
        cube([41,41,3]);
        
    
    translate([6,28,17])
    rotate(90,[1,0,0])
    lightning2();
        
    translate([6,28-44,17])
    rotate(90,[1,0,0])
    lightning2();    
        
        rotate(90,[0,0,1])
      translate([6,28-54,17])
    rotate(90,[1,0,0])
    lightning2(); 


          rotate(90,[0,0,1])
      translate([6,28-10,17])
    rotate(90,[1,0,0])
    #lightning2(); 
 
        
}
    
    
}

module sensorPlatform()
{
    
    difference()
    {
        union()
        {
            translate([-17.95,-17.95,-1])
            cube([40.9+$SNAPTOLERANCE/2,40.9+$SNAPTOLERANCE/2,2]);
            
            translate([2.5,2.5,-5])
            #cylinder(5,r=10.4);
        }
        
        translate([2.5,2.5,-5])
        #cylinder(20,r=9.0); 
    }
    
    
}

module rsensorPlatform()
{
    
    difference()
    {
        union()
        {
            translate([-17.95,-17.95,-1])
            rcube([40.9,40.9,2],center=false);
            
            translate([2.5,2.5,-5])
            #cylinder(5,r=10.4);
        }
        
        translate([2.5,2.5,-5])
        #cylinder(20,r=9.0); 
    }
    
    
}

MaxX = 136;
MaxY = 56;

module fitbox(x, y)

{
    
    difference()
    {
        cube([x+2,y+2,7]);
        
        translate([1,1,3])
        cube([x,y,6]);
        
    }
    
    
}


module PlaceFitBox(x,y,xloc,yloc)
{
    translate([xloc,yloc])
fitbox(x, y);
    
}

$fn =400;

module PlaceGroveHole(xloc, yloc)
{
    translate([xloc,yloc,-20])
    cube([12.25,6.5,50]);

}

module VPlaceGroveHole(xloc, yloc)
{
    translate([xloc,yloc,-20])
    cube([7.5,12.25,50]);

}


module topPlate()
{
    difference()
    {
        union()
            {
    
        
                rcube([188+$TOLERANCE/2, 78+$TOLERANCE/2, 2], center=false);
            
   
       
            
            // Lightning Pylon
            
           translate([150,10+28,2])
            rotate(180,[0,1,0])
            sensorPlatform();

                  
       
            
            
        }
        

        // LCD display Hole
        
        #translate([12,26.5,-5])
        cube([71.3-$SNAPTOLERANCE/2,25-$SNAPTOLERANCE/2,10]);
        
        
        // Platform hole
        
        #translate([150-2.5,10+28+2.5,-3])        
        cylinder(20,r=9.0); 
        
    }
    

    

}


rotate([0,0,90])
union()
{

  translate([0,0,0])
   bottomBox();
   
    translate([120,100,0])
    sensorPylon();


    translate([80,100,1])
    rotate(180,[0,1,0])
    rsensorPlatform();


    translate([80,100,0])
    rotate(180,[0,1,0])
    translate([50,0,-33])
    sensorBox();
   

    translate([3,130,0])
    topPlate();


}




