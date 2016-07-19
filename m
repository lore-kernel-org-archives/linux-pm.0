From: Juri Lelli <juri.lelli@arm.com>
Subject: [PATCH v6 0/8] CPUs capacity information for heterogeneous systems
Date: Tue, 19 Jul 2016 13:40:40 +0100
Message-ID: <1468932048-31635-1-git-send-email-juri.lelli@arm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, peterz@infradead.org, vincent.guittot@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com, linux@arm.linux.org.uk, sudeep.holla@arm.com, lorenzo.pieralisi@arm.com, catalin.marinas@arm.com, will.deacon@arm.com, morten.rasmussen@arm.com, dietmar.eggemann@arm.com, juri.lelli@arm.com, broonie@kernel.org
List-Id: linux-pm@vger.kernel.org

Hi all,

version 6 of "CPUs capacity information for heterogeneous systems" patchset [1]
(please refer to previous postings to get some context).

A few changes from v5:

 - rebase on top of mainline (4.7-rc6)
 - documentation fixes
 - kcalloc() for raw_capacity array
 - pr_err() only for partial updates
 - cpu_scale_mutex to protect sysfs interface

Patches high level description:

 o 01/08 introduces documentation for the new optional DT binding
 o [02-06]/08 add cpu-capacity attribute to TC2, Juno and Juno r2 DTs and
   provide parsing of such information at boot time
 o [07-08]/08 introduce sysfs attribute

In case you would like to test this out, I pushed a branch here:

 git://linux-arm.org/linux-jl.git upstream/default_caps_v6

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
[2] https://lkml.org/lkml/2016/6/22/614 

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
 arch/arm/kernel/topology.c                         | 218 ++++++++++++++++++-
 arch/arm64/boot/dts/arm/juno-r2.dts                |   6 +
 arch/arm64/boot/dts/arm/juno.dts                   |   6 +
 arch/arm64/kernel/topology.c                       | 218 +++++++++++++++++++
 7 files changed, 698 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/arm/cpu-capacity.txt

-- 
2.7.0
