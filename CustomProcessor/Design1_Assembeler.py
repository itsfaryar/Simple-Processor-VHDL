
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
            binary_code = ""
            if parts[0] == "LOAD":
                binary_code += "00" + reg_dic[parts[1]] + "00" + "\n" + getIn6bitBinaryFormat(int(parts[2]))
            elif parts[0] == "ADD":
                binary_code += "01" + reg_dic[parts[1]] + reg_dic[parts[2]]
            elif parts[0] == "SUB":
                binary_code += "10" + reg_dic[parts[1]] + reg_dic[parts[2]]
            elif parts[0] == "JNZ":
                binary_code += "11" + reg_dic[parts[1]] + "00" + "\n" + getIn6bitBinaryFormat(int(parts[2]))
            else:
                print("Invalid OP code: " + parts[0] + "")
                return ""
            output += binary_code + "\n"
    except: 
        print("Syntax error")
    f.close()
    return output
    


def Main(_argv):
    binaryCode = getCodeInBinaryFormat(_argv[0])
    print(binaryCode)
    f = open("outputDesign1.txt", "w")
    f.write(binaryCode)
    f.close()

if __name__ == "__main__":
    import sys
    Main(sys.argv[1:])
    