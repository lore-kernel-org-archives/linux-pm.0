From: Dietmar Eggemann <dietmar.eggemann@arm.com>
Subject: [PATCH v2 00/10] arm, arm64: frequency- and cpu-invariant accounting support for task scheduler
Date: Thu,  6 Jul 2017 10:49:38 +0100
Message-ID: <20170706094948.8779-1-dietmar.eggemann@arm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-pm@vger.kernel.org, linux@arm.linux.org.uk, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Russell King <rmk+kernel@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Juri Lelli <juri.lelli@arm.com>, Vincent Guittot <vincent.guittot@linaro.org>, Peter Zijlstra <peterz@infradead.org>, Morten Rasmussen <morten.rasmussen@arm.com>, Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>
List-Id: linux-pm@vger.kernel.org

For a more accurate (i.e. frequency- and cpu-invariant) load-tracking
the task scheduler needs a frequency-scaling and on a heterogeneous
system a cpu-scaling correction factor.

This patch-set implements a Frequency Invariance Engine (FIE)
(topology_get_freq_scale()) in drivers/base/arch_topology.c to provide
a frequency-scaling correction factor.

During the v1 [1] review Viresh Kumar pointed out that such a FIE based
on cpufreq transition notifier will not work with future cpufreq
policies supporting fast frequency switching.
To include support for fast frequency switching policies the FIE
implementation has been changed. Whenever there is a frequency change
cpufreq now calls the arch specific function arch_set_freq_scale() which
has to be implemented by the architecture. In case the arch does not
specify this function FIE support is compiled out of cpufreq.
The advantage is that this would support fast frequency switching since
it does not rely on cpufreq transition (or policy) notifier anymore.

The Cpu Invariance Engine (CIE) (topology_get_cpu_scale()) providing a
cpu-scaling correction factor was already introduced by the "Fix issues
and factorize arm/arm64 capacity information code" patch-set [2].

This patch-set also enables the frequency- and cpu-invariant accounting
support. Enabling here means to associate (wire) the task scheduler
function name arch_scale_freq_capacity and arch_scale_cpu_capacity with
the FIE and CIE function names from drivers/base/arch_topology.c. This
replaces the task scheduler's default FIE and CIE in
kernel/sched/sched.h.

There is an additional patch [10/10] in v2 which allows inlining of the
FIE and CIE into the appropriate task scheduler functions.

+------------------------------+       +------------------------------+
|                              |       |                              |
| cpufreq:                     |       | arch:                        |
|                              |       |                              |
|      arch_set_freq_scale() +-----------> topology_set_freq_scale()  |
|                              |       |                              |
+------------------------------+       |                              |
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

Patch high level description:

  [   01/10] Fix to free cpumask cpus_to_visit
  [   02/10] Let cpufreq provide current and max supported frequency for
  	     the set of related cpus
  [   03/10] Frequency Invariance Engine (FIE)
  [   04/10] Connect cpufreq input data to FIE on arm
  [05,06/10] Enable frequency- and cpu-invariant accounting support on
  	     arm
  [   07/10] Connect cpufreq input data to FIE on arm64
  [08,09/10] Enable frequency- and cpu-invariant accounting support on
  	     arm64
  [   10/10] Allow CIE and FIE inlining

Changes v1->v2:

  - Rebase on top of next-20170630
  - Add fixup patch to free cpumask cpus_to_visit [01/10]
  - Propose solution to support fast frequency switching [02-04,07/10]
  - Add patch to allow CIE and FIE inlining [10/10]

The patch-set is based on top of linux-next/master (tag: next-20170630)
and it is also available from:

  git://linux-arm.org/linux-de.git upstream/freq_and_cpu_inv_v2

It has been tested on TC2 (arm) and JUNO (arm64) by running a ramp-up
rt-app task pinned to a cpu with the ondemand cpufreq governor and
checking the load-tracking signals of this task.

[1] https://marc.info/?l=linux-kernel&m=149690865010019&w=2
[2] https://marc.info/?l=linux-kernel&m=149625018223002&w=2

Dietmar Eggemann (10):
  drivers base/arch_topology: free cpumask cpus_to_visit
  cpufreq: provide data for frequency-invariant load-tracking support
  drivers base/arch_topology: frequency-invariant load-tracking support
  arm: wire cpufreq input data for frequency-invariant accounting up to
    the arch
  arm: wire frequency-invariant accounting support up to the task
    scheduler
  arm: wire cpu-invariant accounting support up to the task scheduler
  arm64: wire cpufreq input data for frequency-invariant accounting up
    to the arch
  arm64: wire frequency-invariant accounting support up to the task
    scheduler
  arm64: wire cpu-invariant accounting support up to the task scheduler
  drivers base/arch_topology: inline cpu- and frequency-invariant
    accounting

 arch/arm/include/asm/topology.h   | 11 +++++++++++
 arch/arm/kernel/topology.c        |  1 -
 arch/arm64/include/asm/topology.h | 11 +++++++++++
 arch/arm64/kernel/topology.c      |  1 -
 drivers/base/arch_topology.c      | 30 ++++++++++++++++++++++++------
 drivers/cpufreq/cpufreq.c         | 26 ++++++++++++++++++++++++++
 include/linux/arch_topology.h     | 20 +++++++++++++++++++-
 7 files changed, 91 insertions(+), 9 deletions(-)

-- 
2.11.0
