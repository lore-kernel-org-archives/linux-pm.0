From: Gregory CLEMENT <gregory.clement@free-electrons.com>
Subject: [PATCH v3 00/14] CPU idle for Armada XP
Date: Mon, 14 Oct 2013 15:58:12 +0200
Message-ID: <1381759106-15004-1-git-send-email-gregory.clement@free-electrons.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:60732 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756207Ab3JNN6m (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 14 Oct 2013 09:58:42 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, linux-pm@vger.kernel.org, lorenzo.pieralisi@arm.com, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Gregory CLEMENT <gregory.clement@free-electrons.com>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, linux-arm-kernel@lists.infradead.org, Nicolas Pitre <nico@fluxnic.net>, Lior Amsalem <alior@marvell.com>, Maen Suleiman <maen@marvell.com>, Tawfik Bayouk <tawfik@marvell.com>, Shadi Ammouri <shadi@marvell.com>, Eran Ben-Avi <benavi@marvell.com>, Yehuda Yitschak <yehuday@marvell.com>, Nadav Haklai <nadavh@marvell.com>, Ike Pan <ike.pan@canonical.com>, Dan Frazier <dann.frazier@canonical.com>, Leif Lindholm <leif.lindholm@arm.com>, Jon Masters <jcm@redhat.com>, David Marlin <dmarlin@redhat.com>

Hello,

This patch set adds the CPU idle support for Armada XP and prepares
the support for Armada 370. This was based on the work of Nadav
Haklai.

Most of the patches modify the mvebu code in order to prepare the
support for CPU idle, hence the patches 2 to 10 should go to mvebu
subsystem (and then arm-soc).

The first patch should go through ARM subsystem and should be taken
by Russell King.

The 11th patch "ARM: mvebu: Add CPU idle low level support for Marvell
Armada XP" was the low level part of the cpuidle support, it will be
under mach-mvebu/ and hence should go to mvebu subsystem but it should
received an acked-by from Daniel Lezcano or Rafael J. Wysocki.

The 12th patch 'cpuidle: mvebu: Add initial cpu idle support for
Armada 370/XP SoC' is the only one who should go to the cpuidle
subsystem. But of course I would like that Daniel Lezcano or Rafael
J. Wysocki have a look on the whole series.

The 13th patch should go to mvebu subsystem.

The last patch should also go to mvebu subsystem (and then arm-soc)
but with an Acked-by from on of the device tree maintainer.

The whole series is also available in the branch CPU-idle-ArmadaXP-v3
at https://github.com/MISL-EBU-System-SW/mainline-public.git

Thanks,

Changelog:
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


Gregory CLEMENT (14):
  ARM: PJ4B: Add cpu_suspend/cpu_resume hooks for PJ4B
  ARM: mvebu: ll_set_cpu_coherent no more uses the coherency address as
    parameter
  ARM: mvebu: ll_set_cpu_coherent always uses the current CPU
  ARM: mvebu: Remove the unused argument of set_cpu_coherent()
  ARM: mvebu: Make ll_set_cpu_coherent() more configurable
  ARM: mvebu: Low level functions to disable cache snooping
  ARM: mvebu: Add a new set of registers for pmsu
  ARM: mvebu: Allow to power down L2 cache controller in idle mode
  ARM: mvebu: Add the PMSU related part of the cpu idle functions
  ARM: mvebu: Set the start address of a CPU in a separate function
  ARM: mvebu: Add CPU idle low level support for Marvell Armada XP
  cpuidle: mvebu: Add initial CPU idle support for Armada 370/XP SoC
  ARM: mvebu: register the cpuidle driver for the Armada XP SoCs
  ARM: dts: mvebu: Add a new set of registers to the PMSU node

 .../devicetree/bindings/arm/armada-370-xp-pmsu.txt |  12 ++-
 arch/arm/boot/dts/armada-xp.dtsi                   |   2 +-
 arch/arm/mach-mvebu/Makefile                       |   1 +
 arch/arm/mach-mvebu/armada-370-xp.c                |   6 ++
 arch/arm/mach-mvebu/coherency.c                    |  12 +--
 arch/arm/mach-mvebu/coherency.h                    |   2 +-
 arch/arm/mach-mvebu/coherency_ll.S                 |  69 +++++++++---
 arch/arm/mach-mvebu/headsmp.S                      |  15 +--
 arch/arm/mach-mvebu/platsmp.c                      |   2 +-
 arch/arm/mach-mvebu/pmsu.c                         | 102 +++++++++++++++++-
 arch/arm/mach-mvebu/suspend-armada-370-xp.S        |  90 ++++++++++++++++
 arch/arm/mm/proc-v7.S                              |  64 ++++++++++-
 drivers/cpuidle/Kconfig.arm                        |   5 +
 drivers/cpuidle/Makefile                           |   1 +
 drivers/cpuidle/cpuidle-armada-370-xp.c            | 117 +++++++++++++++++++++
 include/linux/armada-370-xp-pmsu.h                 |  19 ++++
 16 files changed, 477 insertions(+), 42 deletions(-)
 create mode 100644 arch/arm/mach-mvebu/suspend-armada-370-xp.S
 create mode 100644 drivers/cpuidle/cpuidle-armada-370-xp.c
 create mode 100644 include/linux/armada-370-xp-pmsu.h

-- 
1.8.1.2

