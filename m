From: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
Subject: Re: [PATCH/RFC 1/5] clk: shmobile: rcar-gen2: Add CPG Clock Domain support
Date: Tue, 31 Mar 2015 02:53:09 +0300
Message-ID: <3861934.bVCAbQmBJW@avalon>
References: <1426708017-28885-1-git-send-email-geert+renesas@glider.be> <1426708017-28885-2-git-send-email-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1426708017-28885-2-git-send-email-geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
Cc: Mike Turquette <mturquette-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Stephen Boyd <sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Simon Horman <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Kevin Hilman <khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org

Hi Geert,

Thank you for the patch.

On Wednesday 18 March 2015 20:46:53 Geert Uytterhoeven wrote:
> Add Clock Domain support to the R-Car Gen2 Clock Pulse Generator (CPG)
> driver using the generic PM Domain.  This allows to power-manage the
> module clocks of SoC devices that are part of the CPG Clock Domain using
> Runtime PM, or for system suspend/resume.
> 
> SoC devices that are part of the CPG Clock Domain and can be
> power-managed through their primary clock should be tagged in DT with a
> proper "power-domains" property.
>
> Signed-off-by: Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>

There's one thing that bothers me: the implementation is tied to the CPG 
driver, but the code is quite generic. That feels a bit wrong, it would be 
nice to come up with a generic implementation. On the other hand, the 
platform-dependent part is the list of clocks to manage, specified implicitly 
through the "pm_clk_add(dev, NULL)" call. That list needs to be specified 
somewhere, and adding it to the CPG driver is likely the best solution we can 
have at the moment.

I'm slightly worried that adding the power-domains property to the DT node 
will introduce backward compatibility issues if we later switch to a different 
way to specify the clocks to manage automatically. I have no specific example 
though.

For those reasons,

Acked-by: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>

> ---
>  .../clock/renesas,rcar-gen2-cpg-clocks.txt         | 26 ++++++++-
>  arch/arm/mach-shmobile/Kconfig                     |  1 +
>  drivers/clk/shmobile/clk-rcar-gen2.c               | 63 +++++++++++++++++++
>  3 files changed, 88 insertions(+), 2 deletions(-)
> 
> diff --git
> a/Documentation/devicetree/bindings/clock/renesas,rcar-gen2-cpg-clocks.txt
> b/Documentation/devicetree/bindings/clock/renesas,rcar-gen2-cpg-clocks.txt
> index b02944fba9de4f86..fc013f225a348929 100644
> ---
> a/Documentation/devicetree/bindings/clock/renesas,rcar-gen2-cpg-clocks.txt
> +++
> b/Documentation/devicetree/bindings/clock/renesas,rcar-gen2-cpg-clocks.txt
> @@ -2,6 +2,8 @@
> 
>  The CPG generates core clocks for the R-Car Gen2 SoCs. It includes three
> PLLs and several fixed ratio dividers.
> +The CPG also provides a Clock Domain for SoC devices, in combination with
> the +CPG Module Stop (MSTP) Clocks.
> 
>  Required Properties:
> 
> @@ -20,10 +22,18 @@ Required Properties:
>    - clock-output-names: The names of the clocks. Supported clocks are
> "main", "pll0", "pll1", "pll3", "lb", "qspi", "sdh", "sd0", "sd1", "z",
> "rcan", and "adsp"
> +  - #power-domain-cells: Must be 0
> 
> +SoC devices that are part of the CPG Clock Domain and can be power-managed
> +through their primary clock should refer to the CPG device node in their
> +"power-domains" property, as documented by the generic PM domain bindings
> in +Documentation/devicetree/bindings/power/power_domain.txt.
> 
> -Example
> --------
> +
> +Examples
> +--------
> +
> +  - CPG device node:
> 
>  	cpg_clocks: cpg_clocks@e6150000 {
>  		compatible = "renesas,r8a7790-cpg-clocks",
> @@ -34,4 +44,16 @@ Example
>  		clock-output-names = "main", "pll0, "pll1", "pll3",
>  				     "lb", "qspi", "sdh", "sd0", "sd1", "z",
>  				     "rcan", "adsp";
> +		#power-domain-cells = <0>;
> +	};
> +
> +
> +  - CPG Clock Domain member node:
> +
> +	thermal@e61f0000 {
> +		compatible = "renesas,thermal-r8a7790", "renesas,rcar-thermal";
> +		reg = <0 0xe61f0000 0 0x14>, <0 0xe61f0100 0 0x38>;
> +		interrupts = <0 69 IRQ_TYPE_LEVEL_HIGH>;
> +		clocks = <&mstp5_clks R8A7790_CLK_THERMAL>;
> +		power-domains = <&cpg_clocks>;
>  	};
> diff --git a/arch/arm/mach-shmobile/Kconfig b/arch/arm/mach-shmobile/Kconfig
> index 0fb484221c90e0eb..048101a3253c52de 100644
> --- a/arch/arm/mach-shmobile/Kconfig
> +++ b/arch/arm/mach-shmobile/Kconfig
> @@ -4,6 +4,7 @@ config ARCH_SHMOBILE
> 
>  config PM_RCAR
>  	bool
> +	select PM_GENERIC_DOMAINS
> 
>  config PM_RMOBILE
>  	bool
> diff --git a/drivers/clk/shmobile/clk-rcar-gen2.c
> b/drivers/clk/shmobile/clk-rcar-gen2.c index
> acfb6d7dbd6bc049..b54439d3722a13ad 100644
> --- a/drivers/clk/shmobile/clk-rcar-gen2.c
> +++ b/drivers/clk/shmobile/clk-rcar-gen2.c
> @@ -18,6 +18,8 @@
>  #include <linux/math64.h>
>  #include <linux/of.h>
>  #include <linux/of_address.h>
> +#include <linux/pm_clock.h>
> +#include <linux/pm_domain.h>
>  #include <linux/spinlock.h>
> 
>  struct rcar_gen2_cpg {
> @@ -364,6 +366,65 @@ rcar_gen2_cpg_register_clock(struct device_node *np,
> struct rcar_gen2_cpg *cpg, 4, 0, table, &cpg->lock);
>  }
> 
> +#ifdef CONFIG_PM_GENERIC_DOMAINS_OF
> +static int cpg_pd_attach_dev(struct generic_pm_domain *domain,
> +			     struct device *dev)
> +{
> +	int error;
> +
> +	error = pm_clk_create(dev);
> +	if (error) {
> +		dev_err(dev, "pm_clk_create failed %d\n", error);
> +		return error;
> +	}
> +
> +	error = pm_clk_add(dev, NULL);
> +	if (error) {
> +		dev_err(dev, "pm_clk_add failed %d\n", error);
> +		goto fail;
> +	}
> +
> +	return 0;
> +
> +fail:
> +	pm_clk_destroy(dev);
> +	return error;
> +}
> +
> +static void cpg_pd_detach_dev(struct generic_pm_domain *domain,
> +			      struct device *dev)
> +{
> +	pm_clk_destroy(dev);
> +}
> +
> +static void __init rcar_gen2_cpg_add_pm_domain(struct device_node *np)
> +{
> +	struct generic_pm_domain *pd;
> +	u32 ncells;
> +
> +	if (of_property_read_u32(np, "#power-domain-cells", &ncells)) {
> +		pr_warn("%s lacks #power-domain-cells. Clocks may fail.\n",
> +			np->full_name);
> +		return;
> +	}
> +
> +	pd = kzalloc(sizeof(*pd), GFP_KERNEL);
> +	if (!pd)
> +		return;
> +
> +	pd->name = np->name;
> +
> +	pd->flags = GENPD_FLAG_PM_CLK;
> +	pm_genpd_init(pd, &simple_qos_governor, false);
> +	pd->attach_dev = cpg_pd_attach_dev;
> +	pd->detach_dev = cpg_pd_detach_dev;
> +
> +	of_genpd_add_provider_simple(np, pd);
> +}
> +#else /* !CONFIG_PM_GENERIC_DOMAINS_OF */
> +static inline void rcar_gen2_cpg_add_pm_domain(struct device_node *np) {}
> +#endif /* !CONFIG_PM_GENERIC_DOMAINS_OF */
> +
>  static void __init rcar_gen2_cpg_clocks_init(struct device_node *np)
>  {
>  	const struct cpg_pll_config *config;
> @@ -415,6 +476,8 @@ static void __init rcar_gen2_cpg_clocks_init(struct
> device_node *np) }
> 
>  	of_clk_add_provider(np, of_clk_src_onecell_get, &cpg->data);
> +
> +	rcar_gen2_cpg_add_pm_domain(np);
>  }
>  CLK_OF_DECLARE(rcar_gen2_cpg_clks, "renesas,rcar-gen2-cpg-clocks",
>  	       rcar_gen2_cpg_clocks_init);

-- 
Regards,

Laurent Pinchart

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
