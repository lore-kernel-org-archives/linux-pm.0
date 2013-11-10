From: Tomasz Figa <tomasz.figa@gmail.com>
Subject: Re: [PATCH 1/1] ARM: EXYNOS: Add default latency values for Device and Power Domain
Date: Sun, 10 Nov 2013 17:55:55 +0100
Message-ID: <9546263.JaCWNRjo5C@flatron>
References: <1383892025-14759-1-git-send-email-sachin.kamat@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <1383892025-14759-1-git-send-email-sachin.kamat@linaro.org>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Sachin Kamat <sachin.kamat@linaro.org>
Cc: linux-samsung-soc@vger.kernel.org, kgene.kim@samsung.com, prathyush.k@samsung.com, Prasanna Kumar <prasanna.ps@samsung.com>, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, "Rafael J. Wysocki" <rjw@sisk.pl>
List-Id: linux-pm@vger.kernel.org

Hi Sachin, Prasanna,

[CCing Rafael and respective mailing lists]

Please see my comments inline. Also please always remember to add all
appropriate recipients on CC list. More reviewers means higher chance of
spotting (and so eliminating) potential issues.

On Friday 08 of November 2013 11:57:05 Sachin Kamat wrote:
> From: Prasanna Kumar <prasanna.ps@samsung.com>
> 
> Power domain and device timing data are intialized with default
> values to avoid dump of warnings from various power domains
> during power gating.
> 
> Signed-off-by: Prasanna Kumar <prasanna.ps@samsung.com>
> Signed-off-by: Prathyush K <prathyush.k@samsung.com>
> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
> ---
>  arch/arm/mach-exynos/pm_domains.c |   15 ++++++++++++++-
>  1 file changed, 14 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mach-exynos/pm_domains.c b/arch/arm/mach-exynos/pm_domains.c
> index 84e0483a0500..9bbb4ac23980 100644
> --- a/arch/arm/mach-exynos/pm_domains.c
> +++ b/arch/arm/mach-exynos/pm_domains.c
> @@ -25,6 +25,10 @@
>  #include <mach/regs-pmu.h>
>  #include <plat/devs.h>
>  
> +#define DEFAULT_DEV_LATENCY_NS			1000000UL
> +#define DEFAULT_PD_PWRON_LATENCY_NS		10000000UL
> +#define DEFAULT_PD_PWROFF_LATENCY_NS		10000000UL

Is there any rationale behind choosing these particular values?

> +
>  /*
>   * Exynos specific wrapper around the generic power domain
>   */
> @@ -36,6 +40,13 @@ struct exynos_pm_domain {
>  	u32 enable;
>  };
>  
> +static struct gpd_timing_data dev_latencies = {
> +	.stop_latency_ns = DEFAULT_DEV_LATENCY_NS,
> +	.start_latency_ns = DEFAULT_DEV_LATENCY_NS,
> +	.save_state_latency_ns = DEFAULT_DEV_LATENCY_NS,
> +	.restore_state_latency_ns = DEFAULT_DEV_LATENCY_NS,

I don't think that stop, start, save and restore latencies should be all
the same.

> +};
> +
>  static int exynos_pd_power(struct generic_pm_domain *domain, bool power_on)
>  {
>  	struct exynos_pm_domain *pd;
> @@ -83,7 +94,7 @@ static void exynos_add_device_to_domain(struct exynos_pm_domain *pd,
>  	dev_dbg(dev, "adding to power domain %s\n", pd->pd.name);
>  
>  	while (1) {
> -		ret = pm_genpd_add_device(&pd->pd, dev);
> +		ret = __pm_genpd_add_device(&pd->pd, dev, &dev_latencies);

The double underscore prefix scares me a bit. Is this function really
supposed to be used like this?

>  		if (ret != -EAGAIN)
>  			break;
>  		cond_resched();
> @@ -173,6 +184,8 @@ static __init int exynos4_pm_init_power_domain(void)
>  		pd->base = of_iomap(np, 0);
>  		pd->pd.power_off = exynos_pd_power_off;
>  		pd->pd.power_on = exynos_pd_power_on;
> +		pd->pd.power_off_latency_ns = DEFAULT_PD_PWROFF_LATENCY_NS;
> +		pd->pd.power_on_latency_ns = DEFAULT_PD_PWRON_LATENCY_NS;

It might be worth to set up the latencies indeed, but wrong values can do
more harm than good.

Best regards,
Tomasz
