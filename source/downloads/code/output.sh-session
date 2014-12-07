Script started on Sun Dec  7 15:51:32 2014
[Chris@Bravo ~]$ cd Documents
[Chris@Bravo Documents]$ cd crossplatform
[Chris@Bravo crossplatform]$ ls
Makefile    hello.cpp   hello.out*  helloWorld/ test/
[Chris@Bravo crossplatform]$ cat hello.cpp
#include <iostream>

using namespace std;

int main(int argc, char** argv)
{
#ifdef __APPLE__
 cout << "Hello Apple!" << endl;
#elif __WIN32 
 cout << "Hello Microsoft!" << endl;
#else
 cout << "Hello Stranger!" << endl;
#endif
}
[Chris@Bravo crossplatform]$ make
clang++ -o hello.out hello.cpp
[Chris@Bravo crossplatform]$ ./hello.out
Hello Apple!
[Chris@Bravo crossplatform]$ echo 'HELLO!'
HELLO!
[Chris@Bravo crossplatform]$ echo 'GOODBYE!'
GOODBYE!
[Chris@Bravo crossplatform]$ exit

Script done on Sun Dec  7 15:52:35 2014
