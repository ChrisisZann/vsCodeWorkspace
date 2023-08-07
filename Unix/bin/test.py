import sys
import getopt

# n = int(sys.argv[1])
# print(n+1)

print("Hello, World!")
def usage():
    print("Printing usage!!")

def main():
    try:
        opts, args = getopt.getopt(sys.argv[1:], "ht:v", ["help", "test="])
    except getopt.GetoptError as err:
        # print help information and exit:
        print(err)  # will print something like "option -a not recognized"
        usage()
        sys.exit(2)
    argument_t = None
    verbose = False
    for option, argument in opts:
        if option == "-v":
            verbose = True
        elif option in ("-h", "--help"):
            usage()
            sys.exit()
        elif option in ("-t", "--test"):
            argument_t = argument
        else:
            assert False, "unhandled option"
    # ...

# if __name__ == "__main__":
#     main()
