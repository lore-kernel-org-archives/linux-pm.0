From: Juri Lelli <juri.lelli@arm.com>
Subject: [PATCH v5 0/8] CPUs capacity information for heterogeneous systems
Date: Wed, 15 Jun 2016 11:17:49 +0100
Message-ID: <1465985877-18271-1-git-send-email-juri.lelli@arm.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:36020 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751884AbcFOKS1 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 15 Jun 2016 06:18:27 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, peterz@infradead.org, vincent.guittot@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com, linux@arm.linux.org.uk, sudeep.holla@arm.com, lorenzo.pieralisi@arm.com, catalin.marinas@arm.com, will.deacon@arm.com, morten.rasmussen@arm.com, dietmar.eggemann@arm.com, juri.lelli@arm.com, broonie@kernel.org, sgurrappadi@nvidia.com

Hi all,

this is take 5 of "CPUs capacity information for heterogeneous systems"
patchset [1] (please refer to previous postings to get some context). Apologies
for taking so much time before posting a new version, I've been busy working on
other (related :-)) stuff.

Anyway, after v4 review we seem to still agree that a new DT binding is
reasonable (as it is only a first-order approximation that it is useful to get
acceptable good behaviours during boot and early execution and it can be then
overwritten using the sysfs interface if needed). However, Rob asked for more
precision in defining the binding and Mark, Sai and Vincent seem to agree that
we should extract the frequency component from the values we put in DT.

In this new version I made several changes:

 - first patch of v4 is now mainline (but we've got a new one, see below)
 - clearly state that Dhrystone is used to get this first order approx values
 - the binding is now called capacity-dmips-mhz (suggestions for better naming
   are welcome!)
 - capacity-dmips-mhz have to be calculated by:
   + running dhrystone at max freq on each cpu (in practice it can be run just
     on the first cpu of each cluster and at any frequency)
   + collect DMIPS/MHz by dividing the score by the frequency at which it has
     been run
   + normalize DMIPS/MHz and put such values in the DT (we've got a new patch
     in the series for JUNO R2)
 - at boot we use a cpufreq callback to be able to multiply back capacity-dmips
   -mhz for policy->max and then normalize w.r.t. 1024
 - if cpufreq is not in the mix, we use capacity-dmips-mhz values as they are
   (since we don't know at which frequency we are running at, we assume that
   CPUs run all at the same frequency)

I guess at least some more comments in the code and some more lines in
Documentation will help, but I'll defer that to v6: I'd like to see if we can
first reach an agreement.

Patches high level description:

 o 01/08 introduces documentation for the new optional DT binding
 o [02-06]/08 add cpu-capacity attribute to TC2, Juno and Juno r2 DTs and
   provide parsing of such information at boot time
 o [07-08]/08 introduce sysfs attribute

The patchset is based on top of mainline as of today (4.7-rc3). 

In case you would like to test this out, I pushed a branch here:

 git://linux-arm.org/linux-jl.git upstream/default_caps_v5

This branch contains additional patches, useful to better understand how CPU
capacity information is actually used by the scheduler. However, discussion
regarding these additional patches is outside the scope of this posting.

Best,

- Juri

Juri Lelli (8):
  Documentation: arm: define DT cpu capacity-dmips-mhz bindings
  arm: parse cpu capacity-dmips-mhz from DT
  arm, dts: add TC2 cpu capacity-dmips-mhz information
  arm64: parse cpu capacity-dmips-mhz from DT
  arm64, dts: add Juno cpu capacity-dmips-mhz information
  arm64, dts: add Juno r2 cpu capacity-dmips-mhz information
  arm: add sysfs cpu_capacity attribute
  arm64: add sysfs cpu_capacity attribute

 .../devicetree/bindings/arm/cpu-capacity.txt       | 236 +++++++++++++++++++++
 Documentation/devicetree/bindings/arm/cpus.txt     |  10 +
 arch/arm/boot/dts/vexpress-v2p-ca15_a7.dts         |   5 +
 arch/arm/kernel/topology.c                         | 213 ++++++++++++++++++-
 arch/arm64/boot/dts/arm/juno-r2.dts                |   6 +
 arch/arm64/boot/dts/arm/juno.dts                   |   6 +
 arch/arm64/kernel/topology.c                       | 213 +++++++++++++++++++
 7 files changed, 688 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/arm/cpu-capacity.txt

-- 
2.7.0

