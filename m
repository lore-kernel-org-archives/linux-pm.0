From: Juri Lelli <juri.lelli@arm.com>
Subject: [PATCH v3 0/6] CPUs capacity information for heterogeneous systems
Date: Wed,  3 Feb 2016 11:59:53 +0000
Message-ID: <1454500799-18451-1-git-send-email-juri.lelli@arm.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:33693 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751308AbcBCL7g (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 3 Feb 2016 06:59:36 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, peterz@infradead.org, vincent.guittot@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com, linux@arm.linux.org.uk, sudeep.holla@arm.com, lorenzo.pieralisi@arm.com, catalin.marinas@arm.com, will.deacon@arm.com, morten.rasmussen@arm.com, dietmar.eggemann@arm.com, juri.lelli@arm.com, broonie@kernel.org

Hi all,

this is take 3 of "CPUs capacity information for heterogeneous systems"
patchset [1]; some context follows.

ARM systems may be configured to have CPUs with different power/performance
characteristics within the same chip. In this case, additional information has
to be made available to the kernel (the scheduler in particular) for it to be
aware of such differences and take decisions accordingly. This RFC stems from
the ongoing discussion about introducing a simple platform energy cost model to
guide scheduling decisions (a.k.a Energy Aware Scheduling [3]), but also aims
to be an independent track aimed to standardise the way we make the scheduler
aware of heterogenous CPU systems. With these patches and in addition patches
from [3] (that make the scheduler wakeup paths aware of heterogenous CPU
systems) we enable the scheduler to have good default performance on such
systems. In addition, we get a clearly defined way of providing the scheduler
with needed information about CPU capacity on such systems.

CPU capacity is defined in this context as a number that provides the scheduler
information about CPUs heterogeneity. Such heterogeneity can come from
micro-architectural differences (e.g., ARM big.LITTLE systems) or maximum
frequency at which CPUs can run (e.g., SMP systems with multiple frequency
domains and different max frequencies). Heterogeneity in this context is about
differing performance characteristics; in practice, the binding that we propose
in this RFC tries to capture a first-order approximation of the relative
performance of CPUs.

Several approaches for providing CPUs capacity information have been already
discussed on the list:

 v1: DT + sysfs [1]

 v2: Dynamic profiling at boot [2]

Third version of this patchset proposes what seems to be the solution we agreed
upon (see [2] for reference) to the problem of how do we init CPUs original
capacity: we run a bogus benchmark (stealing int_sqrt from lib/ we run that in
a loop to perform some integer computation, better benchmarks are welcome)
on the first cpu of each frequency domain (assuming no u-arch differences
inside domains), measure time to complete a fixed number of iterations and then
normalize results to SCHED_CAPACITY_SCALE (1024). This time around we also
added a boot time parameter to disable profiling at boot (as it can be time
consuming) and sysfs attributes with which default values can be overwritten.
The proposed solution is basically putting together bits of v1 and v2 that are
considered valuable and acceptable for mainline.

What follows gives you and idea of the kind of results you can expect comparing
the dynamic approach to profiling in userspace:

                          LITTLE      big

 TC2-userspace_profile     430        1024
 TC2-dynamic_profile      ~490        1024

 JUNO-userspace_profile    446        1024
 JUNO-dynamic_profile     ~424        1024

This time around we also decided to remove the RFC tag; even if patches might
still need some degree of improvement and discussion, there seems to be general
consensus about the idea behind the current solution (i.e., nobody NAKed it yet 
:)).

Patches high level description:

 o 01/06 cleans up how cpu_scale is initialized in arm (already landed on
   Russell's patch system)
 o 02/06 introduces dynamic profiling of CPUs capacity at boot
 o [03-04]/06 enable dynamic profiling for arm and arm64.
 o [05-06]/06 introduce sysfs attribute for arm and arm64.

The patchset is based on top of mainline as of today (4.5-rc2).

In case you would like to test this out, I pushed a branch here:

 git://linux-arm.org/linux-jl.git upstream/default_caps_v3

This branch contains additional patches, useful to better understand how CPU
capacity information is actually used by the scheduler. Discussion regarding
these additional patches will be started with a different posting in the
future. We just didn't want to make discussion too broad, as we realize that
this set can be controversial already on its own.

Comments, concerns and rants are more than welcome!

Best,

- Juri

[1] v1 - https://lkml.org/lkml/2015/11/23/391
[2] v2 - https://lkml.org/lkml/2016/1/8/417
[3] https://lkml.org/lkml/2015/7/7/754

Juri Lelli (6):
  ARM: initialize cpu_scale to its default
  drivers/cpufreq: implement init_cpu_capacity_default()
  arm: Enable dynamic CPU capacity initialization
  arm64: Enable dynamic CPU capacity initialization
  arm: add sysfs cpu_capacity attribute
  arm64: add sysfs cpu_capacity attribute

 Documentation/kernel-parameters.txt |   4 +
 arch/arm/kernel/topology.c          |  79 +++++++++++++++-
 arch/arm64/kernel/topology.c        |  85 ++++++++++++++++++
 drivers/cpufreq/Makefile            |   2 +-
 drivers/cpufreq/cpufreq.c           |   1 +
 drivers/cpufreq/cpufreq_capacity.c  | 174 ++++++++++++++++++++++++++++++++++++
 include/linux/cpufreq.h             |   2 +
 7 files changed, 342 insertions(+), 5 deletions(-)
 create mode 100644 drivers/cpufreq/cpufreq_capacity.c

-- 
2.7.0

