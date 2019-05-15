From: Parth Shah <parth@linux.ibm.com>
Subject: [RFCv2 0/6] TurboSched: A scheduler for sustaining Turbo Frequencies for longer durations
Date: Wed, 15 May 2019 19:23:16 +0530
Message-ID: <20190515135322.19393-1-parth@linux.ibm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc: mingo@redhat.com, peterz@infradead.org, dietmar.eggemann@arm.com, dsmythies@telus.net
List-Id: linux-pm@vger.kernel.org

Abstract
========

The modern servers allows multiple cores to run at range of
frequencies higher than rated range of frequencies. But the power budget
of the system inhibits sustaining these higher frequencies for
longer durations.

However when certain cores are put to idle states, the power can be
effectively channelled to other busy cores, allowing them to sustain
the higher frequency.

One way to achieve this is to pack tasks onto fewer cores keeping others idle,
but it may lead to performance penalty for such tasks and sustaining higher
frequencies proves to be of no benefit. But if one can identify unimportant low
utilization tasks which can be packed on the already active cores then waking up
of new cores can be avoided. Such tasks are short and/or bursty "jitter tasks"
and waking up new core is expensive for such case.

Current CFS algorithm in kernel scheduler is performance oriented and hence
tries to assign any idle CPU first for the waking up of new tasks. This policy
is perfect for major categories of the workload, but for jitter tasks, one
can save energy by packing it onto active cores and allow other cores to run at
higher frequencies.

These patch-set tunes the task wake up logic in scheduler to pack exclusively
classified jitter tasks onto busy cores. The work involves the use of additional
attributes inside "cpu" cgroup controller to manually classify tasks as jitter. 


Implementation
==============

These patches uses UCLAMP mechanism from "cpu" cgroup controller which
can be used to classify the jitter tasks. The task wakeup logic uses
this information to pack such tasks onto cores which are busy running
other workloads. The task packing is done at `select_task_rq_fair` only
so that in case of wrong decision load balancer may pull the classified
jitter tasks to performance giving CPU.

Any tasks added to the "cpu" cgroup tagged with cpu.util.max=1 are
classified as jitter. We define a core to be non-idle if it is over
12.5% utilized; the jitters are packed over these cores using First-fit
approach.

To demonstrate/benchmark, one can use a synthetic workload generator
`turbo_bench.c` available at
https://github.com/parthsl/tools/blob/master/benchmarks/turbo_bench.c

Following snippet demonstrates the use of TurboSched feature:
```
mkdir -p /sys/fs/cgroup/cpu/jitter
echo 0 > /proc/sys/kernel/sched_uclamp_util_min;
echo 0 > /sys/fs/cgroup/cpu/jitter/cpu.util.min;
echo 0 > /sys/fs/cgroup/cpu/jitter/cpu.util.max;
i=8;
./turbo_bench -t 30 -h $i -n $i &
./turbo_bench -t 30 -h 0 -n $i &
echo $! > /sys/fs/cgroup/cpu/jitter/cgroup.procs
```

Current implementation uses only jitter classified tasks to be packed on any
busy cores, but can be further optimized by getting userspace input of
important tasks and keeping track of such tasks. This leads to optimized
searching of non idle cores and also more accurate as userspace hints
are safer than auto classified busy cores/tasks.


Result
======

The patch-set proves to be useful for the system and the workload where
frequency boost is found to be useful than packing tasks into cores. IBM POWER 9
system shows the benefit for a workload can be up to 13%.

                   Performance benefit of TurboSched over CFS                  
     +-+-+-+-+--+-+-+-+-+-+-+-+--+-+-+-+-+-+-+-+--+-+-+-+-+-+-+-+--+-+-+-+-+   
     | + + + +  + + + + + + + +  + + + + + + + +  + + + + + + + +  + + + + |   
  15 +-+                                  Performance benefit in %       +-+   
     |                    **                                               |   
     |                    **                                               |   
  10 +-+                ********                                         +-+   
     |                  ********                                           |   
     |              ************   *                                       |   
   5 +-+            ************   *                                     +-+   
     |            * ************   * ****                                  |   
     |       ** * * ************ * * ******                                |   
     |       ** * * ************ * * ************ *                        |   
   0 +-******** * * ************ * * ************ * * * ********** * * * **+   
     |     **                                           ****               |   
     |     **                                                              |   
  -5 +-+   **                                                            +-+   
     | + + + +  + + + + + + + +  + + + + + + + +  + + + + + + + +  + + + + |   
     +-+-+-+-+--+-+-+-+-+-+-+-+--+-+-+-+-+-+-+-+--+-+-+-+-+-+-+-+--+-+-+-+-+   
       1 2 3 4  5 6 7 8 9101112 1314151617181920 2122232425262728 29303132     
                             Workload threads count                            


                     Frequency benefit of TurboSched over CFS                   
  20 +-+-+-+-+--+-+-+-+-+-+-+-+--+-+-+-+-+-+-+-+--+-+-+-+-+-+-+-+--+-+-+-+-+   
     | + + + +  + + + + + + + +  + + + + + + + +  + + + + + + + +  + + + + |   
     |                                      Frequency benefit in %         |   
  15 +-+                  **                                             +-+   
     |                    **                                               |   
     |              ********                                               |   
  10 +-+          * ************                                         +-+   
     |            * ************                                           |   
     |            * ************                                           |   
   5 +-+        * * ************   *                                     +-+   
     |       ** * * ************ * *                                       |   
     |     **** * * ************ * * ******                 **             |   
   0 +-******** * * ************ * * ************ * * * ********** * * * **+   
     |   **                                                                |   
     |   **                                                                |   
  -5 +-+ **                                                              +-+   
     | + + + +  + + + + + + + +  + + + + + + + +  + + + + + + + +  + + + + |   
     +-+-+-+-+--+-+-+-+-+-+-+-+--+-+-+-+-+-+-+-+--+-+-+-+-+-+-+-+--+-+-+-+-+   
       1 2 3 4  5 6 7 8 9101112 1314151617181920 2122232425262728 29303132     
                             Workload threads count                            

These numbers are w.r.t. `turbo_bench.c` test benchmark which spawns multiple
threads of a mix of High Utilization and Low Utilization(jitters). X-axis
represents the count of both the categories of tasks spawned.


Series organization
==============
- Patches [01-03]: Cgroup based jitter tasks classification
- Patches [04]: Defines Core Capacity to limit task packing
- Patches [05-06]: Tune CFS task wakeup logic to pack tasks onto busy
  cores

Series can be applied on top of Patrick Bellasi's UCLAMP RFCv8[3]
patches with branch on tip/sched/core and UCLAMP_TASK_GROUP config
options enabled.


Changelogs
=========
This patch set is a respin of TurboSched RFCv1
https://lwn.net/Articles/783959/
which includes the following main changes

- No WOF tasks classification, only jitter tasks are classified from
  the cpu cgroup controller
- Use of Spinlock rather than mutex to count number of jitters in the
  system classified from cgroup
- Architecture specific implementation of Core capacity multiplication
  factor changes dynamically based on the number of active threads in
  the core
- Selection of non idle core in the system is bounded by DIE domain
- Use of UCLAMP mechanism to classify jitter tasks
- Removed "highutil_cpu_mask", and rather uses sd for DIE domain to find
  better fit


References
==========

[1] "TurboSched : A scheduler for sustaining Turbo frequency for longer
durations" https://lwn.net/Articles/783959/

[2] "Turbo_bench: Synthetic workload generator"
https://github.com/parthsl/tools/blob/master/benchmarks/turbo_bench.c

[3] "Patrick Bellasi, Add utilization clamping support"
https://lore.kernel.org/lkml/20190402104153.25404-1-patrick.bellasi@arm.com/


Parth Shah (6):
  sched/core: Add manual jitter classification from cgroup interface
  sched: Introduce switch to enable TurboSched mode
  sched/core: Update turbo_sched count only when required
  sched/fair: Define core capacity to limit task packing
  sched/fair: Tune task wake-up logic to pack jitter tasks
  sched/fair: Bound non idle core search by DIE domain

 arch/powerpc/include/asm/topology.h |   7 ++
 arch/powerpc/kernel/smp.c           |  37 ++++++++
 kernel/sched/core.c                 |  32 +++++++
 kernel/sched/fair.c                 | 127 +++++++++++++++++++++++++++-
 kernel/sched/sched.h                |   8 ++
 5 files changed, 210 insertions(+), 1 deletion(-)

-- 
2.17.1
