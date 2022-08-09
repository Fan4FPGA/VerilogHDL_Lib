


input clk;
input rst_n;
input i1,i2,i3;
output reg o1,o2,o3;





localparam	IDLE	= 3'd0,
						S1	= 3'd1,
						S2	= 3'd1,
						S3	= 3'd1
						S4	= 3'd1
						S5	= 3'd1;
						
reg [2:0] CS,NS;

always@(posedge clk or negedge rst_n)begin
	if(!rst_n)
		CS <= IDLE;
	else
		CS <= NS;
end

always@(*)begin
	case(CS)
		IDLE	:		if(i1 == 1) begin NS <= S1; end;
							else NS <= IDLE;
							
		S1		:		if(i2 == 1) begin NS <= S2; end;
							else NS <= S2;
							
		S2		:		if(i3 == 1) begin NS <= S3; end;
							else NS <= S2;
							
		S3		:		NS <= IDLE;
		
		default :  NS <= IDLE;
	endcase
end


always@(posedge clk or negedge rst_n) begin
	if(!rst_n)begin
		o1 <= 1'b0;
		o2 <= 1'b0;
		o3 <= 1'b0;
	end
	else begin
		case(NS)
			IDLE 	: 	if(i1 == 1) o1 <= 1;
								else o1 <= 0;
								
			S1		:		if(i2 == 1) o2 <= 1;
								else o2 <= 0;
								
			S2		:		if(i3 == 1) o3 <= 1;
								else o3 <= 0;
								
			S3		:		begin o1 <= 0; o2<= 0; o3<= 0; end
			
			default	:	begin o1 <= 0; o2<= 0; o3<= 0; end
		endcase
	end


end