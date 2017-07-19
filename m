From: Lucas Stach <l.stach@pengutronix.de>
Subject: Re: [PATCH] cpufreq: imx6q: Fix imx6sx low frequency support
Date: Wed, 19 Jul 2017 12:28:27 +0200
Message-ID: <1500460107.13757.6.camel@pengutronix.de>
References: <8e6f731906fe5f8dce6f23b1e8ad084c8041f49e.1500457396.git.leonard.crestez@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:34541 "EHLO
        metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754501AbdGSK2c (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 19 Jul 2017 06:28:32 -0400
In-Reply-To: <8e6f731906fe5f8dce6f23b1e8ad084c8041f49e.1500457396.git.leonard.crestez@nxp.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Leonard Crestez <leonard.crestez@nxp.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Shawn Guo <shawnguo@kernel.org>, Fabio Estevam <fabio.estevam@nxp.com>, linux-pm@vger.kernel.org, Octavian Purdila <octavian.purdila@nxp.com>, Anson Huang <Anson.Huang@nxp.com>, Bai Ping <ping.bai@nxp.com>, Dong Aisheng <aisheng.dong@nxp.com>, kernel@pengutronix.de, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org

Hi Leonard,

Am Mittwoch, den 19.07.2017, 12:54 +0300 schrieb Leonard Crestez:
> This patch contains the minimal changes required to support imx6sx OPP of
> 198 Mhz. Without this patch cpufreq still reports success but the frequency
> is not changed, the "arm" clock will still be at 396000000 in clk_summary.
> 
> In order to do this PLL1 needs to be bypassed but still kept enabled. This
> is required despite the fact that the arm clk is configured to come from
> pll2_pfd2 and from the clk framework perspective pll1 and related clocks
> are unused.

I'm not really an expert for MX6SX, so a little background on why PLL1
needs to be kept enabled would help to review this change.

Thanks,
Lucas

> This patch adds pll1, pll_bypass and pll1_bypass_src clocks to the imx
> cpufreq driver as imx6sx-specific for the bypass logic.
> 
> The definition of pll1_sys is changed to imx_clk_fixed_factor so that it's
> never disabled.
> 
> Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
> ---
> 
> Some potential issues:
> 
> In theory pll1_sys could be explictly kept enabled from cpufreq. It's not
> clear this would be better since the intention is to never let this be
> disabled.
> 
> The new clocks are only added for imx6sx. The frequency changing code
> relies on the fact that the clk API simply does nothing when called with a
> null clk.
> 
> Perhaps it might be better to accept ENOENT from clk_get on these new
> clocks instead of checking of_machine_is_compatible.
> 
>  arch/arm/boot/dts/imx6sx.dtsi   |  8 ++++++--
>  drivers/clk/imx/clk-imx6sx.c    |  2 +-
>  drivers/cpufreq/imx6q-cpufreq.c | 33 +++++++++++++++++++++++++++++++++
>  3 files changed, 40 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/imx6sx.dtsi b/arch/arm/boot/dts/imx6sx.dtsi
> index f16b9df..4394137 100644
> --- a/arch/arm/boot/dts/imx6sx.dtsi
> +++ b/arch/arm/boot/dts/imx6sx.dtsi
> @@ -87,9 +87,13 @@
>  				 <&clks IMX6SX_CLK_PLL2_PFD2>,
>  				 <&clks IMX6SX_CLK_STEP>,
>  				 <&clks IMX6SX_CLK_PLL1_SW>,
> -				 <&clks IMX6SX_CLK_PLL1_SYS>;
> +				 <&clks IMX6SX_CLK_PLL1_SYS>,
> +				 <&clks IMX6SX_CLK_PLL1>,
> +				 <&clks IMX6SX_PLL1_BYPASS>,
> +				 <&clks IMX6SX_PLL1_BYPASS_SRC>;
>  			clock-names = "arm", "pll2_pfd2_396m", "step",
> -				      "pll1_sw", "pll1_sys";
> +				      "pll1_sw", "pll1_sys", "pll1",
> +				      "pll1_bypass", "pll1_bypass_src";
>  			arm-supply = <&reg_arm>;
>  			soc-supply = <&reg_soc>;
>  		};
> diff --git a/drivers/clk/imx/clk-imx6sx.c b/drivers/clk/imx/clk-imx6sx.c
> index b5c96de..aa63b92 100644
> --- a/drivers/clk/imx/clk-imx6sx.c
> +++ b/drivers/clk/imx/clk-imx6sx.c
> @@ -199,7 +199,7 @@ static void __init imx6sx_clocks_init(struct device_node *ccm_node)
>  	clk_set_parent(clks[IMX6SX_PLL6_BYPASS], clks[IMX6SX_CLK_PLL6]);
>  	clk_set_parent(clks[IMX6SX_PLL7_BYPASS], clks[IMX6SX_CLK_PLL7]);
>  
> -	clks[IMX6SX_CLK_PLL1_SYS]      = imx_clk_gate("pll1_sys",      "pll1_bypass", base + 0x00, 13);
> +	clks[IMX6SX_CLK_PLL1_SYS]      = imx_clk_fixed_factor("pll1_sys",      "pll1_bypass", 1, 1);
>  	clks[IMX6SX_CLK_PLL2_BUS]      = imx_clk_gate("pll2_bus",      "pll2_bypass", base + 0x30, 13);
>  	clks[IMX6SX_CLK_PLL3_USB_OTG]  = imx_clk_gate("pll3_usb_otg",  "pll3_bypass", base + 0x10, 13);
>  	clks[IMX6SX_CLK_PLL4_AUDIO]    = imx_clk_gate("pll4_audio",    "pll4_bypass", base + 0x70, 13);
> diff --git a/drivers/cpufreq/imx6q-cpufreq.c b/drivers/cpufreq/imx6q-cpufreq.c
> index b6edd3c..caf727a 100644
> --- a/drivers/cpufreq/imx6q-cpufreq.c
> +++ b/drivers/cpufreq/imx6q-cpufreq.c
> @@ -31,6 +31,9 @@ static struct clk *step_clk;
>  static struct clk *pll2_pfd2_396m_clk;
>  
>  /* clk used by i.MX6UL */
> +static struct clk *pll1_bypass;
> +static struct clk *pll1_bypass_src;
> +static struct clk *pll1;
>  static struct clk *pll2_bus_clk;
>  static struct clk *secondary_sel_clk;
>  
> @@ -122,8 +125,21 @@ static int imx6q_set_target(struct cpufreq_policy *policy, unsigned int index)
>  		clk_set_parent(step_clk, pll2_pfd2_396m_clk);
>  		clk_set_parent(pll1_sw_clk, step_clk);
>  		if (freq_hz > clk_get_rate(pll2_pfd2_396m_clk)) {
> +			/*
> +			 * Ensure that pll1_bypass is set back to
> +			 * pll1. We have to do this first so that the
> +			 * change rate done to pll1_sys_clk done below
> +			 * can propagate up to pll1.
> +			 */
> +			clk_set_parent(pll1_bypass, pll1);
>  			clk_set_rate(pll1_sys_clk, new_freq * 1000);
>  			clk_set_parent(pll1_sw_clk, pll1_sys_clk);
> +		} else {
> +			/*
> +			 * Need to ensure that PLL1 is bypassed and enabled
> +			 * before ARM-PODF is set.
> +			 */
> +			clk_set_parent(pll1_bypass, pll1_bypass_src);
>  		}
>  	}
>  
> @@ -216,6 +232,17 @@ static int imx6q_cpufreq_probe(struct platform_device *pdev)
>  		goto put_clk;
>  	}
>  
> +	if (of_machine_is_compatible("fsl,imx6sx")) {
> +		pll1 = clk_get(cpu_dev, "pll1");
> +		pll1_bypass = clk_get(cpu_dev, "pll1_bypass");
> +		pll1_bypass_src = clk_get(cpu_dev, "pll1_bypass_src");
> +		if (IS_ERR(pll1) || IS_ERR(pll1_bypass) || IS_ERR(pll1_bypass_src)) {
> +			dev_err(cpu_dev, "failed to get clocks specific to imx6sx\n");
> +			ret = -ENOENT;
> +			goto put_clk;
> +		}
> +	}
> +
>  	if (of_machine_is_compatible("fsl,imx6ul") ||
>  	    of_machine_is_compatible("fsl,imx6ull")) {
>  		pll2_bus_clk = clk_get(cpu_dev, "pll2_bus");
> @@ -380,6 +407,12 @@ static int imx6q_cpufreq_probe(struct platform_device *pdev)
>  		clk_put(step_clk);
>  	if (!IS_ERR(pll2_pfd2_396m_clk))
>  		clk_put(pll2_pfd2_396m_clk);
> +	if (!IS_ERR(pll1))
> +		clk_put(pll1);
> +	if (!IS_ERR(pll1_bypass))
> +		clk_put(pll1_bypass);
> +	if (!IS_ERR(pll1_bypass_src))
> +		clk_put(pll1_bypass_src);
>  	if (!IS_ERR(pll2_bus_clk))
>  		clk_put(pll2_bus_clk);
>  	if (!IS_ERR(secondary_sel_clk))
