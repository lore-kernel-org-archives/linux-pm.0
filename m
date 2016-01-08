From: Juri Lelli <juri.lelli@arm.com>
Subject: [RFC PATCH v2 0/4] CPUs capacity information for heterogeneous systems
Date: Fri,  8 Jan 2016 14:09:28 +0000
Message-ID: <1452262172-31861-1-git-send-email-juri.lelli@arm.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:45507 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751533AbcAHOJm (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 8 Jan 2016 09:09:42 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, peterz@infradead.org, vincent.guittot@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com, linux@arm.linux.org.uk, sudeep.holla@arm.com, lorenzo.pieralisi@arm.com, catalin.marinas@arm.com, will.deacon@arm.com, morten.rasmussen@arm.com, dietmar.eggemann@arm.com, juri.lelli@arm.com, broonie@kernel.org

Hi all,

this is take 2 of https://lkml.org/lkml/2015/11/23/391; some context follows.

ARM systems may be configured to have CPUs with different power/performance
characteristics within the same chip. In this case, additional information has
to be made available to the kernel (the scheduler in particular) for it to be
aware of such differences and take decisions accordingly. This RFC stems from
the ongoing discussion about introducing a simple platform energy cost model to
guide scheduling decisions (a.k.a Energy Aware Scheduling [1]), but also aims
to be an independent track aimed to standardise the way we make the scheduler
aware of heterogenous CPU systems. With these patches and in addition patches
from [1] (that make the scheduler wakeup paths aware of heterogenous CPU
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

Second version of this RFC proposes an alternative solution (w.r.t. v1) to the
problem of how do we init CPUs original capacity: we run a bogus benchmark (for
this RFC I simple stole int_sqrt from lib/ and I run that in a loop to perform
some integer computation, I'm sure there are better benchmarks around) on the
first cpu of each frequency domain (assuming no u-arch differences inside
domains), measure time to complete a fixed number of iterations and then
normalize results to SCHED_CAPACITY_SCALE (1024). I didn't spend much time in
polishing this up or thinking about a better benchmark, as this is an RFC and
I'd like discussion happening before we make this solution better
working/looking. However, surprisingly, results are not that bad already:

                          LITTLE      big

 TC2-userspace_profile     430        1024
 TC2-dynamic_profile      ~490        1024

 JUNO-userspace_profile    446        1024
 JUNO-dynamic_profile     ~424        1024

Considering v1 approach as well, there are currently three proposals for
providing CPUs capacity information; each one has of course pros and cons. I'll
try to summarize the long discussion we had about v1 in the list that follows
(mixing in my personal view points :-)), please don't hesitate to add/comment
(and thanks a lot for the time spent reviewing v1!):

 1. DT (v1)

    pros: - clean and easy to implement
          - standard for both arm and arm64 (and possibly other archs)
          - requires profiling only once and in userspace

    cons: - capacity is not a physical, unequivocally definable property
          - might be incorrecly used for tuning purposes
          - it's a standard, so it requires additional care when defining it

 2. Dynamic profiling at boot (v2)

    pros: - does not require a standardized definition of capacity
          - cannot be incorrectly tuned (once benchmark is fixed)
          - does not require user/integrator work

    cons: - not easy to come up with a clean solution, as it seems interaction
            with several subsystems (e.g., cpufreq) is required
          - not easy to agree upon a single benchmark (that has to be both
            representative and simple enough to run at boot)
          - numbers might (and do) vary from boot to boot

 3. sysfs (v1)

    pros: - clean and super easy to implement
          - values don't require to be physical properties, defining them is
            probably easier

    cons: - CPUs capacity have to be provided after boot (by some init script?)
          - API is modified, still some discussion/review is needed
          - values can still be incorrectly used for runtime tuning purposes

Patches high level description:

 o 01/04 cleans up how cpu_scale is initialized in arm (already landed on
   Russell's patch system)
 o 02/04 introduces dynamic profiling of CPUs capacity at boot
 o [03-04]/04 enable dynamic profiling for arm and arm64.

The patchset is based on top of tip/sched/core as of today (4.4.0-rc8).

In case you would like to test this out, I pushed a branch here:

 git://linux-arm.org/linux-jl.git upstream/default_caps_v2

This branch contains additional patches, useful to better understand how CPU
capacity information is actually used by the scheduler. Discussion regarding
these additional patches will be started with a different posting in the
future. We just didn't want to make discussion too broad, as we realize that
this set can be controversial already on its own.

Comments, concerns and rants are more than welcome!

Best,

- Juri

Juri Lelli (4):
  ARM: initialize cpu_scale to its default
  drivers/cpufreq: implement init_cpu_capacity_default()
  arm: Enable dynamic CPU capacity initialization
  arm64: Enable dynamic CPU capacity initialization

 arch/arm/kernel/topology.c         |  11 ++-
 arch/arm64/kernel/topology.c       |  17 ++++
 drivers/cpufreq/Makefile           |   2 +-
 drivers/cpufreq/cpufreq.c          |   1 +
 drivers/cpufreq/cpufreq_capacity.c | 161 +++++++++++++++++++++++++++++++++++++
 include/linux/cpufreq.h            |   2 +
 6 files changed, 189 insertions(+), 5 deletions(-)
 create mode 100644 drivers/cpufreq/cpufreq_capacity.c

-- 
2.2.2

