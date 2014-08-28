From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH 3/3] cpufreq: cpu0: Convert pr_ to dev_ as struct device
 is available
Date: Thu, 28 Aug 2014 14:15:23 +0800
Message-ID: <20140828061521.GD23836@dragon>
References: <1409209212-18730-1-git-send-email-pramod.gurav@smartplayin.com>
 <1409209212-18730-3-git-send-email-pramod.gurav@smartplayin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1409209212-18730-3-git-send-email-pramod.gurav@smartplayin.com>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Pramod Gurav <pramod.gurav@smartplayin.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>
List-Id: linux-pm@vger.kernel.org

On Thu, Aug 28, 2014 at 12:00:12AM -0700, Pramod Gurav wrote:
> CC: Shawn Guo <shawn.guo@linaro.org>
> CC: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> CC: Viresh Kumar <viresh.kumar@linaro.org>
> Signed-off-by: Pramod Gurav <pramod.gurav@smartplayin.com>
> ---
>  drivers/cpufreq/cpufreq-cpu0.c |   12 ++++++------
>  1 files changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/cpufreq/cpufreq-cpu0.c b/drivers/cpufreq/cpufreq-cpu0.c
> index 0652cea..8f0b02f 100644
> --- a/drivers/cpufreq/cpufreq-cpu0.c
> +++ b/drivers/cpufreq/cpufreq-cpu0.c
> @@ -126,7 +126,7 @@ static int cpu0_cpufreq_probe(struct platform_device *pdev)
>  
>  	np = of_node_get(cpu_dev->of_node);
>  	if (!np) {
> -		pr_err("failed to find cpu0 node\n");
> +		dev_err(cpu_dev, "failed to find cpu0 node\n");

There are more pr_* calls in the driver.  Since you do not get rid of
all of them anyway, and pr_fmt(fmt) definition in the file also gives
good context of the messages, I'm not fond of the change.

Shawn

>  		return -ENOENT;
>  	}
>  
> @@ -141,14 +141,14 @@ static int cpu0_cpufreq_probe(struct platform_device *pdev)
>  			ret = -EPROBE_DEFER;
>  			goto out_put_node;
>  		}
> -		pr_warn("failed to get cpu0 regulator: %ld\n",
> +		dev_warn(cpu_dev, "failed to get cpu0 regulator: %ld\n",
>  			PTR_ERR(cpu_reg));
>  	}
>  
>  	cpu_clk = clk_get(cpu_dev, NULL);
>  	if (IS_ERR(cpu_clk)) {
>  		ret = PTR_ERR(cpu_clk);
> -		pr_err("failed to get cpu0 clock: %d\n", ret);
> +		dev_err(cpu_dev, "failed to get cpu0 clock: %d\n", ret);
>  		goto out_put_reg;
>  	}
>  
> @@ -157,7 +157,7 @@ static int cpu0_cpufreq_probe(struct platform_device *pdev)
>  
>  	ret = dev_pm_opp_init_cpufreq_table(cpu_dev, &freq_table);
>  	if (ret) {
> -		pr_err("failed to init cpufreq table: %d\n", ret);
> +		dev_err(cpu_dev, "failed to init cpufreq table: %d\n", ret);
>  		goto out_put_clk;
>  	}
>  
> @@ -193,7 +193,7 @@ static int cpu0_cpufreq_probe(struct platform_device *pdev)
>  
>  	ret = cpufreq_register_driver(&cpu0_cpufreq_driver);
>  	if (ret) {
> -		pr_err("failed register driver: %d\n", ret);
> +		dev_err(cpu_dev, "failed register driver: %d\n", ret);
>  		goto out_free_table;
>  	}
>  
> @@ -204,7 +204,7 @@ static int cpu0_cpufreq_probe(struct platform_device *pdev)
>  	if (of_find_property(np, "#cooling-cells", NULL)) {
>  		cdev = of_cpufreq_cooling_register(np, cpu_present_mask);
>  		if (IS_ERR(cdev))
> -			pr_err("running cpufreq without cooling device: %ld\n",
> +			dev_err(cpu_dev, "running cpufreq without cooling device: %ld\n",
>  			       PTR_ERR(cdev));
>  	}
>  
> -- 
> 1.7.0.4
> 
