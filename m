From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v3] cpufreq: kirkwood-cpufreq:- Handle return value of
 clk_prepare_enable
Date: Wed, 17 May 2017 12:44:03 +0530
Message-ID: <20170517071403.GD17481@vireshk-i7>
References: <1495003835-25828-1-git-send-email-arvind.yadav.cs@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f169.google.com ([209.85.192.169]:34578 "EHLO
        mail-pf0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753465AbdEQHOG (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 17 May 2017 03:14:06 -0400
Received: by mail-pf0-f169.google.com with SMTP id 9so2913270pfj.1
        for <linux-pm@vger.kernel.org>; Wed, 17 May 2017 00:14:06 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1495003835-25828-1-git-send-email-arvind.yadav.cs@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Arvind Yadav <arvind.yadav.cs@gmail.com>
Cc: rjw@rjwysocki.net, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

On 17-05-17, 12:20, Arvind Yadav wrote:
> clk_prepare_enable() can fail here and we must check its return value.
> 
> Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
> ---
>  drivers/cpufreq/kirkwood-cpufreq.c | 19 ++++++++++++++++---
>  1 file changed, 16 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/cpufreq/kirkwood-cpufreq.c b/drivers/cpufreq/kirkwood-cpufreq.c
> index 1b9bcd7..c2dd43f 100644
> --- a/drivers/cpufreq/kirkwood-cpufreq.c
> +++ b/drivers/cpufreq/kirkwood-cpufreq.c
> @@ -127,7 +127,12 @@ static int kirkwood_cpufreq_probe(struct platform_device *pdev)
>  		return PTR_ERR(priv.cpu_clk);
>  	}
>  
> -	clk_prepare_enable(priv.cpu_clk);
> +	err = clk_prepare_enable(priv.cpu_clk);
> +	if (err) {
> +		dev_err(priv.dev, "Unable to prepare cpuclk\n");
> +		return err;
> +	}
> +
>  	kirkwood_freq_table[0].frequency = clk_get_rate(priv.cpu_clk) / 1000;
>  
>  	priv.ddr_clk = of_clk_get_by_name(np, "ddrclk");
> @@ -137,7 +142,11 @@ static int kirkwood_cpufreq_probe(struct platform_device *pdev)
>  		goto out_cpu;
>  	}
>  
> -	clk_prepare_enable(priv.ddr_clk);
> +	err = clk_prepare_enable(priv.ddr_clk);
> +	if (err) {
> +		dev_err(priv.dev, "Unable to prepare ddrclk\n");
> +		goto out_cpu;
> +	}
>  	kirkwood_freq_table[1].frequency = clk_get_rate(priv.ddr_clk) / 1000;
>  
>  	priv.powersave_clk = of_clk_get_by_name(np, "powersave");
> @@ -146,7 +155,11 @@ static int kirkwood_cpufreq_probe(struct platform_device *pdev)
>  		err = PTR_ERR(priv.powersave_clk);
>  		goto out_ddr;
>  	}
> -	clk_prepare_enable(priv.powersave_clk);
> +	err = clk_prepare_enable(priv.powersave_clk);
> +	if (err) {
> +		dev_err(priv.dev, "Unable to prepare powersave clk\n");
> +		goto out_ddr;
> +	}
>  
>  	of_node_put(np);
>  	np = NULL;

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
