From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: [PATCH 0/3 v6] cpufreq: Add 'load_table' debugfs file to show colleced
 CPUs load
Date: Thu, 18 Jul 2013 20:17:52 +0900
Message-ID: <1374146275-5758-1-git-send-email-cw00.choi@samsung.com>
Return-path: <cpufreq-owner@vger.kernel.org>
Sender: cpufreq-owner@vger.kernel.org
To: viresh.kumar@linaro.org, rjw@sisk.pl, linux-kernel@vger.kernel.org
Cc: linux-pm@vger.kernel.org, cpufreq@vger.kernel.org, kyungmin.park@samsung.com, myungjoo.ham@samsung.com, Chanwoo Choi <cw00.choi@samsung.com>
List-Id: linux-pm@vger.kernel.org

This patchset add 'load_table' debugfs file to provide collected CPUs data.
The load_table debugfs file gives below CPU datas.
- measured time
- old CPU frequency
- new CPU frequency
- Per-CPU load

These data will mean the change of CPU frequency according to CPUs load at
specific measured time. Also, the user can determine the storage size of colleced
CPUs data. The range is from 10 to 1000. The patch3 explain the detailed
description of load_table debugfs file.

Changes since v5:
[patch1/3]
- Refactoring patch v4
- Create again symbolic link of debugfs directory when first CPU dev is removed
  (In this case, many CPUs share only one cpufreq policy)

[patch2/3]
- Determine index value of policy->cpu_debugfs[] according to
  cpumask_weight(policy->cpus) value
- Bug fix, store 'policy->cpu' to 'freq->cpu' before notify
  CPUFREQ_LOADCHECK notification

[patch3/3]
- Add description of test case

Changes since v4:
[patch2/3]
- Reset the data of CPUs load when cpufreq governor is changed
- Move code about creating debugfs directory to below first patch
	: [PATCH 1/2] cpufreq: Add debugfs directory for cpufreq

--
I sent only one patch before v4
and then I divided one patch in 3 patches after v4.

Changes since v3:
- Extend a range of accumulated data (10 ~ 1000)
- Add unit information of time/freq and align 'Time' field as left for readability
- Use CONFIG_CPU_FREQ_STAT depdendency instead of CONFIG_CPU_FREQ_STAT_DETATILS
- Initialize load of offline CPUx as zero(0)
- Create/remove debugfs root directory on cpufreq_stats_init/exit() because
  debugfs root is used on all CPUs.

Changes since v2:
- Code clean according to Viresh Kumar's comment
- Show both old frequency and new frequency on 'load_table' debugfs file
- Change debufs file patch as below
  old: /sys/kernel/debugfs/cpufreq/load_table
  new: /sys/kernel/debugfs/cpufreq/cpuX/load_table

Changes since v1:
- Set maximum storage size to save CPUs load on Kconfig
- Use spinlock to synchronize read/write operation for CPUs load
- Use local variable instead of global variable(struct cpufreq_freqs *freqs)
- Use pointer of data structure to get correct size of data structure
  in sizeof() macro instead of structure name
  : sizeof(struct cpufreq_freqs) -> sizeof(*stat->load_table)
- Change time unit from nanosecond to microsecond
- Remove unnecessary memory copy

Thanks,
Chanwoo Choi

[Test Result]
- condition : Samsung SoC Exynos4412 (all CPUs share one voltage/frequency)

1. [ONDEMAND governor, the number of online CPU is 4]
-sh-4.1# ls -al /sys/kernel/debug/cpufreq/
total 0
drwxr-xr-x  3 root root 0 Jan  1 09:00 .
drwx------ 28 root root 0 Jan  1 09:00 ..
drwxr-xr-x  2 root root 0 Jan  1 09:00 cpu0
lrwxrwxrwx  1 root root 0 Jan  1 09:00 cpu1 -> ./cpu0
lrwxrwxrwx  1 root root 0 Jan  1 09:00 cpu2 -> ./cpu0
lrwxrwxrwx  1 root root 0 Jan  1 09:00 cpu3 -> ./cpu0

-sh-4.1# cat /sys/kernel/debug/cpufreq/cpu0/load_table
Time(ms)   Old Freq(Hz) New Freq(Hz) CPU0 CPU1 CPU2 CPU3
135720     400000       400000       56   52   53   91
135820     400000       400000       67   65   83   64
135920     400000       400000       67   66   77   67
136020     400000       1100000      40   41   98   37
136120     1100000      600000       21   24   43   32
136220     600000       600000       29   36   25   87
136320     600000       600000       83   45   44   44
136420     600000       300000       38   27   37   45
136520     300000       1100000      48   45   49   97
136620     1100000      900000       28   38   26   74

2. [ONDEMAND governor, the number of online CPU is 3]
-sh-4.1# ls -al /sys/kernel/debug/cpufreq/
total 0
drwxr-xr-x  3 root root 0 Jan  1 09:02 .
drwx------ 28 root root 0 Jan  1 09:00 ..
drwxr-xr-x  2 root root 0 Jan  1 09:00 cpu0
lrwxrwxrwx  1 root root 0 Jan  1 09:00 cpu1 -> ./cpu0
lrwxrwxrwx  1 root root 0 Jan  1 09:00 cpu3 -> ./cpu0

-sh-4.1# cat /sys/kernel/debug/cpufreq/cpu0/load_table
Time(ms)   Old Freq(Hz) New Freq(Hz) CPU0 CPU1 CPU3
156720     200000       200000       60   60   60
156820     200000       200000       61   58   60
156930     200000       200000       61   61   59
157020     200000       200000       61   67   61
157120     200000       200000       63   66   63
157230     200000       200000       61   61   60
157320     200000       200000       60   63   61
157420     200000       200000       61   61   60
157520     200000       200000       69   69   69
157620     200000       200000       93   95   94
<s/devices/system/cpu/cpu0/cpufreq/scaling_governor

3. [PERFORMANCE governor, the number of online CPU is 3]
-sh-4.1# echo performance > /sys/kernel/debug/cpufreq/cpu0/cpufreq/scaling_governor
-sh-4.1# cat /sys/kernel/debug/cpufreq/cpu0/load_table
Time(ms)   Old Freq(Hz) New Freq(Hz) CPU0 CPU1 CPU3
0          0            0            0    0    0
0          0            0            0    0    0
0          0            0            0    0    0
0          0            0            0    0    0
0          0            0            0    0    0
0          0            0            0    0    0
0          0            0            0    0    0
0          0            0            0    0    0
0          0            0            0    0    0
0          0            0            0    0    0

Chanwoo Choi (3):
  cpufreq: Add debugfs directory for cpufreq
  cpufreq: stats: Add 'load_table' debugfs file to show accumulated data of CPUs
  Documentation: cpufreq: load_table: Update load_table debugfs file documentation

 Documentation/cpu-freq/cpufreq-stats.txt |  40 ++++-
 drivers/cpufreq/Kconfig                  |   6 +
 drivers/cpufreq/cpufreq.c                | 181 ++++++++++++++++++++++
 drivers/cpufreq/cpufreq_governor.c       |  14 ++
 drivers/cpufreq/cpufreq_stats.c          | 258 ++++++++++++++++++++++++++++---
 include/linux/cpufreq.h                  |   7 +
 6 files changed, 478 insertions(+), 28 deletions(-)

-- 
1.8.0

