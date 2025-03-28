#pragma once

#include <mutex>
#include <semaphore>
#include <vector>

template <typename T>
class synchronized_queue_semaphores {
public: 
    explicit synchronized_queue_semaphores(size_t size) :
        capacity_ { size }, buffer_ (capacity_) {
    }

    void push(const T& item) {
        sem_empty_.acquire();

        std::unique_lock<std::mutex> lock(mtx_);

        buffer_[tail_] = item;
        tail_ = next(tail_);

        lock.unlock();
        sem_full_.release();
    }

    bool try_push(const T& item) {
        if(!sem_empty_.try_acquire()) {
            return false;
        }

        std::unique_lock<std::mutex> lock(mtx_, std::try_to_lock);

        buffer_[tail_] = item;
        tail_ = next(tail_);

        lock.unlock();

        sem_full_.release();

        return true;
    }

    void pop(T& item) {
        sem_full_.acquire();

        std::unique_lock<std::mutex> lock(mtx_);

        item = buffer_[head_];
        head_ = next(head_);

        lock.unlock();
        sem_empty_.release();
    }

    bool try_pop(T& item) {
        if(!sem_full_.try_acquire()) {
            return false;
        }
            
        std::unique_lock<std::mutex> lock(mtx_, std::try_to_lock);

        item = buffer_[head_];
        head_ = next(head_);

        head_ = next(head_);

        lock.unlock();

        sem_empty_.release();

        return true;
    }

private:
    [[nodiscard]] std::size_t next(std::size_t index) const noexcept {
        return ((index + 1) % capacity_);
    }

    std::mutex mtx_;
    std::counting_semaphore<> sem_empty_;
    std::counting_semaphore<> sem_full_;

    std::size_t head_ { 0 };
    std::size_t tail_ { 0 };
    std::size_t capacity_ { 0 };
    std::vector<T> buffer_ { 0 };
};
