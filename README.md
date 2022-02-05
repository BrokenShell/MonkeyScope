# MonkeyScope
Distribution Tests & Performance Timer for Non-deterministic Functions

### Sister Project:
- Fortuna: Collection of abstractions to make custom random generators. https://pypi.org/project/Fortuna/


### Quick Install `$ pip install MonkeyScope`


### Installation may require the following:
- Python 3.7 or later with dev tools (setuptools, pip, etc.)
- Cython: Bridge from C/C++ to Python.
- Modern C++ compiler and Standard Library. Clang or GCC.

---

## MonkeyScope Specifications
- `MonkeyScope.distribution_timer(func: staticmethod, *args, **kwargs) -> None`
    - Logger for the statistical analysis of non-deterministic generators.
    - @param func :: function, method or lambda to analyze. Evaluated as `func(*args, **kwargs)`
    - @optional_kw num_cycles=10000 :: Total number of samples to use for analysis.
    - @optional_kw post_processor=None staticmethod :: Used to scale a large set of data into a smaller set of groupings for better visualization of the data, esp. useful for distributions of floats. For many functions in quick_test(), math.floor() is used, for others round() is more appropriate. For more complex post processing - lambdas work nicely. Post processing only affects the distribution, the statistics and performance results are unaffected.
- `MonkeyScope.distribution(func: staticmethod, *args, **kwargs) -> None`
    - Stats and distribution.
- `MonkeyScope.timer(func: staticmethod, *args, **kwargs) -> None`
    - Just the function timer.

### MonkeyScope Script Example
```python
import MonkeyScope, random


x, y, z = 1, 10, 2
MonkeyScope.distribution_timer(random.randint, x, y)
MonkeyScope.distribution_timer(random.randrange, x, y)
MonkeyScope.distribution_timer(random.randrange, x, y, z)
```

### Typical Script Output
```
Output Analysis: Random.randint(1, 10)
Typical Timing: 1270 ± 88 ns
Statistics of 1000 samples:
 Minimum: 1
 Median: 5.0
 Maximum: 10
 Mean: 5.425
 Std Deviation: 2.867468395641005
Distribution of 100000 samples:
 1: 10.0%
 2: 10.073%
 3: 10.046%
 4: 10.07%
 5: 10.032%
 6: 9.991%
 7: 9.978%
 8: 10.115%
 9: 9.836%
 10: 9.859%

Output Analysis: Random.randrange(1, 10)
Typical Timing: 1135 ± 69 ns
Statistics of 1000 samples:
 Minimum: 1
 Median: 5.0
 Maximum: 9
 Mean: 5.028
 Std Deviation: 2.605228588819031
Distribution of 100000 samples:
 1: 11.281%
 2: 11.098%
 3: 11.04%
 4: 11.119%
 5: 10.999%
 6: 11.176%
 7: 11.206%
 8: 11.091%
 9: 10.99%

Output Analysis: Random.randrange(1, 10, 2)
Typical Timing: 1332 ± 55 ns
Statistics of 1000 samples:
 Minimum: 1
 Median: 5.0
 Maximum: 9
 Mean: 5.068
 Std Deviation: 2.771890329720857
Distribution of 100000 samples:
 1: 19.868%
 3: 20.025%
 5: 20.001%
 7: 19.811%
 9: 20.295%
```


### Development Log:
##### MonkeyScope 1.4.4
- Resolves bug caused by attempting to generate a distribution of non-numeric values.

##### MonkeyScope 1.4.3
- Updates calling signature of `distribution` and `distribution_timer`

##### MonkeyScope 1.3.4
- Adds toml file to aid installation

##### MonkeyScope 1.3.3
- Documentation Update

##### MonkeyScope 1.3.2
- MonkeyScope no longer requires C++17 compiler. Any C++ compiler should work.

##### MonkeyScope 1.3.1
- Documentation Update
- Nano second precision enabled with time_ns

##### MonkeyScope 1.3.0
- No longer requires numpy
- Requires Python3.7 or later

##### MonkeyScope 1.2.8
- Internal Performance Update
- Final 3.6 release

##### MonkeyScope 1.2.7
- Docs update

##### MonkeyScope 1.2.6
- Installer Update, will properly install numpy as needed.

##### MonkeyScope 1.2.5
- Fixed Typos

##### MonkeyScope 1.2.4
- More minor typos fixed

##### MonkeyScope 1.2.3
- Minor typos fixed.

##### MonkeyScope 1.2.2
- MonkeyScope is now compatible with python notebooks.

##### MonkeyScope 1.2.1
- Documentation update

##### MonkeyScope 1.2.0
- Minor performance improvement.

##### MonkeyScope 1.1.5
- Public Release

##### MonkeyScope Beta 0.1.5
- Installer Update

##### MonkeyScope Beta 0.1.4
- Minor Bug Fix

##### MonkeyScope Beta 0.1.3
- Continued Development

##### MonkeyScope Beta 0.1.2
- Renamed to MonkeyScope

##### MonkeyTimer Beta 0.0.2
- Changed to c++ compiler

##### MonkeyTimer Beta 0.0.1
- Initial Project Setup
