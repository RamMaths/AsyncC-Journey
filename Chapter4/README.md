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

## Timed mutex types

They are similar to their non-timed counterparts and implement the following additional functions to allow waiting for the lock to be available for a specific period of time:
- `try_lock_for()`: Tries to lock the mutex and blocks the thread until the specified time duration has elapsed (timed out). If the mutex is locked before the specified time duration, then it returns true; otherwise, it returns false. If the specified time duration is less than or equal to zero (`timeout_duration.zero()`), then the function behaves exactly like `try_lock()`. This function may block for longer than the specified duration due to scheduling or contention delays.
- `try_lock_until()`: Tries to lock the mutex until the specified timeout time or the mutex is locked, whichever comes first. In this case, we specify an instance in the future as a limit for the waiting.

## Problems when using locks

### Deadlocks

This is called a deadlock because both threads will be blocked forever waiting for each other to release the required mutex.

### Livelocks

The threads are unable to do anything but acquire a lock, wait, release the lock, and do the same again. This situation is called livelock because the threads are not just waiting forever (as in the deadlock case), but they are kind of alive and acquire and release a lock continuously.

## Generic lock management

|Mutex Manager Class|Supported Mutex types|Mutexes Managed|
|---|---|---|
|`std::lock_guard`|All|1|
|`std::scoped_lock`|All|Zero or more|
|`std::unique_lock`|All|1|
|`std::shared_lock`|`std::shared_mutex` `std::shared_timed_mutex`|1|

### std::lock_guard

The std::lock_guard class is a Resource Acquisition Is Initialization (RAII) class that makes it easier to use mutexes and guarantees that a mutex will be released when the lock_guard destructor is called and automatically acquires the mutex in its constructor.

### std::unique_lock

The std::unique_lock constructor accepts a tag as its second parameter to indicate what we want to do with the underlying mutex. There are three options:
- `std::defer_lock`: Does not acquire ownership of the mutex. The mutex is not locked in the constructor, and it will not be unlocked in the destructor if it is never acquired.
- `std::adopt_lock`: Assumes that the mutex has been acquired by the calling thread. It will be released in the destructor. This option is also available for `std::lock_guard`.
- `std::try_to_lock`: Try to acquire the mutex without blocking.

### std::scoped_lock

The main difference is that std::unique_lock, as its name implies, just wraps one mutex, but std::scoped_lock wraps zero or more mutexes. Also, the mutexes are acquired in the order they are passed to the std::scoped_lock constructor, hence avoiding deadlock.

### std::shared_lock

The std::shared_lock class is another general-purpose mutex ownership wrapper. As with std::unique_lock and std::scoped_lock, it allows deferred locking and transferring the lock ownership.

## Condition variables

Condition variables are another synchronization primitive provided by the C++ Standard Library. They allow multiple threads to communicate with each other. They also allow for several threads to wait for a notification from another thread. Condition variables are always associated with a mutex.
