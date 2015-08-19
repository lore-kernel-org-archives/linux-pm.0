From: Patrick Bellasi <patrick.bellasi@arm.com>
Subject: [RFC PATCH 00/14] sched: Central, scheduler-driven, power-perfomance control
Date: Wed, 19 Aug 2015 19:47:10 +0100
Message-ID: <1440010044-3402-1-git-send-email-patrick.bellasi@arm.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:53334 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751258AbbHSSrm (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 19 Aug 2015 14:47:42 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org

The topic of a single simple power-performance tunable, that is wholly
scheduler centric with defined and predictable properties, has come up on
several occasions in the past [1,2]. With techniques such as scheduler driven
DVFS [4], we now have a good framework for implementing such a tunable.

This RFC introduces the foundation to add a single, central tunable 'knob' to
the scheduler. The main goal of this RFC is to present an initial proposal for
a possible solution as well as triggering a discussion on how the ideas here
may be extended for integration with Energy Aware Scheduling [5].

Patch set organization
======================

The following patches implement the tunable knob stacked on top of sched-DVFS.
The knob extends the functionality provided by sched-DVFS to support task
performance boosting. The knob is expressed as a simple user-space facing
interface that allows the tuning of system wide scheduler behaviors ranging
from energy efficiency at one end through to full performance boosting at the
other end.

The tunable can be used globally such that it affects all tasks. It can also be
used for a select set of tasks via a new CGroup controller.

The content of this RFC consists of three main parts:

Patches 01-07: sched:
         Juri's patches on sched-DVFS, which have been updated to
         address review comments from the last EAS RFCv5 posting.

Patches 08-11: sched, schedtune:
         A new proposal for "global task boosting"

Patches 12-14: sched, schedtune:
         An extension, based on CGroups, to support per-task boosting

These patches are based on tip/sched/core and depend on:

 1. patches to "compute capacity invariant load/utilization tracking"
    recently posted by Morten Rasmussen [8]

 2. patches for "scheduler-driven cpu frequency selection"
    which add the new sched-DVFS CPUFreq governor
    initially posted by Mike Turquette [4]
    and recently updated in the series [5] posted by Morten Rasmussen

For testing purposes an integration branch providing all the required
dependencies as well as the patches of this RFC is available here:

    git://www.linux-arm.com/linux-power eas/stune/rfcv1


Test results
============

Tests have been performed on an ARM Juno board, booted using only the LITTLE
cluster (4x ARM64 CortexA53 @ 850 MHz) to mimic a standard SMP platform.

Impact on scheduler performance
-------------------------------

Performance impact has been evaluated using the hackbench test provided by
perf with this command line:

     perf bench sched messaging --thread --group 25 --loop 1000

Reported completion times (CTime) in seconds are averages over 10 runs

                 |           |            |     SchedTune
                 | Ondemand  | sched-DVFS |  Global    PerTask
-----------------+-----------+------------+--------------------
CTime        [s] |     50.9  |      50.3  |   51.1       51.3
 vs Ondemand [%] |      0.00 |      -1.19 |    0.34       0.84
-----------------+-----------+------------+--------------------
Energy           |           |            |
 vs Ondemand [%] |      0.00 |      -0.80 |    1.16       1.45
-----------------+-----------+------------+--------------------

Overall considerations are:

 1) sched-DVFS is quite well positioned compare to the Ondemand
    governor with respect to both performance and energy consumption

 2) SchedTune is always worse than the Ondemand governor due to the
    missing optimizations in the current implementation for working on
    saturated conditions

The SchedTune extension is useful only on a lightly loaded system.
On the other hand, when the system is saturated, the SchedTune support
should be automatically disabled. This automatic disabling is currently
being implemented and will be posted in the next revision of this RFC.


Performance/energy impacts of task boosting
-------------------------------------------

We considered a set of rt-app [5] generated workloads.
All the tests are executed using:
   - 4 threads (to match the number of available CPUs)
   - each thread has a 2ms period
   - duty-cycle (at highest OPP) is (6,13,19,25,31,38 and 44)%
   - each workload runs for 60s

The energy metric (EnergyDiff) is based on energy counters available on the
Juno platform and it reports the energy consumption for the complete execution
of the workload.

The performance evaluation is based on data obtained by rt-app [6] using the
same metric introduced with the EAS RFCv5 [5].

The following table reports the percentage variation on each metric.
Each variation compares:
    base   : workload run using the sched-DVFS governor but without boosting
    testNN : workload run using the sched-DVFS governor with a NN boost value
             configured for just the tasks of the workload,
             i.e. using per-task boosting

Reported numbers are averages on 10 runs for each test configuration.
Numbers in (parenthesis) are reference for the comments below the table.


  Test Id   : Comparison      | EnergyDiff [%] |  PerfIndex [%] |
  ----------------------------+----------------+----------------+
  Test_43   : test05 vs base  |  (1) -0.24     |  (4) -1.22     |
  Test_43   : test10 vs base  |      -0.25     |      -0.82     |
  Test_43   : test30 vs base  |      -0.22     |      -0.62     |
  Test_43   : test80 vs base  |      22.72     |      10.40     |
  --------------------- ------+----------------+----------------+
  Test_44   : test05 vs base  |  (1) -0.37     |       1.43     |
  Test_44   : test10 vs base  |      -0.30     |       0.70     |
  Test_44   : test30 vs base  |       0.52     |       1.57     |
  Test_44   : test80 vs base  |      21.08     |      17.36     |
  --------------------- ------+----------------+----------------+
  Test_45   : test05 vs base  |  (1) -0.17     |       1.00     |
  Test_45   : test10 vs base  |      -0.12     |      -0.22     |
  Test_45   : test30 vs base  |       4.15     |       8.25     |
  Test_45   : test80 vs base  |      21.84     |      22.38     |
  --------------------- ------+----------------+----------------+
  Test_46   : test05 vs base  |  (1) -0.09     |      -0.48     |
  Test_46   : test10 vs base  |      -0.02     |      -1.06     |
  Test_46   : test30 vs base  |       4.36     |      13.01     |
  Test_46   : test80 vs base  |  (2) 21.15     |  (3) 29.58     |
  --------------------- ------+----------------+----------------+
  Test_47   : test05 vs base  |       0.11     |       1.15     |
  Test_47   : test10 vs base  |       0.58     |       1.99     |
  Test_47   : test30 vs base  |       5.44     |       8.54     |
  Test_47   : test80 vs base  |  (2) 22.47     |  (3) 30.88     |
  --------------------- ------+----------------+----------------+
  Test_48   : test05 vs base  |       4.23     |       5.00     |
  Test_48   : test10 vs base  |       7.32     |      16.88     |
  Test_48   : test30 vs base  |      14.75     |      28.72     |
  Test_48   : test80 vs base  |  (2) 29.11     |  (3) 42.30     |
  --------------------- ------+----------------+----------------+
  Test_49   : test05 vs base  |       0.21     |       1.15     |
  Test_49   : test10 vs base  |       0.50     |       2.47     |
  Test_49   : test30 vs base  |       6.60     |      11.51     |
  Test_49   : test80 vs base  |  (2) 18.22     |  (3) 27.45     |


Comments on Results
===================

The goal of the proposed task boosting strategy is to speed-up task
completion, by running them at a higher Operating Performance Point (OPP),
with respect to the lowest OPP required by the specific workload.

Here are some considerations on reported results:

 a) Low intensity workloads present a small decrease in energy
    consumption (1) probably due to a race-to-idle effect when running
    at lower OPP. Otherwise, in general we observe an increase in
    energy consumption which is monotonic and proportional wrt the
    configured boost value.

 b) Higher boost values (2) are subject to 20-30% more energy
    consumption which is however compensated by an expected improvement
    in the performance metric.

 c) The PerfIndex is in general aligned with the magnitude of the boost
    value. The more we boost the workload the sooner tasks activation complete
    and thus the better the PerfIndex metric (3)

 d) On really small workloads, when the boosting value is relatively small (4),
    the overhead introduced by SchedTune is not compensated by the possibility
    to select an higher OPP.
    This aspect is part of the SchedTune optimization that we will target for
    the following posting.


Conclusions
===========

The proposed patch set provides a simple and effective tunable knob which
allows to boost performance of low-intensity tasks. This tunable works by
biasing sched-DVFS in the selection of the operating frequency.
This allows to trade-off increased energy consumptions for faster tasks
completion time.

This patch set provides just the foundation bits which focus on OPP
selection. A further extension of this patch set is under development
to target the integration with the Energy Aware Scheduler (EAS) [5] by
biasing CPU selection.

This will allow to complete the boosting knob semantics by providing a single
knob which allows:
   a) to tune sched-DVFS to mimic (dynamically and on a per-task base) the
      behaviors of other governors (i.e. ondemand, performance and interactive)
   b) to tune EAS to be more energy-efficient or performance boosting oriented


References
==========

[1] Remove stale power aware scheduling remnants and dysfunctional knobs
      http://lkml.org/lkml/2012/5/18/91
[2] Power-efficient scheduling design
      http://lwn.net/Articles/552889
[3] Compute capacity invariant load/utilization tracking
      http://lkml.org/lkml/2015/8/14/296
[4] Scheduler-driven CPU frequency selection (RFCv3)
      http://lkml.org/lkml/2015/6/26/620
[5] Energy cost model for energy-aware scheduling (RFCv5)
      https://lkml.org/lkml/2015/7/7/754
[6] Extended RT-App to report Time to Completion
      https://github.com/scheduler-tools/rt-app.git exp/eas_v5


Juri Lelli (7):
  sched/cpufreq_sched: use static key for cpu frequency selection
  sched/fair: add triggers for OPP change requests
  sched/{core,fair}: trigger OPP change request on fork()
  sched/{fair,cpufreq_sched}: add reset_capacity interface
  sched/fair: jump to max OPP when crossing UP threshold
  sched/cpufreq_sched: modify pcpu_capacity handling
  sched/fair: cpufreq_sched triggers for load balancing

Patrick Bellasi (7):
  sched/tune: add detailed documentation
  sched/tune: add sysctl interface to define a boost value
  sched/fair: add function to convert boost value into "margin"
  sched/fair: add boosted CPU usage
  sched/tune: add initial support for CGroups based boosting
  sched/tune: compute and keep track of per CPU boost value
  sched/{fair,tune}: track RUNNABLE tasks impact on per CPU boost value

 Documentation/scheduler/sched-tune.txt | 367 +++++++++++++++++++++++++++++
 include/linux/cgroup_subsys.h          |   4 +
 include/linux/sched/sysctl.h           |  16 ++
 init/Kconfig                           |  43 ++++
 kernel/sched/Makefile                  |   1 +
 kernel/sched/core.c                    |   2 +-
 kernel/sched/cpufreq_sched.c           |  28 ++-
 kernel/sched/fair.c                    | 168 +++++++++++++-
 kernel/sched/sched.h                   |  10 +
 kernel/sched/tune.c                    | 411 +++++++++++++++++++++++++++++++++
 kernel/sched/tune.h                    |  23 ++
 kernel/sysctl.c                        |  15 ++
 12 files changed, 1082 insertions(+), 6 deletions(-)
 create mode 100644 Documentation/scheduler/sched-tune.txt
 create mode 100644 kernel/sched/tune.c
 create mode 100644 kernel/sched/tune.h

--
2.5.0

