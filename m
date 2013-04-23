From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [V4 patch 00/15] cpuidle: code consolidation
Date: Tue, 23 Apr 2013 14:00:26 +0200
Message-ID: <1575993.FIabeJeWGY@vostro.rjw.lan>
References: <1366707285-12179-1-git-send-email-daniel.lezcano@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from hydra.sisk.pl ([212.160.235.94]:41558 "EHLO hydra.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755807Ab3DWLwa (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 23 Apr 2013 07:52:30 -0400
In-Reply-To: <1366707285-12179-1-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: andrew@lunn.ch, khilman@deeprootsystems.com, nsekhar@ti.com, josephl@nvidia.com, kgene.kim@samsung.com, patches@linaro.org, magnus.damm@gmail.com, tony@atomide.com, plagnioj@jcrosoft.com, linaro-kernel@lists.linaro.org, jason@lakedaemon.net, swarren@wwwdotorg.org, rob.herring@calxeda.com, horms@verge.net.au, linux@maxim.org.za, linux-arm-kernel@lists.infradead.org, deepthi@linux.vnet.ibm.com, jkosina@suse.cz, linux-pm@vger.kernel.org, lethal@linux-sh.org, kernel@pengutronix.de

On Tuesday, April 23, 2013 10:54:30 AM Daniel Lezcano wrote:
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
>         dev = per_cpu(cpuidle_device, cpu);
>         cpuidle_register_device(dev);
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
> Changelog:
>  - V4:
>    * Added the different Acked-by and Reviewed-by
>    * Removed the patches already merged:
>      * ARM: shmobile: cpuidle: remove shmobile_enter_wfi function
>      * ARM: shmobile: cpuidle: remove shmobile_enter_wfi prototype
>      * ARM: OMAP3: remove cpuidle_wrap_enter
>    * Removed patch without acked-by (no answer from the maintainer)
>      * ARM: s3c64xx: cpuidle: use init/exit common routine
> 
>  - V3:
>    * folded patch 5/19 into 19/19, they were:
>      * ARM: imx: cpuidle: use init/exit common routine
>      * ARM: imx: cpuidle: create separate drivers for imx5/imx6
>    * removed rule to make cpuidle.o in the imx's Makefile
>    * splitted patch 1/19 into two, they are:
>      * [V3 patch 01/19] ARM: shmobile: cpuidle: remove shmobile_enter_wfi
>      * [V3 patch 02/19] ARM: shmobile: cpuidle: remove shmobile_enter_wfi prototype
> 
>  - V2:
>    * fixed cpumask NULL test for coupled state in cpuidle_register
>    * added comment about structure copy
>    * changed printk by pr_err
>    * folded splitted message
>    * fixed return code in cpuidle_register
>    * updated Documentation/cpuidle/drivers.txt
>    * added in the changelog dev->state_count is filled by cpuidle_enable_device
>    * fixed tag for tegra in the first line patch description
>    * fixed tegra2 removed tegra_tear_down_cpu = tegra20_tear_down_cpu;
> 
>  - V1: Initial post
> 
> Tested-on: u8500
> Tested-on: at91
> Tested-on: intel i5
> Tested-on: OMAP4
> Tested-by: Kevin Hilman <khilman@linaro.org> # OMAP3, OMAP4
> Tested-by: Andrew Lunn <andrew@lunn.ch> # Kirkwood
> 
> Compiled with and without CPU_IDLE for:
>  u8500, at91, davinci, exynos, imx5, imx6, kirkwood, multi_v7 (for calxeda),
>  omap2plus, s3c64, tegra1, tegra2, tegra3
> 
> Daniel Lezcano (15):
>   cpuidle: remove en_core_tk_irqen flag
>   ARM: ux500: cpuidle: replace for_each_online_cpu by
>     for_each_possible_cpu
>   cpuidle: make a single register function for all
>   ARM: ux500: cpuidle: use init/exit common routine
>   ARM: at91: cpuidle: use init/exit common routine
>   ARM: OMAP3: cpuidle: use init/exit common routine
>   ARM: tegra: cpuidle: use init/exit common routine
>   ARM: shmobile: cpuidle: use init/exit common routine
>   ARM: OMAP4: cpuidle: use init/exit common routine
>   ARM: tegra: cpuidle: use init/exit common routine for tegra2
>   ARM: tegra: cpuidle: use init/exit common routine for tegra3
>   ARM: calxeda: cpuidle: use init/exit common routine
>   ARM: kirkwood: cpuidle: use init/exit common routine
>   ARM: davinci: cpuidle: use init/exit common routine
>   ARM: imx: cpuidle: use init/exit common routine

Whole series applied.

Thanks,
Rafael


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
