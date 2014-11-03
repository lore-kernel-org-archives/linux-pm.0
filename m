From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 03/12] PM / Domains: Add notifier support for power domain transitions
Date: Mon, 03 Nov 2014 15:54:05 +0100
Message-ID: <1651173.5xzCFxz3LI@vostro.rjw.lan>
References: <1414986790-11940-1-git-send-email-amit.daniel@samsung.com> <1414986790-11940-4-git-send-email-amit.daniel@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:61656 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752426AbaKCOdY (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 3 Nov 2014 09:33:24 -0500
In-Reply-To: <1414986790-11940-4-git-send-email-amit.daniel@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Amit Daniel Kachhap <amit.daniel@samsung.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org, kgene.kim@samsung.com, pankaj.dubey@samsung.com, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Kevin Hilman <khilman@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Ulf Hansson <ulf.hansson@linaro.org>

CC: Kevin, Ulf, Geert.

On Monday, November 03, 2014 09:23:01 AM Amit Daniel Kachhap wrote:
> These power domain transition notifiers will assist in carrying
> out some activity associated with domain power on/off such as
> some registers which may lose its contents and need save/restore
> across domain power off/on.
> 
> 4 type of notifications are added,
> GPD_OFF_PRE     - GPD state before power off
> GPD_OFF_POST    - GPD state after power off
> GPD_ON_PRE      - GPD state before power off
> GPD_ON_POST     - GPD state after power off
> 
> 3 notfication API's are exported.
> 1) int genpd_register_notifier(struct notifier_block *nb, char *pd_name);
> 2) int genpd_unregister_notifier(struct notifier_block *nb, char *pd_name);
> 3) void genpd_invoke_transition_notifier(struct generic_pm_domain *genpd,
> 			enum gpd_on_off_state state);
> 
> In this approach the notifiers are registered/unregistered with pd name.
> The actual invoking of the notfiers will be done by the platform implementing
> power domain enable/disable low level handlers according to the above
> defined notification types. This approach will considerably reduce the
> number of call to notifiers as compared to calling always from core
> powerdomain subsystem.
> 
> Also the registered domain's will be managed inside a cache list and not
> part of the genpd structure. This will help in registration of notifiers from
> subsystems (such as clock) even when the PD subsystem is still not initialised.
> This list also filters out the unregistered pd's requesting notification.
> 
> Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Reviewed-by: Pankaj Dubey <pankaj.dubey@samsung.com>
> Signed-off-by: Amit Daniel Kachhap <amit.daniel@samsung.com>
> ---
>  drivers/base/power/domain.c |  112 ++++++++++++++++++++++++++++++++++++++++++-
>  include/linux/pm_domain.h   |   31 ++++++++++++
>  2 files changed, 142 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
> index 40bc2f4..e05045e 100644
> --- a/drivers/base/power/domain.c
> +++ b/drivers/base/power/domain.c
> @@ -46,10 +46,19 @@
>  	__retval;								\
>  })
>  
> +struct cache_notify_domains {
> +	char *name;
> +	/* Node in the cache pm domain name list */
> +	struct list_head cache_list_node;
> +};
> +
>  static LIST_HEAD(gpd_list);
>  static DEFINE_MUTEX(gpd_list_lock);
> +static LIST_HEAD(domain_notify_list);
> +static DEFINE_MUTEX(domain_notify_list_lock);
> +static BLOCKING_NOTIFIER_HEAD(genpd_transition_notifier_list);
>  
> -static struct generic_pm_domain *pm_genpd_lookup_name(const char *domain_name)
> +struct generic_pm_domain *pm_genpd_lookup_name(const char *domain_name)
>  {
>  	struct generic_pm_domain *genpd = NULL, *gpd;
>  
> @@ -66,6 +75,7 @@ static struct generic_pm_domain *pm_genpd_lookup_name(const char *domain_name)
>  	mutex_unlock(&gpd_list_lock);
>  	return genpd;
>  }
> +EXPORT_SYMBOL_GPL(pm_genpd_lookup_name);
>  
>  struct generic_pm_domain *dev_to_genpd(struct device *dev)
>  {
> @@ -1908,6 +1918,106 @@ void pm_genpd_init(struct generic_pm_domain *genpd,
>  	mutex_unlock(&gpd_list_lock);
>  }
>  
> +/**
> + * genpd_register_notifier - Register a PM domain for future notification.
> + * @nb: notification block containing notification handle.
> + * @pd_name: PM domain name.
> + */
> +int genpd_register_notifier(struct notifier_block *nb, char *pd_name)
> +{
> +	int ret;
> +	struct cache_notify_domains *entry;
> +
> +	if (!pd_name)
> +		return -EINVAL;
> +
> +	/* Search if the pd is already registered */
> +	mutex_lock(&domain_notify_list_lock);
> +	list_for_each_entry(entry, &domain_notify_list, cache_list_node) {
> +		if (!strcmp(entry->name, pd_name))
> +			break;
> +	}
> +	mutex_unlock(&domain_notify_list_lock);
> +
> +	if (entry) {
> +		pr_err("%s: pd already exists\n", __func__);
> +		return -EINVAL;
> +	}
> +
> +	entry = kzalloc(sizeof(*entry), GFP_KERNEL);
> +	if (!entry)
> +		return -ENOMEM;
> +
> +	entry->name = pd_name;
> +
> +	mutex_lock(&domain_notify_list_lock);
> +	list_add(&entry->cache_list_node, &domain_notify_list);
> +	mutex_unlock(&domain_notify_list_lock);
> +	ret = blocking_notifier_chain_register(
> +				&genpd_transition_notifier_list, nb);
> +	return ret;
> +}
> +
> +/**
> + * genpd_unregister_notifier - Un-register a PM domain for future notification.
> + * @nb: notification block containing notification handle.
> + * @pd_name: PM domain name.
> + */
> +int genpd_unregister_notifier(struct notifier_block *nb, char *pd_name)
> +{
> +	int ret;
> +	struct cache_notify_domains *entry;
> +
> +	mutex_lock(&domain_notify_list_lock);
> +	list_for_each_entry(entry, &domain_notify_list, cache_list_node) {
> +		if (!strcmp(entry->name, pd_name))
> +			break;
> +	}
> +	if (!entry) {
> +		mutex_unlock(&domain_notify_list_lock);
> +		pr_err("%s: Invalid pd name\n", __func__);
> +		return -EINVAL;
> +	}
> +	list_del(&entry->cache_list_node);
> +	mutex_unlock(&domain_notify_list_lock);
> +	ret = blocking_notifier_chain_unregister(
> +				&genpd_transition_notifier_list, nb);
> +	return ret;
> +}
> +
> +/**
> + * genpd_invoke_transition_notifier - Calls the matching notification handler.
> + * @genpd: generic power domain structure.
> + * @state: can be of type - GPD_OFF_PRE/GPD_OFF_POST/GPD_ON_PRE/GPD_ON_POST.
> + */
> +void genpd_invoke_transition_notifier(struct generic_pm_domain *genpd,
> +			enum gpd_on_off_state state)
> +{
> +	struct cache_notify_domains *entry;
> +
> +	if (!genpd) {
> +		pr_err("Invalid genpd parameter\n");
> +		return;
> +	}
> +
> +	if (state != GPD_OFF_PRE || state != GPD_OFF_POST
> +			|| state != GPD_ON_PRE || state != GPD_ON_POST) {
> +		pr_err("Invalid state parameter\n");
> +		return;
> +	}
> +
> +	mutex_lock(&domain_notify_list_lock);
> +	list_for_each_entry(entry, &domain_notify_list, cache_list_node) {
> +		if (!strcmp(entry->name, genpd->name))
> +			break;
> +	}
> +	mutex_unlock(&domain_notify_list_lock);
> +	if (!entry) /* Simply ignore */
> +		return;
> +
> +	blocking_notifier_call_chain(&genpd_transition_notifier_list, state,
> +				genpd);
> +}
>  #ifdef CONFIG_PM_GENERIC_DOMAINS_OF
>  /*
>   * Device Tree based PM domain providers.
> diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
> index 73e938b..659997f 100644
> --- a/include/linux/pm_domain.h
> +++ b/include/linux/pm_domain.h
> @@ -25,6 +25,13 @@ enum gpd_status {
>  	GPD_STATE_POWER_OFF,	/* PM domain is off */
>  };
>  
> +enum gpd_on_off_state {
> +	GPD_OFF_PRE = 0,	/* GPD state before power off */
> +	GPD_OFF_POST,		/* GPD state after power off */
> +	GPD_ON_PRE,		/* GPD state before power on */
> +	GPD_ON_POST,		/* GPD state after power on */
> +};
> +
>  struct dev_power_governor {
>  	bool (*power_down_ok)(struct dev_pm_domain *domain);
>  	bool (*stop_ok)(struct device *dev);
> @@ -148,6 +155,12 @@ extern int pm_genpd_name_poweron(const char *domain_name);
>  
>  extern struct dev_power_governor simple_qos_governor;
>  extern struct dev_power_governor pm_domain_always_on_gov;
> +
> +struct generic_pm_domain *pm_genpd_lookup_name(const char *domain_name);
> +int genpd_register_notifier(struct notifier_block *nb, char *pd_name);
> +int genpd_unregister_notifier(struct notifier_block *nb, char *pd_name);
> +void genpd_invoke_transition_notifier(struct generic_pm_domain *genpd,
> +			enum gpd_on_off_state state);
>  #else
>  
>  static inline struct generic_pm_domain_data *dev_gpd_data(struct device *dev)
> @@ -219,6 +232,24 @@ static inline int pm_genpd_name_poweron(const char *domain_name)
>  {
>  	return -ENOSYS;
>  }
> +static inline struct
> +generic_pm_domain *pm_genpd_lookup_name(const char *domain_name)
> +{
> +	return NULL;
> +}
> +static inline int
> +genpd_register_notifier(struct notifier_block *nb, char *pd_name)
> +{
> +	return 0;
> +}
> +static inline int
> +genpd_unregister_notifier(struct notifier_block *nb, char *pd_name)
> +{
> +	return 0;
> +}
> +static inline void
> +genpd_invoke_transition_notifier(struct generic_pm_domain *genpd,
> +			enum gpd_on_off_state state) { }
>  #define simple_qos_governor NULL
>  #define pm_domain_always_on_gov NULL
>  #endif
> 

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
