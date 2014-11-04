From: amit daniel kachhap <amit.daniel@samsung.com>
Subject: Re: [PATCH 03/12] PM / Domains: Add notifier support for power domain transitions
Date: Tue, 4 Nov 2014 11:46:21 +0530
Message-ID: <CADGdYn6TiXmric5Jzm-38KSmU0iV=9Zxg2wWKL-Ydy1bwxxfDA@mail.gmail.com>
References: <1414986790-11940-1-git-send-email-amit.daniel@samsung.com>
	<1414986790-11940-4-git-send-email-amit.daniel@samsung.com>
	<5457C791.1000904@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <5457C791.1000904@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Sylwester Nawrocki <s.nawrocki@samsung.com>
Cc: Kukjin Kim <kgene.kim@samsung.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, pankaj.dubey@samsung.com, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, Beata Michalska <b.michalska@samsung.com>, LAK <linux-arm-kernel@lists.infradead.org>
List-Id: linux-pm@vger.kernel.org

On Mon, Nov 3, 2014 at 11:51 PM, Sylwester Nawrocki
<s.nawrocki@samsung.com> wrote:
> Hi,
>
> Cc: Ulf, Kevin, Geert.
>
> On 03/11/14 04:53, Amit Daniel Kachhap wrote:
>> These power domain transition notifiers will assist in carrying
>> out some activity associated with domain power on/off such as
>> some registers which may lose its contents and need save/restore
>> across domain power off/on.
>
> Other specific use cases I could add here is gating selected clocks
> to ensure proper signal propagation for devices attached to a power
> domain, e.g. ungating selected clocks before the power domain on and
> restoring them to previous state after the power domain was switched
> on.
yes correct.
>
>> 4 type of notifications are added,
>> GPD_OFF_PRE     - GPD state before power off
>> GPD_OFF_POST    - GPD state after power off
>> GPD_ON_PRE      - GPD state before power off
>> GPD_ON_POST     - GPD state after power off
>>
>> 3 notfication API's are exported.
>> 1) int genpd_register_notifier(struct notifier_block *nb, char *pd_name);
>> 2) int genpd_unregister_notifier(struct notifier_block *nb, char *pd_name);
>> 3) void genpd_invoke_transition_notifier(struct generic_pm_domain *genpd,
>>                       enum gpd_on_off_state state);
>>
>> In this approach the notifiers are registered/unregistered with pd name.
>> The actual invoking of the notfiers will be done by the platform implementing
>> power domain enable/disable low level handlers according to the above
>> defined notification types. This approach will considerably reduce the
>> number of call to notifiers as compared to calling always from core
>> powerdomain subsystem.
>>
>> Also the registered domain's will be managed inside a cache list and not
>> part of the genpd structure. This will help in registration of notifiers from
>> subsystems (such as clock) even when the PD subsystem is still not initialised.
>> This list also filters out the unregistered pd's requesting notification.
>
> This patch is somewhat similar my patch adding power domain state change
> notifications [1].  I have already a reworked version of that patch, with the
> notifier list moved to struct generic_pm_domain and using genpd->lock instead

Yes this will be correct as others also suggested to make per genpd
notifier block.

> of dev->power.lock.  Anyway, while I'd leave the decision about the location
> from where the notifier chains are supposed to be called to the subsystem's
> maintainers preference, I'm rather reluctant to having one global notifiers
> list for all possible power domains and all the notification clients.
> The possibly long list needs to be traversed at each notifier call and it
> seems in your implementation any registered user of the notification gets
> notifications for all possible power domains.
>
> [1] https://lkml.org/lkml/2014/8/5/182
My fault, I somehow missed this link earlier. After going through
this, I found it registers genpd from the platform driver, so the
function signature is
int pm_genpd_register_notifier(struct device *dev, struct notifier_block *nb);
I suggest to make the function signature to be like,
int pm_genpd_register_notifier(struct device_node *np, struct
notifier_block *nb)

In this way this function should should be able to support both
platform devices and non platform devices like clk.

The function may work like,

pdev = of_find_device_by_node(np);
if (pdev) {
         //  get genpd from device and go ahead with notfier registration.
         // blocking_notifier_chain_register(genpd->pd_notifier, nb)
} else
{
        // get pd_handle from np
        // get the pd_name from phandle and try registering this gen pd
        // if the genpd subsystem is not initialised then add this in
a temporary list and register the notifier later
}

Can you post your implementation with 1st part ? Later I can post the
else part with my changes.

>
>> Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>> Reviewed-by: Pankaj Dubey <pankaj.dubey@samsung.com>
>> Signed-off-by: Amit Daniel Kachhap <amit.daniel@samsung.com>
>> ---
>>  drivers/base/power/domain.c |  112 ++++++++++++++++++++++++++++++++++++++++++-
>>  include/linux/pm_domain.h   |   31 ++++++++++++
>>  2 files changed, 142 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
>> index 40bc2f4..e05045e 100644
>> --- a/drivers/base/power/domain.c
>> +++ b/drivers/base/power/domain.c
>> @@ -46,10 +46,19 @@
>>       __retval;                                                               \
>>  })
>>
>> +struct cache_notify_domains {
>> +     char *name;
>> +     /* Node in the cache pm domain name list */
>> +     struct list_head cache_list_node;
>> +};
>> +
>>  static LIST_HEAD(gpd_list);
>>  static DEFINE_MUTEX(gpd_list_lock);
>> +static LIST_HEAD(domain_notify_list);
>> +static DEFINE_MUTEX(domain_notify_list_lock);
>> +static BLOCKING_NOTIFIER_HEAD(genpd_transition_notifier_list);
>>
>> -static struct generic_pm_domain *pm_genpd_lookup_name(const char *domain_name)
>> +struct generic_pm_domain *pm_genpd_lookup_name(const char *domain_name)
>>  {
>>       struct generic_pm_domain *genpd = NULL, *gpd;
>>
>> @@ -66,6 +75,7 @@ static struct generic_pm_domain *pm_genpd_lookup_name(const char *domain_name)
>>       mutex_unlock(&gpd_list_lock);
>>       return genpd;
>>  }
>> +EXPORT_SYMBOL_GPL(pm_genpd_lookup_name);
>>
>>  struct generic_pm_domain *dev_to_genpd(struct device *dev)
>>  {
>> @@ -1908,6 +1918,106 @@ void pm_genpd_init(struct generic_pm_domain *genpd,
>>       mutex_unlock(&gpd_list_lock);
>>  }
>>
>> +/**
>> + * genpd_register_notifier - Register a PM domain for future notification.
>> + * @nb: notification block containing notification handle.
>> + * @pd_name: PM domain name.
>> + */
>> +int genpd_register_notifier(struct notifier_block *nb, char *pd_name)
>> +{
>> +     int ret;
>> +     struct cache_notify_domains *entry;
>> +
>> +     if (!pd_name)
>> +             return -EINVAL;
>> +
>> +     /* Search if the pd is already registered */
>> +     mutex_lock(&domain_notify_list_lock);
>> +     list_for_each_entry(entry, &domain_notify_list, cache_list_node) {
>> +             if (!strcmp(entry->name, pd_name))
>> +                     break;
>> +     }
>> +     mutex_unlock(&domain_notify_list_lock);
>> +
>> +     if (entry) {
>> +             pr_err("%s: pd already exists\n", __func__);
>> +             return -EINVAL;
>
> I suspect this code doesn't work as expected. 'entry' will be NULL only
> in case of an empty domain_notify_list list. Have you tested multiple
> calls to genpd_register_notifier() ? It looks like only the first call
> would work.
Yes this list check is not correct. Will update this. Thanks.
>
>> +     }
>> +
>> +     entry = kzalloc(sizeof(*entry), GFP_KERNEL);
>> +     if (!entry)
>> +             return -ENOMEM;
>> +
>> +     entry->name = pd_name;
>> +
>> +     mutex_lock(&domain_notify_list_lock);
>> +     list_add(&entry->cache_list_node, &domain_notify_list);
>> +     mutex_unlock(&domain_notify_list_lock);
>> +     ret = blocking_notifier_chain_register(
>> +                             &genpd_transition_notifier_list, nb);
>> +     return ret;
>> +}
>> +
>> +/**
>> + * genpd_unregister_notifier - Un-register a PM domain for future notification.
>> + * @nb: notification block containing notification handle.
>> + * @pd_name: PM domain name.
>> + */
>> +int genpd_unregister_notifier(struct notifier_block *nb, char *pd_name)
>> +{
>> +     int ret;
>> +     struct cache_notify_domains *entry;
>> +
>> +     mutex_lock(&domain_notify_list_lock);
>> +     list_for_each_entry(entry, &domain_notify_list, cache_list_node) {
>> +             if (!strcmp(entry->name, pd_name))
>> +                     break;
>> +     }
>> +     if (!entry) {
>> +             mutex_unlock(&domain_notify_list_lock);
>> +             pr_err("%s: Invalid pd name\n", __func__);
>> +             return -EINVAL;
>> +     }
>> +     list_del(&entry->cache_list_node);
>
> 'entry' will not be NULL even when the requested notification entry
> was not found above. In such case it looks like last entry in the
> domain_notify_list list will be removed, not something we would expect.
>
>> +     mutex_unlock(&domain_notify_list_lock);
>> +     ret = blocking_notifier_chain_unregister(
>> +                             &genpd_transition_notifier_list, nb);
>> +     return ret;
>> +}
>> +
>> +/**
>> + * genpd_invoke_transition_notifier - Calls the matching notification handler.
>> + * @genpd: generic power domain structure.
>> + * @state: can be of type - GPD_OFF_PRE/GPD_OFF_POST/GPD_ON_PRE/GPD_ON_POST.
>> + */
>> +void genpd_invoke_transition_notifier(struct generic_pm_domain *genpd,
>> +                     enum gpd_on_off_state state)
>> +{
>> +     struct cache_notify_domains *entry;
>> +
>> +     if (!genpd) {
>> +             pr_err("Invalid genpd parameter\n");
>> +             return;
>> +     }
>> +
>> +     if (state != GPD_OFF_PRE || state != GPD_OFF_POST
>> +                     || state != GPD_ON_PRE || state != GPD_ON_POST) {
>> +             pr_err("Invalid state parameter\n");
>> +             return;
>> +     }
>> +
>> +     mutex_lock(&domain_notify_list_lock);
>> +     list_for_each_entry(entry, &domain_notify_list, cache_list_node) {
>> +             if (!strcmp(entry->name, genpd->name))
>> +                     break;
>> +     }
>> +     mutex_unlock(&domain_notify_list_lock);
>> +     if (!entry) /* Simply ignore */
>
> Similar issue here, this condition will only be true when the notifications
> list is empty.
>
>> +             return;
>> +
>> +     blocking_notifier_call_chain(&genpd_transition_notifier_list, state,
>> +                             genpd);
>
> And finally regardless of to what power domain the notification user has
> registered it will get notification for each possible power domain in
> the system?  Are the notification users supposed to test the 'genpd'
> argument to react on a specific power domain? If so, how? I guess not by
> nother strcmp() ?
>
>> +}
>>  #ifdef CONFIG_PM_GENERIC_DOMAINS_OF
>>  /*
>>   * Device Tree based PM domain providers.
>> diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
>> index 73e938b..659997f 100644
>> --- a/include/linux/pm_domain.h
>> +++ b/include/linux/pm_domain.h
>> @@ -25,6 +25,13 @@ enum gpd_status {
>>       GPD_STATE_POWER_OFF,    /* PM domain is off */
>>  };
>>
>> +enum gpd_on_off_state {
>> +     GPD_OFF_PRE = 0,        /* GPD state before power off */
>
> The assignment is not needed.
yes correct.

Regards,
Amit
>
>> +     GPD_OFF_POST,           /* GPD state after power off */
>> +     GPD_ON_PRE,             /* GPD state before power on */
>> +     GPD_ON_POST,            /* GPD state after power on */
>> +};
>> +
>>  struct dev_power_governor {
>>       bool (*power_down_ok)(struct dev_pm_domain *domain);
>>       bool (*stop_ok)(struct device *dev);
>> @@ -148,6 +155,12 @@ extern int pm_genpd_name_poweron(const char *domain_name);
>
> --
> Regards,
> Sylwester
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
