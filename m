From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] cpufreq: tegra124: add missing of_node_put()
Date: Mon, 4 Feb 2019 12:06:15 +0530
Message-ID: <20190204063615.yr4fbz3b7ovbm7a2@vireshk-i7>
References: <20190204063501.1348-1-tiny.windzz@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190204063501.1348-1-tiny.windzz@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Yangtao Li <tiny.windzz@gmail.com>
Cc: rjw@rjwysocki.net, thierry.reding@gmail.com, jonathanh@nvidia.com, linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 04-02-19, 01:35, Yangtao Li wrote:
> of_cpu_device_node_get() will increase the refcount of device_node,
> it is necessary to call of_node_put() at the end to release the
> refcount.
> 
> Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
> ---
>  drivers/cpufreq/tegra124-cpufreq.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/cpufreq/tegra124-cpufreq.c b/drivers/cpufreq/tegra124-cpufreq.c
> index 43530254201a..140a9266b64a 100644
> --- a/drivers/cpufreq/tegra124-cpufreq.c
> +++ b/drivers/cpufreq/tegra124-cpufreq.c
> @@ -118,6 +118,8 @@ static int tegra124_cpufreq_probe(struct platform_device *pdev)
>  		goto out_put_pllx_clk;
>  	}
>  
> +	of_node_put(np);
> +
>  	ret = tegra124_cpu_switch_to_dfll(priv);
>  	if (ret)
>  		goto out_put_pllp_clk;

Fixes and stable tags ?

-- 
viresh
