From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH/RFC v2 05/11] soc: renesas: rcar: Handle clock domain devices in SYSC PM domains
Date: Tue, 16 Feb 2016 00:08:16 +0200
Message-ID: <2087210.c20JsV3rp3@avalon>
References: <1455571020-18968-1-git-send-email-geert+renesas@glider.be> <1455571020-18968-6-git-send-email-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from galahad.ideasonboard.com ([185.26.127.97]:56573 "EHLO
	galahad.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753082AbcBOWHt (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 15 Feb 2016 17:07:49 -0500
In-Reply-To: <1455571020-18968-6-git-send-email-geert+renesas@glider.be>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, linux-renesas-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org

Hi Geert,

Thank you for the patch.

On Monday 15 February 2016 22:16:54 Geert Uytterhoeven wrote:
> R-Car H3 contains some hardware modules (e.g. VSP and FCP_V) that are
> not only located in a power area controlled by the SYSC system
> controller, but that are also part of the generic CPG/MSSR clock domain.
> Make sure both are handled by enabling module clock PM when the device
> for such a hardware module is attached to the SYSC PM Domain.

Can't we specify both power domains in the DT power-domains attribute instead 
?

> FIXME Share code with the renesas-cpg-mssr driver.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> v2:
>   - New.
> ---
> drivers/soc/renesas/pm-rcar.c | 68 +++++++++++++++++++++++++++++++++++++++++
> 1 file changed, 68 insertions(+)
> 
> diff --git a/drivers/soc/renesas/pm-rcar.c b/drivers/soc/renesas/pm-rcar.c
> index c0540934126e58eb..d1bf8c231540b11d 100644
> --- a/drivers/soc/renesas/pm-rcar.c
> +++ b/drivers/soc/renesas/pm-rcar.c
> @@ -9,16 +9,20 @@
>   * for more details.
>   */
> 
> +#include <linux/clk.h>
>  #include <linux/delay.h>
>  #include <linux/err.h>
>  #include <linux/mm.h>
>  #include <linux/of_address.h>
> +#include <linux/pm_clock.h>
>  #include <linux/pm_domain.h>
>  #include <linux/slab.h>
>  #include <linux/spinlock.h>
>  #include <linux/io.h>
>  #include <linux/soc/renesas/pm-rcar.h>
> 
> +#include <dt-bindings/clock/renesas-cpg-mssr.h>
> +
>  /* SYSC Common */
>  #define SYSCSR			0x00	/* SYSC Status Register */
>  #define SYSCISR			0x04	/* Interrupt Status Register */
> @@ -248,11 +252,75 @@ static int rcar_pd_power_up(struct generic_pm_domain
> *genpd) return rcar_sysc_power_up(&to_rcar_pd(genpd)->ch);
>  }
> 
> +#ifdef CONFIG_ARCH_R8A7795
> +static int rcar_clk_pd_attach_dev(struct generic_pm_domain *genpd,
> +				  struct device *dev)
> +{
> +	struct device_node *np = dev->of_node;
> +	struct of_phandle_args clkspec;
> +	struct clk *clk;
> +	int i = 0;
> +	int error;
> +
> +	while (!of_parse_phandle_with_args(np, "clocks", "#clock-cells", i,
> +					   &clkspec)) {
> +		if (clkspec.args_count == 2 && clkspec.args[0] == CPG_MOD &&
> +		    of_device_is_compatible(clkspec.np,
> +					    "renesas,r8a7795-cpg-mssr"))
> +			goto found;
> +
> +		of_node_put(clkspec.np);
> +		i++;
> +	}
> +
> +	return 0;
> +
> +found:
> +	clk = of_clk_get_from_provider(&clkspec);
> +	of_node_put(clkspec.np);
> +
> +	if (IS_ERR(clk))
> +		return PTR_ERR(clk);
> +
> +	error = pm_clk_create(dev);
> +	if (error) {
> +		dev_err(dev, "pm_clk_create failed %d\n", error);
> +		goto fail_put;
> +	}
> +
> +	error = pm_clk_add_clk(dev, clk);
> +	if (error) {
> +		dev_err(dev, "pm_clk_add_clk %pC failed %d\n", clk, error);
> +		goto fail_destroy;
> +	}
> +
> +	return 0;
> +
> +fail_destroy:
> +	pm_clk_destroy(dev);
> +fail_put:
> +	clk_put(clk);
> +	return error;
> +}
> +
> +static void rcar_clk_pd_detach_dev(struct generic_pm_domain *genpd,
> +				   struct device *dev)
> +{
> +	if (!list_empty(&dev->power.subsys_data->clock_list))
> +		pm_clk_destroy(dev);
> +}
> +#endif /* CONFIG_ARCH_R8A7795 */
> +
>  static void rcar_init_pm_domain(struct rcar_pm_domain *rcar_pd)
>  {
>  	struct generic_pm_domain *genpd = &rcar_pd->genpd;
>  	struct dev_power_governor *gov = rcar_pd->gov;
> 
> +#ifdef CONFIG_ARCH_R8A7795
> +	genpd->flags = GENPD_FLAG_PM_CLK;
> +	genpd->attach_dev = rcar_clk_pd_attach_dev;
> +	genpd->detach_dev = rcar_clk_pd_detach_dev;
> +#endif
>  	pm_genpd_init(genpd, gov ? : &simple_qos_governor, false);
>  	genpd->dev_ops.active_wakeup	= rcar_pd_active_wakeup;
>  	genpd->power_off		= rcar_pd_power_down;

-- 
Regards,

Laurent Pinchart

