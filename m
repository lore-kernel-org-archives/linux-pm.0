From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v2 29/38] thermal: exynos: Support both Exynos4x12 SoCs
Date: Mon, 17 Jun 2013 21:59:15 +0200
Message-ID: <201306172159.15352.arnd@arndb.de>
References: <1371486863-12398-1-git-send-email-t.figa@samsung.com> <1371486863-12398-30-git-send-email-t.figa@samsung.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <1371486863-12398-30-git-send-email-t.figa@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Tomasz Figa <t.figa@samsung.com>
Cc: linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Kukjin Kim <kgene.kim@samsung.com>, Olof Johansson <olof@lixom.net>, Marek Szyprowski <m.szyprowski@samsung.com>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Thomas Abraham <thomas.abraham@linaro.org>, linux-pm@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <eduardo.valentin@ti.com>, Kyungmin Park <kyungmin.park@samsung.com>
List-Id: linux-pm@vger.kernel.org

On Monday 17 June 2013, Tomasz Figa wrote:
> diff --git a/drivers/thermal/exynos_thermal.c b/drivers/thermal/exynos_thermal.c
> index 788b1dd..4cbe3ee 100644
> --- a/drivers/thermal/exynos_thermal.c
> +++ b/drivers/thermal/exynos_thermal.c
> @@ -817,7 +817,8 @@ static struct exynos_tmu_platform_data const exynos4210_default_tmu_data = {
>  #define EXYNOS4210_TMU_DRV_DATA (NULL)
>  #endif
>  
> -#if defined(CONFIG_SOC_EXYNOS5250) || defined(CONFIG_SOC_EXYNOS4412)
> +#if defined(CONFIG_SOC_EXYNOS5250) || defined(CONFIG_SOC_EXYNOS4412) || \
> +       defined(CONFIG_SOC_EXYNOS4212)
>  static struct exynos_tmu_platform_data const exynos_default_tmu_data = {
>         .threshold_falling = 10,
>         .trigger_levels[0] = 85,

The patch is correct, but generally speaking I think we should get away from
having the drivers get configured per SoC on such a fine-grained level.
Better make this driver (and others) always work on all exynos variants.

	Arnd
