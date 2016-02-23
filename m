From: Steve Muckle <steve.muckle@linaro.org>
Subject: [RFCv7 PATCH 00/10] sched: scheduler-driven CPU frequency selection
Date: Mon, 22 Feb 2016 17:22:40 -0800
Message-ID: <1456190570-4475-1-git-send-email-smuckle@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, "Rafael J. Wysocki" <rafael@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, Morten Rasmussen <morten.rasmussen@arm.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Juri Lelli <Juri.Lelli@arm.com>, Patrick Bellasi <patrick.bellasi@arm.com>, Michael Turquette <mturquette@baylibre.com>
List-Id: linux-pm@vger.kernel.org

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

Changes in this series since RFCv6 [1], posted December 9, 2015:
  Patch 3, sched: scheduler-driven cpu frequency selection
  - Added Kconfig dependency on IRQ_WORK.
  - Reworked locking.
  - Make throttling optional - it is not required in order to ensure that
    the previous frequency transition is complete.
  - Some fixes in cpufreq_sched_thread related to the task state.
  - Changes to support mixed fast and slow path operation.
  Patch 7: sched/fair: jump to max OPP when crossing UP threshold
  - move sched_freq_tick() call so rq lock is still held
  Patch 9: sched/deadline: split rt_avg in 2 distincts metrics
  - RFCv6 calculated DL capacity from DL task parameters, RFCv7 restores
    the original method of calculation but keeps DL capacity separate
  Patch 10: sched: rt scheduler sets capacity requirement
  - change #ifdef from CONFIG_SMP, trivial cleanup

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
1.8GHz. The interactive governor was incorporated/adapted from [3]. A
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
1	100	100	0	62.07%	0	100.02%	0	78.49%
10	1000	10	0	21.80%	0	22.74%	0	72.56%
1	10	1000	0	21.72%	0	63.08%	0	52.40%
10	100	100	0	8.09%	0	15.53%	0	17.33%
100	1000	10	0	1.83%	0	1.77%	0	0.29%
6	33	300	0	15.32%	0	8.60%	0	17.34%
66	333	30	0	0.79%	0	3.18%	0	12.26%
4	10	1000	0	5.87%	0	10.21%	0	6.15%
40	100	100	0	0.41%	0	0.04%	0	2.68%
400	1000	10	0	0.42%	0	0.50%	0	1.22%
5	9	1000	2	3.82%	1	6.10%	0	2.51%
50	90	100	0	0.19%	0	0.05%	0	1.71%
500	900	10	0	0.37%	0	0.38%	0	1.82%
9	12	1000	6	1.79%	1	0.77%	0	0.26%
90	120	100	0	0.16%	1	0.05%	0	0.49%
900	1200	10	0	0.09%	0	0.26%	0	0.62%

SCHED_FIFO workload:
 wload parameters	  ondemand        interactive     sched	
run	period	loops	OR	OH	OR	OH	OR	OH
1	100	100	0	39.61%	0	100.49%	0	99.57%
10	1000	10	0	73.51%	0	21.09%	0	96.66%
1	10	1000	0	18.01%	0	61.46%	0	67.68%
10	100	100	0	31.31%	0	18.62%	0	77.01%
100	1000	10	0	58.80%	0	1.90%	0	15.40%
6	33	300	251	85.99%	0	9.20%	1	30.09%
66	333	30	24	84.03%	0	3.38%	0	33.23%
4	10	1000	0	6.23%	0	12.21%	10	11.54%
40	100	100	100	62.08%	0	0.11%	1	11.85%
400	1000	10	10	62.09%	0	0.51%	0	7.00%
5	9	1000	999	12.29%	1	6.03%	0	0.04%
50	90	100	99	61.47%	0	0.05%	2	6.53%
500	900	10	10	43.37%	0	0.39%	0	6.30%
9	12	1000	999	9.83%	0	0.01%	14	1.69%
90	120	100	99	61.47%	0	0.01%	28	2.29%
900	1200	10	10	43.31%	0	0.22%	0	2.15%

Note that at this point RT CPU capacity is measured via rt_avg. For
the above results sched_time_avg_ms has been set to 50ms.

Known issues:
 - More testing with real world type workloads, such as UI workloads and
   benchmarks, is required.
 - The power side of the characterization is in progress.
 - Deadline scheduling class does not yet make CPU capacity requests.
 - Not sure what's going on yet with the ondemand numbers above, it seems like
   there may a regression with ondemand and RT tasks.

Dependencies:
Frequency invariant load tracking is required. For heterogeneous
systems such as big.Little, CPU invariant load tracking is required as
well. The required support for ARM platforms along with a patch
creating tracepoints for cpufreq_sched is located in [5].

References:
[0] http://article.gmane.org/gmane.linux.kernel/1499836
[1] http://thread.gmane.org/gmane.linux.power-management.general/69176
[2] https://git.linaro.org/power/rt-app.git
[3] https://lkml.org/lkml/2015/10/28/782
[4] https://git.linaro.org/people/steve.muckle/kernel.git/shortlog/refs/heads/interactive
[5] https://git.linaro.org/people/steve.muckle/kernel.git/shortlog/refs/heads/sched-freq-rfcv7

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
  sched/deadline: split rt_avg in 2 distincts metrics
  sched: rt scheduler sets capacity requirement

 drivers/cpufreq/Kconfig      |  21 ++
 drivers/cpufreq/cpufreq.c    |   6 +
 include/linux/cpufreq.h      |  12 ++
 include/linux/sched.h        |   8 +
 kernel/sched/Makefile        |   1 +
 kernel/sched/core.c          |  43 +++-
 kernel/sched/cpufreq_sched.c | 459 +++++++++++++++++++++++++++++++++++++++++++
 kernel/sched/deadline.c      |   2 +-
 kernel/sched/fair.c          | 108 +++++-----
 kernel/sched/rt.c            |  48 ++++-
 kernel/sched/sched.h         | 120 ++++++++++-
 11 files changed, 777 insertions(+), 51 deletions(-)
 create mode 100644 kernel/sched/cpufreq_sched.c

-- 
2.4.10
