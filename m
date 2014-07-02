From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH 06/14] cpufreq: cpu0: defer probe if clock isn't
 registered yet
Date: Wed, 2 Jul 2014 13:53:33 +0800
Message-ID: <20140702055330.GA3454@dragon>
References: <cover.1404231535.git.viresh.kumar@linaro.org>
 <eb6df0f1f2c82db0d516b9b63820cfe0c0c97d5c.1404231535.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-bn1blp0188.outbound.protection.outlook.com ([207.46.163.188]:2397
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751983AbaGBGIT (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 2 Jul 2014 02:08:19 -0400
Content-Disposition: inline
In-Reply-To: <eb6df0f1f2c82db0d516b9b63820cfe0c0c97d5c.1404231535.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: rjw@rjwysocki.net, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, arvind.chauhan@arm.com, sboyd@codeaurora.org, linux-arm-msm@vger.kernel.org, spk.linux@gmail.com, thomas.ab@samsung.com, nm@ti.com, t.figa@samsung.com

On Tue, Jul 01, 2014 at 10:02:35PM +0530, Viresh Kumar wrote:
> Currently, we defer probe if regulator_get() returned -EPROBE_DEFER, i.e.
> regulator isn't registered yet.
> 
> The same is true for clock as well, so lets defer in that case as well.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  drivers/cpufreq/cpufreq-cpu0.c | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cpufreq/cpufreq-cpu0.c b/drivers/cpufreq/cpufreq-cpu0.c
> index 4273a5f..b5b8e1c 100644
> --- a/drivers/cpufreq/cpufreq-cpu0.c
> +++ b/drivers/cpufreq/cpufreq-cpu0.c
> @@ -150,8 +150,17 @@ static int cpu0_cpufreq_probe(struct platform_device *pdev)
>  
>  	cpu_clk = clk_get(cpu_dev, NULL);
>  	if (IS_ERR(cpu_clk)) {
> -		ret = PTR_ERR(cpu_clk);

If you keep this ...

> -		pr_err("failed to get cpu0 clock: %d\n", ret);
> +		/*
> +		 * If cpu's clk node is present, but clock is not yet
> +		 * registered, we should try defering probe.
> +		 */
> +		if (PTR_ERR(cpu_clk) == -EPROBE_DEFER) {

... you can use 'ret' here ...

> +			dev_err(cpu_dev, "cpu0 clock not ready, retry\n");
> +			ret = -EPROBE_DEFER;

... this can be saved ...

> +		} else {
> +			ret = PTR_ERR(cpu_clk);

... and this as well.

Shawn

> +			dev_err(cpu_dev, "failed to get cpu0 clock: %d\n", ret);
> +		}
>  		goto out_put_reg;
>  	}
>  
> -- 
> 2.0.0.rc2
> 
