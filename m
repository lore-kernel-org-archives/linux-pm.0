From: Lucas Stach <l.stach@pengutronix.de>
Subject: Re: [PATCH] cpufreq: imx6q: use devm to fetch resources
Date: Mon, 20 Feb 2017 15:12:52 +0100
Message-ID: <1487599972.2268.14.camel@pengutronix.de>
References: <964303696dfe1462bd0af2bcd2735d9a6b7ac52c.1487598539.git.leonard.crestez@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:40669 "EHLO
        metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752888AbdBTOMz (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 20 Feb 2017 09:12:55 -0500
In-Reply-To: <964303696dfe1462bd0af2bcd2735d9a6b7ac52c.1487598539.git.leonard.crestez@nxp.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Leonard Crestez <leonard.crestez@nxp.com>
Cc: linux-pm@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Jacky Bai <ping.bai@nxp.com>, Shawn Guo <shawnguo@kernel.org>, linux-kernel@vger.kernel.org

Am Montag, den 20.02.2017, 16:02 +0200 schrieb Leonard Crestez:
> Replace the clk_get and regulator_get will devm variants to free the
> resources automatically when probe failed or driver is removed.
> 
> The device we are probing is not cpu_dev but the cpufreq platform_device
> (pdev->dev). In order for this to actually work correctly we assign to
> the cpufreq device the of_node from cpu_dev.
> 
> Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
> ---
>  drivers/cpufreq/imx6q-cpufreq.c | 75 +++++++++++++----------------------------
>  1 file changed, 24 insertions(+), 51 deletions(-)
> 
> Something similar was rejected in the past: https://patchwork.kernel.org/patch/7099051/
> 
> New version assigns the of_node from the cpu device to the cpufreq device so
> that devm_clk_get(pdev->dev, ...) works as expected. It is not clear if this is
> allowed but I don't see why it wouldn't.

Don't do this, as this can have side effects later on. See
http://lists.infradead.org/pipermail/linux-arm-kernel/2015-September/367736.html

Please leave this code as is. It works as intended and has seen a lot of
testing. If this isn't some preparation for new development, I don't see
what we gain from people constantly trying to convert this code to devm.

And if this is in fact some preparation for new development, consider if
you really need to modify this driver, instead of using cpufreq-dt.

Regards,
Lucas

> 
> diff --git a/drivers/cpufreq/imx6q-cpufreq.c b/drivers/cpufreq/imx6q-cpufreq.c
> index ef1fa81..374bc72 100644
> --- a/drivers/cpufreq/imx6q-cpufreq.c
> +++ b/drivers/cpufreq/imx6q-cpufreq.c
> @@ -1,5 +1,6 @@
>  /*
>   * Copyright (C) 2013 Freescale Semiconductor, Inc.
> + * Copyright (C) 2017 NXP
>   *
>   * This program is free software; you can redistribute it and/or modify
>   * it under the terms of the GNU General Public License version 2 as
> @@ -198,35 +199,37 @@ static int imx6q_cpufreq_probe(struct platform_device *pdev)
>  		return -ENOENT;
>  	}
>  
> -	arm_clk = clk_get(cpu_dev, "arm");
> -	pll1_sys_clk = clk_get(cpu_dev, "pll1_sys");
> -	pll1_sw_clk = clk_get(cpu_dev, "pll1_sw");
> -	step_clk = clk_get(cpu_dev, "step");
> -	pll2_pfd2_396m_clk = clk_get(cpu_dev, "pll2_pfd2_396m");
> +	pdev->dev.of_node = cpu_dev->of_node;
> +
> +	arm_clk = devm_clk_get(&pdev->dev, "arm");
> +	pll1_sys_clk = devm_clk_get(&pdev->dev, "pll1_sys");
> +	pll1_sw_clk = devm_clk_get(&pdev->dev, "pll1_sw");
> +	step_clk = devm_clk_get(&pdev->dev, "step");
> +	pll2_pfd2_396m_clk = devm_clk_get(&pdev->dev, "pll2_pfd2_396m");
>  	if (IS_ERR(arm_clk) || IS_ERR(pll1_sys_clk) || IS_ERR(pll1_sw_clk) ||
>  	    IS_ERR(step_clk) || IS_ERR(pll2_pfd2_396m_clk)) {
>  		dev_err(cpu_dev, "failed to get clocks\n");
>  		ret = -ENOENT;
> -		goto put_clk;
> +		goto put_node;
>  	}
>  
>  	if (of_machine_is_compatible("fsl,imx6ul")) {
> -		pll2_bus_clk = clk_get(cpu_dev, "pll2_bus");
> -		secondary_sel_clk = clk_get(cpu_dev, "secondary_sel");
> +		pll2_bus_clk = devm_clk_get(&pdev->dev, "pll2_bus");
> +		secondary_sel_clk = devm_clk_get(&pdev->dev, "secondary_sel");
>  		if (IS_ERR(pll2_bus_clk) || IS_ERR(secondary_sel_clk)) {
>  			dev_err(cpu_dev, "failed to get clocks specific to imx6ul\n");
>  			ret = -ENOENT;
> -			goto put_clk;
> +			goto put_node;
>  		}
>  	}
>  
> -	arm_reg = regulator_get(cpu_dev, "arm");
> -	pu_reg = regulator_get_optional(cpu_dev, "pu");
> -	soc_reg = regulator_get(cpu_dev, "soc");
> +	arm_reg = devm_regulator_get(&pdev->dev, "arm");
> +	pu_reg = devm_regulator_get_optional(&pdev->dev, "pu");
> +	soc_reg = devm_regulator_get(&pdev->dev, "soc");
>  	if (IS_ERR(arm_reg) || IS_ERR(soc_reg)) {
>  		dev_err(cpu_dev, "failed to get regulators\n");
>  		ret = -ENOENT;
> -		goto put_reg;
> +		goto put_node;
>  	}
>  
>  	/*
> @@ -239,7 +242,7 @@ static int imx6q_cpufreq_probe(struct platform_device *pdev)
>  		ret = dev_pm_opp_of_add_table(cpu_dev);
>  		if (ret < 0) {
>  			dev_err(cpu_dev, "failed to init OPP table: %d\n", ret);
> -			goto put_reg;
> +			goto put_node;
>  		}
>  
>  		/* Because we have added the OPPs here, we must free them */
> @@ -256,11 +259,11 @@ static int imx6q_cpufreq_probe(struct platform_device *pdev)
>  	ret = dev_pm_opp_init_cpufreq_table(cpu_dev, &freq_table);
>  	if (ret) {
>  		dev_err(cpu_dev, "failed to init cpufreq table: %d\n", ret);
> -		goto put_reg;
> +		goto out_free_opp;
>  	}
>  
>  	/* Make imx6_soc_volt array's size same as arm opp number */
> -	imx6_soc_volt = devm_kzalloc(cpu_dev, sizeof(*imx6_soc_volt) * num, GFP_KERNEL);
> +	imx6_soc_volt = devm_kzalloc(&pdev->dev, sizeof(*imx6_soc_volt) * num, GFP_KERNEL);
>  	if (imx6_soc_volt == NULL) {
>  		ret = -ENOMEM;
>  		goto free_freq_table;
> @@ -339,7 +342,6 @@ static int imx6q_cpufreq_probe(struct platform_device *pdev)
>  		goto free_freq_table;
>  	}
>  
> -	of_node_put(np);
>  	return 0;
>  
>  free_freq_table:
> @@ -347,29 +349,9 @@ static int imx6q_cpufreq_probe(struct platform_device *pdev)
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
> -	of_node_put(np);
> +put_node:
> +	of_node_put(pdev->dev.of_node);
> +	pdev->dev.of_node = NULL;
>  	return ret;
>  }
>  
> @@ -379,17 +361,8 @@ static int imx6q_cpufreq_remove(struct platform_device *pdev)
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
> +	of_node_put(pdev->dev.of_node);
> +	pdev->dev.of_node = NULL;
>  
>  	return 0;
>  }
