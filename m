From: Juri Lelli <juri.lelli@arm.com>
Subject: [PATCH v4 0/8] CPUs capacity information for heterogeneous systems
Date: Fri, 18 Mar 2016 14:24:06 +0000
Message-ID: <1458311054-13524-1-git-send-email-juri.lelli@arm.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:54618 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751188AbcCROXd (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 18 Mar 2016 10:23:33 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, peterz@infradead.org, vincent.guittot@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com, linux@arm.linux.org.uk, sudeep.holla@arm.com, lorenzo.pieralisi@arm.com, catalin.marinas@arm.com, will.deacon@arm.com, morten.rasmussen@arm.com, dietmar.eggemann@arm.com, juri.lelli@arm.com, broonie@kernel.org

Hi all,

this is take 4 of "CPUs capacity information for heterogeneous systems"
patchset [1]; some context follows.

ARM systems may be configured to have CPUs with different power/performance
characteristics within the same chip. In this case, additional information has
to be made available to the kernel (the scheduler in particular) for it to be
aware of such differences and take decisions accordingly. This RFC stems from
the ongoing discussion about introducing a simple platform energy cost model to
guide scheduling decisions (a.k.a Energy Aware Scheduling [2]), but also aims
to be an independent track aimed to standardise the way we make the scheduler
aware of heterogeneous CPU systems. With these patches and in addition patches
from [2] (that make the scheduler wakeup paths aware of heterogeneous CPU
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

After discussing at the recent Linaro Connect pros and cons of the alternatives
presented on the list, we seem to come to the conclusion that a new DT binding
is reasonable: the new property is only a first-order approximation that it is
useful to get acceptable good behaviours during boot and early execution; it
can be then overwritten using the sysfs interface if needed.
I thus rebased v1 of this set on mainline as of today and I also removed the
capacity-scale property (as agreed during v1 review): CPU capacity properties
are now normalized w.r.t. the biggest capacity found while parsing the DT.
The capacity property name and definition didn't change w.r.t. v1, as I
intended this to be an almost pure refresh of that posting. Comments and
feedback on what needs to be changed there is highly welcome.

Patches high level description:

 o 01/08 cleans up how cpu_scale is initialized in arm (already landed on
   Russell's patch system)
 o 02/08 introduces documentation for the new optional DT binding
 o [03-06]/08 add cpu-capacity attribute to TC2 and Juno DTs and provide
   parsing of such information at boot time
 o [07-08]/08 introduce sysfs attribute

The patchset is based on top of mainline as of today (4.5). Changelogs comments
regarding changes relative to previous versions, where present, refer to v1, as
v2 and v3 didn't contain 02-06.

In case you would like to test this out, I pushed a branch here:

 git://linux-arm.org/linux-jl.git upstream/default_caps_v4

This branch contains additional patches, useful to better understand how CPU
capacity information is actually used by the scheduler. However, discussion
regarding these additional patches is outside the scope of this posting.

Best,

- Juri

[1] v1 - https://lkml.org/lkml/2015/11/23/391
    v2 - https://lkml.org/lkml/2016/1/8/417
    v3 - https://lkml.org/lkml/2016/2/3/405
[2] https://lkml.org/lkml/2015/7/7/754

Juri Lelli (8):
  ARM: initialize cpu_scale to its default
  Documentation: arm: define DT cpu capacity bindings
  arm: parse cpu capacity from DT
  arm, dts: add TC2 cpu capacity information
  arm64: parse cpu capacity from DT
  arm64, dts: add Juno cpu capacity information
  arm: add sysfs cpu_capacity attribute
  arm64: add sysfs cpu_capacity attribute

 .../devicetree/bindings/arm/cpu-capacity.txt       | 222 +++++++++++++++++++++
 Documentation/devicetree/bindings/arm/cpus.txt     |   9 +
 arch/arm/boot/dts/vexpress-v2p-ca15_a7.dts         |   5 +
 arch/arm/kernel/topology.c                         | 150 +++++++++++++-
 arch/arm64/boot/dts/arm/juno.dts                   |   6 +
 arch/arm64/kernel/topology.c                       | 143 +++++++++++++
 6 files changed, 531 insertions(+), 4 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/cpu-capacity.txt

-- 
2.7.0

