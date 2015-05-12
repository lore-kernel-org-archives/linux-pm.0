From: Morten Rasmussen <morten.rasmussen@arm.com>
Subject: [RFCv4 PATCH 00/34] sched: Energy cost model for energy-aware scheduling
Date: Tue, 12 May 2015 20:38:35 +0100
Message-ID: <1431459549-18343-1-git-send-email-morten.rasmussen@arm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: peterz@infradead.org, mingo@redhat.com
Cc: vincent.guittot@linaro.org, Dietmar Eggemann <Dietmar.Eggemann@arm.com>, yuyang.du@intel.com, preeti@linux.vnet.ibm.com, mturquette@linaro.org, rjw@rjwysocki.net, Juri Lelli <Juri.Lelli@arm.com>, sgurrappadi@nvidia.com, pang.xunlei@zte.com.cn, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, morten.rasmussen@arm.com
List-Id: linux-pm@vger.kernel.org

Several techniques for saving energy through various scheduler
modifications have been proposed in the past, however most of the
techniques have not been universally beneficial for all use-cases and
platforms. For example, consolidating tasks on fewer cpus is an
effective way to save energy on some platforms, while it might make
things worse on others.

This proposal, which is inspired by the Ksummit workshop discussions in
2013 [1], takes a different approach by using a (relatively) simple
platform energy cost model to guide scheduling decisions. By providing
the model with platform specific costing data the model can provide an
estimate of the energy implications of scheduling decisions. So instead
of blindly applying scheduling techniques that may or may not work for
the current use-case, the scheduler can make informed energy-aware
decisions. We believe this approach provides a methodology that can be
adapted to any platform, including heterogeneous systems such as ARM
big.LITTLE. The model considers cpus only, i.e. no peripherals, GPU or
memory. Model data includes power consumption at each P-state and
C-state.

This is an RFC and there are some loose ends that have not been
addressed here or in the code yet. The model and its infrastructure is
in place in the scheduler and it is being used for load-balancing
decisions. The energy model data is hardcoded and there are some
limitations still to be addressed. However, the main idea is presented
here, which is the use of an energy model for scheduling decisions.

RFCv4 is a consolidation of the latest energy model related patches and
patches adding scale-invariance to the CFS per-entity load-tracking
(PELT) as well as fixing a few issues that have emerged as we use PELT
more extensively for load-balancing. The patches are based on
tip/sched/core. Many of the changes since RFCv3 are addressing issues
pointed out during the review of v3 by Peter, Sai, and Xunlei. However,
there are still a few issues that needs fixing. Energy-aware scheduling
is now strictly following the 'tipping point' policy (with one minor
exception). That is, when the system is deemed over-utilized (above the
'tipping point') all balancing decisions are made by the normal way
based on priority scaled load and spreading of tasks. When below the
tipping point energy-aware scheduling decisions are active. The
rationale being that when below the tipping point we can safely shuffle
tasks around without harming throughput. The focus is more on putting
tasks on the right cpus at wake-up and less on periodic/idle/nohz_idle
as the latter are less likely to have a chance of balancing tasks when
below the tipping point as tasks are smaller and not always
running/runnable. This has simplified the code a bit.

The patch set now consists of two main parts but contains independent
fixes that will be reposted separately later. The capacity rework [2]
that was included in RFCv3 has been merged in v4.1-rc1 and [3] has been
reworked. The latter is the first part of this patch set.

Patch 01-12: sched: frequency and cpu invariant per-entity load-tracking
                    and other load-tracking bits.

Patch 13-34: sched: Energy cost model and energy-aware scheduling
                      features.

Test results for ARM TC2 (2xA15+3xA7) with cpufreq enabled:

sysbench: Single task running for 3 seconds.
rt-app [4]: mp3 playback use-case model
rt-app [4]: 5 ~[6,13,19,25,31,38,44,50]% periodic (2ms) tasks

Note: % is relative to the capacity of the fastest cpu at the highest
frequency, i.e. the more busy ones do not fit on little cpus.

A newer version of rt-app was used which supports a better but slightly
different way of modelling the periodic tasks. Numbers are therefore
_not_ comparable to the RFCv3 numbers.

Average numbers for 20 runs per test (ARM TC2).

Energy		Mainline	EAS		noEAS

sysbench	100		251*		227*

rt-app mp3	100		63		111

rt-app 6%	100		42		102
rt-app 13%	100		58		101
rt-app 19%	100		87		101
rt-app 25%	100		94		104
rt-app 31%	100		93		104
rt-app 38%	100		114		117
rt-app 44%	100		115		118
rt-app 50%	100		125		126

The higher load rt-app runs show significant variation in the energy
numbers for mainline as it schedules tasks randomly due to lack of
proper compute capacity awareness - tasks may be scheduled on LITTLE
cpus despite being too big.

Early test results for ARM (64-bit) Juno (2xA57+4x53) with cpufreq
enabled:

Average numbers for 20 runs per test (ARM Juno).

Energy		Mainline	EAS		noEAS

sysbench	100		219		196

rt-app mp3	100		82		120

rt-app 6%	100		65		108
rt-app 13%	100		75		102
rt-app 19%	100		86		104
rt-app 25%	100		84		105
rt-app 31%	100		87		111
rt-app 38%	100		136		132
rt-app 44%	100		141		141
rt-app 50%	100		146		142

* Sensitive to task placement on big.LITTLE. Mainline may put it on
  either cpu due to it's lack of compute capacity awareness, while EAS
  consistently puts heavy tasks on big cpus. The EAS energy increase came
  with a 2.06x (TC2)/1.70x (Juno) _increase_ in performance (throughput)
  vs Mainline.

[1] http://etherpad.osuosl.org/energy-aware-scheduling-ks-2013 (search
for 'cost')
[2] https://lkml.org/lkml/2015/1/15/136
[3] https://lkml.org/lkml/2014/12/2/328
[4] https://wiki.linaro.org/WorkingGroups/PowerManagement/Resources/Tools/WorkloadGen

Changes:

RFCv4:

(0) Reordering of the whole patch-set:

    01-02: Frequency-invariant PELT
    03-08: CPU-invariant PELT
    09-10: Track blocked usage
    11-12: PELT fixes for forked and dying tasks
    13-18: Energy model data structures
    19-21: Energy model helper functions
    22-24: Energy calculation functions
    25-26: Tipping point and max cpu capacity
    27-29: Idle-state index for energy model
    30-34: Energy-aware scheduling

(1) Rework frequency and cpu invariance arch support.

  - Remove weak arch functions and replace them with #defines and
    cpufreq notifiers.

(2) Changed PELT initialization and immediate removal of dead tasks from
    PELT rq signals.

(3) scheduler energy data setup.

  - Clean-up of allocation and initialization of energy data structures.

(4) Fix issue in sched_group_energy() not using correct capacity index.

(5) Rework energy-aware load balancing code.

  - Introduce a system-wide over-utilization indicator/tipping point.
  - Restrict periodic/idle/nohz_idle load balance to the detection of
    over-utilization scenarios.
  - Use conventional load-balance path when above tipping point and bail
    out when below.
  - Made energy-aware wake-up conditional on tipping point (only when
    below) and added capacity awareness to wake-ups when above.

RFCv3: https://lkml.org/lkml/2015/2/4/537

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

Morten Rasmussen (22):
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
  sched: Energy-aware wake-up task placement
  sched: Disable energy-unfriendly nohz kicks

 Documentation/scheduler/sched-energy.txt   | 363 +++++++++++++++++
 arch/arm/boot/dts/vexpress-v2p-ca15_a7.dts |   5 +
 arch/arm/include/asm/topology.h            |  11 +
 arch/arm/kernel/smp.c                      |  56 ++-
 arch/arm/kernel/topology.c                 | 204 +++++++---
 include/linux/sched.h                      |  22 +
 kernel/sched/core.c                        | 139 ++++++-
 kernel/sched/fair.c                        | 634 +++++++++++++++++++++++++----
 kernel/sched/features.h                    |  11 +-
 kernel/sched/idle.c                        |   2 +
 kernel/sched/sched.h                       |  81 +++-
 11 files changed, 1391 insertions(+), 137 deletions(-)
 create mode 100644 Documentation/scheduler/sched-energy.txt

-- 
1.9.1
