From: Dietmar Eggemann <dietmar.eggemann@arm.com>
Subject: [PATCH 0/6] arm, arm64: frequency- and cpu-invariant accounting support for task scheduler
Date: Thu,  8 Jun 2017 08:55:07 +0100
Message-ID: <20170608075513.12475-1-dietmar.eggemann@arm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-pm@vger.kernel.org, linux@arm.linux.org.uk, linux-arm-kernel@lists.infradead.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Russell King <rmk+kernel@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Juri Lelli <juri.lelli@arm.com>, Vincent Guittot <vincent.guittot@linaor.org>, Peter Zijlstra <peterz@infradead.org>, Morten Rasmussen <morten.rasmussen@arm.com>
List-Id: linux-pm@vger.kernel.org

For a more accurate (i.e. frequency- and cpu-invariant) load-tracking
the task scheduler needs a frequency-scaling and on a heterogeneous
system a cpu-scaling correction factor.

This patch-set implements a Frequency Invariance Engine (FIE)
(topology_get_freq_scale()) in drivers/base/arch_topology.c to provide
a frequency-scaling correction factor.

The Cpu Invariance Engine (CIE) (topology_get_cpu_scale()) providing a
cpu-scaling correction factor was already introduced by the "Fix issues
and factorize arm/arm64 capacity information code" patch-set [1].

This patch-set also enables the frequency- and cpu-invariant accounting
support. Enabling here means to associate (wire) the task scheduler
cname arch_scale_freq_capacity and arch_scale_cpu_capacity with the FIE
and CIE function names from drivers/base/arch_topology.c. This replaces
the task scheduler's default FIE and CIE in kernel/sched/sched.h.

Patch high level description:

 [   01/06] Rework cpufreq policy notifier for frequency-invariant
            accounting support
 [   02/06] Frequency Invariance Engine (FIE)
 [03,04/06] Enable frequency- and cpu-invariant accounting support on
            arm
 [05,06/06] Enable frequency- and cpu-invariant accounting support on
            arm64

The patch-set is based on top of linux-next/master (tag: next-20170607)
and it is also available from:

 git://linux-arm.org/linux-de.git upstream/freq_and_cpu_inv

It has been tested on TC2 (arm) and JUNO (arm64) by running a ramp-up
rt-app task pinned to a cpu with the ondemand cpufreq governor and
checking the load-tracking signals of this task.

[1] https://marc.info/?l=linux-kernel&m=149625018223002&w=2


Dietmar Eggemann (6):
  drivers base/arch_topology: prepare cpufreq policy notifier for
    frequency-invariant load-tracking support
  drivers base/arch_topology: frequency-invariant load-tracking support
  arm: wire frequency-invariant accounting support up to the task
    scheduler
  arm: wire cpu-invariant accounting support up to the task scheduler
  arm64: wire frequency-invariant accounting support up to the task
    scheduler
  arm64: wire cpu-invariant accounting support up to the task scheduler

 arch/arm/include/asm/topology.h   |  8 +++++
 arch/arm/kernel/topology.c        |  1 -
 arch/arm64/include/asm/topology.h |  8 +++++
 arch/arm64/kernel/topology.c      |  1 -
 drivers/base/arch_topology.c      | 64 ++++++++++++++++++++++++++++++++++-----
 include/linux/arch_topology.h     |  2 ++
 6 files changed, 75 insertions(+), 9 deletions(-)

-- 
2.11.0
