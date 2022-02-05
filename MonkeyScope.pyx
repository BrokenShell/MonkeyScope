#!python3
#distutils: language = c++
import time
import math
from typing import Callable
from statistics import median_low, median_high, stdev, mean


__all__ = ("timer", "distribution", "distribution_timer")


def timer(func: Callable, *args, cycles: int = 256, **kwargs):
    results = []
    for i in range(cycles):
        for _ in range(100):
            _ = func(*args, **kwargs)
        start = time.perf_counter_ns()
        for _ in range(cycles):
            _ = func(*args, **kwargs)
        end = time.perf_counter_ns()
        t_time = end - start
        results.append(t_time / cycles)
    n = stdev(results) / 2
    m = min(results) + n
    print(f"Typical Timing: {int(math.ceil(m))} ± {int(math.ceil(n))} ns")


def distribution(func: Callable,
                 *args,
                 num_cycles: int = 1000000,
                 post_processor: Callable = None,
                 stats: bool = True,
                 **kwargs):
    results = [func(*args, **kwargs) for _ in range(num_cycles)]
    if isinstance(results[0], list):
        for i, _ in enumerate(results):
            results[i] = results[i][0]
    if stats:
        try:
            stat_samples = results[:1000]
            if isinstance(stat_samples[0], str):
                stat_samples = list(map(float, stat_samples))
            med_lo, med_hi = median_low(stat_samples), median_high(stat_samples)
            med = med_lo if med_lo == med_hi else (med_lo, med_hi)
            output = (
                f" Minimum: {min(stat_samples)}",
                f" Median: {med}",
                f" Maximum: {max(stat_samples)}",
                f" Mean: {mean(stat_samples)}",
                f" Std Deviation: {stdev(stat_samples)}",
            )
            print(f"Statistics of {len(stat_samples)} samples:")
            print("\n".join(output))
        except ValueError:
            pass
        except TypeError:
            pass
    if post_processor is None:
        processed_results = results
        print(f"Distribution of {num_cycles} samples:")
        unique_results = list(set(results))
    else:
        processed_results = list(map(post_processor, results))
        unique_results = list(set(processed_results))
        print(f"{post_processor.__name__} distribution of {num_cycles}:")
    try:
        unique_results.sort()
    except TypeError:
        pass
    result_obj = {
        key: f"{processed_results.count(key) / (num_cycles / 100)}%"
        for key in unique_results
    }
    for key, val in result_obj.items():
        print(f" {key}: {val}")


def distribution_timer(func: Callable,
                       *args,
                       num_cycles: int = 100000,
                       label: str = "",
                       post_processor: Callable = None,
                       stats: bool = True,
                       **kwargs):

    def quote_str(value):
        return f'"{value}"' if isinstance(value, str) else str(value)

    arguments = ', '.join([quote_str(v) for v in args] + [f'{k}={quote_str(v)}' for k, v in kwargs.items()])
    if label:
        print(f"Output Analysis: {label}")
    elif hasattr(func, "__qualname__"):
        print(f"Output Analysis: {func.__qualname__}({arguments})")
    elif hasattr(func, "__name__"):
        print(f"Output Analysis: {func.__name__}({arguments})")
    else:
        print(f"Output Analysis: {func}({arguments})")
    timer(func, *args, **kwargs)
    distribution(
        func,
        *args,
        num_cycles=num_cycles,
        post_processor=post_processor,
        stats=stats,
        **kwargs,
    )
    print("")
