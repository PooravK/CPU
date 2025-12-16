# RV32I Five-Stage Pipelined CPU

I am building a fully functional pipelined processor capable of:
1) IF (Instruction Fetch)
2) ID (Instruction Decode)
3) EX (Execute)
4) MEM (Memory data access)
5) WB (Writing back to register file)

### ISA:
 - Harvard style architecture
 - All pipelines and register file operate on rising edge of clock

**Goals:**
 - PC ✅
 - IM ✅
 - ALU ✅
 - IF ✅
 - RF ✅
 - Decoder ✅
 - Immediate Generator ✅
 - ID/EX register
 - EX
 - EX/MEM register
 - MEM
 - MEM/WB register
 - WB
 - Hazard detection unit
 - FOrwarding unit
 - Branch and Jump control logic
 - Top level wrapper module
 - Complete verification
