From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [V4 patch 00/15] cpuidle: code consolidation
Date: Tue, 23 Apr 2013 10:54:30 +0200
Message-ID: <1366707285-12179-1-git-send-email-daniel.lezcano@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wg0-f45.google.com ([74.125.82.45]:45457 "EHLO
	mail-wg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755573Ab3DWIyu (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 23 Apr 2013 04:54:50 -0400
Received: by mail-wg0-f45.google.com with SMTP id l18so151843wgh.0
        for <linux-pm@vger.kernel.org>; Tue, 23 Apr 2013 01:54:48 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@sisk.pl
Cc: andrew@lunn.ch, khilman@deeprootsystems.com, nsekhar@ti.com, josephl@nvidia.com, kgene.kim@samsung.com, patches@linaro.org, magnus.damm@gmail.com, tony@atomide.com, plagnioj@jcrosoft.com, linaro-kernel@lists.linaro.org, jason@lakedaemon.net, swarren@wwwdotorg.org, rob.herring@calxeda.com, horms@verge.net.au, linux@maxim.org.za, linux-arm-kernel@lists.infradead.org, deepthi@linux.vnet.ibm.com, jkosina@suse.cz, linux-pm@vger.kernel.org, lethal@linux-sh.org, kernel@pengutronix.de

This patchset series provide some code consolidation across the different
cpuidle drivers. It contains two parts, the first one is the removal of
the time keeping flag and the second one, is a common initialization routine.

All the drivers use the en_core_tk_irqen flag, which means it is not necessary
to make the time computation optional. We can remove this flag and assume the
cpuidle framework always manage this operation.

The cpuidle code initialization is duplicated across the different drivers in
the same manner.

The repeating pattern is:

SMP:

cpuidle_register_driver(drv);
for_each_possible_cpu(cpu) {
        dev = per_cpu(cpuidle_device, cpu);
        cpuidle_register_device(dev);
}

UP:

cpuidle_register_driver(drv);
cpuidle_register_device(dev);

As on a UP machine the macro 'for_each_cpu' is a one iteration loop, using the
initialization loop from SMP to UP works.

The patchset does some cleanup for different drivers in order to make the init
code the same. Then it introduces a generic function:

  cpuidle_register(struct cpuidle_driver *drv, struct cpumask *cpumask)

The cpumask is for the coupled idle states.

The drivers are then modified to take into account this new function and
to remove the duplicated code.

The benefit is observable in the diffstat: 332 lines of code removed.

Changelog:
 - V4:
   * Added the different Acked-by and Reviewed-by
   * Removed the patches already merged:
     * ARM: shmobile: cpuidle: remove shmobile_enter_wfi function
     * ARM: shmobile: cpuidle: remove shmobile_enter_wfi prototype
     * ARM: OMAP3: remove cpuidle_wrap_enter
   * Removed patch without acked-by (no answer from the maintainer)
     * ARM: s3c64xx: cpuidle: use init/exit common routine

 - V3:
   * folded patch 5/19 into 19/19, they were:
     * ARM: imx: cpuidle: use init/exit common routine
     * ARM: imx: cpuidle: create separate drivers for imx5/imx6
   * removed rule to make cpuidle.o in the imx's Makefile
   * splitted patch 1/19 into two, they are:
     * [V3 patch 01/19] ARM: shmobile: cpuidle: remove shmobile_enter_wfi
     * [V3 patch 02/19] ARM: shmobile: cpuidle: remove shmobile_enter_wfi prototype

 - V2:
   * fixed cpumask NULL test for coupled state in cpuidle_register
   * added comment about structure copy
   * changed printk by pr_err
   * folded splitted message
   * fixed return code in cpuidle_register
   * updated Documentation/cpuidle/drivers.txt
   * added in the changelog dev->state_count is filled by cpuidle_enable_device
   * fixed tag for tegra in the first line patch description
   * fixed tegra2 removed tegra_tear_down_cpu = tegra20_tear_down_cpu;

 - V1: Initial post

Tested-on: u8500
Tested-on: at91
Tested-on: intel i5
Tested-on: OMAP4
Tested-by: Kevin Hilman <khilman@linaro.org> # OMAP3, OMAP4
Tested-by: Andrew Lunn <andrew@lunn.ch> # Kirkwood

Compiled with and without CPU_IDLE for:
 u8500, at91, davinci, exynos, imx5, imx6, kirkwood, multi_v7 (for calxeda),
 omap2plus, s3c64, tegra1, tegra2, tegra3

Daniel Lezcano (15):
  cpuidle: remove en_core_tk_irqen flag
  ARM: ux500: cpuidle: replace for_each_online_cpu by
    for_each_possible_cpu
  cpuidle: make a single register function for all
  ARM: ux500: cpuidle: use init/exit common routine
  ARM: at91: cpuidle: use init/exit common routine
  ARM: OMAP3: cpuidle: use init/exit common routine
  ARM: tegra: cpuidle: use init/exit common routine
  ARM: shmobile: cpuidle: use init/exit common routine
  ARM: OMAP4: cpuidle: use init/exit common routine
  ARM: tegra: cpuidle: use init/exit common routine for tegra2
  ARM: tegra: cpuidle: use init/exit common routine for tegra3
  ARM: calxeda: cpuidle: use init/exit common routine
  ARM: kirkwood: cpuidle: use init/exit common routine
  ARM: davinci: cpuidle: use init/exit common routine
  ARM: imx: cpuidle: use init/exit common routine

 Documentation/cpuidle/driver.txt                |    6 +
 arch/arm/mach-at91/cpuidle.c                    |   18 +--
 arch/arm/mach-davinci/cpuidle.c                 |   21 +---
 arch/arm/mach-exynos/cpuidle.c                  |    1 -
 arch/arm/mach-imx/Makefile                      |    2 +-
 arch/arm/mach-imx/cpuidle-imx5.c                |   37 ++++++
 arch/arm/mach-imx/cpuidle-imx6q.c               |    3 +-
 arch/arm/mach-imx/cpuidle.c                     |   80 -------------
 arch/arm/mach-imx/cpuidle.h                     |   10 +-
 arch/arm/mach-imx/pm-imx5.c                     |   30 +----
 arch/arm/mach-omap2/cpuidle34xx.c               |   23 +---
 arch/arm/mach-omap2/cpuidle44xx.c               |   27 +----
 arch/arm/mach-s3c64xx/cpuidle.c                 |    1 -
 arch/arm/mach-shmobile/cpuidle.c                |   11 +-
 arch/arm/mach-shmobile/pm-sh7372.c              |    1 -
 arch/arm/mach-tegra/cpuidle-tegra114.c          |   27 +----
 arch/arm/mach-tegra/cpuidle-tegra20.c           |   31 +----
 arch/arm/mach-tegra/cpuidle-tegra30.c           |   28 +----
 arch/arm/mach-ux500/cpuidle.c                   |   33 +-----
 arch/powerpc/platforms/pseries/processor_idle.c |    1 -
 arch/sh/kernel/cpu/shmobile/cpuidle.c           |    1 -
 arch/x86/kernel/apm_32.c                        |    1 -
 drivers/acpi/processor_idle.c                   |    1 -
 drivers/cpuidle/cpuidle-calxeda.c               |   53 +--------
 drivers/cpuidle/cpuidle-kirkwood.c              |   18 +--
 drivers/cpuidle/cpuidle.c                       |  144 ++++++++++++++---------
 drivers/idle/intel_idle.c                       |    1 -
 include/linux/cpuidle.h                         |   20 ++--
 28 files changed, 162 insertions(+), 468 deletions(-)
 create mode 100644 arch/arm/mach-imx/cpuidle-imx5.c
 delete mode 100644 arch/arm/mach-imx/cpuidle.c

-- 
1.7.9.5

