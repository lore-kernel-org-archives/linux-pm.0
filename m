From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 1/2] cpufreq: Documentation: Minor reformatting
Date: Fri,  6 Jan 2017 11:08:04 +0530
Message-ID: <f3a8d4fd3c5a632c6e118a471d44a8fd5af390c8.1483681020.git.viresh.kumar@linaro.org>
Return-path: <linux-doc-owner@vger.kernel.org>
Sender: linux-doc-owner@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, Claudio Scordino <claudio@evidence.eu.com>, linux-doc@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

This patch doesn't change the content of the documentation, but rather
reformat it to make it more readable.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 Documentation/cpu-freq/governors.txt | 205 +++++++++++++++++++----------------
 1 file changed, 112 insertions(+), 93 deletions(-)

diff --git a/Documentation/cpu-freq/governors.txt b/Documentation/cpu-freq/governors.txt
index c15aa75f5227..63eef4cca1b7 100644
--- a/Documentation/cpu-freq/governors.txt
+++ b/Documentation/cpu-freq/governors.txt
@@ -111,82 +111,96 @@ directory.
 
 The CPUfreq governor "ondemand" sets the CPU depending on the
 current usage. To do this the CPU must have the capability to
-switch the frequency very quickly.  There are a number of sysfs file
-accessible parameters:
-
-sampling_rate: measured in uS (10^-6 seconds), this is how often you
-want the kernel to look at the CPU usage and to make decisions on
-what to do about the frequency.  Typically this is set to values of
-around '10000' or more. It's default value is (cmp. with users-guide.txt):
-transition_latency * 1000
-Be aware that transition latency is in ns and sampling_rate is in us, so you
-get the same sysfs value by default.
-Sampling rate should always get adjusted considering the transition latency
-To set the sampling rate 750 times as high as the transition latency
-in the bash (as said, 1000 is default), do:
-echo `$(($(cat cpuinfo_transition_latency) * 750 / 1000)) \
-    >ondemand/sampling_rate
-
-sampling_rate_min:
-The sampling rate is limited by the HW transition latency:
-transition_latency * 100
-Or by kernel restrictions:
-If CONFIG_NO_HZ_COMMON is set, the limit is 10ms fixed.
-If CONFIG_NO_HZ_COMMON is not set or nohz=off boot parameter is used, the
-limits depend on the CONFIG_HZ option:
-HZ=1000: min=20000us  (20ms)
-HZ=250:  min=80000us  (80ms)
-HZ=100:  min=200000us (200ms)
-The highest value of kernel and HW latency restrictions is shown and
-used as the minimum sampling rate.
-
-up_threshold: defines what the average CPU usage between the samplings
-of 'sampling_rate' needs to be for the kernel to make a decision on
-whether it should increase the frequency.  For example when it is set
-to its default value of '95' it means that between the checking
-intervals the CPU needs to be on average more than 95% in use to then
-decide that the CPU frequency needs to be increased.  
-
-ignore_nice_load: this parameter takes a value of '0' or '1'. When
-set to '0' (its default), all processes are counted towards the
-'cpu utilisation' value.  When set to '1', the processes that are
-run with a 'nice' value will not count (and thus be ignored) in the
-overall usage calculation.  This is useful if you are running a CPU
-intensive calculation on your laptop that you do not care how long it
-takes to complete as you can 'nice' it and prevent it from taking part
-in the deciding process of whether to increase your CPU frequency.
-
-sampling_down_factor: this parameter controls the rate at which the
-kernel makes a decision on when to decrease the frequency while running
-at top speed. When set to 1 (the default) decisions to reevaluate load
-are made at the same interval regardless of current clock speed. But
-when set to greater than 1 (e.g. 100) it acts as a multiplier for the
-scheduling interval for reevaluating load when the CPU is at its top
-speed due to high load. This improves performance by reducing the overhead
-of load evaluation and helping the CPU stay at its top speed when truly
-busy, rather than shifting back and forth in speed. This tunable has no
-effect on behavior at lower speeds/lower CPU loads.
-
-powersave_bias: this parameter takes a value between 0 to 1000. It
-defines the percentage (times 10) value of the target frequency that
-will be shaved off of the target. For example, when set to 100 -- 10%,
-when ondemand governor would have targeted 1000 MHz, it will target
-1000 MHz - (10% of 1000 MHz) = 900 MHz instead. This is set to 0
-(disabled) by default.
-When AMD frequency sensitivity powersave bias driver --
-drivers/cpufreq/amd_freq_sensitivity.c is loaded, this parameter
-defines the workload frequency sensitivity threshold in which a lower
-frequency is chosen instead of ondemand governor's original target.
-The frequency sensitivity is a hardware reported (on AMD Family 16h
-Processors and above) value between 0 to 100% that tells software how
-the performance of the workload running on a CPU will change when
-frequency changes. A workload with sensitivity of 0% (memory/IO-bound)
-will not perform any better on higher core frequency, whereas a
-workload with sensitivity of 100% (CPU-bound) will perform better
-higher the frequency. When the driver is loaded, this is set to 400
-by default -- for CPUs running workloads with sensitivity value below
-40%, a lower frequency is chosen. Unloading the driver or writing 0
-will disable this feature.
+switch the frequency very quickly.
+
+Sysfs files:
+
+* sampling_rate:
+
+  Measured in uS (10^-6 seconds), this is how often you want the kernel
+  to look at the CPU usage and to make decisions on what to do about the
+  frequency.  Typically this is set to values of around '10000' or more.
+  It's default value is (cmp. with users-guide.txt): transition_latency
+  * 1000.  Be aware that transition latency is in ns and sampling_rate
+  is in us, so you get the same sysfs value by default.  Sampling rate
+  should always get adjusted considering the transition latency to set
+  the sampling rate 750 times as high as the transition latency in the
+  bash (as said, 1000 is default), do:
+
+  $ echo `$(($(cat cpuinfo_transition_latency) * 750 / 1000)) > ondemand/sampling_rate
+
+* sampling_rate_min:
+
+  The sampling rate is limited by the HW transition latency:
+  transition_latency * 100
+
+  Or by kernel restrictions:
+  - If CONFIG_NO_HZ_COMMON is set, the limit is 10ms fixed.
+  - If CONFIG_NO_HZ_COMMON is not set or nohz=off boot parameter is
+    used, the limits depend on the CONFIG_HZ option:
+    HZ=1000: min=20000us  (20ms)
+    HZ=250:  min=80000us  (80ms)
+    HZ=100:  min=200000us (200ms)
+
+  The highest value of kernel and HW latency restrictions is shown and
+  used as the minimum sampling rate.
+
+* up_threshold:
+
+  This defines what the average CPU usage between the samplings of
+  'sampling_rate' needs to be for the kernel to make a decision on
+  whether it should increase the frequency.  For example when it is set
+  to its default value of '95' it means that between the checking
+  intervals the CPU needs to be on average more than 95% in use to then
+  decide that the CPU frequency needs to be increased.
+
+* ignore_nice_load:
+
+  This parameter takes a value of '0' or '1'. When set to '0' (its
+  default), all processes are counted towards the 'cpu utilisation'
+  value.  When set to '1', the processes that are run with a 'nice'
+  value will not count (and thus be ignored) in the overall usage
+  calculation.  This is useful if you are running a CPU intensive
+  calculation on your laptop that you do not care how long it takes to
+  complete as you can 'nice' it and prevent it from taking part in the
+  deciding process of whether to increase your CPU frequency.
+
+* sampling_down_factor:
+
+  This parameter controls the rate at which the kernel makes a decision
+  on when to decrease the frequency while running at top speed. When set
+  to 1 (the default) decisions to reevaluate load are made at the same
+  interval regardless of current clock speed. But when set to greater
+  than 1 (e.g. 100) it acts as a multiplier for the scheduling interval
+  for reevaluating load when the CPU is at its top speed due to high
+  load. This improves performance by reducing the overhead of load
+  evaluation and helping the CPU stay at its top speed when truly busy,
+  rather than shifting back and forth in speed. This tunable has no
+  effect on behavior at lower speeds/lower CPU loads.
+
+* powersave_bias:
+
+  This parameter takes a value between 0 to 1000. It defines the
+  percentage (times 10) value of the target frequency that will be
+  shaved off of the target. For example, when set to 100 -- 10%, when
+  ondemand governor would have targeted 1000 MHz, it will target
+  1000 MHz - (10% of 1000 MHz) = 900 MHz instead. This is set to 0
+  (disabled) by default.
+
+  When AMD frequency sensitivity powersave bias driver --
+  drivers/cpufreq/amd_freq_sensitivity.c is loaded, this parameter
+  defines the workload frequency sensitivity threshold in which a lower
+  frequency is chosen instead of ondemand governor's original target.
+  The frequency sensitivity is a hardware reported (on AMD Family 16h
+  Processors and above) value between 0 to 100% that tells software how
+  the performance of the workload running on a CPU will change when
+  frequency changes. A workload with sensitivity of 0% (memory/IO-bound)
+  will not perform any better on higher core frequency, whereas a
+  workload with sensitivity of 100% (CPU-bound) will perform better
+  higher the frequency. When the driver is loaded, this is set to 400 by
+  default -- for CPUs running workloads with sensitivity value below
+  40%, a lower frequency is chosen. Unloading the driver or writing 0
+  will disable this feature.
 
 
 2.5 Conservative
@@ -200,23 +214,28 @@ CPU.  This behaviour more suitable in a battery powered environment.
 The governor is tweaked in the same manner as the "ondemand" governor
 through sysfs with the addition of:
 
-freq_step: this describes what percentage steps the cpu freq should be
-increased and decreased smoothly by.  By default the cpu frequency will
-increase in 5% chunks of your maximum cpu frequency.  You can change this
-value to anywhere between 0 and 100 where '0' will effectively lock your
-CPU at a speed regardless of its load whilst '100' will, in theory, make
-it behave identically to the "ondemand" governor.
-
-down_threshold: same as the 'up_threshold' found for the "ondemand"
-governor but for the opposite direction.  For example when set to its
-default value of '20' it means that if the CPU usage needs to be below
-20% between samples to have the frequency decreased.
-
-sampling_down_factor: similar functionality as in "ondemand" governor.
-But in "conservative", it controls the rate at which the kernel makes
-a decision on when to decrease the frequency while running in any
-speed. Load for frequency increase is still evaluated every
-sampling rate.
+* freq_step:
+
+  This describes what percentage steps the cpu freq should be increased
+  and decreased smoothly by.  By default the cpu frequency will increase
+  in 5% chunks of your maximum cpu frequency.  You can change this value
+  to anywhere between 0 and 100 where '0' will effectively lock your CPU
+  at a speed regardless of its load whilst '100' will, in theory, make
+  it behave identically to the "ondemand" governor.
+
+* down_threshold:
+
+  Same as the 'up_threshold' found for the "ondemand" governor but for
+  the opposite direction.  For example when set to its default value of
+  '20' it means that if the CPU usage needs to be below 20% between
+  samples to have the frequency decreased.
+
+* sampling_down_factor:
+
+  Similar functionality as in "ondemand" governor.  But in
+  "conservative", it controls the rate at which the kernel makes a
+  decision on when to decrease the frequency while running in any speed.
+  Load for frequency increase is still evaluated every sampling rate.
 
 3. The Governor Interface in the CPUfreq Core
 =============================================
-- 
2.7.1.410.g6faf27b

