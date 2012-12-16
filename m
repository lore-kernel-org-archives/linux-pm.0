From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 1/3] cpufreq: Manage only online cpus
Date: Sun, 16 Dec 2012 14:04:24 +0100
Message-ID: <4137114.myBUIQvsg3@vostro.rjw.lan>
References: <98330b2deb910453a356404b8cf774c94326bc42.1355636864.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <98330b2deb910453a356404b8cf774c94326bc42.1355636864.git.viresh.kumar@linaro.org>
Sender: cpufreq-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: linaro-dev@lists.linaro.org, nicolas.pitre@linaro.org, amit.kucheria@linaro.org, mathieu.poirier@linaro.org, linux-kernel@vger.kernel.org, cpufreq@vger.kernel.org, pdsw-power-team@arm.com, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Sunday, December 16, 2012 11:20:08 AM Viresh Kumar wrote:
> cpufreq core doesn't manage offline cpus and if driver->init() has returned
> mask including offline cpus, it may result in unwanted behavior by cpufreq core
> or governors.
> 
> We need to get only online cpus in this mask. There are two places to fix this
> mask, cpufreq core and cpufreq driver. It makes sense to do this at common place
> and hence is done in core.

Well, this series makes sense to me, but I'd like to hear what the other people
think.

Thanks,
Rafael


> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  drivers/cpufreq/cpufreq.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index 1f93dbd..de99517 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -970,6 +970,13 @@ static int cpufreq_add_dev(struct device *dev, struct subsys_interface *sif)
>  		pr_debug("initialization failed\n");
>  		goto err_unlock_policy;
>  	}
> +
> +	/*
> +	 * affected cpus must always be the one, which are online. We aren't
> +	 * managing offline cpus here.
> +	 */
> +	cpumask_and(policy->cpus, policy->cpus, cpu_online_mask);
> +
>  	policy->user_policy.min = policy->min;
>  	policy->user_policy.max = policy->max;
>  
> 
-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
