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
    if (argc != 2)
        return -1;

    // get file type and path
    string path = argv[1];
    int extIdx = path.find_last_of(".");
    string ext = path.substr(extIdx + 1);
    string exe = path.substr(0, extIdx);
    string prefix = "", suffix = "";

    // compile files to executable in path
    if (ext == "c")
        exec("gcc " + path + " -o " + exe);
    else if (ext == "cpp")
        exec("g++ " + path + " -o " + exe);
    else if (ext == "java") {
        exec("javac " + path);
        prefix = "java ";
        exe += ".class";
    } else if (ext == "py")
        prefix = "python ";

    // now execute and ask if any parameters shall be entered
    cout << exe << endl;
    string params = "";
    getline(cin, params);
    string exeCmd = prefix + exe + " " + params + suffix;
    system(exeCmd.c_str());

    return 0;
}
