# Memory Management in Android Development project

Managing memory in Android is a bit like packing for a long backpacking trip: you have limited space (RAM), and if you don't manage it well, the system will eventually force you to throw things out—or worse, crash your app.

Since Android devices often run multiple apps simultaneously, the system is aggressive about reclaiming memory. Here’s a breakdown of how it works and how to stay out of trouble.

## 1. How Android Manages Memory

- **How Android Manages Memory**

Android uses Generative Garbage Collection (GC). The system automatically identifies objects that are no longer reachable from your code and wipes them to free up space.

- **The Heap**: Every app is assigned a specific amount of heap memory. If you exceed this, you get the dreaded `OutOfMemoryError (OOM)`.

- **The Low Memory Killer (LMK)**: If the whole system runs low on RAM, Android will start killing background processes, starting with the ones the user hasn't touched in a while.

## 2. Common Pitfalls: Memory Leaks

A Memory Leak occurs when an object is no longer needed but is still being held by a reference that won't let the Garbage Collector do its job. In Android, the most common culprit is holding onto a Context (like an Activity) for too long.

- **Frequent Offenders**:

  - **Static Variables**: Storing an Activity or View in a static variable. Because static lives for the life of the process, that Activity can never be cleared.

  - **Inner Classes/Anonymous Listeners**: Non-static inner classes hold an implicit reference to their outer class. If you start a long-running background task in an Activity, that Activity stays in memory until the task finishes.

  - **Unregistered Listeners**: Forgetting to unregister BroadcastReceivers or SensorListeners in onStop() or onDestroy().

## 3. Strategies for Memory Optimization

### A. The ViewModel Pattern

Viewmodels are lifecycle-aware. They survive configuration changes (like screen rotation), ensuring that if the user rotates the device, `you don't have to reload all the data from scratch`.

### B. Efficient Bitmap Handling

Images are memory hogs. In a complex app, loading a full-resolution image for a thumbnail is wasteful.

- **Downsampling**: Use libraries like Glide or Coil. They automatically downsample images to the size required by the ImageView, preventing unnecessary memory usage.

- **Recycling**: When using `RecyclerView`, ensure you are recycling bitmaps correctly. Libraries handle this automatically.

### C. Context Awareness

Never hold a reference to an Activity Context longer than necessary. If you need a Context for a background task, use the `ApplicationContext`.

### D. Weak References

For listeners or callbacks that need to reference an Activity but shouldn't prevent it from being garbage collected, use `WeakReference`.

## 4. Tools for Debugging Memory Issues

- **Android Profiler**: The built-in profiler in Android Studio is your best friend. It allows you to monitor memory usage in real-time and capture heap dumps.

- **LeakCanary**: A third-party library that automatically detects memory leaks and notifies you in development builds.

- **Heap Dump Analysis**: Taking a heap dump and analyzing it can help you identify which objects are consuming the most memory and what is holding references to them.

## 5. Best Practices

- **Use `ApplicationContext` for long-lived objects**.

- **Unregister all listeners in `onStop()` or `onDestroy()`**.

- **Use `ViewModel` to store UI-related data**.

- **Profile your app regularly**.

- **Use `Bitmap.Config.RGB_565` for non-critical images to save memory**.

# How to use profiler in android studio

The **Android Profiler** is the "EKG monitor" for your app. It provides real-time data on how your code impacts the device's CPU, Memory, Network, and Battery.

Here is how to get it running and what to look for.

---

## 1. How to Launch the Profiler

To get accurate data, you should run the profiler on a **physical device** if possible, as emulators can sometimes skew timing and resource results.

1. Connect your device and enable **USB Debugging**.
2. In Android Studio, go to **View > Tool Windows > Profiler**.
3. Click the **+ (New Session)** button in the Profiler window.
4. Select your device and the specific app process you want to inspect.

> **Note:** For the most detailed data (especially for the "Leak" detection), ensure you are running a **"Debuggable"** build variant of your app.

---

## 2. Navigating the Shared Timeline

Once started, you’ll see a scrolling timeline. This is the high-level view of your app's "vitals":

- **CPU:** Shows usage percentages and thread activity.
- **Memory:** Displays the total heap usage. If this line keeps climbing without ever dropping, you likely have a leak.
- **Network:** Shows radio activity and data transfer speeds.
- **Energy:** Estimates battery drain caused by your app.

---

## 3. Deep Dive: The Memory Profiler

Since memory management is usually the biggest headache, here is how to use the specialized Memory view:

1. **Click on the Memory track** in the timeline to expand it.
2. **Force Garbage Collection:** Click the "trash can" icon. If the memory doesn't drop significantly after a few clicks, your app is holding onto objects it doesn't need.
3. **Capture a Heap Dump:**

- Click **Capture heap dump** and then **Record**.

- Android Studio will freeze the app for a moment to take a "snapshot" of every object currently in RAM.

1. **Analyze the Results:** * Look for the **"Leak Detection"** tab in the heap dump results.

- It will specifically flag Activities or Fragments that have been destroyed but are still taking up space.

---

## 4. Deep Dive: The CPU Profiler

If your app feels "janky" or the UI freezes, use the CPU Profiler:

1. **Click the CPU track.**
2. Choose a recording configuration (e.g., **System Trace** is best for identifying UI frame drops).
3. Click **Record**, interact with your app where it feels slow, and click **Stop**.
4. **Look for "Long Frames":** The profiler will highlight frames that took longer than 16ms to render (the limit for 60fps). You can see exactly which method call on the Main Thread caused the delay.

---

## 5. Pro-Tip: Comparison Sessions

One of the best ways to find a leak is to:

1. Start a session and capture a heap dump while the app is on the "Home" screen.
2. Navigate deep into your app, then return to the "Home" screen.
3. Capture a *second* heap dump.
4. **Compare them.** If the second dump has significantly more objects than the first, you’ve found your culprit.

---

# Memory Mangement in jetpack compose project

Memory management in Jetpack Compose is a different beast compared to the old View system. In the "old world," you worried about leaking Activities; in the Compose world, you have to worry about `leaking State`and `Coroutines`during the Recomposition cycle.

Because Compose is functions-based and reactive, memory issues usually stem from objects being recreated too often or not being cleared when a Composable leaves the screen.

## 1. Remember trap

The remember keyword stores an object in the Composition. However, if you store a large object (like a Bitmap or a heavy Database result) inside a remember block without thinking about the lifecycle, you can run into issues.

- **The Risk**: If you use remember for a heavy object in a Composable that stays in the backstack, that memory stays allocated.

- **The Fix**: Use remember for lightweight UI state. Move heavy logic and data-holding to a ViewModel. ViewModels outlive configuration changes but are cleared when the user definitively leaves the screen.

## 2. Side Effects and Leaks

Composable functions can be called many times (Recomposition). If you start a process inside a Composable without a "Manager," you will leak memory or create duplicate processes.

### LaunchedEffect vs. DisposableEffect

- **LaunchedEffect**: Use this for coroutines. It automatically cancels the coroutine when the Composable leaves the Composition, preventing "hanging" background tasks.

- **DisposableEffect**: Use this when you need to clean up non-coroutine resources (like registering/unregistering a listener or a MapView).

```kotlin
DisposableEffect(locationManager) {
    val listener = MyLocationListener { /* ... */ }
    locationManager.register(listener)

    onDispose {
        // This is crucial for memory management!
        locationManager.unregister(listener)
    }
}
```

## 3. State Hoisting and ViewModels

One of the most common causes of "bloated" memory in Compose is holding onto data in the UI layer that should be in the business layer.

| Bad Practice | Why it's bad | Good Practice |
| --- | --- | --- |
| Storing large lists in `mutableStateOf` inside a Composable. | Re-allocated/Reset on config changes unless carefully handled. | Store the list in a ViewModel using StateFlow. |
| Passing a Context deep into Composables. | High risk of leaking the Activity context. | Use Hilt to inject dependencies or use `LocalContext.current` only where needed. |
| Hard-coding heavy images in resources. | High RAM usage. | Use Coil with `rememberAsyncImagePainter` for automatic memory caching. |

## 4. Lamda References  (The silent killer)

 This is a subtle one. If a Composable captures a large object in a lambda, that object might stay in memory as long as the Composition exists.

```kotlin
 // POTENTIAL LEAK
@Composable
func MyComponent(bigObject: BigObject) {
    Button(onClick = { bigObject.doSomething() }) { 
        Text("Click Me")
    }
}
```

If MyComponent stays in the UI tree, bigObject cannot be garbage collected. If you find your heap growing, check if your lambdas are capturing entire ViewModels or Activities unnecessarily.

## 5. How to Profile Compose Memory

When using the Android Studio Profiler with Compose:

- **Check Recomposition Counts**: Use the "Layout Inspector" alongside the Profiler. High recomposition counts often correlate with "Churn" (creating and destroying objects rapidly), which triggers the Garbage Collector and causes lag.

- **Monitor the "CompositionLocal" tree**: Ensure you aren't providing massive objects via CompositionLocalProvider that aren't being cleared.

- **Look for StateStack**: In a Heap Dump, look for androidx.compose.runtime.State. If you see thousands of these for a single screen, you are likely creating state objects inside a loop or a frequently called Composable without remember
