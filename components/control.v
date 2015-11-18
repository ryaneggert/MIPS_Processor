module control(  Jump, Branch, MemRead, MemtoReg, MemWrite, ALUSrc, RegWrite, JumpSel, RegDst, WriDataSel, ALUOp, opcode, funct, clk);
    input clk;
    input[5:0] opcode, funct;

    output reg Jump, Branch, MemRead, MemtoReg, MemWrite, ALUSrc, RegWrite, JumpSel, WriDataSel;
    output reg[1:0] RegDst;
    output reg[5:0] ALUOp;

    parameter LW = 6'b100011, SW = 6'b101011, J = 6'b000010, JR = 6'b001000, JAL = 6'b000011 , BNE = 6'b000101, XORI = 6'b001110, 
    ADD = 6'b100000, SUB = 6'b100010, SLT = 6'b101010, SYSCALL = 6'b001100, NOOP = 6'b000000, More = 6'b000000;
    //opps in fist case: LW, SW, J, JAL, BNE, XORI
    //opps that have opcode zero and go in second case: JR, ADD, SUB, SLT, SYSCALL, NOOP
    always @(posedge clk) begin

        case(opcode)
/*
            RegDst = ;
            Jump = ;
            Branch = ;
            MemRead = ;
            MemtoReg = ;
            ALUOp = 6'b;
            
            MemWrite = ;
            ALUSrc = ;
            RegWrite = ;
            WriDataSel = ;
            JumpSel = ;
*/

        LW: begin
            RegDst = 0;
            Jump = 0;
            Branch = 0;
            MemRead = 1;
            MemtoReg = 1;
            ALUOp = 6'b100000;
            
            MemWrite = 0;
            ALUSrc = 1;
            RegWrite = 1;
            WriDataSel = 1;
        end

        SW: begin 
            RegDst = 0;
            Jump = 0;
            Branch = 0;
            MemRead = 0;
            MemtoReg = 0;
            ALUOp = 6'b100000;
            MemWrite = 1;
            ALUSrc = 1;
            RegWrite = 0;

        end 
        J: begin 
            Jump = 1;
            Branch = 0;
            MemRead = 0;
            MemtoReg = 0;
            ALUOp = 6'b101100;
            
            MemWrite = 0;
            ALUSrc = 0;
            RegWrite = 0;
            JumpSel = 0;
        end
        JAL: begin 
            RegDst = 2'b10;
            Jump = 1;
            Branch = 0;
            MemRead = 0;
            MemtoReg = 0;
            ALUOp = 6'b101100;
            
            MemWrite = 0;
            ALUSrc = 0;
            RegWrite = 1;
            WriDataSel = 0;
            JumpSel = 0;
        end
        BNE: begin 
            RegDst = 2'b00;
            Jump = 0;
            Branch = 1;
            MemRead = 0;
            MemtoReg = 0;
            ALUOp = 6'b100010;
            
            MemWrite = 0;
            ALUSrc = 0;
            RegWrite = 0;

        end
        XORI: begin 
            RegDst = 2'b01 ;
            Jump = 0;
            Branch = 0;
            MemRead = 0;
            MemtoReg = 0;
            ALUOp = 6'b100110;
            
            MemWrite = 0;
            ALUSrc = 1;
            RegWrite = 0;
            
        end
        More: begin 
            case(funct)
            JR: begin 
                Jump = 1;
                Branch = 0;
                MemRead = 0;
                MemtoReg = 0;
                ALUOp = 6'b101100;
                
                MemWrite = 0;
                ALUSrc = 0;
                RegWrite = 0;
                JumpSel = 1;                
            end
            ADD: begin
                RegDst = 1;
                Jump = 0;
                Branch = 0;
                MemRead = 0;
                MemtoReg = 0;
                ALUOp = 6'b100000;
                
                MemWrite = 0;
                ALUSrc = 0;
                RegWrite = 1;
            end
            SUB:  begin
                RegDst = 1;
                Jump = 0;
                Branch = 0;
                MemRead = 0;
                MemtoReg = 0;
                ALUOp = 6'b100010;
                
                MemWrite = 0;
                ALUSrc = 0;
                RegWrite = 1;             
            end
            SLT:  begin 
                RegDst = 1;
                Jump = 0;
                Branch = 0;
                MemRead = 0;
                MemtoReg = 0;
                ALUOp = 6'b101010;
                
                MemWrite = 0;
                ALUSrc = 0;
                RegWrite = 1;            
            end
            SYSCALL: begin
                    $finish;            
                end
            NOOP:  begin
                Jump = 0;
                Branch = 0;
                ALUOp = 6'b101100;
                MemWrite = 0;
                ALUSrc = 0;
                RegWrite = 0; 
            end
        end




        
    end
endmodule
