# Simple-Processor-VHDL
## Description
#### Project Processor 6 OP-Code: LOAD, SUM, SUB, JNZ 
#### LOAD: laods a data from a regester(there are 4 regesters from R0 to R4 available to load data from
#### SUM: For example
#### SUM R0 R1 means R0 = R0 + R1
#### SUB: For example
#### SUB R0 R1 means R0 = R0 - R1
#### JNZ : Jumps to the address in ROM when the Regester is not zero For example
  #### JNZ Rx, Address means
  #### if (Rx != 0) PC = M[PC]
  #### else PC = PC + 1

فایل در دو صورت دیزایل ۱ و ۲ طراحی شده است و هریک به ترتیب برای بخش‌های ۱ و ۳ است.

فایل‌های تبدیل کد اسمبلی به باینری نیز در پوشه‌ی کاستوم پراسسور موجود بوده و قادر به برنامه‌ریزی مستقیم فایل مموری مربوطه است.