
PART = "full"; // ["bracket", "washer", "print"]

module board() {
    translate([-5, 0, 0])
        rotate([90, 0, 90]) {
            import("Skadis_36x56.stl");
            translate([-360, 0, 0])
                    import("Skadis_36x56.stl");
        }
}

module skadis_connector() {
    spacing=40;
    width=70;
    height=25;
    depth=5;
    bolt_offset=(width-spacing)/2;
    translate([0, -width/2, 0]) {
        difference() {
            cube([depth, width, height]);
            translate([-13.7, bolt_offset, height/2])
                rotate([0, 90, 0])
                  m3_16_bolt();
            translate([-13.7, bolt_offset + spacing, height/2])
                rotate([0, 90, 0])
                  m3_16_bolt();
        }
    }
}

module skadis_connector_washer() {
    difference() {
        cylinder(h=5, d=19.5, $fn=6);
            translate([0, 0, 5-2.39]) {
                rotate([0, 0, 30])
                    m3_nut();
                cylinder(h=20, d=3.2, center=true, $fn=36);
            }
   }
}

module m3_16_bolt() {
    cylinder(h=15.75, d=3.1, $fn=36);
        translate([0, 0, 15.74]) {
            cylinder(h=3.1, d=5.5, $fn=72);
        }
    }

module m3_nut() {
    difference() {
        cylinder(h=2.4, d=6.2, $fn=6);
        cylinder(h = 5, d=3.1, center=true, $fn=36);
    }
}

if (PART == "bracket") {
    skadis_connector();
} else if (PART == "washer") {
    skadis_connector_washer();
} else if (PART == "print") {
    skadis_connector();
    translate([20, 20, 0])
        skadis_connector_washer();
    translate([20, 40, 0])
        skadis_connector_washer();
} else {
    translate([0, 0, 40 - 7.5 - 5]) {
        skadis_connector();
    }

    translate([-5, 20 , 40])
        rotate([90, 0, -90])
            skadis_connector_washer();
    translate([-5, -20 , 40])
        rotate([90, 0, -90])
            skadis_connector_washer();

    color("white") board();
}
