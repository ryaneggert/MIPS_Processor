//------------------------------------------------------------------------------
// memory
//   Simple read-only memory initialized from a .dat file.
//   data_out always has the value mem[address]
//   Parameter default values will support 32-bit addresses and 32-bit data.
//
//------------------------------------------------------------------------------

module memory
#(
    parameter addresswidth  = 32,
    parameter depth         = 2**14,
    parameter width         = 32,
    parameter loadfrom      = "NONE"
)
(
    output reg [width-1:0]     data_out,
    input                       clk,
    input [addresswidth-1:0]    address
);

    reg [width-1:0] mem [depth-1:0];

    always @(address) begin 
        data_out = mem[address];
    end
    initial begin
        if ((loadfrom == "NONE") | (loadfrom == "")) begin
            $display("No memfile specified");
        end else begin
            $display("Loading \"%s\" into instruction memory", loadfrom);
            $readmemh(loadfrom, mem); // Still throws "can not open in read mode" error?
        end
        data_out = 32'h201d3ffc;
    end

endmodule