From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 00/18] cpuidle: code consolidation
Date: Wed, 10 Apr 2013 21:12:38 +0200
Message-ID: <17970296.uCm16aDdBG@vostro.rjw.lan>
References: <1365603743-5618-1-git-send-email-daniel.lezcano@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from hydra.sisk.pl ([212.160.235.94]:55635 "EHLO hydra.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752443Ab3DJTE6 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 10 Apr 2013 15:04:58 -0400
In-Reply-To: <1365603743-5618-1-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: linus.walleij@linaro.org, jason@lakedaemon.net, andrew@lunn.ch, kernel@pengutronix.de, swarren@wwwdotorg.org, santosh.shilimkar@ti.com, nicolas.ferre@atmel.com, plagnioj@jcrosoft.com, linux@maxim.org.za, rob.herring@calxeda.com, nsekhar@ti.com, horms@verge.net.au, magnus.damm@gmail.com, deepthi@linux.vnet.ibm.com, lethal@linux-sh.org, jkosina@suse.cz, kgene.kim@samsung.com, khilman@deeprootsystems.com, tony@atomide.com, linux-pm@vger.kernel.org, patches@linaro.org, linux-arm-kernel@lists.infradead.org, linaro-kernel@lists.linaro.org, josephl@nvidia.com

On Wednesday, April 10, 2013 04:22:05 PM Daniel Lezcano wrote:
> This patchset series provide some code consolidation across the different
> cpuidle drivers. It contains two parts, the first one is the removal of
> the time keeping flag and the second one, is a common initialization routine.
> 
> All the drivers use the en_core_tk_irqen flag, which means it is not necessary
> to make the time computation optional. We can remove this flag and assume the
> cpuidle framework always manage this operation.
> 
> The cpuidle code initialization is duplicated across the different drivers in
> the same manner.
> 
> The repeating pattern is:
> 
> SMP:
> 
> cpuidle_register_driver(drv);
> for_each_possible_cpu(cpu) {
> 	dev = per_cpu(cpuidle_device, cpu);
> 	cpuidle_register_device(dev);
> }
> 
> UP:
> 
> cpuidle_register_driver(drv);
> cpuidle_register_device(dev);
> 
> As on a UP machine the macro 'for_each_cpu' is a one iteration loop, using the
> initialization loop from SMP to UP works.
> 
> The patchset does some cleanup for different drivers in order to make the init
> code the same. Then it introduces a generic function:
> 
>   cpuidle_register(struct cpuidle_driver *drv, struct cpumask *cpumask)
> 
> The cpumask is for the coupled idle states.
> 
> The drivers are then modified to take into account this new function and
> to remove the duplicated code.
> 
> The benefit is observable in the diffstat: 332 lines of code removed.
> 
> Tested-on: u8500
> Tested-on: at91
> Tested-on: intel i5
> Tested-on: OMAP4
> 
> Compiled with and without CPU_IDLE for:
>  u8500, at91, davinci, exynos, imx5, imx6, kirkwood, multi_v7 (for calxeda),
>  omap2plus, s3c64, tegra1, tegra2, tegra3
> 
> 
> Daniel Lezcano (18):
>   ARM: OMAP3: remove cpuidle_wrap_enter
>   cpuidle: remove en_core_tk_irqen flag
>   ARM: ux500: cpuidle: replace for_each_online_cpu by
>     for_each_possible_cpu
>   ARM: imx: cpuidle: create separate drivers for imx5/imx6
>   cpuidle: make a single register function for all
>   ARM: ux500: cpuidle: use init/exit common routine
>   ARM: at91: cpuidle: use init/exit common routine
>   ARM: OMAP3: cpuidle: use init/exit common routine
>   ARM: s3c64xx: cpuidle: use init/exit common routine
>   ARM: tegra1: cpuidle: use init/exit common routine
>   ARM: shmobile: cpuidle: use init/exit common routine
>   ARM: OMAP4: cpuidle: use init/exit common routine
>   ARM: tegra2: cpuidle: use init/exit common routine
>   ARM: tegra3: cpuidle: use init/exit common routine
>   ARM: calxeda: cpuidle: use init/exit common routine
>   ARM: kirkwood: cpuidle: use init/exit common routine
>   ARM: davinci: cpuidle: use init/exit common routine
>   ARM: imx: cpuidle: use init/exit common routine
> 
>  arch/arm/mach-at91/cpuidle.c                    |   18 +--
>  arch/arm/mach-davinci/cpuidle.c                 |   21 +---
>  arch/arm/mach-exynos/cpuidle.c                  |    1 -
>  arch/arm/mach-imx/Makefile                      |    1 +
>  arch/arm/mach-imx/cpuidle-imx5.c                |   40 +++++++
>  arch/arm/mach-imx/cpuidle-imx6q.c               |    3 +-
>  arch/arm/mach-imx/cpuidle.c                     |   80 -------------
>  arch/arm/mach-imx/cpuidle.h                     |   10 +-
>  arch/arm/mach-imx/pm-imx5.c                     |   30 +----
>  arch/arm/mach-omap2/cpuidle34xx.c               |   49 ++------
>  arch/arm/mach-omap2/cpuidle44xx.c               |   23 +---
>  arch/arm/mach-s3c64xx/cpuidle.c                 |   15 +--
>  arch/arm/mach-shmobile/cpuidle.c                |   11 +-
>  arch/arm/mach-shmobile/pm-sh7372.c              |    1 -
>  arch/arm/mach-tegra/cpuidle-tegra114.c          |   27 +----
>  arch/arm/mach-tegra/cpuidle-tegra20.c           |   34 +-----
>  arch/arm/mach-tegra/cpuidle-tegra30.c           |   28 +----
>  arch/arm/mach-ux500/cpuidle.c                   |   33 +-----
>  arch/powerpc/platforms/pseries/processor_idle.c |    1 -
>  arch/sh/kernel/cpu/shmobile/cpuidle.c           |    1 -
>  arch/x86/kernel/apm_32.c                        |    1 -
>  drivers/acpi/processor_idle.c                   |    1 -
>  drivers/cpuidle/cpuidle-calxeda.c               |   53 +--------
>  drivers/cpuidle/cpuidle-kirkwood.c              |   18 +--
>  drivers/cpuidle/cpuidle.c                       |  137 ++++++++++++++---------
>  drivers/idle/intel_idle.c                       |    1 -
>  include/linux/cpuidle.h                         |   20 ++--
>  27 files changed, 162 insertions(+), 496 deletions(-)
>  create mode 100644 arch/arm/mach-imx/cpuidle-imx5.c
>  delete mode 100644 arch/arm/mach-imx/cpuidle.c

I will be traveling from Saturday onwards pretty much until the beginning of
the 3.10 merge window, so I'm afraid this will have to wait for the next
release cycle.  At least I'm not going to take patches that haven't been
ACKed before tomorrow evening (CEST).

Thanks,
Rafael


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
