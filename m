From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: Re: [PATCH v3 2/4] ARM: EXYNOS: add code for setting/clearing boot flag
Date: Wed, 18 Mar 2015 14:33:54 +0100
Message-ID: <CAJKOXPe_V8uj9opDQ_oYMZMb8aFsNc2CCC4MgV8nna9u2-rkaQ@mail.gmail.com>
References: <1426683113-31209-1-git-send-email-b.zolnierkie@samsung.com>
	<1426683113-31209-3-git-send-email-b.zolnierkie@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <1426683113-31209-3-git-send-email-b.zolnierkie@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Kukjin Kim <kgene.kim@samsung.com>, Kukjin Kim <kgene@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, Tomasz Figa <tomasz.figa@gmail.com>, Kyungmin Park <kyungmin.park@samsung.com>, linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

2015-03-18 13:51 GMT+01:00 Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>:
> This code is needed for cpuidle (W-)AFTR mode support on Exynos3250.
>
> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> Acked-by: Kyungmin Park <kyungmin.park@samsung.com>
> ---
>  arch/arm/mach-exynos/common.h |  6 ++++++
>  arch/arm/mach-exynos/exynos.c | 25 +++++++++++++++++++++++++
>  2 files changed, 31 insertions(+)
>
> diff --git a/arch/arm/mach-exynos/common.h b/arch/arm/mach-exynos/common.h
> index f70eca7..87bf1f3 100644
> --- a/arch/arm/mach-exynos/common.h
> +++ b/arch/arm/mach-exynos/common.h
> @@ -119,6 +119,12 @@ extern void __iomem *sysram_base_addr;
>  extern void __iomem *pmu_base_addr;
>  void exynos_sysram_init(void);
>
> +/* CPU BOOT mode flag */
> +#define C2_STATE       (1 << 3)

Is this "C2_STATE" like ACPI C2 state? It looks specific to Exynos3250
boot loader so maybe describe its real purpose?

> +
> +void exynos_set_boot_flag(unsigned int cpu, unsigned int mode);
> +void exynos_clear_boot_flag(unsigned int cpu, unsigned int mode);
> +
>  enum {
>         FW_DO_IDLE_SLEEP,
>         FW_DO_IDLE_AFTR,
> diff --git a/arch/arm/mach-exynos/exynos.c b/arch/arm/mach-exynos/exynos.c
> index 4031a96..90ed2e5 100644
> --- a/arch/arm/mach-exynos/exynos.c
> +++ b/arch/arm/mach-exynos/exynos.c
> @@ -117,6 +117,31 @@ static void __init exynos_init_late(void)
>         exynos_pm_init();
>  }
>
> +#define REG_CPU_STATE_ADDR     (sysram_ns_base_addr + 0x28)
> +#define BOOT_MODE_MASK         0x1f
> +
> +void exynos_set_boot_flag(unsigned int cpu, unsigned int mode)
> +{
> +       unsigned int tmp;
> +
> +       tmp = __raw_readl(REG_CPU_STATE_ADDR + cpu * 4);
> +
> +       if (mode & BOOT_MODE_MASK)
> +               tmp &= ~BOOT_MODE_MASK;
> +
> +       tmp |= mode;
> +       __raw_writel(tmp, REG_CPU_STATE_ADDR + cpu * 4);
> +}
> +
> +void exynos_clear_boot_flag(unsigned int cpu, unsigned int mode)
> +{
> +       unsigned int tmp;
> +
> +       tmp = __raw_readl(REG_CPU_STATE_ADDR + cpu * 4);
> +       tmp &= ~mode;
> +       __raw_writel(tmp, REG_CPU_STATE_ADDR + cpu * 4);
> +}
> +

Shouldn't these to functions be put in firmware.c? The
exynos_set_cpu_boot_addr() is there already. It would be consistent to
have them in one place.

Best regards,
Krzysztof
