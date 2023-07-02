'''
LOAD RX NUMBER:
    00 Binary(X) 00
    Binary(NUMBER)
JNZ RX NUMBER:
    00 Binary(X) 01
    Binary(NUMBER)
ADD RX RY:
    01 Binary(X) Binary(Y)
SUB RX RY:
    10 Binary(X) Binary(Y)
MULT RX RY:
    11 Binary(X) Binary(Y)

'''
header = "library IEEE;\nuse IEEE.STD_LOGIC_1164.all;\nuse IEEE.STD_LOGIC_unsigned.all;\nuse ieee.numeric_std.all; \nentity Memory is	\n	port(\n	     Address : in std_logic_vector(5 downto 0);\n		 Data : out std_logic_vector(5 downto 0)\n		 );	\nend Memory;\narchitecture Memory of Memory is\ntype mem_type is array(0 to 63) of std_logic_vector(5 downto 0);\nsignal ROM : mem_type;\nbegin"
footer ="Data <= m(to_integer(unsigned(Address)));\nend Memory;"

reg_dic = {"R0": "00", "R1": "01", "R2": "10", "R3": "11", }
def getIn6bitBinaryFormat(Integer: int):
    binary = bin(Integer)[2:]
    while(len(binary) < 6): binary = "0" + binary
    return binary
def getCodeInBinaryFormat(file_path):
    output = ""
    try:
        f = open(file_path, "r")
    except: 
        print("File not found")
    try:
        for line in f:
            
            parts = line.upper().split()
            if parts[0] == "LOAD":
               output.append("00" + reg_dic[parts[1]] + "00")
               output.append(getIn6bitBinaryFormat(int(parts[2])))
            elif parts[0] == "JNZ":
                output.append("00" + reg_dic[parts[1]] + "01")
                output.append(getIn6bitBinaryFormat(int(parts[2])))
            elif parts[0] == "ADD":
                output.append("01" + reg_dic[parts[1]] + reg_dic[parts[2]])
            elif parts[0] == "SUB":
                output.append("10" + reg_dic[parts[1]] + reg_dic[parts[2]])
            elif parts[0] == "MULT":
                output.append("11" + reg_dic[parts[1]] + reg_dic[parts[2]])
            else:
                print("Invalid OP code: " + parts[0] + "")
                return ""
    except: 
        print("Syntax error")
    f.close()
    return output


def getVHDLCode(binaryCode):
    output = header
    for i, code in enumerate(binaryCode):
        output += "\nROM("+ str(i) +") <= " + code + ";"
    return output + "\n" + footer

def Main(_argv):
    code = getVHDLCode(getCodeInBinaryFormat(_argv[0]))
    f = open("outputDesign1.txt", "w")
    f.write(code)
    f.close()

if __name__ == "__main__":
    import sys
    Main(sys.argv[1:])
    