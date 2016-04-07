From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] cpufreq: tegra124: No need of setting platform-data
Date: Thu, 7 Apr 2016 13:51:43 +0530
Message-ID: <20160407082143.GA3201@vireshk-i7>
References: <60bdca9a8f31714d733ace7e7c25c46cd366082f.1459260280.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <60bdca9a8f31714d733ace7e7c25c46cd366082f.1459260280.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, ttynkkynen@nvidia.com, Stephen Warren <swarren@wwwdotorg.org>, Thierry Reding <thierry.reding@gmail.com>, Alexandre Courbot <gnurou@gmail.com>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 29-03-16, 19:35, Viresh Kumar wrote:
> All CPUs on Tegra platform share clock/voltage lines and there is
> absolutely no need of setting platform data for 'cpufreq-dt' platform
> device, as that's the default case.
> 
> Stop setting platform data for cpufreq-dt device.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
> Only compile tested.
> 
>  drivers/cpufreq/tegra124-cpufreq.c | 7 -------
>  1 file changed, 7 deletions(-)
> 
> diff --git a/drivers/cpufreq/tegra124-cpufreq.c b/drivers/cpufreq/tegra124-cpufreq.c
> index 20bcceb58ccc..43530254201a 100644
> --- a/drivers/cpufreq/tegra124-cpufreq.c
> +++ b/drivers/cpufreq/tegra124-cpufreq.c
> @@ -14,7 +14,6 @@
>  #define pr_fmt(fmt)	KBUILD_MODNAME ": " fmt
>  
>  #include <linux/clk.h>
> -#include <linux/cpufreq-dt.h>
>  #include <linux/err.h>
>  #include <linux/init.h>
>  #include <linux/kernel.h>
> @@ -69,10 +68,6 @@ static void tegra124_cpu_switch_to_pllx(struct tegra124_cpufreq_priv *priv)
>  	clk_set_parent(priv->cpu_clk, priv->pllx_clk);
>  }
>  
> -static struct cpufreq_dt_platform_data cpufreq_dt_pd = {
> -	.independent_clocks = false,
> -};
> -
>  static int tegra124_cpufreq_probe(struct platform_device *pdev)
>  {
>  	struct tegra124_cpufreq_priv *priv;
> @@ -129,8 +124,6 @@ static int tegra124_cpufreq_probe(struct platform_device *pdev)
>  
>  	cpufreq_dt_devinfo.name = "cpufreq-dt";
>  	cpufreq_dt_devinfo.parent = &pdev->dev;
> -	cpufreq_dt_devinfo.data = &cpufreq_dt_pd;
> -	cpufreq_dt_devinfo.size_data = sizeof(cpufreq_dt_pd);
>  
>  	priv->cpufreq_dt_pdev =
>  		platform_device_register_full(&cpufreq_dt_devinfo);

Ping !!

-- 
viresh
