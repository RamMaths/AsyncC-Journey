# Thread synchronization with locks

## std::mutex

If a thread owning a mutex tries to acquire it again, the resulting behavior is undefined. Usually, an exception is thrown when this happens, but this is implementation-defined. If, after a thread releases a mutex, it tries to release it again, this is also undefined behavior (as in the previous case). A mutex being destroyed while a thread has it locked or a thread terminating without releasing the lock are also causes of undefined behavior.

The std::mutex class has three methods:
- `lock()`: Calling `lock()` acquires the mutex. If the mutex is already locked, then the calling thread is blocked until the mutex is unlocked. From the application’s point of view, it is as if the calling thread waits for the mutex to be available.
- `try_lock()`: When called, this function returns either true, indicating that the mutex has been successfully locked, or false in the event of the mutex being already locked. Note that try_lock is non-blocking, and the calling thread either acquires the mutex or not, but it is not blocked like when calling `lock()`. The `try_lock()` method is generally used when we don’t want the thread to wait until the mutex is available. We will call try_lock() when we want the thread to proceed with some processing and try to acquire the mutex later.
• `unlock()`: Calling `unlock()` releases the mutex.

## std::recursive_mutex

A calling thread may acquire the same mutex more than once. It will own the mutex until it releases the mutex the same number of times it acquired it. For example, if a thread recursively acquires a mutex three times, it will own the mutex until it releases it for the third time. The maximum number of times a recursive mutex can be recursively acquired is unspecified and hence implementation-defined. Once a mutex has been acquired for the maximum number of times, calls to `lock()` will throw std::system_error, and calls to `try_lock()` will return false. Ownership is the same as for std::mutex: if a thread owns a std::recursive_mutex class, any other threads will block if they try to acquire it by calling `lock()`, or they will get false as a return when calling `try_lock()`.

## std::shared_mutex

- **Shared**: Several threads can share the ownership of the same mutex. Shared ownership is acquired/ released calling lock_shared(), try_lock_shared()/unlock shared(). While at least one thread has acquired shared access to the lock, no other thread can get exclusive access to it, but it can acquire shared access.
- **Exclusive**: Only one thread can own the mutex. Exclusive ownership is acquired/released by calling lock(), try_lock()/unlock(). While a thread has acquired exclusive access to the lock, no other thread can acquire either shared or exclusive access to it
