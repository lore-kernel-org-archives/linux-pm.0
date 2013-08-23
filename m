From: Gregory CLEMENT <gregory.clement@free-electrons.com>
Subject: [PATCH 00/12] CPU idle for Armada XP
Date: Fri, 23 Aug 2013 08:53:05 +0200
Message-ID: <1377240797-4047-1-git-send-email-gregory.clement@free-electrons.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:47774 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754757Ab3HWGxc (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 23 Aug 2013 02:53:32 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, linux-pm@vger.kernel.org, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Gregory CLEMENT <gregory.clement@free-electrons.com>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, linux-arm-kernel@lists.infradead.org, Nicolas Pitre <nico@fluxnic.net>, Lior Amsalem <alior@marvell.com>, Maen Suleiman <maen@marvell.com>, Tawfik Bayouk <tawfik@marvell.com>, Shadi Ammouri <shadi@marvell.com>, Eran Ben-Avi <benavi@marvell.com>, Yehuda Yitschak <yehuday@marvell.com>, Nadav Haklai <nadavh@marvell.com>, Ike Pan <ike.pan@canonical.com>, Chris Van Hoof <vanhoof@canonical.com>, Dan Frazier <dann.frazier@canonical.com>, Leif Lindholm <leif.lindholm@arm.com>, Jon Masters <jcm@redhat.com>, David Marlin <dmarlin@redhat.com>, Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Atsushi Yamagata <yamagata@plathome.co.jp>, Hironobu Shibata <h-shibata@plathome.co.jp>, Tomonori Kimura <kimura@plathome.co.jp>

Hello,

This patch set adds the CPU idle support for Armada XP and prepares
the support for Armada 370. This was based on the work of Nadav
Haklai.

Most of the patches modify the mvebu code in order to prepare the
support for CPU idle, hence the patches 2 to 10 should go to mvebu
subsystem (and then arm-soc).

The first patch should go through ARM subsystem and should be taken
by Russell King.

The 11th patch 'cpuidle: mvebu: Add initial cpu idle support for
Armada 370/XP SoC' is the only one who should go to the cpuidle
subsystem. But of course I would like that Daniel Lezcano or Rafael
J. Wysocki have a look on the whole series.

The last patch should also go to mvebu subsystem (and then arm-soc)
but with an Acked-by from on of the device tree maintainer.

The whole series is also available in the branch CPU-idle-ArmadaXP at
https://github.com/MISL-EBU-System-SW/mainline-public.git

Thanks,

Gregory CLEMENT (12):
  ARM: PJ4B: Add cpu_suspend/cpu_resume hooks for PJ4B
  ARM: mvebu: ll_set_cpu_coherent no more uses the coherency address as
    parameter
  ARM: mvebu: ll_set_cpu_coherent always uses the current CPU
  ARM: mvebu: Remove the unused argument of set_cpu_coherent()
  ARM: mvebu: Makes ll_set_cpu_coherent() more configurable
  ARM: mvebu: Low level functions to disbale cache snooping
  ARM: mvebu: Add a new set of registers for pmsu
  ARM: mvebu: Allow to power down L2 cache controller in idle mode
  ARM: mvebu: Add the PMSU related part of the cpu idle functions
  ARM: mvebu: Set the start address of a CPU in a separate function
  cpuidle: mvebu: Add initial cpu idle support for Armada 370/XP SoC
  ARM: dts: mvebu: Add a new set of registers to the PMSU node

 .../devicetree/bindings/arm/armada-370-xp-pmsu.txt |  12 +-
 arch/arm/boot/dts/armada-xp.dtsi                   |   2 +-
 arch/arm/mach-mvebu/coherency.c                    |  12 +-
 arch/arm/mach-mvebu/coherency.h                    |   2 +-
 arch/arm/mach-mvebu/coherency_ll.S                 |  69 +++++++++--
 arch/arm/mach-mvebu/headsmp.S                      |  15 +--
 arch/arm/mach-mvebu/platsmp.c                      |   2 +-
 arch/arm/mach-mvebu/pmsu.c                         |  99 +++++++++++++++-
 arch/arm/mm/proc-v7.S                              |  64 +++++++++-
 drivers/cpuidle/Kconfig                            |   6 +
 drivers/cpuidle/Makefile                           |   1 +
 drivers/cpuidle/cpuidle-armada-370-xp.c            | 132 +++++++++++++++++++++
 drivers/cpuidle/suspend-armada-370-xp.S            |  91 ++++++++++++++
 include/linux/armada-370-xp-pmsu.h                 |  19 +++
 14 files changed, 484 insertions(+), 42 deletions(-)
 create mode 100644 drivers/cpuidle/cpuidle-armada-370-xp.c
 create mode 100644 drivers/cpuidle/suspend-armada-370-xp.S
 create mode 100644 include/linux/armada-370-xp-pmsu.h

-- 
1.8.1.2

