From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH V2] cpufreq: cpu0: Free parent node for error cases
Date: Fri, 3 May 2013 14:03:29 +0800
Message-ID: <20130503060327.GA19902@S2101-09.ap.freescale.net>
References: <03c6b0e0f41238c1b4346b4186040ff69e369b4a.1367556239.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <cpufreq-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <03c6b0e0f41238c1b4346b4186040ff69e369b4a.1367556239.git.viresh.kumar@linaro.org>
Sender: cpufreq-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: rjw@sisk.pl, linaro-kernel@lists.linaro.org, patches@linaro.org, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, robin.randhawa@arm.com, Steve.Bannister@arm.com, Liviu.Dudau@arm.com, charles.garcia-tobin@arm.com, arvind.chauhan@arm.com
List-Id: linux-pm@vger.kernel.org

On Fri, May 03, 2013 at 10:14:25AM +0530, Viresh Kumar wrote:
> We are freeing parent node in success cases but not in failure cases. Lets do
> it.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

Acked-by: Shawn Guo <shawn.guo@linaro.org>

> ---
>  drivers/cpufreq/cpufreq-cpu0.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/cpufreq/cpufreq-cpu0.c b/drivers/cpufreq/cpufreq-cpu0.c
> index 3ab8294..8565d41 100644
> --- a/drivers/cpufreq/cpufreq-cpu0.c
> +++ b/drivers/cpufreq/cpufreq-cpu0.c
> @@ -189,7 +189,8 @@ static int cpu0_cpufreq_probe(struct platform_device *pdev)
>  
>  	if (!np) {
>  		pr_err("failed to find cpu0 node\n");
> -		return -ENOENT;
> +		ret = -ENOENT;
> +		goto out_put_parent;
>  	}
>  
>  	cpu_dev = &pdev->dev;
> @@ -264,6 +265,8 @@ out_free_table:
>  	opp_free_cpufreq_table(cpu_dev, &freq_table);
>  out_put_node:
>  	of_node_put(np);
> +out_put_parent:
> +	of_node_put(parent);
>  	return ret;
>  }
>  
> -- 
> 1.7.12.rc2.18.g61b472e
> 

