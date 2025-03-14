#include <stop_token>
#include <syncstream>
#include <chrono>
#include <functional>
#include <thread>
#include <iostream>
#include <condition_variable>
#include <mutex>

#define sync_cout std::osyncstream(std::cout)

using namespace std::chrono_literals;
using namespace std::chrono;

template<typename Duration>
class Timeout {
    public:
        typedef std::function<void(void)> Callback;
        Timeout(const Duration timeout, const Callback& callback) 
            : timeout_duration(duration_cast<milliseconds>(timeout)),
              callback(callback),
              thread([this](std::stop_token st) { this->run(st); }) {
            sync_cout << "Timeout Starting with timeout of "
                            << timeout_duration << std::endl;
        }

        void reset() {
            sync_cout << "Timeout: Reset\n";
            cv.notify_one();
        }

        void stop() {
            thread.request_stop();
            cv.notify_one();
        }
        
    private:
        void run(std::stop_token stop_token) {
            std::unique_lock lock(mutex);
            while(!stop_token.stop_requested()) {
                auto status = cv.wait_for(lock, timeout_duration);

                if(stop_token.stop_requested()) {
                    break;
                }

                if(status == std::cv_status::timeout) {
                    sync_cout << "Timeout: No activity detecte, calling callback\n";
                    callback();
                } else {
                    sync_cout << "Timeout: Activity detected, resetting...\n";
                }
            }

            sync_cout << "Timeout: Exit\n";
        }

    std::jthread thread;
    milliseconds timeout_duration;
    std::mutex mutex;
    std::condition_variable cv;
    Callback callback;
};
