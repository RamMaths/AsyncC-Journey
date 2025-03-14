#include <atomic>
#include <stop_token>
#include <syncstream>
#include <chrono>
#include <functional>
#include <thread>
#include <iostream>

#define sync_cout std::osyncstream(std::cout)

using namespace std::chrono_literals;
using namespace std::chrono;

template<typename Duration>
class Timer {
    public:
        typedef std::function<void(void)> Callback;
        Timer(const Duration interval,
              const Callback& callback) {
            auto value = duration_cast<milliseconds>(interval);
            sync_cout << "Timer: Starting with interval of "
                      << value << std::endl;

            t = std::jthread([&](std::stop_token stop_token) {
                while(!stop_token.stop_requested()) {
                    sync_cout << "Timer: Running callback "
                              << val.load() << std::endl;
                    val++;
                    callback();
                    sync_cout << "Timer: Sleeping...\n";
                    std::this_thread::sleep_for(interval);
                }

                sync_cout << "Timer: Exit\n";
            });
        }

        void stop() {
            t.request_stop();
        }

    private:
        std::jthread t;
        std::atomic_int32_t val { 0 };
};
