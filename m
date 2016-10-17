From: Juri Lelli <juri.lelli@arm.com>
Subject: [PATCH v7 REPOST 0/9] CPUs capacity information for heterogeneous systems
Date: Mon, 17 Oct 2016 16:46:41 +0100
Message-ID: <20161017154650.18779-1-juri.lelli@arm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, peterz@infradead.org, vincent.guittot@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com, linux@arm.linux.org.uk, sudeep.holla@arm.com, lorenzo.pieralisi@arm.com, catalin.marinas@arm.com, will.deacon@arm.com, morten.rasmussen@arm.com, dietmar.eggemann@arm.com, juri.lelli@arm.com, broonie@kernel.org
List-Id: linux-pm@vger.kernel.org

Hi all,

this is a repost of version 7 of "CPUs capacity information for heterogeneous
systems" patchset [1] (please refer to previous postings to get some context).
I only added Juno r1 dts, as discussed off-line with Sudeep meanwhile (no code
changes at all, so that's why I'm saying this is a repost).

I'm reposting as I didn't receive any comment (despite pinging people) on the
original v7 posting (apart from Vincent acking patches 2 and 4, thanks!). I
then waited until merge window for 4.9 was closed.

I'm thus now assuming that everybody is OK with the patches and that they can
be queued for 4.10 (we certainly need this plumbing at this point). Please
speak if my assumption is wrong (and provide feedback! :).
Otherwise I'm going to:

 - use Russell's patching system for patches 2 and 8
 - ask Sudeep to pull patches 3,5,6 and 7
 - ask Catalin/Will to pull patches 1,4 and 9

Do you think we might get into trouble splitting the merge process this way?
Please let me know how to proceed otherwise.

As per orginal v7 posting, patches high level description:

 o 01/09 introduces documentation for the new optional DT binding
 o [02-07]/09 add cpu-capacity attribute to TC2, Juno, Juno r1 and Juno r2 DTs
   and provide parsing of such information at boot time
 o [08-09]/09 introduce sysfs attribute

In case you would like to test this out, I updated the branch here:

 git://linux-arm.org/linux-jl.git upstream/default_caps_v7

This branch contains additional patches, useful to better understand how CPU
capacity information is actually used by the scheduler.

These patches also form the basis for Morten/Dietmar's "Clean-ups and
asymmetric cpu capacity support" series [2] (and the EAS stack in general).

Best,

- Juri

[1] v1 - https://lkml.org/lkml/2015/11/23/391
    v2 - https://lkml.org/lkml/2016/1/8/417
    v3 - https://lkml.org/lkml/2016/2/3/405
    v4 - https://lkml.org/lkml/2016/3/18/350
    v5 - https://lkml.org/lkml/2016/6/15/291
    v6 - https://lkml.org/lkml/2016/7/19/419
    v7 - https://lkml.org/lkml/2016/9/5/409
[2] https://lkml.org/lkml/2016/10/14/312 

Juri Lelli (9):
  Documentation: arm: define DT cpu capacity-dmips-mhz bindings
  arm: parse cpu capacity-dmips-mhz from DT
  arm, dts: add TC2 cpu capacity-dmips-mhz information
  arm64: parse cpu capacity-dmips-mhz from DT
  arm64, dts: add Juno cpu capacity-dmips-mhz information
  arm64, dts: add Juno r1 cpu capacity-dmips-mhz information
  arm64, dts: add Juno r2 cpu capacity-dmips-mhz information
  arm: add sysfs cpu_capacity attribute
  arm64: add sysfs cpu_capacity attribute

 .../devicetree/bindings/arm/cpu-capacity.txt       | 236 +++++++++++++++++++++
 Documentation/devicetree/bindings/arm/cpus.txt     |  10 +
 arch/arm/boot/dts/vexpress-v2p-ca15_a7.dts         |   5 +
 arch/arm/kernel/topology.c                         | 229 +++++++++++++++++++-
 arch/arm64/boot/dts/arm/juno-r1.dts                |   6 +
 arch/arm64/boot/dts/arm/juno-r2.dts                |   6 +
 arch/arm64/boot/dts/arm/juno.dts                   |   6 +
 arch/arm64/kernel/topology.c                       | 232 +++++++++++++++++++-
 8 files changed, 728 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/cpu-capacity.txt

-- 
2.10.0
