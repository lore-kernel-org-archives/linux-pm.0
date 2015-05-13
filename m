From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: [PATCH 0/6] cpufreq: use generic cpufreq drivers for Exynos4210
 platform
Date: Wed, 13 May 2015 16:08:49 +0200
Message-ID: <2036292.PZC6aPyUyX@amdc1976>
References: <'@samsung.com>
 <1428079429-4252-1-git-send-email-b.zolnierkie@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1428079429-4252-1-git-send-email-b.zolnierkie@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Abraham <thomas.ab@samsung.com>
Cc: Sylwester Nawrocki <s.nawrocki@samsung.com>, Mike Turquette <mturquette@linaro.org>, Kukjin Kim <kgene.kim@samsung.com>, Kukjin Kim <kgene@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Tomasz Figa <tomasz.figa@gmail.com>, Lukasz Majewski <l.majewski@samsung.com>, Heiko Stuebner <heiko@sntech.de>, Chanwoo Choi <cw00.choi@samsung.com>, Kevin Hilman <khilman@linaro.org>, Javier Martinez Canillas <javier.martinez@collabora.co.uk>, linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org


Hi,

On Friday, April 03, 2015 06:43:43 PM Bartlomiej Zolnierkiewicz wrote:
> Hi,
> 
> This patch series removes the use of Exynos4210 specific support
> from cpufreq-exynos driver and enables the use of cpufreq-dt driver
> for this platform.

Gentle Ping.  Mike/Kukjin/Viresh could you please review/ack relevant
patches (patches #1-3 are for clock subsystem, patches #4-5 for Exynos
mach/dts and patch #6 is for cpufreq subsystem)?  Also what is your
preferred way to upstream them (patches are not independent so it would
be best to merge them through one tree, otherwise synchronization of
git pulls between different subsystem trees will be needed)?

I'm still hoping that this patchset will make it into v4.2 as there are
no known issues with it (except minor coding nit for patch #5)...

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

> It consists of a modified "[PATCH v12 0/6] cpufreq: use generic
> cpufreq drivers for exynos platforms" [1] patch series from Thomas
> Abraham.  As there have not been updates of this patchset since
> November 2014 I decided to dust it off myself.  I updated Thomas'
> patchset to current kernels, fixed bugs that I noticed and removed
> non-Exynos4210 support for now (to speed up inclusion in upstream
> kernel).  Since some modifications were not trivial I dropped all
> Reviewed-by:, Tested-by: and Acked-by: tags.  Please review/test
> this patchset and reply with revelant tag (Thank You!).  I also
> plan to work on Exynos4x12 support next (which was missing in
> the original patchset) and then on Exynos5250/Exynos5420 one.
> 
> This patch series has been tested on Exynos4210 based Origen and
> Trats boards.
> 
> Depends on:
> - next-20150330 branch of linux-next kernel tree
>   (mfd tree contains a crucial fix for MAX8997 PMIC support)
> - "[PATCH] clk: samsung: exynos4: Disable ARMCLK down feature on
>   Exynos4210 SoC" [2]
> 
> [1] https://www.marc.info/?l=linux-arm-kernel&m=141657611003803&w=2
> [2] https://lkml.org/lkml/2015/3/27/568
> 
> Changes over Thomas' code:
> - fixed issue with wrong dividers being setup by Common Clock Framework
>   (by an addition of CLK_RECALC_NEW_RATES clock flag to mout_apll clock,
>   without this change cpufreq-dt driver showed ~10 mA larger energy
>   consumption when compared to cpufreq-exynos one when "performance"
>   cpufreq governor was used on Exynos4210 SoC based Origen board), this
>   was probably meant to be workarounded by use of CLK_GET_RATE_NOCACHE
>   and CLK_DIVIDER_READ_ONLY clock flags in the original patchset (in
>   "[PATCH v12 6/6] clk: samsung: remove unused clock aliases and update
>   clock flags") but using these flags is not sufficient to fix the issue
>   observed
> - fixed issue with setting lower dividers before the parent clock speed
>   was lowered (the issue resulted in lockup on Exynos4210 SoC based
>   Origen board when "ondemand" cpufreq governor was stress tested)
> - fixed missing spin_unlock on error in exynos_cpuclk_post_rate_change()
>   problem by moving cfg_data search outside of the spin locked area
> - removed leftover kfree() in exynos_register_cpu_clock() that could
>   result in dereferencing the NULL pointer on error
> - moved spin_lock earlier in exynos_cpuclk_pre_rate_change() to cover
>   reading of E4210_SRC_CPU and E4210_DIV_CPU1 registers
> - added missing "last chance" checks to wait_until_divider_stable() and
>   wait_until_mux_stable() (needed in case that IRQ handling took long
>   time to proceed and resulted in function printing incorrect error
>   message about timeout)
> - moved E4210_CPU_DIV[0,1]() macros just before their only users,
>   this resulted in moving them from patch #2 to patch #3/6 ("clk:
>   samsung: exynos4: add cpu clock configuration data and instantiate
>   cpu clock")
> - added my Copyrights to drivers/clk/samsung/clk-cpu.c
> - updated exynos-cpufreq.[c,h]
> - removed non-Exynos4210 support for now
> - dropped "[PATCH v12 6/6] clk: samsung: remove unused clock aliases and
>   update clock flags" altogether for now
> 
> Best regards,
> --
> Bartlomiej Zolnierkiewicz
> Samsung R&D Institute Poland
> Samsung Electronics
> 
> 
> Bartlomiej Zolnierkiewicz (1):
>   clk: add CLK_RECALC_NEW_RATES clock flag for Exynos cpu clock support
> 
> Thomas Abraham (5):
>   clk: samsung: add infrastructure to register cpu clocks
>   clk: samsung: exynos4: add cpu clock configuration data and
>     instantiate cpu clock
>   ARM: dts: Exynos4210: add CPU OPP and regulator supply property
>   ARM: Exynos: switch to using generic cpufreq driver for Exynos4210
>   cpufreq: exynos: remove Exynos4210 specific cpufreq driver support
> 
>  arch/arm/boot/dts/exynos4210-origen.dts         |    4 +
>  arch/arm/boot/dts/exynos4210-trats.dts          |    4 +
>  arch/arm/boot/dts/exynos4210-universal_c210.dts |    4 +
>  arch/arm/boot/dts/exynos4210.dtsi               |   12 +
>  arch/arm/mach-exynos/exynos.c                   |   21 +-
>  drivers/clk/clk.c                               |    3 +
>  drivers/clk/samsung/Makefile                    |    2 +-
>  drivers/clk/samsung/clk-cpu.c                   |  349 +++++++++++++++++++++++
>  drivers/clk/samsung/clk-cpu.h                   |   73 +++++
>  drivers/clk/samsung/clk-exynos4.c               |   24 +-
>  drivers/cpufreq/Kconfig.arm                     |   11 -
>  drivers/cpufreq/Makefile                        |    1 -
>  drivers/cpufreq/exynos-cpufreq.c                |    5 +-
>  drivers/cpufreq/exynos-cpufreq.h                |    9 -
>  drivers/cpufreq/exynos4210-cpufreq.c            |  184 ------------
>  include/linux/clk-provider.h                    |    1 +
>  16 files changed, 495 insertions(+), 212 deletions(-)
>  create mode 100644 drivers/clk/samsung/clk-cpu.c
>  create mode 100644 drivers/clk/samsung/clk-cpu.h
>  delete mode 100644 drivers/cpufreq/exynos4210-cpufreq.c
