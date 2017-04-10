From: Rajendra Nayak <rnayak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Subject: Re: [RFC PATCH 2/4] PM / Domains: Add support for explicit control of
 PM domains
Date: Mon, 10 Apr 2017 09:39:15 +0530
Message-ID: <edbd9d3a-d978-6f64-b1aa-3b1ea226a8bd@codeaurora.org>
References: <1490710443-27425-1-git-send-email-jonathanh@nvidia.com>
 <1490710443-27425-3-git-send-email-jonathanh@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1490710443-27425-3-git-send-email-jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "Rafael J . Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Kevin Hilman <khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org
Cc: stanimir.varbanov-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, Marek Szyprowski <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org

Hey Jon,

On 03/28/2017 07:44 PM, Jon Hunter wrote:
> The current generic PM domain framework (GenDP) only allows a single
> PM domain to be associated with a given device. There are several
> use-cases for various system-on-chip devices where it is necessary for
> a PM domain consumer to control more than one PM domain where the PM
> domains:
> i).  Do not conform to a parent-child relationship so are not nested
> ii). May not be powered on and off at the same time so need independent
>      control.
> 
> To support the above, add new APIs for GenPD to allow consumers to get,
> power-on, power-off and put PM domains so that they can be explicitly
> controlled by the consumer.

thanks for working on this RFC.

[]..
  
> +/**
> + * pm_genpd_get - Get a generic I/O PM domain by name
> + * @name: Name of the PM domain.
> + *
> + * Look-ups a PM domain by name. If found, increment the device
> + * count for PM domain to ensure that the PM domain cannot be
> + * removed, increment the suspended count so that it can still
> + * be turned off (when not in-use) and return a pointer to its
> + * generic_pm_domain structure. If not found return ERR_PTR().
> + */
> +struct generic_pm_domain *pm_genpd_get(const char *name)
> +{
> +	struct generic_pm_domain *gpd, *genpd = ERR_PTR(-EEXIST);
> +
> +	if (!name)
> +		return ERR_PTR(-EINVAL);
> +
> +	mutex_lock(&gpd_list_lock);
> +	list_for_each_entry(gpd, &gpd_list, gpd_list_node) {
> +		if (!strcmp(gpd->name, name)) {
> +			genpd_lock(gpd);
> +			gpd->device_count++;

There apis' should also take a device pointer as a parameter,
so we can track all the devices belonging to a powerdomain.
That would also mean keeping the genpd->dev_list updated instead of
only incrementing the device_count here.

> +			gpd->suspended_count++;
> +			genpd_unlock(gpd);
> +			genpd = gpd;
> +			break;
> +		}
> +	}
> +	mutex_unlock(&gpd_list_lock);
> +
> +	return genpd;

Instead of returning a pointer to generic_pm_domain to all
consumers (who are then free to poke around it) we should hide
all internal structures handled by the framework and only expose
some kind of a handle to all the consumers.
That would also mean having a clear split of the headers to
distinguish between what's accessible to consumers vs providers.

regards
Rajendra

> +}
> +EXPORT_SYMBOL(pm_genpd_get);
> +
> +/**
> + * pm_genpd_put - Put a generic I/O PM domain
> + * @genpd: Pointer to a PM domain.
> + */
> +void pm_genpd_put(struct generic_pm_domain *genpd)
> +{
> +	if (!genpd)
> +		return;
> +
> +	genpd_lock(genpd);
> +
> +	if (WARN_ON(!genpd->device_count || !genpd->suspended_count))
> +		goto out;
> +
> +	genpd->suspended_count--;
> +	genpd->device_count--;
> +
> +out:
> +	genpd_unlock(genpd);
> +}
> +EXPORT_SYMBOL(pm_genpd_put);
> +
> +/**
> + * pm_genpd_poweron - Power on a generic I/O PM domain
> + * @genpd: Pointer to a PM domain.
> + *
> + * Powers on a PM domain, if not already on, and decrements the
> + * 'suspended_count' to prevent the PM domain from being powered off.
> + */
> +int pm_genpd_poweron(struct generic_pm_domain *genpd)
> +{
> +	if (!genpd)
> +		return -EINVAL;
> +
> +	genpd_lock(genpd);
> +
> +	if (WARN_ON(!genpd->suspended_count))
> +		goto out;
> +
> +	genpd->suspended_count--;
> +	genpd_sync_power_on(genpd, true, 0);
> +
> +out:
> +	genpd_unlock(genpd);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(pm_genpd_poweron);
> +
> +/**
> + * pm_genpd_poweroff - Power off a generic I/O PM domain
> + * @genpd: Pointer to a PM domain.
> + *
> + * Increments the 'suspended_count' for a PM domain and if the
> + * 'suspended_count' equals the 'device_count' then will power
> + * off the PM domain.
> + */
> +int pm_genpd_poweroff(struct generic_pm_domain *genpd)
> +{
> +	if (!genpd)
> +		return -EINVAL;
> +
> +	genpd_lock(genpd);
> +
> +	if (WARN_ON(genpd->suspended_count >= genpd->device_count))
> +		goto out;
> +
> +	genpd->suspended_count++;
> +	genpd_sync_power_off(genpd, false, 0);
> +
> +out:
> +	genpd_unlock(genpd);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(pm_genpd_poweroff);
> +
>  #ifdef CONFIG_PM_GENERIC_DOMAINS_OF
>  
>  typedef struct generic_pm_domain *(*genpd_xlate_t)(struct of_phandle_args *args,
> @@ -2171,7 +2285,6 @@ int of_genpd_parse_idle_states(struct device_node *dn,
>  	return 0;
>  }
>  EXPORT_SYMBOL_GPL(of_genpd_parse_idle_states);
> -
>  #endif /* CONFIG_PM_GENERIC_DOMAINS_OF */
>  
>  
> @@ -2223,7 +2336,7 @@ static int pm_genpd_summary_one(struct seq_file *s,
>  	const char *kobj_path;
>  	struct gpd_link *link;
>  	char state[16];
> -	int ret;
> +	int ret, count;
>  
>  	ret = genpd_lock_interruptible(genpd);
>  	if (ret)
> @@ -2250,6 +2363,8 @@ static int pm_genpd_summary_one(struct seq_file *s,
>  			seq_puts(s, ", ");
>  	}
>  
> +	count = genpd->device_count;
> +
>  	list_for_each_entry(pm_data, &genpd->dev_list, list_node) {
>  		kobj_path = kobject_get_path(&pm_data->dev->kobj,
>  				genpd_is_irq_safe(genpd) ?
> @@ -2260,8 +2375,12 @@ static int pm_genpd_summary_one(struct seq_file *s,
>  		seq_printf(s, "\n    %-50s  ", kobj_path);
>  		rtpm_status_str(s, pm_data->dev);
>  		kfree(kobj_path);
> +		count--;
>  	}
>  
> +	if (count > 0)
> +		seq_printf(s, "\n    unknown (%d)", count);
> +
>  	seq_puts(s, "\n");
>  exit:
>  	genpd_unlock(genpd);
> diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
> index 5339ed5bd6f9..b3aa1f237d96 100644
> --- a/include/linux/pm_domain.h
> +++ b/include/linux/pm_domain.h
> @@ -143,6 +143,10 @@ extern int pm_genpd_remove_subdomain(struct generic_pm_domain *genpd,
>  extern int pm_genpd_init(struct generic_pm_domain *genpd,
>  			 struct dev_power_governor *gov, bool is_off);
>  extern int pm_genpd_remove(struct generic_pm_domain *genpd);
> +extern struct generic_pm_domain *pm_genpd_get(const char *name);
> +extern void pm_genpd_put(struct generic_pm_domain *genpd);
> +extern int pm_genpd_poweron(struct generic_pm_domain *genpd);
> +extern int pm_genpd_poweroff(struct generic_pm_domain *genpd);
>  
>  extern struct dev_power_governor simple_qos_governor;
>  extern struct dev_power_governor pm_domain_always_on_gov;
> @@ -182,6 +186,20 @@ static inline int pm_genpd_remove(struct generic_pm_domain *genpd)
>  {
>  	return -ENOTSUPP;
>  }
> +static inline struct generic_pm_domain *pm_genpd_get(const char *name)
> +{
> +	return ERR_PTR(-ENOTSUPP);
> +}
> +
> +static inline void pm_genpd_put(struct generic_pm_domain *genpd) {}
> +static inline int pm_genpd_poweron(struct generic_pm_domain *genpd)
> +{
> +	return -ENOTSUPP;
> +}
> +static inline int pm_genpd_poweroff(struct generic_pm_domain *genpd)
> +{
> +	return -ENOTSUPP;
> +}
>  
>  #define simple_qos_governor		(*(struct dev_power_governor *)(NULL))
>  #define pm_domain_always_on_gov		(*(struct dev_power_governor *)(NULL))
> 

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
