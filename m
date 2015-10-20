From: Lucas Stach <l.stach@pengutronix.de>
Subject: Re: [PATCH] cpufreq: imx6: rework getting clocks and regulators
Date: Tue, 20 Oct 2015 14:26:58 +0200
Message-ID: <1445344018.3716.16.camel@pengutronix.de>
References: <1445342218-12895-1-git-send-email-s.hauer@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:59097 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752413AbbJTM1A (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 20 Oct 2015 08:27:00 -0400
In-Reply-To: <1445342218-12895-1-git-send-email-s.hauer@pengutronix.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sascha Hauer <s.hauer@pengutronix.de>
Cc: linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, kernel@pengutronix.de, Shawn Guo <shawnguo@kernel.org>

Am Dienstag, den 20.10.2015, 13:56 +0200 schrieb Sascha Hauer:
> Use devm_* functions for getting clocks and regulators. This simplfifies
> the error path. Also return the error from the failing call instead of
> collating all regulator and clock errors to -ENOENT. With this the
> driver can properly handle -EPROBE_DEFER. Handling deferred probing
> becomes necessary once the SoC internal regulators get supplies. While
> the SoC internal regulators are registered early in architecture code,
> the supplies may be regular I2C devices which may be probed after the
> cpufreq driver.
> 
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>

NACK

This has come up several times before, maybe we should get a comment in
the code.
Using devm_ here is NOT safe. The cpu_dev is not the cpufreq device and
will not be unbound if something return -EPROBE-DEFER in the cpufreq
driver, so using devm will result in resource leaks. Please look at the
git history of this file.

Regards,
Lucas
> ---
>  drivers/cpufreq/imx6q-cpufreq.c | 125 ++++++++++++++++++++--------------------
>  1 file changed, 63 insertions(+), 62 deletions(-)
> 
> diff --git a/drivers/cpufreq/imx6q-cpufreq.c b/drivers/cpufreq/imx6q-cpufreq.c
> index ef1fa81..f48f90a 100644
> --- a/drivers/cpufreq/imx6q-cpufreq.c
> +++ b/drivers/cpufreq/imx6q-cpufreq.c
> @@ -176,6 +176,56 @@ static struct cpufreq_driver imx6q_cpufreq_driver = {
>  	.attr = cpufreq_generic_attr,
>  };
>  
> +static int imx6q_cpufreq_get_clocks(struct platform_device *pdev)
> +{
> +	arm_clk = devm_clk_get(cpu_dev, "arm");
> +	if (IS_ERR(arm_clk))
> +		return PTR_ERR(arm_clk);
> +
> +	pll1_sys_clk = devm_clk_get(cpu_dev, "pll1_sys");
> +	if (IS_ERR(pll1_sys_clk))
> +		return PTR_ERR(pll1_sys_clk);
> +
> +	pll1_sw_clk = devm_clk_get(cpu_dev, "pll1_sw");
> +	if (IS_ERR(pll1_sw_clk))
> +		return PTR_ERR(pll1_sw_clk);
> +
> +	step_clk = devm_clk_get(cpu_dev, "step");
> +	if (IS_ERR(step_clk))
> +		return PTR_ERR(step_clk);
> +
> +	pll2_pfd2_396m_clk = devm_clk_get(cpu_dev, "pll2_pfd2_396m");
> +	if (IS_ERR(pll2_pfd2_396m_clk))
> +		return PTR_ERR(pll2_pfd2_396m_clk);
> +
> +	if (of_machine_is_compatible("fsl,imx6ul")) {
> +		pll2_bus_clk = devm_clk_get(cpu_dev, "pll2_bus");
> +		if (IS_ERR(pll2_bus_clk))
> +			return PTR_ERR(pll2_bus_clk);
> +
> +		secondary_sel_clk = devm_clk_get(cpu_dev, "secondary_sel");
> +		if (IS_ERR(secondary_sel_clk))
> +			return PTR_ERR(secondary_sel_clk);
> +	}
> +
> +	return 0;
> +}
> +
> +static int imx6q_cpufreq_get_regulators(struct platform_device *pdev)
> +{
> +	arm_reg = devm_regulator_get(cpu_dev, "arm");
> +	if (IS_ERR(arm_reg))
> +		return PTR_ERR(arm_reg);
> +
> +	pu_reg = devm_regulator_get_optional(cpu_dev, "pu");
> +
> +	soc_reg = devm_regulator_get(cpu_dev, "soc");
> +	if (IS_ERR(soc_reg))
> +		return PTR_ERR(soc_reg);
> +
> +	return 0;
> +}
> +
>  static int imx6q_cpufreq_probe(struct platform_device *pdev)
>  {
>  	struct device_node *np;
> @@ -198,35 +248,18 @@ static int imx6q_cpufreq_probe(struct platform_device *pdev)
>  		return -ENOENT;
>  	}
>  
> -	arm_clk = clk_get(cpu_dev, "arm");
> -	pll1_sys_clk = clk_get(cpu_dev, "pll1_sys");
> -	pll1_sw_clk = clk_get(cpu_dev, "pll1_sw");
> -	step_clk = clk_get(cpu_dev, "step");
> -	pll2_pfd2_396m_clk = clk_get(cpu_dev, "pll2_pfd2_396m");
> -	if (IS_ERR(arm_clk) || IS_ERR(pll1_sys_clk) || IS_ERR(pll1_sw_clk) ||
> -	    IS_ERR(step_clk) || IS_ERR(pll2_pfd2_396m_clk)) {
> -		dev_err(cpu_dev, "failed to get clocks\n");
> -		ret = -ENOENT;
> -		goto put_clk;
> -	}
> -
> -	if (of_machine_is_compatible("fsl,imx6ul")) {
> -		pll2_bus_clk = clk_get(cpu_dev, "pll2_bus");
> -		secondary_sel_clk = clk_get(cpu_dev, "secondary_sel");
> -		if (IS_ERR(pll2_bus_clk) || IS_ERR(secondary_sel_clk)) {
> -			dev_err(cpu_dev, "failed to get clocks specific to imx6ul\n");
> -			ret = -ENOENT;
> -			goto put_clk;
> -		}
> +	ret = imx6q_cpufreq_get_clocks(pdev);
> +	if (ret) {
> +		dev_err(cpu_dev, "getting clocks failed with %d\n", ret);
> +		goto put_node;
>  	}
>  
> -	arm_reg = regulator_get(cpu_dev, "arm");
> -	pu_reg = regulator_get_optional(cpu_dev, "pu");
> -	soc_reg = regulator_get(cpu_dev, "soc");
> -	if (IS_ERR(arm_reg) || IS_ERR(soc_reg)) {
> -		dev_err(cpu_dev, "failed to get regulators\n");
> -		ret = -ENOENT;
> -		goto put_reg;
> +	ret = imx6q_cpufreq_get_regulators(pdev);
> +	if (ret) {
> +		if (ret != -EPROBE_DEFER)
> +			dev_err(cpu_dev, "getting regulators failed with %d\n",
> +					ret);
> +		goto put_node;
>  	}
>  
>  	/*
> @@ -239,7 +272,7 @@ static int imx6q_cpufreq_probe(struct platform_device *pdev)
>  		ret = dev_pm_opp_of_add_table(cpu_dev);
>  		if (ret < 0) {
>  			dev_err(cpu_dev, "failed to init OPP table: %d\n", ret);
> -			goto put_reg;
> +			goto put_node;
>  		}
>  
>  		/* Because we have added the OPPs here, we must free them */
> @@ -256,7 +289,7 @@ static int imx6q_cpufreq_probe(struct platform_device *pdev)
>  	ret = dev_pm_opp_init_cpufreq_table(cpu_dev, &freq_table);
>  	if (ret) {
>  		dev_err(cpu_dev, "failed to init cpufreq table: %d\n", ret);
> -		goto put_reg;
> +		goto out_free_opp;
>  	}
>  
>  	/* Make imx6_soc_volt array's size same as arm opp number */
> @@ -347,28 +380,7 @@ free_freq_table:
>  out_free_opp:
>  	if (free_opp)
>  		dev_pm_opp_of_remove_table(cpu_dev);
> -put_reg:
> -	if (!IS_ERR(arm_reg))
> -		regulator_put(arm_reg);
> -	if (!IS_ERR(pu_reg))
> -		regulator_put(pu_reg);
> -	if (!IS_ERR(soc_reg))
> -		regulator_put(soc_reg);
> -put_clk:
> -	if (!IS_ERR(arm_clk))
> -		clk_put(arm_clk);
> -	if (!IS_ERR(pll1_sys_clk))
> -		clk_put(pll1_sys_clk);
> -	if (!IS_ERR(pll1_sw_clk))
> -		clk_put(pll1_sw_clk);
> -	if (!IS_ERR(step_clk))
> -		clk_put(step_clk);
> -	if (!IS_ERR(pll2_pfd2_396m_clk))
> -		clk_put(pll2_pfd2_396m_clk);
> -	if (!IS_ERR(pll2_bus_clk))
> -		clk_put(pll2_bus_clk);
> -	if (!IS_ERR(secondary_sel_clk))
> -		clk_put(secondary_sel_clk);
> +put_node:
>  	of_node_put(np);
>  	return ret;
>  }
> @@ -379,17 +391,6 @@ static int imx6q_cpufreq_remove(struct platform_device *pdev)
>  	dev_pm_opp_free_cpufreq_table(cpu_dev, &freq_table);
>  	if (free_opp)
>  		dev_pm_opp_of_remove_table(cpu_dev);
> -	regulator_put(arm_reg);
> -	if (!IS_ERR(pu_reg))
> -		regulator_put(pu_reg);
> -	regulator_put(soc_reg);
> -	clk_put(arm_clk);
> -	clk_put(pll1_sys_clk);
> -	clk_put(pll1_sw_clk);
> -	clk_put(step_clk);
> -	clk_put(pll2_pfd2_396m_clk);
> -	clk_put(pll2_bus_clk);
> -	clk_put(secondary_sel_clk);
>  
>  	return 0;
>  }

-- 
Pengutronix e.K.             | Lucas Stach                 |
Industrial Linux Solutions   | http://www.pengutronix.de/  |

