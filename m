From: Alex Shi <alex.shi@linaro.org>
Subject: [PATCH v2 0/3] per cpu resume latency
Date: Thu, 12 Jan 2017 21:27:01 +0800
Message-ID: <1484227624-6740-1-git-send-email-alex.shi@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, vincent.guittot@linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

V2 changes: remove #ifdef CONFIG_CPU_IDLE_GOV_MENU for func
dev_pm_qos_expose_latency_limit(), since we have CONFIG_PM.

---
cpu_dma_latency is designed to keep all cpu awake from deep c-state.
That is good keep system with short response latency. But sometime we
don't need all cpu power especially in a more and more multi-core day.
So set all cpu restless that lead to a big power waste.

A better way is to keep the short cpu response latency on needed cpu, 
while let other unnecesscary cpus go to deep idle. That is this 
patchset. We just use the pm_qos_resume_latency on cpu. Giving the 
short cpu latency on appointed cpu via setting value on
/sys/devices/system/cpu/cpuX/power/pm_qos_resume_latency_us
We can set we wanted latency value according to the value of
/sys/devices/system/cpu/cpuX/cpuidle/stateX/latency. to just a bit
less related state's latency value. Then cpu can get to this state or
higher.

Here is some testing data on my dragonboard 410c, the latency of state1
is 280us. It has 4 cores.

Benchmark: cyclictest -t 1  -n -i 10000 -l 1000 -q --latency=10000

without the patch:
Latency (us) Min:     87 Act:  209 Avg:  205 Max:     239
With the patch and cpu0/power/pm_qos_resume_latency_us is lower than
280us, like any value between 1 to 279
benchmark result on cpu0:
Latency (us) Min:     82 Act:   91 Avg:   95 Max:     110
In repeat testing, the Avg latency always drop to half of vanilla kernel
value, as well as Max latency value, although sometime the Max latency
is similar with vanilla kernel. 

Also we could use the cpu_dma_latency to get the similar short latency.
But 'idlestate' show all cpu are restless. Here is the idle status 
compression between cpu_dma_latency and this feature:

To record idlestate
#./idlestat --trace -t 10 -f /tmp/mytracepmlat -p -c -w -- cyclictest -t 1  -n -i 10000 -l 1000 -q --latency=10000

To compare the idle state, the 'total' colum show cpu1~3 nearly stay
in WFI state with cpu_dma_latency. but w/ my patch, they can get about
10 second sleep in 'spc' state.
# ./idlestat --import -f /tmp/mytracepmlat -b /tmp/mytrace -r comparison
Log is 10.055305 secs long with 7514 events
Log is 10.055370 secs long with 7545 events
--------------------------------------------------------------------------------
| C-state  |   min    |   max    |   avg    |   total  | hits  |  over | under |
--------------------------------------------------------------------------------
| clusterA                                                                     |
--------------------------------------------------------------------------------
|      WFI |      2us |  12.88ms |   4.18ms |    9.76s |  2334 |     0 |     0 |
|          |     -2us |  -14.4ms |    -17us |  -72.5ms |    -8 |     0 |     0 |
--------------------------------------------------------------------------------
|             cpu0                                                             |
--------------------------------------------------------------------------------
|      WFI |      3us | 100.98ms |  26.81ms |   10.03s |   374 |     0 |     0 |
|          |     -1us |     -1us |   -350us |   +5.0ms |    +5 |     0 |     0 |
--------------------------------------------------------------------------------
|             cpu1                                                             |
--------------------------------------------------------------------------------
|      WFI |    280us |   3.96ms |   1.96ms |  19.64ms |    10 |     0 |     5 |
|          |   +221us | -891.7ms |   -9.1ms |    -9.9s |  -889 |     0 |     0 |
|      spc |    234us |  19.71ms |   9.79ms |    9.91s |  1012 |     4 |     0 |
|          |   +167us |  +17.9ms |   +8.6ms |    +9.9s | +1009 |    +1 |     0 |
--------------------------------------------------------------------------------
|             cpu2                                                             |
--------------------------------------------------------------------------------
|      WFI |     86us |   1.01ms |    637us |   1.91ms |     3 |     0 |     0 |
|          |    -16us |  -26.5ms |   -8.8ms |   -10.0s | -1057 |     0 |     0 |
|      spc |    930us |  47.67ms |  10.05ms |    9.92s |   987 |     2 |     0 |
|          |   -1.4ms |  +43.7ms |   +6.9ms |    +9.9s |  +985 |    +2 |     0 |
--------------------------------------------------------------------------------
|             cpu3                                                             |
--------------------------------------------------------------------------------
|      WFI |      0us |      0us |      0us |      0us |     0 |     0 |     0 |
|          |          |    -4.0s | -152.1ms |   -10.0s |   -66 |     0 |     0 |
|      spc |    420us |    3.50s | 913.74ms |   10.05s |    11 |     3 |     0 |
|          |   -891us |    +3.5s | +911.0ms |   +10.0s |    +8 |    +1 |     0 |
--------------------------------------------------------------------------------

Thanks
Alex
