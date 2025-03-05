# Processes, Threads, and Services

A process can be defined as an instance of a running program, it includes the program’s code, all the threads belonging to this proces, the stack, the heap and its data section containing global variables and initialized variables. Each process operates within its own virtual address space and is isolated from other processes, ensuring that its operations do not interfere directly with those of others.

- Creation: A new process is created using the `fork()` system call, which creates a new process by duplicating an existing one.
- Execution: After creation, the child process may execute the same code as the parent or use the `exec()` family of system calls to load and run a different program.
- Termination: A process terminates either voluntarily, by calling the `exit()` system call, or involuntarily, due to receiving a signal from another process that causes it to stop

Each process is uniquely identified by a Process ID (PID), an integer that the kernel uses to manage processes.

## Exploring IPC

In the Linux operating system, processes operate in isolation, meaning that they cannot directly access the memory space of other processes. o address these challenges, the Linux kernel provides a versatile set of IPC mechanisms. Each IPC mechanism is tailored to suit different scenarios and requirements, enabling developers to build complex, high-performance applications that leverage asynchronous processing effectively.

Linux supports several IPC mechanisms, each with its unique characteristics and use cases

- **Pipes and named pipes**: unidirectional communication between processes.
- **Signals**: Signals are a form of software interrupt that can be sent to a process to notify it of events.
- **Message queues**: Message queues allow processes to exchange messages in a FIFO manner. Unlike pipes, message queues support asynchronous communication,
- **Semaphores**: Semaphores are used for synchronization, helping processes manage access to shared resources
- **Shared memory**: Shared memory is a fundamental concept in IPC that enables multiple processes to access and manipulate the same segment of physical memory.
- **Sockets**: They provide a way for processes to communicate with each other, either within the same machine or across networks.

## Services and Deamons

In the realm of Linux operating systems, daemons are a fundamental component that runs quietly in the background, silently executing essential tasks without the direct involvement of an interactive user. They are designed to be autonomous and resilient, starting at system boot and running continuously until the system is shut down. Unlike regular processes initiated and controlled by users, daemons possess distinct characteristics:

- Background operation
- User independence
- Task oriented focus

Creating a Deamon process involves:

1. Detaching from the terminal: The `fork()` system call is employed to detach the daemon from the terminal. The parent process exits after the fork, leaving the child process running in the background.
2. Session creation: The `setsid()` system call creates a new session and designates the calling process as the leader of both the session and the process group. This step is crucial for complete detachment from the terminal.
3. Working directory change: To prevent blocking the unmounting of the filesystem, daemons typically change their working directory to the root directory.
4. File descriptor handling: Inherited file descriptors are closed by daemons, and stdin, stdout, and stderr are often redirected to /dev/null.
5. Signal handling: Proper handling of signals, such as SIGHUP for configuration reloading or SIGTERM for graceful shutdown, is essential for effective daemon management.

## Threads

In contrast to processes, which are independent entities with their own private memory space and resources, threads are closely intertwined with the process they belong to. This intimate relationship allows threads to share the same memory space and resources, including file descriptors, heap memory, and any other global data structures allocated by the process.

### Thread lifecycle

1. Creation: This phase begins when a new thread is created in the system. The creation process involves using the function, which takes several parameters. One critical parameter is the thread’s attributes, such as its scheduling policy, stack size, and priority. Another essential parameter is the function that the thread will execute, known as the start routine. Upon its successful creation, the thread is allocated its own stack and other resources.
2. Execution: After creation, the thread starts executing its assigned start routine. During execution, the thread can perform various tasks independently or interact with other threads if necessary. Threads can also create and manage their own local variables and data structures, making them self-contained and capable of performing specific tasks concurrently. Processes, Threads, and Services30
3. Synchronization: To ensure orderly access to shared resources and prevent data corruption, threads employ synchronization mechanisms. Common synchronization primitives include locks, semaphores, and barriers. Proper synchronization allows threads to coordinate their activities, avoiding race conditions, deadlocks, and other issues that can arise in concurrent programming.
4. Termination: A thread can terminate in several ways. It can explicitly call the function to terminate itself. It can also terminate by returning from its start routine. In some cases, a thread can be canceled by another thread using the function. Upon termination, the system reclaims the resources allocated to the thread, and any pending operations or locks held by the thread are released.


## Synchronization primitives

Synchronization primitives are essential tools for managing concurrent access to shared resources in
multithreaded programming. 

- Mutexes: Mutexes are used to enforce exclusive access to critical sections of code. A mutex can be locked by a thread, preventing other threads from entering the protected section until the mutex is unlocked. Mutexes guarantee that only one thread can execute the critical section at any given time, ensuring data integrity and preventing race conditions.
- Semaphores: Semaphores are more versatile than mutexes and can be used for a wider range of synchronization tasks, including signaling between threads. A semaphore maintains an integer counter that can be incremented (signaling) or decremented (waiting) by threads. Semaphores allow for more complex coordination patterns, such as counting semaphores (for resource allocation) and binary semaphores (similar to mutexes).
- Condition variables: Condition variables are used for thread synchronization based on specific conditions. Threads can block (wait on) a condition variable until a particular condition becomes true. Other threads can signal the condition variable, causing waiting threads to wake up and continue execution. Condition variables are often used in conjunction with mutexes to achieve more fine-grained synchronization and avoid busy waiting.
- Additional synchronization primitives: In addition to the core synchronization primitives discussed previously, there are several other synchronization mechanisms: 
    - Barriers: Barriers allow a group of threads to synchronize their execution, ensuring that all threads reach a certain point before proceeding further
    - Read-write locks: Read-write locks provide a way to control concurrent access to shared data, allowing multiple readers but only a single writer at a time
    - Spinlocks: Spinlocks are a type of mutex that involves busy waiting, continuously checking a memory location until it becomes available

When to use them...

- Mutexes: Use mutexes when exclusive access to a critical section is required to ensure data integrity and prevent race conditions
- Semaphores: Use semaphores when more complex coordination patterns are needed, such as resource allocation or signaling between threads
- Condition variables: Use condition variables when threads need to wait for a specific condition to become true before proceeding

## Common problems when using multiple threads

- Race conditions occur when multiple threads access and modify shared data concurrently. The outcome of a race condition depends on the non-deterministic sequencing of threads’ operations, which can lead to unpredictable and inconsistent results. For example, consider two threads that are updating a shared counter. If the threads increment the counter concurrently, the final value may be incorrect due to a race condition.
- Deadlocks occur when two or more threads wait indefinitely for resources held by each other. This creates a cycle of dependencies that cannot be resolved, causing the threads to become permanently blocked. For instance, consider two threads that are waiting for each other to release locks on shared resources. If neither thread releases the lock it holds, a deadlock occurs.
- Starvation occurs when a thread is perpetually denied access to resources it needs to make progress. This can happen when other threads continuously acquire and hold resources, leaving the starved thread unable to execute.
- Livelocks are like deadlocks, but instead of being permanently blocked, the threads remain active and repeatedly try to acquire resources, only without making any progress
