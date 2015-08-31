From: Lucas Stach <l.stach@pengutronix.de>
Subject: Re: [PATCH] cpufreq: imx: use the managed interfaces for resources
 allocation
Date: Mon, 31 Aug 2015 13:06:03 +0200
Message-ID: <1441019163.3652.2.camel@pengutronix.de>
References: <1441040730-16391-1-git-send-email-b51503@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:59698 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752456AbbHaLGH (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 31 Aug 2015 07:06:07 -0400
In-Reply-To: <1441040730-16391-1-git-send-email-b51503@freescale.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Bai Ping <b51503@freescale.com>
Cc: rjw@rjwysocki.net, viresh.kumar@linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

Am Dienstag, den 01.09.2015, 01:05 +0800 schrieb Bai Ping:
> Replace the clk_get() and regulator_get() with the managed interfaces
> then the error path can be simplified.
> 
> Signed-off-by: Bai Ping <b51503@freescale.com>

NACK.
Please go back in the git history of this file and look at the commits.
Those clocks and regulators are explicitly _not_ using the managed
functions, as this would lead to resource leaks.

Regards,
Lucas
> ---
>  drivers/cpufreq/imx6q-cpufreq.c | 52 +++++++++++------------------------------
>  1 file changed, 13 insertions(+), 39 deletions(-)
> 
> diff --git a/drivers/cpufreq/imx6q-cpufreq.c b/drivers/cpufreq/imx6q-cpufreq.c
> index 380a90d..1439f93 100644
> --- a/drivers/cpufreq/imx6q-cpufreq.c
> +++ b/drivers/cpufreq/imx6q-cpufreq.c
> @@ -174,25 +174,25 @@ static int imx6q_cpufreq_probe(struct platform_device *pdev)
>  		return -ENOENT;
>  	}
>  
> -	arm_clk = clk_get(cpu_dev, "arm");
> -	pll1_sys_clk = clk_get(cpu_dev, "pll1_sys");
> -	pll1_sw_clk = clk_get(cpu_dev, "pll1_sw");
> -	step_clk = clk_get(cpu_dev, "step");
> -	pll2_pfd2_396m_clk = clk_get(cpu_dev, "pll2_pfd2_396m");
> +	arm_clk = devm_clk_get(cpu_dev, "arm");
> +	pll1_sys_clk = devm_clk_get(cpu_dev, "pll1_sys");
> +	pll1_sw_clk = devm_clk_get(cpu_dev, "pll1_sw");
> +	step_clk = devm_clk_get(cpu_dev, "step");
> +	pll2_pfd2_396m_clk = devm_clk_get(cpu_dev, "pll2_pfd2_396m");
>  	if (IS_ERR(arm_clk) || IS_ERR(pll1_sys_clk) || IS_ERR(pll1_sw_clk) ||
>  	    IS_ERR(step_clk) || IS_ERR(pll2_pfd2_396m_clk)) {
>  		dev_err(cpu_dev, "failed to get clocks\n");
>  		ret = -ENOENT;
> -		goto put_clk;
> +		goto put_node;
>  	}
>  
> -	arm_reg = regulator_get(cpu_dev, "arm");
> -	pu_reg = regulator_get_optional(cpu_dev, "pu");
> -	soc_reg = regulator_get(cpu_dev, "soc");
> +	arm_reg = devm_regulator_get(cpu_dev, "arm");
> +	pu_reg = devm_regulator_get_optional(cpu_dev, "pu");
> +	soc_reg = devm_regulator_get(cpu_dev, "soc");
>  	if (IS_ERR(arm_reg) || IS_ERR(soc_reg)) {
>  		dev_err(cpu_dev, "failed to get regulators\n");
>  		ret = -ENOENT;
> -		goto put_reg;
> +		goto put_node;
>  	}
>  
>  	/*
> @@ -205,7 +205,7 @@ static int imx6q_cpufreq_probe(struct platform_device *pdev)
>  		ret = of_init_opp_table(cpu_dev);
>  		if (ret < 0) {
>  			dev_err(cpu_dev, "failed to init OPP table: %d\n", ret);
> -			goto put_reg;
> +			goto put_node;
>  		}
>  
>  		/* Because we have added the OPPs here, we must free them */
> @@ -222,7 +222,7 @@ static int imx6q_cpufreq_probe(struct platform_device *pdev)
>  	ret = dev_pm_opp_init_cpufreq_table(cpu_dev, &freq_table);
>  	if (ret) {
>  		dev_err(cpu_dev, "failed to init cpufreq table: %d\n", ret);
> -		goto put_reg;
> +		goto out_free_opp;
>  	}
>  
>  	/* Make imx6_soc_volt array's size same as arm opp number */
> @@ -313,24 +313,7 @@ free_freq_table:
>  out_free_opp:
>  	if (free_opp)
>  		of_free_opp_table(cpu_dev);
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
> +put_node:
>  	of_node_put(np);
>  	return ret;
>  }
> @@ -341,15 +324,6 @@ static int imx6q_cpufreq_remove(struct platform_device *pdev)
>  	dev_pm_opp_free_cpufreq_table(cpu_dev, &freq_table);
>  	if (free_opp)
>  		of_free_opp_table(cpu_dev);
> -	regulator_put(arm_reg);
> -	if (!IS_ERR(pu_reg))
> -		regulator_put(pu_reg);
> -	regulator_put(soc_reg);
> -	clk_put(arm_clk);
> -	clk_put(pll1_sys_clk);
> -	clk_put(pll1_sw_clk);
> -	clk_put(step_clk);
> -	clk_put(pll2_pfd2_396m_clk);
>  
>  	return 0;
>  }

-- 
Pengutronix e.K.             | Lucas Stach                 |
Industrial Linux Solutions   | http://www.pengutronix.de/  |

