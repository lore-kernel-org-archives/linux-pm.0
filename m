From: Gregory CLEMENT <gregory.clement@free-electrons.com>
Subject: [PATCH v4 00/13] CPU idle for Armada XP
Date: Thu, 13 Feb 2014 18:33:23 +0100
Message-ID: <1392312816-17657-1-git-send-email-gregory.clement@free-electrons.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:51886 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752416AbaBMReE (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 13 Feb 2014 12:34:04 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, linux-pm@vger.kernel.org, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Gregory CLEMENT <gregory.clement@free-electrons.com>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, linux-arm-kernel@lists.infradead.org, Lior Amsalem <alior@marvell.com>, Tawfik Bayouk <tawfik@marvell.com>, Nadav Haklai <nadavh@marvell.com>

Hello,

This patch set adds the CPU idle support for Armada XP and prepares
the support for Armada 370. This was based on the work of Nadav
Haklai.

There were many changes done, see the changelog for the details. I
should have managed to comply with all the reviewer wishes.

Most of the patches modify the mvebu code in order to prepare the
support for CPU idle, hence the patches 2 to 6 and from 8 to 11 should
go to mvebu subsystem (and then arm-soc).

The first patch should go through ARM subsystem and should be taken by
Russell King. As I didn't receive any comment against this patch, I
planed to submit to Russell's patch system.

The 7th patch should also go to mvebu subsystem (and then arm-soc) but
it would be nice to have an Acked-by from on of the device tree
maintainer.

The 12th patch 'cpuidle: mvebu: Add initial cpu idle support for
Armada 370/XP SoC' is the only one who should go to the cpuidle
subsystem. But of course I would like that Daniel Lezcano or Rafael
J. Wysocki have a look on the whole series.

The 13th patch should go to mvebu subsystem.

The whole series is also available in the branch CPU-idle-ArmadaXP-v4
at https://github.com/MISL-EBU-System-SW/mainline-public.git

Thanks,

Changelog:
v3 -> v4:

* factorized the code in coherency_ll.S and make it autodetect as mush
  as possible

* reordered the introduction of the device tree binding

* removed all the EXPORT_SYMBOL_GPL as the driver can only be built
  into the kernel and never be built as a module.

* moved the armada_370_xp_pmsu_enable_l2_powerdown_onidle function in
  armada_370_cp.c file during the initialization of the platform.

* fixed various coding style issue and typos pointed by Thomas

* fixed all the coding issue style, made the comments more coherent
  and add more comment in the suspend-armada-370-xp.S file.

* moved all the device tree related check from
  armada_370_xp_cpuidle_probe to armada_370_xp_dt_init.

* used cpu_pm_enter() instead of directly calling platform code in
  Armada_370_xp_enter_idle.

* convert the sequence to disable the coherency to the one used in
  TC2.

* Rebased on v3.14-rc1

v2 -> v3:

* Converted the driver to use module_platform_driver. This lead to the
  introduction of a new patch (PATCH 11). Pointed by Daniel Lezcano.

* Used PUIDLE_DRIVER_FLAGS_MASK to store the deep idle information,
  suggested by Daniel Lezcano.

* Removed cpu_init call from armada_370_xp_enter_idle
  function. Pointed by Lorenzo Pieralisi.

* Rebased on v3.12-rc5


v1 -> v2:

* Removed the pm_level kernel parameter. As Kevin Hilman pointed, its
  usage can be replaced by using
  /sys/devices/system/cpu/cpu*/cpuidle/state*/disable or the kernel
  parameter cpuidle.off.

* Used BIT() macro (reported by Ezequiel)

* Made the function more readable the
  armada_370_xp_pmsu_idle_prepare() function (reported by Thomas)

* Moved the config entry in Kconfig.arm, and rename the config symbol
  according the pattern used by other arm cpu: ARM_"soc name"_CPUIDLE

* Moved the build rule under the new ARM SoC section in the Makefile

* Rebased on Linus Torvalds master branch of Thursday September 12

Gregory CLEMENT (13):
  ARM: PJ4B: Add cpu_suspend/cpu_resume hooks for PJ4B
  ARM: mvebu: remove the address parameter for ll_set_cpu_coherent
  ARM: mvebu: ll_set_cpu_coherent always uses the current CPU
  ARM: mvebu: Remove the unused argument of set_cpu_coherent()
  ARM: mvebu: Low level function to disable HW coherency support
  ARM: mvebu: Add a new set of registers for pmsu
  ARM: dts: mvebu: Add a new set of registers to the PMSU node
  ARM: mvebu: Allow to power down L2 cache controller in idle mode
  ARM: mvebu: Add the PMSU related part of the cpu idle functions
  ARM: mvebu: Set the start address of a CPU in a separate function
  ARM: mvebu: Register notifier callback for the cpuidle transition
  cpuidle: mvebu: Add initial CPU idle support for Armada 370/XP SoC
  ARM: mvebu: register the cpuidle driver for the Armada XP SoCs

 .../devicetree/bindings/arm/armada-370-xp-pmsu.txt |  12 +-
 arch/arm/boot/dts/armada-xp.dtsi                   |   2 +-
 arch/arm/mach-mvebu/armada-370-xp.c                |  12 ++
 arch/arm/mach-mvebu/coherency.c                    |  12 +-
 arch/arm/mach-mvebu/coherency.h                    |   2 +-
 arch/arm/mach-mvebu/coherency_ll.S                 |  86 +++++++++---
 arch/arm/mach-mvebu/headsmp.S                      |  15 +--
 arch/arm/mach-mvebu/platsmp.c                      |   2 +-
 arch/arm/mach-mvebu/pmsu.c                         | 147 ++++++++++++++++++++-
 arch/arm/mach-mvebu/pmsu.h                         |   2 +
 arch/arm/mm/proc-v7.S                              |  64 ++++++++-
 drivers/cpuidle/Kconfig.arm                        |   5 +
 drivers/cpuidle/Makefile                           |   1 +
 drivers/cpuidle/cpuidle-armada-370-xp.c            | 120 +++++++++++++++++
 14 files changed, 427 insertions(+), 55 deletions(-)
 create mode 100644 drivers/cpuidle/cpuidle-armada-370-xp.c

-- 
1.8.1.2

