From: Lukasz Majewski <l.majewski@samsung.com>
Subject: Re: [PATCH 5/8] ARM: Exynos: use generic cpufreq driver for Exynos5420
Date: Wed, 22 Apr 2015 10:13:30 +0200
Message-ID: <20150422101330.5dbec7bc@amdc2363>
References: <1429622278-12216-1-git-send-email-b.zolnierkie@samsung.com>
 <1429622278-12216-6-git-send-email-b.zolnierkie@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <1429622278-12216-6-git-send-email-b.zolnierkie@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Thomas Abraham <thomas.ab@samsung.com>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Mike Turquette <mturquette@linaro.org>, Kukjin Kim <kgene.kim@samsung.com>, Kukjin Kim <kgene@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Kevin Hilman <khilman@linaro.org>, Heiko Stuebner <heiko@sntech.de>, linux-pm@vger.kernel.org, Tomasz Figa <tomasz.figa@gmail.com>, linux-kernel@vger.kernel.org, Chanwoo Choi <cw00.choi@samsung.com>, linux-samsung-soc@vger.kernel.org, Javier Martinez Canillas <javier.martinez@collabora.co.uk>, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

Hi Bartlomiej,

> From: Thomas Abraham <thomas.ab@samsung.com>
> 
> The new CPU clock type allows the use of generic arm_big_little_dt
> cpufreq driver for Exynos5420.
> 
> Changes by Bartlomiej:
> - split Exynos5420 support from the original patch
> - disable cpufreq if big.LITTLE switcher support is enabled
> 
> Cc: Tomasz Figa <tomasz.figa@gmail.com>
> Cc: Kukjin Kim <kgene.kim@samsung.com>
> Cc: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
> Signed-off-by: Thomas Abraham <thomas.ab@samsung.com>
> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> ---
>  arch/arm/mach-exynos/exynos.c |    7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/arch/arm/mach-exynos/exynos.c
> b/arch/arm/mach-exynos/exynos.c index 4b03a32..11ac7fb 100644
> --- a/arch/arm/mach-exynos/exynos.c
> +++ b/arch/arm/mach-exynos/exynos.c
> @@ -207,6 +207,13 @@ struct cpufreq_dt_platform_data cpufreq_dt_pd = {
>  static const struct of_device_id exynos_cpufreq_matches[] = {
>  	{ .compatible = "samsung,exynos4210", .data = "cpufreq-dt" },
>  	{ .compatible = "samsung,exynos5250", .data = "cpufreq-dt" },
> +/*
> + * FIXME: When big.LITTLE switcher is enabled system lockups during
> + * ondemand governor stress testing (observed on ODROID-XU3 board).
> + */
> +#ifndef CONFIG_BL_SWITCHER
> +	{ .compatible = "samsung,exynos5420", .data =
> "arm-bL-cpufreq-dt" }, +#endif
>  	{ /* sentinel */ }
>  };
>  

Reviewed-by: Lukasz Majewski <l.majewski@samsung.com>

-- 
Best regards,

Lukasz Majewski

Samsung R&D Institute Poland (SRPOL) | Linux Platform Group
