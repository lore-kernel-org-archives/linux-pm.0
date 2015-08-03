From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v3 3/5] ARM: Exynos: switch to using generic cpufreq
 driver for Exynos4x12
Date: Mon, 3 Aug 2015 21:20:41 +0530
Message-ID: <20150803155041.GE21529@linux>
References: <1438368557-2352-1-git-send-email-b.zolnierkie@samsung.com>
 <4532306.AVvo5hem3c@amdc1976>
 <55BF4D41.1060903@samsung.com>
 <2347616.SxxJmTVssu@amdc1976>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <2347616.SxxJmTVssu@amdc1976>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Krzysztof Kozlowski <k.kozlowski@samsung.com>, Thomas Abraham <thomas.ab@samsung.com>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Michael Turquette <mturquette@baylibre.com>, Kukjin Kim <kgene.kim@samsung.com>, Kukjin Kim <kgene@kernel.org>, Tomasz Figa <tomasz.figa@gmail.com>, Lukasz Majewski <l.majewski@samsung.com>, Heiko Stuebner <heiko@sntech.de>, Chanwoo Choi <cw00.choi@samsung.com>, Kevin Hilman <khilman@linaro.org>, Javier Martinez Canillas <javier@dowhile0.org>, Tobias Jakobi <tjakobi@math.uni-bielefeld.de>, Anand Moon <linux.amoon@gmail.com>, linux-samsung-soc@vger.kernel.org, linux-clk@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Javier Martinez Canillas <javier@osg.samsung.com>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>
List-Id: linux-pm@vger.kernel.org

On 03-08-15, 15:55, Bartlomiej Zolnierkiewicz wrote:
> diff --git a/arch/arm/mach-exynos/Kconfig b/arch/arm/mach-exynos/Kconfig
> index 81064cd..491914c 100644
> --- a/arch/arm/mach-exynos/Kconfig
> +++ b/arch/arm/mach-exynos/Kconfig
> @@ -25,6 +25,8 @@ menuconfig ARCH_EXYNOS
>  	select S5P_DEV_MFC
>  	select SRAM
>  	select MFD_SYSCON
> +	select THERMAL
> +	select EXYNOS_THERMAL

Why do you need to select both of them?

>  	help
>  	  Support for SAMSUNG EXYNOS SoCs (EXYNOS4/5)
>  
> diff --git a/arch/arm/mach-exynos/exynos.c b/arch/arm/mach-exynos/exynos.c
> index 77ac021..1c47aee 100644
> --- a/arch/arm/mach-exynos/exynos.c
> +++ b/arch/arm/mach-exynos/exynos.c
> @@ -227,6 +227,8 @@ static void __init exynos_init_irq(void)
>  static const struct of_device_id exynos_cpufreq_matches[] = {
>  	{ .compatible = "samsung,exynos3250", .data = "cpufreq-dt" },
>  	{ .compatible = "samsung,exynos4210", .data = "cpufreq-dt" },
> +	{ .compatible = "samsung,exynos4212", .data = "cpufreq-dt" },
> +	{ .compatible = "samsung,exynos4412", .data = "cpufreq-dt" },
>  	{ .compatible = "samsung,exynos5250", .data = "cpufreq-dt" },
>  	{ /* sentinel */ }
>  };

Otherwise looks fine:

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
