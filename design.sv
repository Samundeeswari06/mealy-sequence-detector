// Code your design here
module mealy_1011_detector (
    input clk,
    input reset,
    input x,         // Serial input
    output reg y     // Output: 1 when 1011 is detected
);
    typedef enum reg [2:0] {
        S0 = 3'b000,
        S1 = 3'b001,
        S2 = 3'b010,
        S3 = 3'b011
    } state_t;

    state_t current_state, next_state;

    // State register
    always @(posedge clk or posedge reset) begin
        if (reset)
            current_state <= S0;
        else
            current_state <= next_state;
    end

    // Next-state logic & output logic (Mealy-style)
    always @(*) begin
        y = 0;
        case (current_state)
            S0: begin
                if (x) next_state = S1;
                else   next_state = S0;
            end
            S1: begin
                if (x) next_state = S1;
                else   next_state = S2;
            end
            S2: begin
                if (x) next_state = S3;
                else   next_state = S0;
            end
            S3: begin
                if (x) begin
                    next_state = S1;
                    y = 1;  // Sequence 1011 detected
                end else begin
                    next_state = S2;
                    y = 0;
                end
            end
            default: next_state = S0;
        endcase
    end
endmodule
