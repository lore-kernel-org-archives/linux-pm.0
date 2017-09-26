From: Dietmar Eggemann <dietmar.eggemann@arm.com>
Subject: [PATCH v5 00/10] arm, arm64, cpufreq: frequency- and cpu-invariant accounting support for task scheduler
Date: Tue, 26 Sep 2017 17:41:05 +0100
Message-ID: <20170926164115.32367-1-dietmar.eggemann@arm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-pm@vger.kernel.org, linux@arm.linux.org.uk, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Russell King <rmk+kernel@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Juri Lelli <juri.lelli@arm.com>, Vincent Guittot <vincent.guittot@linaro.org>, Peter Zijlstra <peterz@infradead.org>, Morten Rasmussen <morten.rasmussen@arm.com>, Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Sudeep Holla <sudeep.holla@arm.com>
List-Id: linux-pm@vger.kernel.org

For a more accurate (i.e. frequency- and cpu-invariant) accounting
the task scheduler needs a frequency-scaling and on a heterogeneous
system a cpu-scaling correction factor.

This patch-set implements a Frequency Invariance Engine (FIE)
based on the ratio of current frequency and maximum supported frequency
(topology_get_freq_scale()) in the arch topology driver (arm, arm64) to
provide such a frequency-scaling correction factor.
This is a solution to get frequency-invariant accounting support for
platforms without hardware-based performance tracking.

The Cpu Invariance Engine (CIE) (topology_get_cpu_scale()) providing a
cpu-scaling correction factor was already introduced by the "Fix issues
and factorize arm/arm64 capacity information code" patch-set [1] which
went into v4.13.

This patch-set also enables the frequency- and cpu-invariant accounting
support. Enabling here means to associate (wire) the task scheduler
function name arch_scale_freq_capacity and arch_scale_cpu_capacity with
the FIE and CIE function names from drivers/base/arch_topology.c. This
replaces the scheduler's default FIE and CIE in kernel/sched/sched.h.

v4: review results:

There were no further comments during the v4 [2] review.

v3: review results:

Viresh Kumar asked me during the v3 [3] review to move the definition
of the default frequency-invariance setter arch_set_freq_scale() in
front of cpufreq_generic_init() and to get rid of the fancy function
header.

v2: review results:

During the v2 [4] review we agreed that cpufreq core is not the right
place to drive this kind of FIE. In case of a future fast-switching
arm/arm64 cpufreq driver, a return value other than
CPUFREQ_ENTRY_INVALID of the '->fast_switch' driver callback does not
indicate that the new frequency has been set. So calling the FIE's
setter function (arch_set_freq_scale()) in cpufreq_driver_fast_switch()
would not be correct.

Instead this version of the patch-set assumes that the FIE setter
function is provided by the cpufreq driver (slow- or fast-switching).

Slow-switching driver:

For a slow-switching driver the FIE setter function can be called in its
'->target_index' driver callback, after a non-error return value from
the (blocking) firmware call has been received.
Two slow-switching cpufreq drivers (arm-big-little (exclusively used in
arm/arm64) and cpufreq-dt) have been changed accordingly.

Fast-switching driver:

For a fast-switching driver the ARM System Control and Management
Interface (SCMI) document [5] (4.5 Performance domain management
protocol) provides an example for such a driver how to communicate with
the firmware.
It defines an optional performance domain related notification which
indicates that the requested frequency has been changed. So the FIE
setter function could be implemented here.
In case the firmware does not implement this notification or the driver
makes no use of it, the FIE setter would have to be placed in the
'->fast_switch' driver callback assuming that the firmware has set the
frequency.

Weak arch_set_freq_scale() interface:

Since a cpufreq driver (e.g. cpufreq-dt) can be build for different
arch's a default (empty) implementation of the FIE setter function in
cpufreq core is still needed for those arch's which do not implement it.

FIE/CIE inlining:

The FIE (topology_get_freq_scale()) and CIE (topology_get_cpu_scale())
getter functions have been coded as static inline functions so they can
be inlined into the scheduler fast path (e.g. __update_load_avg_se()).

+------------------------------+       +------------------------------+
|                              |       |                              |
| cpufreq:                     |       | arch:                        |
|                              |       |                              |
| weak arch_set_freq_scale() {}|       |                              |
|                              |       |                              |
+------------------------------+       |                              |
                                       |                              |
+------------------------------+       |                              |
|                              |       |                              |
| cpufreq driver:              |       |                              |
|                              |       |                              |
|                            +-----------> arch_set_freq_scale()      |
|                              |       |                              |
+------------------------------+       |   topology_set_cpu_scale()   |
                                       |                              |
+------------------------------+       |                              |
|                              |       |                              |
| task scheduler:              |       |                              |
|                              |       |                              |
| arch_scale_freq_capacity() +-----------> topology_get_freq_scale()  |
|                              |       |                              |
| arch_scale_cpu_capacity()  +-----------> topology_get_cpu_scale()   |
|                              |       |                              |
+------------------------------+       +------------------------------+

v1 review results:

During the v1 [6] review Viresh Kumar pointed out that such a FIE based
on cpufreq transition notifier will not work with future cpufreq
policies supporting fast frequency switching.
To include support for fast frequency switching policies the FIE
implementation has been changed. Whenever there is a frequency change
cpufreq now calls the arch specific function arch_set_freq_scale() which
has to be implemented by the architecture. In case the arch does not
specify this function FIE support is compiled out of cpufreq.
The advantage is that this would support fast frequency switching since
it does not rely on cpufreq transition (or policy) notifier anymore.

Patch high level description:

   [   01/10] Fix to free cpumask cpus_to_visit
   [   02/10] Default (empty, weak) arch_set_freq_scale() implementation
   [03,04/10] Call arch_set_freq_scale() from two cpufreq drivers
              (arm_big_little and cpufreq-dt)
   [   05/10] FIE
   [   06/10] Allow CIE inlining
   [07,08/10] Enable frequency- and cpu-invariant accounting on arm
   [09,10/10] Enable frequency- and cpu-invariant accounting on arm64

Changes v4->v5:

   - Rebase on top of v4.14-rc1 
   - Add Acked-by for [02/10]

Changes v3->v4:

   - Rebase on top of v4.13-rc6
   - Move definition of arch_set_freq_scale() in cpufreq.c [02/10]
   - Add Acked-by for [01/10, 03-08/10]

Changes v2->v3:

   - Rebase on top of v4.13-rc2
   - Fix 'notifier unregister'-'free cpumask' order in
     parsing_done_workfn() in [01/10]
   - Call arch_set_freq_scale() from cpufreq drivers (arm-big-little
     and cpufreq-dt) [02-04/10]
   - Allow inlining of topology_get_freq_scale() and    
     topology_get_cpu_scale() into task scheduler fastpath [05,06/10]

Changes v1->v2:
   - Rebase on top of next-20170630
   - Add fixup patch to free cpumask cpus_to_visit [01/10]
   - Propose solution to support fast frequency switching [02-04,07/10]
   - Add patch to allow CIE and FIE inlining [10/10]

The patch-set is based on top of v4.14-rc1 and is also available from:

   git://linux-arm.org/linux-de.git upstream/freq_and_cpu_inv_v5

Testing:

The patch-set has been tested on TC2 (arm, arm-big-little driver), JUNO
(arm64, arm-big-little driver) and Hikey620 (arm64, cpufreq-dt driver)
by running a ramp-up rt-app task pinned to a cpu with the ondemand
cpufreq governor and checking the load-tracking signals of this task.

Driver module loading has been tested on TC2, JUNO and Hikey620 as well.

[1] https://marc.info/?l=linux-kernel&m=149625018223002&w=2
[2] https://marc.info/?l=linux-kernel&m=150367155611291&w=2
[3] https://marc.info/?l=linux-kernel&m=150118402232039&w=2
[4] https://marc.info/?l=linux-pm&m=149933474313566&w=2
[5] http://arminfo.emea.arm.com/help/topic/com.arm.doc.den0056a/DEN0056A_System_Control_and_Management_Interface.pdf
[6] https://marc.info/?l=linux-kernel&m=149690865010019&w=2


Dietmar Eggemann (10):
  drivers base/arch_topology: free cpumask cpus_to_visit
  cpufreq: provide default frequency-invariance setter function
  cpufreq: arm_big_little: invoke frequency-invariance setter function
  cpufreq: dt: invoke frequency-invariance setter function
  drivers base/arch_topology: provide frequency-invariant accounting
    support
  drivers base/arch_topology: allow inlining cpu-invariant accounting
    support
  arm: wire frequency-invariant accounting support up to the task
    scheduler
  arm: wire cpu-invariant accounting support up to the task scheduler
  arm64: wire frequency-invariant accounting support up to the task
    scheduler
  arm64: wire cpu-invariant accounting support up to the task scheduler

 arch/arm/include/asm/topology.h   |  8 ++++++++
 arch/arm64/include/asm/topology.h |  8 ++++++++
 drivers/base/arch_topology.c      | 29 +++++++++++++++++++++++------
 drivers/cpufreq/arm_big_little.c  | 10 +++++++++-
 drivers/cpufreq/cpufreq-dt.c      | 12 ++++++++++--
 drivers/cpufreq/cpufreq.c         |  6 ++++++
 include/linux/arch_topology.h     | 17 ++++++++++++++++-
 include/linux/cpufreq.h           |  3 +++
 8 files changed, 83 insertions(+), 10 deletions(-)

-- 
2.11.0
