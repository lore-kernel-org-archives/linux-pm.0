From: Morten Rasmussen <morten.rasmussen@arm.com>
Subject: [RFCv5 PATCH 00/46] sched: Energy cost model for energy-aware scheduling
Date: Tue,  7 Jul 2015 19:23:43 +0100
Message-ID: <1436293469-25707-1-git-send-email-morten.rasmussen@arm.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:37297 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757731AbbGGSV7 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 7 Jul 2015 14:21:59 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: peterz@infradead.org, mingo@redhat.com
Cc: vincent.guittot@linaro.org, daniel.lezcano@linaro.org, Dietmar Eggemann <Dietmar.Eggemann@arm.com>, yuyang.du@intel.com, mturquette@baylibre.com, rjw@rjwysocki.net, Juri Lelli <Juri.Lelli@arm.com>, sgurrappadi@nvidia.com, pang.xunlei@zte.com.cn, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org

Several techniques for saving energy through various scheduler
modifications have been proposed in the past, however most of the
techniques have not been universally beneficial for all use-cases and
platforms. For example, consolidating tasks on fewer cpus is an
effective way to save energy on some platforms, while it might make
things worse on others. At the same time there has been a demand for
scheduler driven power management given the scheduler's position to
judge performance requirements for the near future [1].

This proposal, which is inspired by [1] and the Ksummit workshop
discussions in 2013 [2], takes a different approach by using a
(relatively) simple platform energy cost model to guide scheduling
decisions. By providing the model with platform specific costing data
the model can provide an estimate of the energy implications of
scheduling decisions. So instead of blindly applying scheduling
techniques that may or may not work for the current use-case, the
scheduler can make informed energy-aware decisions. We believe this
approach provides a methodology that can be adapted to any platform,
including heterogeneous systems such as ARM big.LITTLE. The model
considers cpus only, i.e. no peripherals, GPU or memory. Model data
includes power consumption at each P-state and C-state. Furthermore a
natural extension of this proposal is to drive P-state selection from
the scheduler given its awareness of changes in cpu utilization.

This is an RFC but contains most of the essential features. The model
and its infrastructure is in place in the scheduler and it is being used
for load-balancing decisions. The energy model data is hardcoded and
there are some limitations still to be addressed. However, the main
ideas are presented here, which is the use of an energy model for
scheduling decisions and scheduler-driven DVFS.

RFCv5 is a consolidation of the latest energy model related patches and
patches adding scale-invariance to the CFS per-entity load-tracking
(PELT) as well as fixing a few issues that have emerged as we use PELT
more extensively for load-balancing. The main additions to v5 are the
inclusion of Mike's previously posted patches that enable
scheduler-driven DVFS [3] (please post comments regarding those in the
original thread) and Juri's patches that drive DVFS from the scheduler.

The patches are based on tip/sched/core. Many of the changes since RFCv4
are addressing issues pointed out during the review of v4. Energy-aware
scheduling is strictly following the 'tipping point' policy (with one
minor exception). That is, when the system is deemed over-utilized
(above the 'tipping point') all balancing decisions are made the normal
way based on priority scaled load and spreading of tasks. When below the
tipping point energy-aware scheduling decisions are active. The
rationale being that when below the tipping point we can safely shuffle
tasks around to save energy without harming throughput. The focus is
more on putting tasks on the right cpus at wake-up and less on
periodic/idle/nohz_idle as the latter are less likely to have a chance
of balancing tasks when below the tipping point as tasks are smaller and
not always running/runnable.

The patch set now consists of four main parts. The first two parts are
largely unchanged since v4, only bug fixes and smaller improvements. The
latter two parts are Mike's DVFS patches and Juri's scheduler-driven
DVFS building on top of Mike's patches.

Patch 01-12: sched: frequency and cpu invariant per-entity load-tracking
                    and other load-tracking bits.

Patch 13-36: sched: Energy cost model and energy-aware scheduling
                    features.

Patch 37-38: sched, cpufreq: Scheduler/DVFS integration (repost Mike
                             Turquette's patches [3])

Patch 39-46: sched: Juri's additions to Mike's patches driving DVFS from
                    the scheduler.

Test results for ARM TC2 (2xA15+3xA7) with cpufreq enabled:

sysbench: Single task running for 30s.
rt-app [4]: mp3 playback use-case model
rt-app [4]: 5 ~[6,13,19,25,31,38,44,50]% periodic (2ms) tasks for 30s.

Note: % is relative to the capacity of the fastest cpu at the highest
frequency, i.e. the more busy ones do not fit on little cpus.

The numbers are normalized against mainline for comparison except the
rt-app performance numbers. Mainline is however a somewhat random
reference point for big.LITTLE systems due to lack of capacity
awareness. noEAS (ENERGY_AWARE sched_feature disabled) has capacity
awareness and delivers consistent performance for big.LITTLE but does
not consider energy efficiency.

We have added an experimental performance metric to rt-app (based on
Linaro's repo [5]) which basically expresses the average time left from
completion of the run period until the next activation normalized to
best case: 100 is best case (not achievable in practice), the busy
period ended as fast as possible, 0 means on average we just finished in
time before the next activation, negative means we continued running
past the next activation.

Average numbers for 20 runs per test (ARM TC2). ndm = cpufreq ondemand
governor with 20ms sampling rate, sched = scheduler driven DVFS.

Energy          Mainline (ndm) noEAS (ndm)    EAS (ndm)      EAS (sched)
                nrg   prf      nrg   prf      nrg   prf      nrg   prf
sysbench        100   100      107   105      108   105      107   105

rt-app mp3      100   n.a.     101   n.a.     45    n.a.     43    n.a.

rt-app 6%       100   85       103   85        31   60        33   59
rt-app 13%      100   76       102   76        39   46        41   50
rt-app 19%      100   64       102   64        93   54        93   54
rt-app 25%      100   53       102   53        93   43        96   45
rt-app 31%      100   44       102   43       115   35       145   43
rt-app 38%      100   35       116   32       113    2       140   29
rt-app 44%      100  -40k      142   -9k      141   -9k      145   -1k
rt-app 50%      100 -100k      133  -21k      131  -22k      131   -4k

sysbench performs slightly better on all EAS kernels with or without EAS
enabled as the task is always scheduled on a big cpu. rt-app mp3 energy
consumption is reduced dramatically with EAS enabled as it is scheduled
on little cpus.

The rt-app periodic tests range from lightly utilized to over-utilized.
At low utilization EAS reduces energy significantly, while the
performance metric is slightly lower due to packing of the tasks on the
little cpus. As the utilization increases the performance metric
decreases as the cpus get closer to over-utilization. 38% is about the
point where little cpus are no longer capable of finishing each period
in time and saturation effects start to kick in. For the two last cases,
the system is over-utilized. EAS consumes more energy than mainline but
has reduced performance degradation (less negative performance metric).
Scheduler driven DVFS generally delivers better performance than
ondemand, which is also why we see a higher energy consumption.

Compile tested and boot tested on x86_64, but doesn't do anything as we
haven't got an energy model for x86_64 yet.

[1] http://article.gmane.org/gmane.linux.kernel/1499836
[2] http://etherpad.osuosl.org/energy-aware-scheduling-ks-2013 (search
for 'cost')
[3] https://lkml.org/lkml/2015/6/26/620
[4] https://github.com/scheduler-tools/rt-app.git exp/eas_v5
[5] https://wiki.linaro.org/WorkingGroups/PowerManagement/Resources/Tools/WorkloadGen

Changes:

RFCv4:

(0) Added better capacity awareness to wake-up path.

(1) Minor cleanups.

(2) Added of two of Mike's DVFS patches.

(3) Added scheduler driven DVFS.

RFCv4: https://lkml.org/lkml/2015/5/12/728

Dietmar Eggemann (12):
  sched: Make load tracking frequency scale-invariant
  arm: vexpress: Add CPU clock-frequencies to TC2 device-tree
  sched: Make usage tracking cpu scale-invariant
  arm: Cpu invariant scheduler load-tracking support
  sched: Get rid of scaling usage by cpu_capacity_orig
  sched: Introduce energy data structures
  sched: Allocate and initialize energy data structures
  arm: topology: Define TC2 energy and provide it to the scheduler
  sched: Store system-wide maximum cpu capacity in root domain
  sched: Determine the current sched_group idle-state
  sched: Consider a not over-utilized energy-aware system as balanced
  sched: Enable idle balance to pull single task towards cpu with higher
    capacity

Juri Lelli (8):
  sched/cpufreq_sched: use static key for cpu frequency selection
  sched/cpufreq_sched: compute freq_new based on capacity_orig_of()
  sched/fair: add triggers for OPP change requests
  sched/{core,fair}: trigger OPP change request on fork()
  sched/{fair,cpufreq_sched}: add reset_capacity interface
  sched/fair: jump to max OPP when crossing UP threshold
  sched/cpufreq_sched: modify pcpu_capacity handling
  sched/fair: cpufreq_sched triggers for load balancing

Michael Turquette (2):
  cpufreq: introduce cpufreq_driver_might_sleep
  sched: scheduler-driven cpu frequency selection

Morten Rasmussen (24):
  arm: Frequency invariant scheduler load-tracking support
  sched: Convert arch_scale_cpu_capacity() from weak function to #define
  arm: Update arch_scale_cpu_capacity() to reflect change to define
  sched: Track blocked utilization contributions
  sched: Include blocked utilization in usage tracking
  sched: Remove blocked load and utilization contributions of dying
    tasks
  sched: Initialize CFS task load and usage before placing task on rq
  sched: Documentation for scheduler energy cost model
  sched: Make energy awareness a sched feature
  sched: Introduce SD_SHARE_CAP_STATES sched_domain flag
  sched: Compute cpu capacity available at current frequency
  sched: Relocated get_cpu_usage() and change return type
  sched: Highest energy aware balancing sched_domain level pointer
  sched: Calculate energy consumption of sched_group
  sched: Extend sched_group_energy to test load-balancing decisions
  sched: Estimate energy impact of scheduling decisions
  sched: Add over-utilization/tipping point indicator
  sched, cpuidle: Track cpuidle state index in the scheduler
  sched: Count number of shallower idle-states in struct
    sched_group_energy
  sched: Add cpu capacity awareness to wakeup balancing
  sched: Consider spare cpu capacity at task wake-up
  sched: Energy-aware wake-up task placement
  sched: Disable energy-unfriendly nohz kicks
  sched: Prevent unnecessary active balance of single task in sched
    group

 Documentation/scheduler/sched-energy.txt   | 363 +++++++++++++
 arch/arm/boot/dts/vexpress-v2p-ca15_a7.dts |   5 +
 arch/arm/include/asm/topology.h            |  11 +
 arch/arm/kernel/smp.c                      |  57 ++-
 arch/arm/kernel/topology.c                 | 204 ++++++--
 drivers/cpufreq/Kconfig                    |  24 +
 drivers/cpufreq/cpufreq.c                  |   6 +
 include/linux/cpufreq.h                    |  12 +
 include/linux/sched.h                      |  22 +
 kernel/sched/Makefile                      |   1 +
 kernel/sched/core.c                        | 138 ++++-
 kernel/sched/cpufreq_sched.c               | 334 ++++++++++++
 kernel/sched/fair.c                        | 786 ++++++++++++++++++++++++++---
 kernel/sched/features.h                    |  11 +-
 kernel/sched/idle.c                        |   2 +
 kernel/sched/sched.h                       | 101 +++-
 16 files changed, 1934 insertions(+), 143 deletions(-)
 create mode 100644 Documentation/scheduler/sched-energy.txt
 create mode 100644 kernel/sched/cpufreq_sched.c

-- 
1.9.1

