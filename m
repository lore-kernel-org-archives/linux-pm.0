From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: [PATCH v3 3/5] ARM: Exynos: switch to using generic cpufreq driver
 for Exynos4x12
Date: Mon, 03 Aug 2015 15:55:17 +0200
Message-ID: <2347616.SxxJmTVssu@amdc1976>
References: <1438368557-2352-1-git-send-email-b.zolnierkie@samsung.com>
 <4532306.AVvo5hem3c@amdc1976> <55BF4D41.1060903@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:48499 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752848AbbHCN4Q (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 3 Aug 2015 09:56:16 -0400
In-reply-to: <55BF4D41.1060903@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, Thomas Abraham <thomas.ab@samsung.com>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Michael Turquette <mturquette@baylibre.com>, Kukjin Kim <kgene.kim@samsung.com>, Kukjin Kim <kgene@kernel.org>, Tomasz Figa <tomasz.figa@gmail.com>, Lukasz Majewski <l.majewski@samsung.com>, Heiko Stuebner <heiko@sntech.de>, Chanwoo Choi <cw00.choi@samsung.com>, Kevin Hilman <khilman@linaro.org>, Javier Martinez Canillas <javier@dowhile0.org>, Tobias Jakobi <tjakobi@math.uni-bielefeld.de>, Anand Moon <linux.amoon@gmail.com>, linux-samsung-soc@vger.kernel.org, linux-clk@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Javier Martinez Canillas <javier@osg.samsung.com>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>


Hi,

On Monday, August 03, 2015 08:15:13 PM Krzysztof Kozlowski wrote:
> W dniu 03.08.2015 o 19:36, Bartlomiej Zolnierkiewicz pisze:
> > On Monday, August 03, 2015 03:59:26 PM Viresh Kumar wrote:
> >> On 03-08-15, 12:17, Bartlomiej Zolnierkiewicz wrote:
> >>>
> >>> Hi,
> >>>
> >>> On Saturday, August 01, 2015 04:47:21 PM Viresh Kumar wrote:
> >>>> On 31-07-15, 20:49, Bartlomiej Zolnierkiewicz wrote:
> >>>>> diff --git a/drivers/cpufreq/Kconfig b/drivers/cpufreq/Kconfig
> >>>>> index 659879a..bf6d596 100644
> >>>>> --- a/drivers/cpufreq/Kconfig
> >>>>> +++ b/drivers/cpufreq/Kconfig
> >>>>> @@ -191,6 +191,7 @@ config CPUFREQ_DT
> >>>>>  	# if CPU_THERMAL is on and THERMAL=m, CPUFREQ_DT cannot be =y:
> >>>>>  	depends on !CPU_THERMAL || THERMAL
> >>>>>  	select PM_OPP
> >>>>> +	select EXYNOS_THERMAL if ARCH_EXYNOS
> >>>>>  	help
> >>>>>  	  This adds a generic DT based cpufreq driver for frequency management.
> >>>>>  	  It supports both uniprocessor (UP) and symmetric multiprocessor (SMP)
> >>>>
> >>>> No, we shouldn't pollute generic Kconfig options with platform specific stuff.
> >>>
> >>> The old code depended on this.  You couldn't enable boost support
> >>> without enabling thermal support (ARM_EXYNOS_CPU_FREQ_BOOST_SW
> >>> config option selected EXYNOS_THERMAL).
> >>>
> >>>> Why don't you enable thermal in your .config?
> >>>
> >>> It is enabled in exynos_defconfig but without the above change it
> >>> can disabled manually which is something that we don't want.
> >>
> >> You are not getting it. I am not asking you to not select thermal, but
> >> to select it from within your architecture Kconfig option if you want.
> > 
> > OK.  Krzysztof/Kukjin do you agree with selecting EXYNOS_THERMAL
> > from ARCH_EXYNOS in the platform code?
> 
> I agree, with your explanation it seems good. Can you just add this
> justification to the commit message?

Updated patch below (I'm not resending the whole series as all other
patches remain unchanged).

> > 
> >> Over that, thermal is really an option, not a dependency. So, if
> >> someone manually disables it, its his problem not yours :)
> > 
> > I would really like it to be dependency not an option (+ I think
> > that ideally it should be checked at runtime, IOW we should be
> > checking from cpufreq-dt driver if the thermal support is enabled
> > before enabling boost support).
> 
> That would be the best. It is fine with me if you want to do this in
> consecutive patches (after applying patch selecting/depending on it in
> mach-exynos code).

---------------------8<-------------------

>From 2595b5e6164a2d1b76626e14302b148b7af5e050 Mon Sep 17 00:00:00 2001
From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Mon, 3 Aug 2015 15:49:06 +0200
Subject: [PATCH] ARM: Exynos: switch to using generic cpufreq driver for
 Exynos4x12

The new CPU clock type allows the use of generic CPUfreq driver.
Switch Exynos4x12 to using generic cpufreq driver.

Previously (when exynos-cpufreq driver was used with boost
functionality) ARM_EXYNOS_CPU_FREQ_BOOST_SW config option
(which enabled boost functionality) selected EXYNOS_THERMAL
one.  After switching Exynos4x12 platforms to use cpufreq-dt
driver boost support is enabled in the cpufreq-dt driver
itself (because there are turbo OPPs defined in the board's
DTS file).  However we still would like to allow enabling
boost support only if thermal support is also enabled for
Exynos platforms.  To achieve this make ARCH_EXYNOS config
option select THERMAL and EXYNOS_THERMAL ones.

Please also note that the switch to use the generic cpufreq-dt
driver fixes the minor issue present with the old code (support
for 'boost' mode in the exynos-cpufreq driver was enabled for
all supported SoCs even though 'boost' frequency was provided
only for Exynos4x12 ones).

Cc: Tomasz Figa <tomasz.figa@gmail.com>
Cc: Kukjin Kim <kgene.kim@samsung.com>
Cc: Thomas Abraham <thomas.ab@samsung.com>
Cc: Javier Martinez Canillas <javier@osg.samsung.com>
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 arch/arm/mach-exynos/Kconfig  | 2 ++
 arch/arm/mach-exynos/exynos.c | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/arch/arm/mach-exynos/Kconfig b/arch/arm/mach-exynos/Kconfig
index 81064cd..491914c 100644
--- a/arch/arm/mach-exynos/Kconfig
+++ b/arch/arm/mach-exynos/Kconfig
@@ -25,6 +25,8 @@ menuconfig ARCH_EXYNOS
 	select S5P_DEV_MFC
 	select SRAM
 	select MFD_SYSCON
+	select THERMAL
+	select EXYNOS_THERMAL
 	help
 	  Support for SAMSUNG EXYNOS SoCs (EXYNOS4/5)
 
diff --git a/arch/arm/mach-exynos/exynos.c b/arch/arm/mach-exynos/exynos.c
index 77ac021..1c47aee 100644
--- a/arch/arm/mach-exynos/exynos.c
+++ b/arch/arm/mach-exynos/exynos.c
@@ -227,6 +227,8 @@ static void __init exynos_init_irq(void)
 static const struct of_device_id exynos_cpufreq_matches[] = {
 	{ .compatible = "samsung,exynos3250", .data = "cpufreq-dt" },
 	{ .compatible = "samsung,exynos4210", .data = "cpufreq-dt" },
+	{ .compatible = "samsung,exynos4212", .data = "cpufreq-dt" },
+	{ .compatible = "samsung,exynos4412", .data = "cpufreq-dt" },
 	{ .compatible = "samsung,exynos5250", .data = "cpufreq-dt" },
 	{ /* sentinel */ }
 };
-- 
1.9.1



