From: Lucas Stach <l.stach@pengutronix.de>
Subject: Re: [PATCH 3/4] cpufreq: imx6q: Fix regulator/clock error handling
Date: Thu, 22 Oct 2015 12:18:57 +0200
Message-ID: <1445509137.3173.27.camel@pengutronix.de>
References: <1445503652-777-1-git-send-email-s.hauer@pengutronix.de>
	 <1445503652-777-4-git-send-email-s.hauer@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:44652 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757148AbbJVKS7 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 22 Oct 2015 06:18:59 -0400
In-Reply-To: <1445503652-777-4-git-send-email-s.hauer@pengutronix.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sascha Hauer <s.hauer@pengutronix.de>
Cc: linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, kernel@pengutronix.de, Shawn Guo <shawnguo@kernel.org>, Heiner Kallweit <hkallweit1@gmail.com>

Am Donnerstag, den 22.10.2015, 10:47 +0200 schrieb Sascha Hauer:
> When one of the regulator_get/clk_get calls fails the driver just
> returns -ENOENT. To properly handle the -EPROBE_DEFER case we have
> to forward the actual error value instead. This patch fixes that.
> 
> Since all clocks/regulators are global static variables the IS_ERR()
> check in the error path in probe() may erroneously work on the values
> assigned in the previous probe run. This means we have to reinitialize
> the variables between two probe runs().
> 
> The probe function already is quite overloaded, so this patch moves
> the regulator and clock allocation into a separate function and the
> dropping of these resourced into a corresponding cleanup function.
> This is easier to review for correctness than the current mix of
> reverse-cleanup and !IS_ERR checks at the end of probe().
> 
> While at it leave a comment that these resource allocations can't use
> devm_* to prevent people from trying to convert it.
> 
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>

Nice cleanup overall, one nit below.

> ---
>  drivers/cpufreq/imx6q-cpufreq.c | 166 ++++++++++++++++++++++++----------------
>  1 file changed, 102 insertions(+), 64 deletions(-)
> 
> diff --git a/drivers/cpufreq/imx6q-cpufreq.c b/drivers/cpufreq/imx6q-cpufreq.c
> index 7557d1e..ce0c6bd 100644
> --- a/drivers/cpufreq/imx6q-cpufreq.c
> +++ b/drivers/cpufreq/imx6q-cpufreq.c
> @@ -176,6 +176,99 @@ static struct cpufreq_driver imx6q_cpufreq_driver = {
>  	.attr = cpufreq_generic_attr,
>  };
>  
> +static int imx6q_cpufreq_get_resources(struct platform_device *pdev)

Given that all the resources are attached to the cpu_dev anyway, do you
really see a use for this parameter?

> +{
> +	/*
> +	 * Do not use devm_* here. The resources are bound to the
> +	 * cpu_dev and not to this drivers platform_device.
> +	 */
> +	arm_clk = clk_get(cpu_dev, "arm");
> +	if (IS_ERR(arm_clk))
> +		return PTR_ERR(arm_clk);
> +
> +	pll1_sys_clk = clk_get(cpu_dev, "pll1_sys");
> +	if (IS_ERR(pll1_sys_clk))
> +		return PTR_ERR(pll1_sys_clk);
> +
> +	pll1_sw_clk = clk_get(cpu_dev, "pll1_sw");
> +	if (IS_ERR(pll1_sw_clk))
> +		return PTR_ERR(pll1_sw_clk);
> +
> +	step_clk = clk_get(cpu_dev, "step");
> +	if (IS_ERR(step_clk))
> +		return PTR_ERR(step_clk);
> +
> +	pll2_pfd2_396m_clk = clk_get(cpu_dev, "pll2_pfd2_396m");
> +	if (IS_ERR(pll2_pfd2_396m_clk))
> +		return PTR_ERR(pll2_pfd2_396m_clk);
> +
> +	if (of_machine_is_compatible("fsl,imx6ul")) {
> +		pll2_bus_clk = clk_get(cpu_dev, "pll2_bus");
> +		if (IS_ERR(pll2_bus_clk))
> +			return PTR_ERR(pll2_bus_clk);
> +
> +		secondary_sel_clk = clk_get(cpu_dev, "secondary_sel");
> +		if (IS_ERR(secondary_sel_clk))
> +			return PTR_ERR(secondary_sel_clk);
> +	}
> +
> +	arm_reg = regulator_get(cpu_dev, "arm");
> +	if (IS_ERR(arm_reg))
> +		return PTR_ERR(arm_reg);
> +
> +	pu_reg = regulator_get_optional(cpu_dev, "pu");
> +
> +	soc_reg = regulator_get(cpu_dev, "soc");
> +	if (IS_ERR(soc_reg))
> +		return PTR_ERR(soc_reg);
> +
> +	return 0;
> +}
> +
[...]

-- 
Pengutronix e.K.             | Lucas Stach                 |
Industrial Linux Solutions   | http://www.pengutronix.de/  |

