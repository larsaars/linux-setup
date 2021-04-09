#include <chrono>
#include <cmath>
#include <cstdio>
#include <cstdlib>
#include <cstring>
#include <fstream>
#include <iomanip>
#include <iostream>
#include <map>
#include <sstream>
#include <string>
#include <vector>

using namespace std;

/*
 * this program shall compile and execute programs determined by their filetype
 */

string exec(string cmd0) {
    const char *cmd = cmd0.c_str();

    array<char, 128> buffer;
    string result;
    unique_ptr<FILE, decltype(&pclose)> pipe(popen(cmd, "r"), pclose);
    if (!pipe) {
        throw std::runtime_error("popen() failed!");
    }
    while (fgets(buffer.data(), buffer.size(), pipe.get()) != nullptr) {
        result += buffer.data();
    }

    return result;
}

int main(int argc, char **argv) {
    // check if all arguments exist
    if (argc != 2) {
        cout << "arguments missing (full path) or too many args!";
        return -1;
    }

    // variables
    string mode = "";
    bool release = true;
    // get file type and path
    string path = argv[1];
    int extIdx = path.find_last_of(".");
    string ext = path.substr(extIdx + 1);
    string exe = path.substr(0, extIdx);
    // prefix to command
    string prefix = "";

    // get mode (debug or release)
    if (ext == "c" || ext == "cpp") {
        cout << "mode? ([d]ebug | [c]ompile only for debuggin | [v]algrind | "
                "[R]elease)"
             << endl;
        getline(cin, mode);
        release = (mode == "r" || mode == "" || mode == "R");
    }

    // inform that is compiling
    cout << "compiling..." << endl;

    // compile files to executable in path
    if (ext == "c") {
        if (release)
            exec("gcc \"" + path + "\" -o \"" + exe + "\"");
        else
            exec("gcc -g -O0 \"" + path + "\" -o \"" + exe + "\"");
    } else if (ext == "cpp") {
        if (release)
            exec("g++ \"" + path + "\" -o \"" + exe + "\"");
        else
            exec("g++ -o0 -ggdb3 \"" + path + "\" -o \"" + exe + "\"");
    } else if (ext == "java") {
        exec("javac \"" + path + "\"");
        prefix = "java ";
        exe += ".class";
    } else if (ext == "py") {
        prefix = "python ";
        exe = path;
    }

    // now execute and ask if any parameters shall be entered
    // print name of executable
    cout << exe << endl;
    // read out params
    string params = "";
    if (mode != "d") {
        getline(cin, params);
    }
    // get exe command
    string exeCmd = "echo \"not executing\"";
    if (release)
        exeCmd = prefix + "\"" + exe + "\" " + params;
    else if (mode == "d") {
        cout << "tips:\n- set breakpoint at main with 'break main'\n-then run "
                "program with 'run param1 param2 ... paramN'\n- step forward "
                "with 'n' or 's' and then 'enter'"
             << endl;
        exeCmd = "cgdb \"" + exe + "\"";
    } else if (mode == "v") {
        exeCmd =
            "valgrind --leak-check=full --show-leak-kinds=all "
            "--track-origins=yes --verbose --log-file=valgrind-out.txt \"" +
            exe + "\" " + params;
        cout << endl << exec("cat valgrind-out.txt") << endl;
    }

    // execute
    system(exeCmd.c_str());

    // if valgrind ran
    if (mode == "v")
        cout << endl
             << "valgrind log can be found in ./valgrind-out.txt" << endl;

    return 0;
}
