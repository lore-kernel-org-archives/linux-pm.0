From: Steve Muckle <steve.muckle@linaro.org>
Subject: [RFCv6 PATCH 00/10] sched: scheduler-driven CPU frequency selection
Date: Tue,  8 Dec 2015 22:19:21 -0800
Message-ID: <1449641971-20827-1-git-send-email-smuckle@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f44.google.com ([209.85.220.44]:35988 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751281AbbLIGTf (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 9 Dec 2015 01:19:35 -0500
Received: by pacdm15 with SMTP id dm15so24604953pac.3
        for <linux-pm@vger.kernel.org>; Tue, 08 Dec 2015 22:19:35 -0800 (PST)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, Morten Rasmussen <morten.rasmussen@arm.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Juri Lelli <Juri.Lelli@arm.com>, Patrick Bellasi <patrick.bellasi@arm.com>, Michael Turquette <mturquette@baylibre.com>

Scheduler-driven CPU frequency selection hopes to exploit both
per-task and global information in the scheduler to improve frequency
selection policy and achieve lower power consumption, improved
responsiveness/performance, and less reliance on heuristics and
tunables. For further discussion of this integration see [0].

This patch series implements a cpufreq governor which collects CPU
capacity requests from the fair, realtime, and deadline scheduling
classes. The fair and realtime scheduling classes are modified to make
these requests. The deadline class is not yet modified to make CPU
capacity requests.

The last RFC posting of this was RFCv5 [1] as part of a larger posting
including energy-aware scheduling. Scheduler-driven CPU frequency
scaling is contained in patches 37-46 of [1]. Changes in this series
since RFCv5:

 - the API to request CPU capacity changes is extended beyond the fair
   scheduling class to the realtime and deadline classes
 - the realtime class is modified to make CPU capacity requests
 - recalculated capacity is converted to a supported target frequency
   to test if a frequency change is actually required
 - allow any CPU to change the frequency domain capacity, not just a
   CPU that is driving the maximum capacity in the frequency domain 
 - cpufreq_driver_might_sleep has been changed to cpufreq_driver_is_slow,
   since it is possible a driver may not sleep but still be too slow to
   be called in scheduler hot paths
 - capacity requests which occur while throttled are no longer lost
 - cleanups based on RFCv5 lkml feedback
 - initialization, static key management fixes

Profiling results:
Performance profiling has been done by using rt-app [2] to generate
various periodic workloads with a particular duty cycle. The time to
complete the busy portion of the duty cycle is measured and overhead
is calculated as

overhead = (busy_duration_test_gov - busy_duration_perf_gov)/
         (busy_duration_pwrsave_gov - busy_duration_perf_gov)

This shows as a percentage how close the governor is to running the
workload at fmin (100%) or fmax (0%). The number of times the busy
duration exceeds the period of the periodic workload (an "overrun") is
also recorded. In the table below the performance of the ondemand
(sampling_rate = 20ms), interactive (default tunables), and
scheduler-driven governors are evaluated using these metrics. The test
platform is a Samsung Chromebook 2 ("Peach Pi"). The workload is
affined to CPU0, an A15 with an fmin of 200MHz and an fmax of
2GHz. The interactive governor was incorporated/adapted from [3]. A
branch with the interactive governor and a few required dependency
patches for ARM is available at [4].

More detailed explanation of the columns below:
run: duration at fmax of the busy portion of the periodic workload in msec
period: duration of the entire period of the periodic workload in msec
loops: number of iterations of the periodic workload tested
OR: number of instances of overrun as described above
OH: overhead as calculated above

SCHED_OTHER workload:
 wload parameters	  ondemand        interactive     sched	
run	period	loops	OR	OH	OR	OH	OR	OH
1	100	100	0	51.83%	0	99.74%	0	99.76%
10	1000	10	0	24.73%	0	19.41%	0	50.09%
1	10	1000	0	19.34%	0	62.81%	7	62.85%
10	100	100	0	11.20%	0	15.84%	0	33.48%
100	1000	10	0	1.62%	0	1.82%	0	6.64%
6	33	300	0	13.73%	0	7.98%	1	33.32%
66	333	30	0	1.87%	0	3.11%	0	12.39%
4	10	1000	1	6.08%	1	10.92%	3	6.63%
40	100	100	0	0.98%	0	0.06%	1	2.92%
400	1000	10	0	0.40%	0	0.50%	0	1.26%
5	9	1000	1	3.38%	2	5.87%	6	3.76%
50	90	100	0	1.78%	0	0.03%	1	1.56%
500	900	10	0	0.32%	0	0.37%	0	1.64%
9	12	1000	2	1.57%	1	0.16%	3	0.47%
90	120	100	0	1.25%	0	0.02%	1	0.45%
900	1200	10	0	0.19%	0	0.24%	0	0.87%

SCHED_FIFO workload:
 wload parameters	  ondemand        interactive     sched	
run	period	loops	OR	OH	OR	OH	OR	OH
1	100	100	0	65.10%	0	99.84%	0	100.00%
10	1000	10	0	96.01%	0	21.08%	0	87.88%
1	10	1000	0	14.11%	0	61.98%	0	62.53%
10	100	100	34	49.89%	0	14.28%	0	68.58%
100	1000	10	1	46.29%	0	1.89%	0	23.78%
6	33	300	50	25.36%	0	8.20%	2	33.42%
66	333	30	10	34.97%	0	3.02%	0	27.07%
4	10	1000	0	5.62%	0	11.00%	9	10.94%
40	100	100	8	10.02%	0	0.11%	1	10.65%
400	1000	10	3	8.17%	0	0.50%	0	6.27%
5	9	1000	1	3.21%	1	5.79%	11	4.79%
50	90	100	12	8.44%	0	0.03%	1	4.74%
500	900	10	4	8.72%	0	0.41%	0	4.05%
9	12	1000	48	1.94%	0	0.01%	10	0.79%
90	120	100	27	6.19%	0	0.01%	1	1.44%
900	1200	10	5	4.95%	0	0.22%	0	1.83%

Note that at this point RT CPU capacity is measured via rt_avg. For
the above results sched_time_avg_ms has been set to 50ms.

Known issues:
 - The sched governor suffers more overruns with SCHED_OTHER than ondemand
   or interactive. This is likely due to PELT's slow responsiveness but
   ore analysis is required.
 - More testing with real world type workloads, such as UI workloads and
   benchmarks, is required.
 - The power side of the characterization is yet to be done.
 - The locking in cpufreq will be improved in a separate patchset. Once
   that is complete this series will be updated so the hot path relies
   only on RCU read locking.
 - Deadline scheduling class does not yet make CPU capacity requests.
 - Throttling is not yet supported on platforms with fast cpufreq
   drivers.

Dependencies:
Frequency invariant load tracking is required. For heterogeneous
systems such as big.Little, CPU invariant load tracking is required as
well. The required support for ARM platforms along with a patch
creating tracepoints for cpufreq_sched is located in [5].

References:
[0] http://article.gmane.org/gmane.linux.kernel/1499836
[1] https://lkml.org/lkml/2015/7/7/754
[2] https://git.linaro.org/power/rt-app.git
[3] https://lkml.org/lkml/2015/10/28/782
[4] https://git.linaro.org/people/steve.muckle/kernel.git/shortlog/refs/heads/interactive
[5] https://git.linaro.org/people/steve.muckle/kernel.git/shortlog/refs/heads/sched-freq-rfcv6

Juri Lelli (3):
  sched/fair: add triggers for OPP change requests
  sched/{core,fair}: trigger OPP change request on fork()
  sched/fair: cpufreq_sched triggers for load balancing

Michael Turquette (2):
  cpufreq: introduce cpufreq_driver_is_slow
  sched: scheduler-driven cpu frequency selection

Morten Rasmussen (1):
  sched: Compute cpu capacity available at current frequency

Steve Muckle (1):
  sched/fair: jump to max OPP when crossing UP threshold

Vincent Guittot (3):
  sched: remove call of sched_avg_update from sched_rt_avg_update
  sched: deadline: use deadline bandwidth in scale_rt_capacity
  sched: rt scheduler sets capacity requirement

 drivers/cpufreq/Kconfig      |  20 +++
 drivers/cpufreq/cpufreq.c    |   6 +
 include/linux/cpufreq.h      |  12 ++
 include/linux/sched.h        |   8 +
 kernel/sched/Makefile        |   1 +
 kernel/sched/core.c          |  43 ++++-
 kernel/sched/cpufreq_sched.c | 364 +++++++++++++++++++++++++++++++++++++++++++
 kernel/sched/deadline.c      |  33 +++-
 kernel/sched/fair.c          | 115 ++++++++------
 kernel/sched/rt.c            |  49 +++++-
 kernel/sched/sched.h         | 114 +++++++++++++-
 11 files changed, 714 insertions(+), 51 deletions(-)
 create mode 100644 kernel/sched/cpufreq_sched.c

-- 
2.4.10

