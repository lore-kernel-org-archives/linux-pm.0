From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: Re: [PATCH v3 1/4] ARM: EXYNOS: fix CPU1 hotplug for AFTR mode on Exynos3250
Date: Wed, 18 Mar 2015 14:10:31 +0100
Message-ID: <CAJKOXPe3P0mO-WuufAwF_tB6P=kfr-ORyQ6pa2pRnvjytCuHZg@mail.gmail.com>
References: <1426683113-31209-1-git-send-email-b.zolnierkie@samsung.com>
	<1426683113-31209-2-git-send-email-b.zolnierkie@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <1426683113-31209-2-git-send-email-b.zolnierkie@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Kukjin Kim <kgene.kim@samsung.com>, Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org, Daniel Lezcano <daniel.lezcano@linaro.org>, Tomasz Figa <tomasz.figa@gmail.com>, linux-kernel@vger.kernel.org, Chanwoo Choi <cw00.choi@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

2015-03-18 13:51 GMT+01:00 Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>:
> CPU1 hotplug may hang when AFTR is used.  Fix it by:
> - setting AUTOWAKEUP_EN bit in ARM_COREx_CONFIGURATION register in
>   exynos_cpu_power_up()
> - not clearing reserved bits of ARM_COREx_CONFIGURATION register in
>   exynos_cpu_power_down()
> - waiting while an undocumented register 0x0908 becomes non-zero in
>   exynos_core_restart()
> - using dsb_sev() instead of IPI in exynos_boot_secondary() on
>   Exynos3250
>
> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
> Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> Acked-by: Kyungmin Park <kyungmin.park@samsung.com>
> ---
>  arch/arm/mach-exynos/platsmp.c  | 23 ++++++++++++++++++++---
>  arch/arm/mach-exynos/regs-pmu.h |  2 ++
>  2 files changed, 22 insertions(+), 3 deletions(-)


Looks good (except one nit below) and this also fixes hotplug issues
during resume from S2R:
$ echo mem > /sys/power/state
[  156.517266] Disabling non-boot CPUs ...
[  156.517781] IRQ18 no longer affine to CPU1
[  156.518043] CPU1: shutdown
[  156.544718] Enabling non-boot CPUs ...
[  156.554925] CPU1: Software reset
[  158.552631] CPU1: failed to come online
[  158.552753] Error taking CPU1 up: -5

Reviewed and tested on Rinato (Gear 2/Exynos 3250) board:

Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Tested-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

One comment below...

>
> diff --git a/arch/arm/mach-exynos/platsmp.c b/arch/arm/mach-exynos/platsmp.c
> index d2e9f12..ebd135b 100644
> --- a/arch/arm/mach-exynos/platsmp.c
> +++ b/arch/arm/mach-exynos/platsmp.c
> @@ -126,6 +126,8 @@ static inline void platform_do_lowpower(unsigned int cpu, int *spurious)
>   */
>  void exynos_cpu_power_down(int cpu)
>  {
> +       u32 core_conf;
> +
>         if (cpu == 0 && (soc_is_exynos5420() || soc_is_exynos5800())) {
>                 /*
>                  * Bypass power down for CPU0 during suspend. Check for
> @@ -137,7 +139,10 @@ void exynos_cpu_power_down(int cpu)
>                 if (!(val & S5P_CORE_LOCAL_PWR_EN))
>                         return;
>         }
> -       pmu_raw_writel(0, EXYNOS_ARM_CORE_CONFIGURATION(cpu));
> +
> +       core_conf = pmu_raw_readl(EXYNOS_ARM_CORE_CONFIGURATION(cpu));
> +       core_conf &= ~S5P_CORE_LOCAL_PWR_EN;
> +       pmu_raw_writel(core_conf, EXYNOS_ARM_CORE_CONFIGURATION(cpu));
>  }
>
>  /**
> @@ -148,7 +153,12 @@ void exynos_cpu_power_down(int cpu)
>   */
>  void exynos_cpu_power_up(int cpu)
>  {
> -       pmu_raw_writel(S5P_CORE_LOCAL_PWR_EN,
> +       u32 core_conf = S5P_CORE_LOCAL_PWR_EN;
> +
> +       if (soc_is_exynos3250())
> +               core_conf |= S5P_CORE_AUTOWAKEUP_EN;
> +
> +       pmu_raw_writel(core_conf,
>                         EXYNOS_ARM_CORE_CONFIGURATION(cpu));
>  }
>
> @@ -226,6 +236,10 @@ static void exynos_core_restart(u32 core_id)
>         if (!of_machine_is_compatible("samsung,exynos3250"))
>                 return;
>
> +       while (!pmu_raw_readl(S5P_PMU_SPARE2))
> +               udelay(10);
> +       udelay(10);

We really need to start documenting this. Please add short description
why this SPARE2 check is here and who uses it. Without documenting
this behavior future generations won't be able to debug this stuff.
Imagine replacing sboot with uboot by someone...

Best regards,
Krzysztof
