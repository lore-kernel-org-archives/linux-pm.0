From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: Re: [PATCH] powercap: add suspend and resume mechanism for SOC
 power limit
Date: Tue, 09 Jan 2018 17:47:10 -0800
Message-ID: <1515548830.69545.28.camel@linux.intel.com>
References: <1515544703-19409-1-git-send-email-xinx.sun@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1515544703-19409-1-git-send-email-xinx.sun@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: xinx.sun@intel.com, rjw@rjwysocki.net, jacob.jun.pan@linux.intel.com
Cc: zhen.han@intel.com, chaox.m.wang@intel.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Wed, 2018-01-10 at 08:38 +0800, xinx.sun@intel.com wrote:
> From: Zhen Han <zhen.han@intel.com>
> 
> PL1 and PL2 could be throlled or de-throttled by
> Thermal management to control SOC temperature.
> However, currently, their value will be reset to default value
> after once system suspend and resume.
> Add pm_notifier to save PL1, PL2 before system suspect and restore
> PL1, PL2 after system resume.
> 
Why are you posting this patch again?
If there any change from your prior post?

Thanks,
Srinivas

> Signed-off-by: Zhen Han <zhen.han@intel.com>
> ---
>  drivers/powercap/intel_rapl.c | 97
> +++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 97 insertions(+)
> 
> diff --git a/drivers/powercap/intel_rapl.c
> b/drivers/powercap/intel_rapl.c
> index d1694f1..0188cff 100644
> --- a/drivers/powercap/intel_rapl.c
> +++ b/drivers/powercap/intel_rapl.c
> @@ -29,6 +29,7 @@
>  #include <linux/sysfs.h>
>  #include <linux/cpu.h>
>  #include <linux/powercap.h>
> +#include <linux/suspend.h>
>  #include <asm/iosf_mbi.h>
>  
>  #include <asm/processor.h>
> @@ -155,6 +156,7 @@ struct rapl_power_limit {
>  	int prim_id; /* primitive ID used to enable */
>  	struct rapl_domain *domain;
>  	const char *name;
> +	u64 last_power_limit;
>  };
>  
>  static const char pl1_name[] = "long_term";
> @@ -1533,6 +1535,92 @@ static int rapl_cpu_down_prep(unsigned int
> cpu)
>  
>  static enum cpuhp_state pcap_rapl_online;
>  
> +static void power_limit_state_save(void)
> +{
> +	struct rapl_package *rp;
> +	struct rapl_domain *rd;
> +	int nr_pl, ret, i;
> +
> +	get_online_cpus();
> +	list_for_each_entry(rp, &rapl_packages, plist) {
> +		if (!rp->power_zone)
> +			continue;
> +		rd = power_zone_to_rapl_domain(rp->power_zone);
> +		nr_pl = find_nr_power_limit(rd);
> +		for (i = 0; i < nr_pl; i++) {
> +			switch (rd->rpl[i].prim_id) {
> +			case PL1_ENABLE:
> +				ret = rapl_read_data_raw(rd,
> +						POWER_LIMIT1,
> +						true,
> +						&rd-
> >rpl[i].last_power_limit);
> +				if (ret)
> +					rd->rpl[i].last_power_limit
> = 0;
> +				break;
> +			case PL2_ENABLE:
> +				ret = rapl_read_data_raw(rd,
> +						POWER_LIMIT2,
> +						true,
> +						&rd-
> >rpl[i].last_power_limit);
> +				if (ret)
> +					rd->rpl[i].last_power_limit
> = 0;
> +				break;
> +			}
> +		}
> +	}
> +	put_online_cpus();
> +}
> +
> +static void power_limit_state_restore(void)
> +{
> +	struct rapl_package *rp;
> +	struct rapl_domain *rd;
> +	int nr_pl, i;
> +
> +	get_online_cpus();
> +	list_for_each_entry(rp, &rapl_packages, plist) {
> +		if (!rp->power_zone)
> +			continue;
> +		rd = power_zone_to_rapl_domain(rp->power_zone);
> +		nr_pl = find_nr_power_limit(rd);
> +		for (i = 0; i < nr_pl; i++) {
> +			switch (rd->rpl[i].prim_id) {
> +			case PL1_ENABLE:
> +				if (rd->rpl[i].last_power_limit)
> +					rapl_write_data_raw(rd,
> +						POWER_LIMIT1,
> +						rd-
> >rpl[i].last_power_limit);
> +				break;
> +			case PL2_ENABLE:
> +				if (rd->rpl[i].last_power_limit)
> +					rapl_write_data_raw(rd,
> +						POWER_LIMIT2,
> +						rd-
> >rpl[i].last_power_limit);
> +				break;
> +			}
> +		}
> +	}
> +	put_online_cpus();
> +}
> +
> +static int rapl_pm_callback(struct notifier_block *nb,
> +	unsigned long mode, void *_unused)
> +{
> +	switch (mode) {
> +	case PM_SUSPEND_PREPARE:
> +		power_limit_state_save();
> +		break;
> +	case PM_POST_SUSPEND:
> +		power_limit_state_restore();
> +		break;
> +	}
> +	return NOTIFY_OK;
> +}
> +
> +static struct notifier_block rapl_pm_notifier = {
> +	.notifier_call = rapl_pm_callback,
> +};
> +
>  static int __init rapl_init(void)
>  {
>  	const struct x86_cpu_id *id;
> @@ -1560,8 +1648,16 @@ static int __init rapl_init(void)
>  
>  	/* Don't bail out if PSys is not supported */
>  	rapl_register_psys();
> +
> +	ret = register_pm_notifier(&rapl_pm_notifier);
> +	if (ret)
> +		goto err_unreg_all;
> +
>  	return 0;
>  
> +err_unreg_all:
> +	cpuhp_remove_state(pcap_rapl_online);
> +
>  err_unreg:
>  	rapl_unregister_powercap();
>  	return ret;
> @@ -1569,6 +1665,7 @@ static int __init rapl_init(void)
>  
>  static void __exit rapl_exit(void)
>  {
> +	unregister_pm_notifier(&rapl_pm_notifier);
>  	cpuhp_remove_state(pcap_rapl_online);
>  	rapl_unregister_powercap();
>  }
