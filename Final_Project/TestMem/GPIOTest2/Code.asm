#define PORT_HEX1[7-0] 0x805 - LSB byte (Output Mode)
#------------------- PORT_HEX2_HEX3 ---------------------------
#define PORT_HEX2[7-0] 0x808 - LSB byte (Output Mode)
#define PORT_HEX3[7-0] 0x809 - LSB byte (Output Mode)
#------------------- PORT_HEX4_HEX5 ---------------------------
#define PORT_HEX4[7-0] 0x80C - LSB byte (Output Mode)
#define PORT_HEX5[7-0] 0x80D - LSB byte (Output Mode)
#--------------------------------------------------------------
#define PORT_SW[7-0]   0x810 - LSB byte (Input Mode)
#--------------------------------------------------------------

.data 
	N: .word 0x0004 
.text
	lw   $t3,N
	lw   $t4,0x810 # read the state of PORT_SW[7-0]
	move $t0,$zero  # $t0=0
	
	sw   $t0,0x800 # write to PORT_LEDR[7-0]
	sw   $t0,0x804 # write to PORT_HEX0[7-0]
	sw   $t0,0x805 # write to PORT_HEX1[7-0]
	sw   $t0,0x808 # write to PORT_HEX2[7-0]
	sw   $t4,0x809 # write to PORT_HEX3[7-0]
	sw   $t0,0x80C # write to PORT_HEX4[7-0]
	sw   $t0,0x80D # write to PORT_HEX5[7-0]