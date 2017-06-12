From: Niklas =?iso-8859-1?Q?S=F6derlund?=
        <niklas.soderlund@ragnatech.se>
Subject: Re: [PATCH/RFC] clk: renesas: cpg-mssr: Restore module clock
 registers during resume
Date: Mon, 12 Jun 2017 13:23:54 +0200
Message-ID: <20170612112354.GF17461@bigcity.dyn.berto.se>
References: <1496836718-10762-1-git-send-email-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1496836718-10762-1-git-send-email-geert+renesas@glider.be>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, linux-renesas-soc@vger.kernel.org, linux-clk@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hi Geert,

Thanks for your patch.

On 2017-06-07 13:58:38 +0200, Geert Uytterhoeven wrote:
> During PSCI system suspend, R-Car Gen3 SoCs are powered down, and their
> clock register state is lost.  Note that as the boot loader skips most
> initialization after resume, clock register state differs from the state
> encountered during normal system boot, too.
> 
> Hence after s2ram, some operations may fail because module clocks are
> disabled, while drivers expect them to be still enabled.  E.g. EtherAVB
> fails when Wake-on-LAN has been enabled using "ethtool -s eth0 wol g":
> 
>     ravb e6800000.ethernet eth0: failed to switch device to config mode
>     ravb e6800000.ethernet eth0: device will be stopped after h/w processes are done.
>     ravb e6800000.ethernet eth0: failed to switch device to config
>     PM: Device e6800000.ethernet failed to resume: error -110
> 
> To fix this, restore all bits of the SMSTPCR registers that have ever
> been written to by Linux.
> 
> Note that while this fixes EtherAVB operation after resume from s2ram,
> EtherAVB cannot be used as an actual wake-up source from s2ram, only
> from s2idle, due to PSCI limitations.

I tested this on H3 ES1.0 for EtherAVB and it now works as you describe 
above after s2ram \o/.

Tested-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>

> 
> TODO: Restore other clock registers, which requires clock-specific code.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Reviewed-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>

> ---
> Tested on Salvator-X (R-Car H3 and M3-W), and Koelsch (R-Car M2-W).
> 
>  drivers/clk/renesas/renesas-cpg-mssr.c | 56 ++++++++++++++++++++++++++++++++++
>  1 file changed, 56 insertions(+)
> 
> diff --git a/drivers/clk/renesas/renesas-cpg-mssr.c b/drivers/clk/renesas/renesas-cpg-mssr.c
> index 7bf164ad64ebd8ef..0f23ad17fba979ac 100644
> --- a/drivers/clk/renesas/renesas-cpg-mssr.c
> +++ b/drivers/clk/renesas/renesas-cpg-mssr.c
> @@ -106,6 +106,8 @@ static const u16 srcr[] = {
>   * @num_core_clks: Number of Core Clocks in clks[]
>   * @num_mod_clks: Number of Module Clocks in clks[]
>   * @last_dt_core_clk: ID of the last Core Clock exported to DT
> + * @smstpcr_shadow[].mask: Mask of SMSTPCR[] bits ever written to
> + * @smstpcr_shadow[].val: Last bit values written to SMSTPCR[]
>   */
>  struct cpg_mssr_priv {
>  #ifdef CONFIG_RESET_CONTROLLER
> @@ -119,6 +121,11 @@ struct cpg_mssr_priv {
>  	unsigned int num_core_clks;
>  	unsigned int num_mod_clks;
>  	unsigned int last_dt_core_clk;
> +
> +	struct {
> +		u32 mask;
> +		u32 val;
> +	} smstpcr_shadow[ARRAY_SIZE(smstpcr)];
>  };
>  
>  
> @@ -161,6 +168,12 @@ static int cpg_mstp_clock_endisable(struct clk_hw *hw, bool enable)
>  
>  	spin_unlock_irqrestore(&priv->rmw_lock, flags);
>  
> +	priv->smstpcr_shadow[reg].mask |= bitmask;
> +	if (enable)
> +		priv->smstpcr_shadow[reg].val &= ~bitmask;
> +	else
> +		priv->smstpcr_shadow[reg].val |= bitmask;
> +
>  	if (!enable)
>  		return 0;
>  
> @@ -727,6 +740,7 @@ static int __init cpg_mssr_probe(struct platform_device *pdev)
>  	if (!clks)
>  		return -ENOMEM;
>  
> +	dev_set_drvdata(dev, priv);
>  	priv->clks = clks;
>  	priv->num_core_clks = info->num_total_core_clks;
>  	priv->num_mod_clks = info->num_hw_mod_clks;
> @@ -763,10 +777,52 @@ static int __init cpg_mssr_probe(struct platform_device *pdev)
>  	return 0;
>  }
>  
> +static int cpg_mssr_resume_noirq(struct device *dev)
> +{
> +	struct cpg_mssr_priv *priv = dev_get_drvdata(dev);
> +	unsigned int reg, i;
> +	u32 value, mask;
> +
> +	for (reg = 0; reg < ARRAY_SIZE(priv->smstpcr_shadow); reg++) {
> +		/* Restore bits ever written to */
> +		mask = priv->smstpcr_shadow[reg].mask;
> +		if (!mask)
> +			continue;
> +
> +		value = readl(priv->base + SMSTPCR(reg));
> +		value &= ~mask;
> +		value |= priv->smstpcr_shadow[reg].val;
> +		writel(value, priv->base + SMSTPCR(reg));
> +
> +		/* Wait until enabled clocks are really enabled */
> +		mask &= ~priv->smstpcr_shadow[reg].val;
> +		if (!mask)
> +			continue;
> +
> +		for (i = 1000; i > 0; --i) {
> +			value = readl(priv->base + MSTPSR(reg));
> +			if (!(value & mask))
> +				break;
> +			cpu_relax();
> +		}
> +
> +		if (!i)
> +			dev_warn(dev, "Failed to enable SMSTP %p[0x%x]\n",
> +				 priv->base + SMSTPCR(reg), value & mask);
> +	}
> +
> +	return 0;
> +}
> +
> +static const struct dev_pm_ops cpg_mssr_pm = {
> +	SET_NOIRQ_SYSTEM_SLEEP_PM_OPS(NULL, cpg_mssr_resume_noirq)
> +};
> +
>  static struct platform_driver cpg_mssr_driver = {
>  	.driver		= {
>  		.name	= "renesas-cpg-mssr",
>  		.of_match_table = cpg_mssr_match,
> +		.pm = &cpg_mssr_pm,
>  	},
>  };
>  
> -- 
> 2.7.4
> 

-- 
Regards,
Niklas Söderlund
