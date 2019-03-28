From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] cpufreq: scpi: fix use after free
Date: Thu, 28 Mar 2019 11:14:47 +0100
Message-ID: <3545642.ato4ToQdI5@aspire.rjw.lan>
References: <20190327220642.8117-1-vincent.stehle@laposte.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190327220642.8117-1-vincent.stehle@laposte.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Vincent =?ISO-8859-1?Q?Stehl=E9?= <vincent.stehle@laposte.net>
Cc: linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Sudeep Holla <sudeep.holla@arm.com>, Viresh Kumar <viresh.kumar@linaro.org>
List-Id: linux-pm@vger.kernel.org

On Wednesday, March 27, 2019 11:06:42 PM CET Vincent Stehlé wrote:
> Free the priv structure only after we are done using it.
> 
> Fixes: 1690d8bb91e370ab ("cpufreq: scpi/scmi: Fix freeing of dynamic OPPs")
> Signed-off-by: Vincent Stehlé <vincent.stehle@laposte.net>
> Cc: Sudeep Holla <sudeep.holla@arm.com>
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Cc: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  drivers/cpufreq/scpi-cpufreq.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/cpufreq/scpi-cpufreq.c b/drivers/cpufreq/scpi-cpufreq.c
> index 3f49427766b88..2b51e0718c9f6 100644
> --- a/drivers/cpufreq/scpi-cpufreq.c
> +++ b/drivers/cpufreq/scpi-cpufreq.c
> @@ -189,8 +189,8 @@ static int scpi_cpufreq_exit(struct cpufreq_policy *policy)
>  
>  	clk_put(priv->clk);
>  	dev_pm_opp_free_cpufreq_table(priv->cpu_dev, &policy->freq_table);
> -	kfree(priv);
>  	dev_pm_opp_remove_all_dynamic(priv->cpu_dev);
> +	kfree(priv);
>  
>  	return 0;
>  }
> 

I've queued this one up, thanks!
