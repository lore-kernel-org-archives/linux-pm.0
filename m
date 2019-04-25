From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 3/4] PM / Domains: Search for the CPU device outside the
 genpd lock
Date: Thu, 25 Apr 2019 15:15:02 +0530
Message-ID: <20190425094502.6wprvxdz44e5g63q@vireshk-i7>
References: <20190425090413.10700-1-ulf.hansson@linaro.org>
 <20190425090413.10700-4-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190425090413.10700-4-ulf.hansson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org, Daniel Lezcano <daniel.lezcano@linaro.org>, "Raju P . L . S . S . S . N" <rplsssn@codeaurora.org>, Stephen Boyd <sboyd@kernel.org>, Tony Lindgren <tony@atomide.com>, Kevin Hilman <khilman@kernel.org>, Lina Iyer <ilina@codeaurora.org>, Rajendra Nayak <rnayak@codeaurora.org>, Niklas Cassel <niklas.cassel@linaro.org>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

On 25-04-19, 11:04, Ulf Hansson wrote:
> While attaching/detaching a device to a PM domain (genpd) that has the
> GENPD_FLAG_CPU_DOMAIN set, genpd iterates the cpu_possible_mask to check
> whether the device corresponds to a CPU. This iteration is done while
> holding the genpd's lock, which is unnecessary. Let's avoid the locking,
> by restructuring the corresponding code a bit.
> 
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
>  drivers/base/power/domain.c | 52 +++++++++++++++++++------------------
>  1 file changed, 27 insertions(+), 25 deletions(-)
> 
> diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
> index 93298b7db408..da1c99178943 100644
> --- a/drivers/base/power/domain.c
> +++ b/drivers/base/power/domain.c
> @@ -1450,8 +1450,8 @@ static void genpd_free_dev_data(struct device *dev,
>  	dev_pm_put_subsys_data(dev);
>  }
>  
> -static void __genpd_update_cpumask(struct generic_pm_domain *genpd,
> -				   int cpu, bool set, unsigned int depth)
> +static void genpd_update_cpumask(struct generic_pm_domain *genpd,
> +				 int cpu, bool set, unsigned int depth)
>  {
>  	struct gpd_link *link;
>  
> @@ -1462,7 +1462,7 @@ static void __genpd_update_cpumask(struct generic_pm_domain *genpd,
>  		struct generic_pm_domain *master = link->master;
>  
>  		genpd_lock_nested(master, depth + 1);
> -		__genpd_update_cpumask(master, cpu, set, depth + 1);
> +		genpd_update_cpumask(master, cpu, set, depth + 1);
>  		genpd_unlock(master);
>  	}
>  
> @@ -1472,38 +1472,37 @@ static void __genpd_update_cpumask(struct generic_pm_domain *genpd,
>  		cpumask_clear_cpu(cpu, genpd->cpus);
>  }
>  
> -static void genpd_update_cpumask(struct generic_pm_domain *genpd,
> -				 struct device *dev, bool set)
> +static void genpd_set_cpumask(struct generic_pm_domain *genpd, int cpu)
> +{
> +	if (cpu >= 0)
> +		genpd_update_cpumask(genpd, cpu, true, 0);
> +}
> +
> +static void genpd_clear_cpumask(struct generic_pm_domain *genpd, int cpu)
> +{
> +	if (cpu >= 0)
> +		genpd_update_cpumask(genpd, cpu, false, 0);
> +}
> +
> +static int genpd_get_cpu(struct generic_pm_domain *genpd, struct device *dev)
>  {
>  	int cpu;
>  
>  	if (!genpd_is_cpu_domain(genpd))
> -		return;
> +		return -1;
>  
>  	for_each_possible_cpu(cpu) {
> -		if (get_cpu_device(cpu) == dev) {
> -			__genpd_update_cpumask(genpd, cpu, set, 0);
> -			return;
> -		}
> +		if (get_cpu_device(cpu) == dev)
> +			return cpu;
>  	}
> -}
>  
> -static void genpd_set_cpumask(struct generic_pm_domain *genpd,
> -			      struct device *dev)
> -{
> -	genpd_update_cpumask(genpd, dev, true);
> -}
> -
> -static void genpd_clear_cpumask(struct generic_pm_domain *genpd,
> -				struct device *dev)
> -{
> -	genpd_update_cpumask(genpd, dev, false);
> +	return -1;
>  }
>  
>  static int genpd_add_device(struct generic_pm_domain *genpd, struct device *dev)
>  {
>  	struct generic_pm_domain_data *gpd_data;
> -	int ret;
> +	int ret, cpu;
>  
>  	dev_dbg(dev, "%s()\n", __func__);
>  
> @@ -1514,13 +1513,15 @@ static int genpd_add_device(struct generic_pm_domain *genpd, struct device *dev)
>  	if (IS_ERR(gpd_data))
>  		return PTR_ERR(gpd_data);
>  
> +	cpu = genpd_get_cpu(genpd, dev);
> +
>  	ret = genpd->attach_dev ? genpd->attach_dev(genpd, dev) : 0;
>  	if (ret)
>  		goto out;
>  
>  	genpd_lock(genpd);
>  
> -	genpd_set_cpumask(genpd, dev);
> +	genpd_set_cpumask(genpd, cpu);

Should we check if "cpu" is valid here ? As that was done earlier.

>  	dev_pm_domain_set(dev, &genpd->domain);
>  
>  	genpd->device_count++;
> @@ -1560,13 +1561,14 @@ static int genpd_remove_device(struct generic_pm_domain *genpd,
>  {
>  	struct generic_pm_domain_data *gpd_data;
>  	struct pm_domain_data *pdd;
> -	int ret = 0;
> +	int cpu, ret = 0;
>  
>  	dev_dbg(dev, "%s()\n", __func__);
>  
>  	pdd = dev->power.subsys_data->domain_data;
>  	gpd_data = to_gpd_data(pdd);
>  	dev_pm_qos_remove_notifier(dev, &gpd_data->nb);
> +	cpu = genpd_get_cpu(genpd, dev);
>  
>  	genpd_lock(genpd);
>  
> @@ -1578,7 +1580,7 @@ static int genpd_remove_device(struct generic_pm_domain *genpd,
>  	genpd->device_count--;
>  	genpd->max_off_time_changed = true;
>  
> -	genpd_clear_cpumask(genpd, dev);
> +	genpd_clear_cpumask(genpd, cpu);

Same here.

>  	dev_pm_domain_set(dev, NULL);
>  
>  	list_del_init(&pdd->list_node);
> -- 
> 2.17.1

-- 
viresh
