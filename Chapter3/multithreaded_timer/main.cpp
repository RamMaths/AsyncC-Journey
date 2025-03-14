#include "timer.cpp"
#include "timeout.cpp"
#include <syncstream>
#include <thread>

#define sync_cout std::osyncstream(std::cout)

using namespace std::chrono_literals;
using namespace std::chrono;

int main(void) {
    sync_cout << "Main: Create timeout\n";

    Timeout timeout(3s, [&]() {
        sync_cout << "Callback: No activity for 3s!\n";
    });

    std::this_thread::sleep_for(1s);
    sync_cout << "Main: Resetting timeout\n";
    timeout.reset();

    std::this_thread::sleep_for(1s);
    sync_cout << "Main: Resetting timeout\n";
    timeout.reset();

    std::this_thread::sleep_for(4s);
    sync_cout << "Main: Stopping timeout\n";
    timeout.stop();

    std::this_thread::sleep_for(500ms);
    sync_cout << "Main: Exit\n";
    return 0;
}
