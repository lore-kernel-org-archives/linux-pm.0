From: Lina Iyer <lina.iyer@linaro.org>
Subject: Re: [PATCH RFC 2/3] PM / Domains: Support atomic PM domains
Date: Thu, 11 Jun 2015 13:47:09 -0600
Message-ID: <20150611194709.GD1103@linaro.org>
References: <1433456946-53296-1-git-send-email-lina.iyer@linaro.org>
 <1433456946-53296-3-git-send-email-lina.iyer@linaro.org>
 <CAPDyKFqqQS+-0guT4+vZ9Y38ztxPeEgENLy_yqFts09z0ZwgJA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f176.google.com ([209.85.192.176]:36820 "EHLO
	mail-pd0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754756AbbFKTrN (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 11 Jun 2015 15:47:13 -0400
Received: by pdjm12 with SMTP id m12so9345646pdj.3
        for <linux-pm@vger.kernel.org>; Thu, 11 Jun 2015 12:47:13 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAPDyKFqqQS+-0guT4+vZ9Y38ztxPeEgENLy_yqFts09z0ZwgJA@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@linaro.org>, Mathieu Poirier <mathieu.poirier@linaro.org>, Kumar Gala <galak@codeaurora.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, msivasub@codeaurora.org, Andy Gross <agross@codeaurora.org>

On Thu, Jun 11 2015 at 03:41 -0600, Ulf Hansson wrote:
>On 5 June 2015 at 00:29, Lina Iyer <lina.iyer@linaro.org> wrote:
>> Power Domains currently support turning on/off only in process context.
>> This restricts the usage of PM domains to devices and domains that
>> could be powered on/off in irq disabled contexts as the mutexes used in
>> GenPD allows for cpu sleep while waiting for locks.
>>
>> Genpd inherently provides support for devices, domain hierarchy and can
>> be used to represent cpu clusters like in ARM's big.Little, where, each
>> cpu cluster is in its domain, with supporting caches and other
>> peripheral hardware. Multiple such domains could be part of another
>> domain. Because mutexes are used to protect and synchronize domain
>> operations and cpu idle operations are inherently atomic, the use of
>> genpd is not possible for runtime suspend and resume of the pm domain.
>> Replacing the locks to spinlocks would allow cpu domain to be be powered
>> off to save power, when all the cpus are powered off.
>>
>> However, not all domains can operate in irq-safe contexts and usually
>> would need to sleep during domain operations. So genpd has to support
>> both the cases, where the domain is or is not irq-safe. The irq-safe
>> attribute is therefore domain specific.
>>
>> To achieve domain specific locking, set the GENPD_FLAG_IRQ_SAFE flag
>> while defining the domain. This determines if the domain should use a
>> spinlock instead of a mutex. Locking is abstracted through
>> genpd_lock_domain() and genpd_unlock_domain() functions that use the
>> flag to determine the locking to be used for this domain.
>>
>> The restriction this imposes on the domain hierarchy is that subdomains
>> and all devices in the hierarchy also be irq-safe. Non irq-safe domains
>> may continue to have irq-safe devices, but not the other way around.
>>
>> Cc: Ulf Hansson <ulf.hansson@linaro.org>
>> Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
>> Cc: Kevin Hilman <khilman@linaro.org>
>> Signed-off-by: Lina Iyer <lina.iyer@linaro.org>
>> ---
>>  drivers/base/power/domain.c | 200 ++++++++++++++++++++++++++++++++++----------
>>  include/linux/pm_domain.h   |  11 ++-
>>  2 files changed, 164 insertions(+), 47 deletions(-)
>>
>> diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
>> index dfd7595..8b89d15 100644
>> --- a/drivers/base/power/domain.c
>> +++ b/drivers/base/power/domain.c
>> @@ -50,6 +50,71 @@
>>  static LIST_HEAD(gpd_list);
>>  static DEFINE_MUTEX(gpd_list_lock);
>>
>> +static inline int genpd_lock_domain_noirq(struct generic_pm_domain *genpd,
>
>Nitpick:
>
>I would prefer a bit shorter names of all these new locking functions.
>In general, I think you can remove "domain" from the names. In this
>case it would mean genpd_lock_noirq().
>
Done.

>> +                                       unsigned int subclass)
>> +       __acquires(&genpd->slock)
>> +{
>> +       unsigned long flags;
>> +
>> +       if (unlikely(subclass > 0))
>> +               spin_lock_irqsave_nested(&genpd->slock, flags, subclass);
>> +       else
>> +               spin_lock_irqsave(&genpd->slock, flags);
>> +
>> +       genpd->flags = flags;
>
>This is wrong, it should be genpd->lock_flags that you assign.
>
Argh. My bad. Fixed.

>BTW, can't you assign the genpd->lock_flags immediately when call
>spin_lock_irqsave*(), instead of keeping a local copy?
>
I vaguely remember reading that in some architecture you needed to use a
stack variable to save the IRQ state . I cant seem to find it now.
I can change it.

>> +
>> +       return 0;
>> +}
>> +
>> +static inline int genpd_unlock_domain_noirq(struct generic_pm_domain *genpd)
>> +       __releases(&genpd->slock)
>> +{
>> +       spin_unlock_irqrestore(&genpd->slock, genpd->lock_flags);
>> +       return 0;
>> +}
>> +
>> +static inline int genpd_lock_domain_irq(struct generic_pm_domain *genpd,
>> +                                       unsigned int subclass)
>> +       __acquires(&genpd->mlock)
>> +{
>> +       if (unlikely(subclass > 0))
>> +               mutex_lock_nested(&genpd->mlock, subclass);
>> +       else
>> +               mutex_lock(&genpd->mlock);
>> +
>> +       return 0;
>> +}
>> +
>> +static inline int genpd_lock_domain_interruptible_irq(
>> +                               struct generic_pm_domain *genpd)
>> +       __acquires(&genpd->mlock)
>> +{
>> +       return mutex_lock_interruptible(&genpd->mlock);
>> +}
>> +
>> +static inline int genpd_unlock_domain_irq(struct generic_pm_domain *genpd)
>> +       __releases(&genpd->mlock)
>> +{
>> +       mutex_unlock(&genpd->mlock);
>> +       return 0;
>> +}
>> +
>> +#define genpd_lock_domain(genpd)                               \
>> +       (genpd->irq_safe ? genpd_lock_domain_noirq(genpd, 0)    \
>> +                       : genpd_lock_domain_irq(genpd, 0))
>> +
>> +#define genpd_lock_domain_nested(genpd)                                \
>> +       (genpd->irq_safe ? genpd_lock_domain_noirq(genpd, SINGLE_DEPTH_NESTING)\
>> +                       : genpd_lock_domain_irq(genpd, SINGLE_DEPTH_NESTING))
>> +
>> +#define genpd_unlock_domain(genpd)                             \
>> +       (genpd->irq_safe ? genpd_unlock_domain_noirq(genpd)     \
>> +                       : genpd_unlock_domain_irq(genpd))
>> +
>> +#define genpd_lock_domain_interruptible(genpd)                 \
>> +       (genpd->irq_safe ? genpd_lock_domain_noirq(genpd, 0)    \
>> +                       : genpd_lock_domain_interruptible_irq(genpd))
>
>In general I don't like macros (as Krzysztof).
>
>In this case I also don't see the benfit, could you consider to
>convert to in-line functions instead?
>
Done. Since I have no strong preference either way, I will change this
to inline functions.

>> +
>>  static struct generic_pm_domain *pm_genpd_lookup_name(const char *domain_name)
>>  {
>>         struct generic_pm_domain *genpd = NULL, *gpd;
>> @@ -262,9 +327,9 @@ int pm_genpd_poweron(struct generic_pm_domain *genpd)
>>  {
>>         int ret;
>>
>> -       mutex_lock(&genpd->lock);
>> +       genpd_lock_domain(genpd);
>>         ret = __pm_genpd_poweron(genpd);
>> -       mutex_unlock(&genpd->lock);
>> +       genpd_unlock_domain(genpd);
>>         return ret;
>>  }
>>
>> @@ -326,9 +391,9 @@ static int genpd_dev_pm_qos_notifier(struct notifier_block *nb,
>>                 spin_unlock_irq(&dev->power.lock);
>>
>>                 if (!IS_ERR(genpd)) {
>> -                       mutex_lock(&genpd->lock);
>> +                       genpd_lock_domain(genpd);
>>                         genpd->max_off_time_changed = true;
>> -                       mutex_unlock(&genpd->lock);
>> +                       genpd_unlock_domain(genpd);
>>                 }
>>
>>                 dev = dev->parent;
>> @@ -387,7 +452,7 @@ static int pm_genpd_poweroff(struct generic_pm_domain *genpd)
>>                         return -EBUSY;
>>
>>                 if (pdd->dev->driver && (!pm_runtime_suspended(pdd->dev)
>> -                   || pdd->dev->power.irq_safe))
>> +                       || (pdd->dev->power.irq_safe && !genpd->irq_safe)))
>
>This deserves a comment in the code.
>
This check should simplify to
		if (!pm_runtime_suspended(pdd->dev))

The other connditions seem unnecessary just to determine if the devices are
suspended.

Do you see any problem with that?

>>                         not_suspended++;
>>         }
>>
>> @@ -453,9 +518,9 @@ static void genpd_power_off_work_fn(struct work_struct *work)
>>
>>         genpd = container_of(work, struct generic_pm_domain, power_off_work);
>>
>> -       mutex_lock(&genpd->lock);
>> +       genpd_lock_domain(genpd);
>>         pm_genpd_poweroff(genpd);
>> -       mutex_unlock(&genpd->lock);
>> +       genpd_unlock_domain(genpd);
>>  }
>>
>>  /**
>> @@ -478,12 +543,8 @@ static int pm_genpd_runtime_suspend(struct device *dev)
>>         if (IS_ERR(genpd))
>>                 return -EINVAL;
>>
>> -       /*
>> -        * We can't allow to power off the PM domain if it holds an irq_safe
>> -        * device. That's beacuse we use mutexes to protect data while power
>> -        * off and on the PM domain, thus we can't execute in atomic context.
>> -        */
>> -       if (dev->power.irq_safe)
>> +       /* We can't allow to power off a domain that is also not irq safe. */
>
>I wouldn't mind to keep some more pieces of the earlier comment, since
>it explains a bit more of the *why*. Could you try to rephrase this
>comment in that regard?
>
>> +       if (dev->power.irq_safe && !genpd->irq_safe)
>
>This looks correct...
>
Apparently not the best place to check this. We should still allow
runtime suspend of the device, irrespective of whether the domain is IRQ
safe or not and this check here is incorrect.

>>                 return -EBUSY;
>>
>>         stop_ok = genpd->gov ? genpd->gov->stop_ok : NULL;
>> @@ -500,11 +561,19 @@ static int pm_genpd_runtime_suspend(struct device *dev)
>>                 return ret;
>>         }
>>
>> -       mutex_lock(&genpd->lock);
>> +       /*
>> +        * If power.irq_safe is set, this routine will be run with interrupts
>> +        * off, so suspend only if the power domain is irq_safe.
>> +        */
>> +       if (dev->power.irq_safe && !genpd->irq_safe)
>> +               return 0;
>
>... but this doesn't. You have already returned -EBUSY above for this case.
>
This is probably more appropriate, as we want to skip locking the
domain, because it may be in atomic context and the domain may use
mutexes to lock.

I feel like, we miss out an opportunity here to power off the domain, if
device is IRQ safe while the domain is not, but the function is called
from a process context. I am not sure how to check that correctly, yet.

>> +
>> +       genpd_lock_domain(genpd);
>> +
>>         genpd->in_progress++;
>>         pm_genpd_poweroff(genpd);
>>         genpd->in_progress--;
>> -       mutex_unlock(&genpd->lock);
>> +       genpd_unlock_domain(genpd);
>>
>>         return 0;
>>  }
>> @@ -528,13 +597,16 @@ static int pm_genpd_runtime_resume(struct device *dev)
>>         if (IS_ERR(genpd))
>>                 return -EINVAL;
>>
>> -       /* If power.irq_safe, the PM domain is never powered off. */
>> -       if (dev->power.irq_safe)
>> +       /*
>> +        * If power.irq_safe and domain is not, then
>
>Let's take the opportunity to rephrase this comment a bit.
>
>Perhaps something along the lines: "As we don't power off a non IRQ
>safe PM domain which holds an IRQ safe device, we don't need to
>restore the power to it."
>
Done. Makes sense.

>> +        * the PM domain is never powered off.
>> +        */
>> +       if (dev->power.irq_safe && !genpd->irq_safe)
>>                 return genpd_start_dev_no_timing(genpd, dev);
>>
>> -       mutex_lock(&genpd->lock);
>> +       genpd_lock_domain(genpd);
>>         ret = __pm_genpd_poweron(genpd);
>> -       mutex_unlock(&genpd->lock);
>> +       genpd_unlock_domain(genpd);
>>
>>         if (ret)
>>                 return ret;
>> @@ -729,14 +801,14 @@ static int pm_genpd_prepare(struct device *dev)
>>         if (resume_needed(dev, genpd))
>>                 pm_runtime_resume(dev);
>>
>> -       mutex_lock(&genpd->lock);
>> +       genpd_lock_domain(genpd);
>>
>>         if (genpd->prepared_count++ == 0) {
>>                 genpd->suspended_count = 0;
>>                 genpd->suspend_power_off = genpd->status == GPD_STATE_POWER_OFF;
>>         }
>>
>> -       mutex_unlock(&genpd->lock);
>> +       genpd_unlock_domain(genpd);
>>
>>         if (genpd->suspend_power_off) {
>>                 pm_runtime_put_noidle(dev);
>> @@ -754,12 +826,12 @@ static int pm_genpd_prepare(struct device *dev)
>>
>>         ret = pm_generic_prepare(dev);
>>         if (ret) {
>> -               mutex_lock(&genpd->lock);
>> +               genpd_lock_domain(genpd);
>>
>>                 if (--genpd->prepared_count == 0)
>>                         genpd->suspend_power_off = false;
>>
>> -               mutex_unlock(&genpd->lock);
>> +               genpd_unlock_domain(genpd);
>>                 pm_runtime_enable(dev);
>>         }
>>
>> @@ -1116,13 +1188,13 @@ static void pm_genpd_complete(struct device *dev)
>>         if (IS_ERR(genpd))
>>                 return;
>>
>> -       mutex_lock(&genpd->lock);
>> +       genpd_lock_domain(genpd);
>>
>>         run_complete = !genpd->suspend_power_off;
>>         if (--genpd->prepared_count == 0)
>>                 genpd->suspend_power_off = false;
>>
>> -       mutex_unlock(&genpd->lock);
>> +       genpd_unlock_domain(genpd);
>>
>>         if (run_complete) {
>>                 pm_generic_complete(dev);
>> @@ -1266,11 +1338,18 @@ int __pm_genpd_add_device(struct generic_pm_domain *genpd, struct device *dev,
>>         if (IS_ERR_OR_NULL(genpd) || IS_ERR_OR_NULL(dev))
>>                 return -EINVAL;
>>
>> +       /* Devices in an IRQ safe PM Domain have to be irq safe too */
>
>Let's be consistent and stick with IRQ in upper case letters for the
>comments. I think there are other places in the patch which needs
>update as well.
>
Sorry. I will stick to IRQ and CPU (thanks Kevin) henceforth. 

>> +       if (genpd->irq_safe && !dev->power.irq_safe) {
>> +               dev_warn(dev,
>
>dev_err(), or perhaps even WARN() ?
>
OK, they are now WARN.

>> +                       "Devices in an irq-safe domain have to be irq safe.\n");
>> +               return -EINVAL;
>> +       }
>> +
>>         gpd_data = genpd_alloc_dev_data(dev, genpd, td);
>>         if (IS_ERR(gpd_data))
>>                 return PTR_ERR(gpd_data);
>>
>> -       mutex_lock(&genpd->lock);
>> +       genpd_lock_domain(genpd);
>>
>>         if (genpd->prepared_count > 0) {
>>                 ret = -EAGAIN;
>> @@ -1287,7 +1366,7 @@ int __pm_genpd_add_device(struct generic_pm_domain *genpd, struct device *dev,
>>         list_add_tail(&gpd_data->base.list_node, &genpd->dev_list);
>>
>>   out:
>> -       mutex_unlock(&genpd->lock);
>> +       genpd_unlock_domain(genpd);
>>
>>         if (ret)
>>                 genpd_free_dev_data(dev, gpd_data);
>> @@ -1331,7 +1410,7 @@ int pm_genpd_remove_device(struct generic_pm_domain *genpd,
>>         gpd_data = to_gpd_data(pdd);
>>         dev_pm_qos_remove_notifier(dev, &gpd_data->nb);
>>
>> -       mutex_lock(&genpd->lock);
>> +       genpd_lock_domain(genpd);
>>
>>         if (genpd->prepared_count > 0) {
>>                 ret = -EAGAIN;
>> @@ -1346,14 +1425,14 @@ int pm_genpd_remove_device(struct generic_pm_domain *genpd,
>>
>>         list_del_init(&pdd->list_node);
>>
>> -       mutex_unlock(&genpd->lock);
>> +       genpd_unlock_domain(genpd);
>>
>>         genpd_free_dev_data(dev, gpd_data);
>>
>>         return 0;
>>
>>   out:
>> -       mutex_unlock(&genpd->lock);
>> +       genpd_unlock_domain(genpd);
>>         dev_pm_qos_add_notifier(dev, &gpd_data->nb);
>>
>>         return ret;
>> @@ -1374,12 +1453,23 @@ int pm_genpd_add_subdomain(struct generic_pm_domain *genpd,
>>             || genpd == subdomain)
>>                 return -EINVAL;
>>
>> +       /*
>> +        * If the domain can be powered on/off in an irq safe
>> +        * context, ensure that the subdomain can also be
>> +        * powered on/off in that context.
>> +        */
>
>Have you considered if/how to address this limitation?
>
>Just to be clear, for now I think this limitation is perfectly okay,
>but going forward we might see a need to mix non IRQ safe domains with
>IRQ safe domains, via sub-domains.
>
Yeah, if we could be cognizant of the context we are running in, we
can be better about operating on domain and devices. Then this
limitation would go away.

>> +       if (genpd->irq_safe && !subdomain->irq_safe) {
>> +               pr_warn("Incompatible sub-domain %s of irq-safe domain %s\n",
>> +                               subdomain->name, genpd->name);
>
>Similar comment as earlier. Perhaps pr_err() or WARN() instead.
>
Done.

>> +               return -EINVAL;
>> +       }
>> +
>>         link = kzalloc(sizeof(*link), GFP_KERNEL);
>>         if (!link)
>>                 return -ENOMEM;
>>
>> -       mutex_lock(&genpd->lock);
>> -       mutex_lock_nested(&subdomain->lock, SINGLE_DEPTH_NESTING);
>> +       genpd_lock_domain(genpd);
>> +       genpd_lock_domain_nested(subdomain);
>>
>>         if (genpd->status == GPD_STATE_POWER_OFF
>>             &&  subdomain->status != GPD_STATE_POWER_OFF) {
>> @@ -1402,8 +1492,8 @@ int pm_genpd_add_subdomain(struct generic_pm_domain *genpd,
>>                 genpd_sd_counter_inc(genpd);
>>
>>   out:
>> -       mutex_unlock(&subdomain->lock);
>> -       mutex_unlock(&genpd->lock);
>> +       genpd_unlock_domain(subdomain);
>> +       genpd_unlock_domain(genpd);
>>
>>         return ret;
>>  }
>> @@ -1451,13 +1541,13 @@ int pm_genpd_remove_subdomain(struct generic_pm_domain *genpd,
>>         if (IS_ERR_OR_NULL(genpd) || IS_ERR_OR_NULL(subdomain))
>>                 return -EINVAL;
>>
>> -       mutex_lock(&genpd->lock);
>> +       genpd_lock_domain(genpd);
>>
>>         list_for_each_entry(link, &genpd->master_links, master_node) {
>>                 if (link->slave != subdomain)
>>                         continue;
>>
>> -               mutex_lock_nested(&subdomain->lock, SINGLE_DEPTH_NESTING);
>> +               genpd_lock_domain_nested(subdomain);
>>
>>                 list_del(&link->master_node);
>>                 list_del(&link->slave_node);
>> @@ -1465,13 +1555,13 @@ int pm_genpd_remove_subdomain(struct generic_pm_domain *genpd,
>>                 if (subdomain->status != GPD_STATE_POWER_OFF)
>>                         genpd_sd_counter_dec(genpd);
>>
>> -               mutex_unlock(&subdomain->lock);
>> +               genpd_unlock_domain(subdomain);
>>
>>                 ret = 0;
>>                 break;
>>         }
>>
>> -       mutex_unlock(&genpd->lock);
>> +       genpd_unlock_domain(genpd);
>>
>>         return ret;
>>  }
>> @@ -1495,11 +1585,17 @@ int pm_genpd_attach_cpuidle(struct generic_pm_domain *genpd, int state)
>>         if (IS_ERR_OR_NULL(genpd) || state < 0)
>>                 return -EINVAL;
>>
>> +       if (genpd->irq_safe) {
>> +               pr_err("Domain %s is irq safe, cannot attach to cpuidle\n",
>> +                               genpd->name);
>
>Here you have pr_err(), which is okay but not consistent. Also, I
>wonder if we should use a WARN() instead?
>
Done.

>> +               return -EINVAL;
>> +       }
>> +
>>         cpuidle_data = kzalloc(sizeof(*cpuidle_data), GFP_KERNEL);
>>         if (!cpuidle_data)
>>                 return -ENOMEM;
>>
>> -       mutex_lock(&genpd->lock);
>> +       genpd_lock_domain(genpd);
>>
>>         if (genpd->cpuidle_data) {
>>                 ret = -EEXIST;
>> @@ -1526,7 +1622,7 @@ int pm_genpd_attach_cpuidle(struct generic_pm_domain *genpd, int state)
>>         genpd_recalc_cpu_exit_latency(genpd);
>>
>>   out:
>> -       mutex_unlock(&genpd->lock);
>> +       genpd_unlock_domain(genpd);
>>         return ret;
>>
>>   err:
>> @@ -1563,7 +1659,7 @@ int pm_genpd_detach_cpuidle(struct generic_pm_domain *genpd)
>>         if (IS_ERR_OR_NULL(genpd))
>>                 return -EINVAL;
>>
>> -       mutex_lock(&genpd->lock);
>> +       genpd_lock_domain(genpd);
>>
>>         cpuidle_data = genpd->cpuidle_data;
>>         if (!cpuidle_data) {
>> @@ -1581,7 +1677,7 @@ int pm_genpd_detach_cpuidle(struct generic_pm_domain *genpd)
>>         kfree(cpuidle_data);
>>
>>   out:
>> -       mutex_unlock(&genpd->lock);
>> +       genpd_unlock_domain(genpd);
>>         return ret;
>>  }
>>
>> @@ -1642,6 +1738,17 @@ static int pm_genpd_default_restore_state(struct device *dev)
>>         return cb ? cb(dev) : 0;
>>  }
>>
>> +static void genpd_lock_domain_init(struct generic_pm_domain *genpd)
>> +{
>> +       if (genpd->flags & GENPD_FLAG_IRQ_SAFE) {
>> +               spin_lock_init(&genpd->slock);
>> +               genpd->irq_safe = true;
>
>Copying the result from "genpd->flags & GENPD_FLAG_IRQ_SAFE" into the
>irq_safe bool, seems like a "micro" optimization. How about only using
>the genpd->flags instead?
>
Actually, I would prefer using the flag, there are a few places in the
code where I need to know if the domain is IRQ safe or not. Checking for
flags is cumbersome and not every aestheic.

>> +       } else {
>> +               mutex_init(&genpd->mlock);
>> +               genpd->irq_safe = false;
>> +       }
>> +}
>> +
>>  /**
>>   * pm_genpd_init - Initialize a generic I/O PM domain object.
>>   * @genpd: PM domain object to initialize.
>> @@ -1657,7 +1764,7 @@ void pm_genpd_init(struct generic_pm_domain *genpd,
>>         INIT_LIST_HEAD(&genpd->master_links);
>>         INIT_LIST_HEAD(&genpd->slave_links);
>>         INIT_LIST_HEAD(&genpd->dev_list);
>> -       mutex_init(&genpd->lock);
>> +       genpd_lock_domain_init(genpd);
>>         genpd->gov = gov;
>>         INIT_WORK(&genpd->power_off_work, genpd_power_off_work_fn);
>>         genpd->in_progress = 0;
>> @@ -2042,7 +2149,7 @@ static int pm_genpd_summary_one(struct seq_file *s,
>>         struct gpd_link *link;
>>         int ret;
>>
>> -       ret = mutex_lock_interruptible(&genpd->lock);
>> +       ret = genpd_lock_domain_interruptible(genpd);
>>         if (ret)
>>                 return -ERESTARTSYS;
>>
>> @@ -2062,7 +2169,8 @@ static int pm_genpd_summary_one(struct seq_file *s,
>>         }
>>
>>         list_for_each_entry(pm_data, &genpd->dev_list, list_node) {
>> -               kobj_path = kobject_get_path(&pm_data->dev->kobj, GFP_KERNEL);
>> +               kobj_path = kobject_get_path(&pm_data->dev->kobj,
>> +                               genpd->irq_safe ? GFP_ATOMIC : GFP_KERNEL);
>>                 if (kobj_path == NULL)
>>                         continue;
>>
>> @@ -2073,7 +2181,7 @@ static int pm_genpd_summary_one(struct seq_file *s,
>>
>>         seq_puts(s, "\n");
>>  exit:
>> -       mutex_unlock(&genpd->lock);
>> +       genpd_unlock_domain(genpd);
>>
>>         return 0;
>>  }
>> diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
>> index b2725e6..dc7cb53 100644
>> --- a/include/linux/pm_domain.h
>> +++ b/include/linux/pm_domain.h
>> @@ -16,9 +16,11 @@
>>  #include <linux/of.h>
>>  #include <linux/notifier.h>
>>  #include <linux/cpuidle.h>
>> +#include <linux/spinlock.h>
>>
>>  /* Defines used for the flags field in the struct generic_pm_domain */
>>  #define GENPD_FLAG_PM_CLK      (1U << 0) /* PM domain uses PM clk */
>> +#define GENPD_FLAG_IRQ_SAFE    (1U << 1) /* PM domain operates in atomic */
>>
>>  enum gpd_status {
>>         GPD_STATE_ACTIVE = 0,   /* PM domain is active */
>> @@ -49,7 +51,6 @@ struct generic_pm_domain {
>>         struct list_head master_links;  /* Links with PM domain as a master */
>>         struct list_head slave_links;   /* Links with PM domain as a slave */
>>         struct list_head dev_list;      /* List of devices */
>> -       struct mutex lock;
>>         struct dev_power_governor *gov;
>>         struct work_struct power_off_work;
>>         const char *name;
>> @@ -74,6 +75,14 @@ struct generic_pm_domain {
>>         void (*detach_dev)(struct generic_pm_domain *domain,
>>                            struct device *dev);
>>         unsigned int flags;             /* Bit field of configs for genpd */
>> +       bool irq_safe;
>> +       union {
>> +               struct mutex mlock;
>> +               struct {
>> +                       spinlock_t slock;
>> +                       unsigned long lock_flags;
>> +               };
>> +       };
>>  };
>>
>>  static inline struct generic_pm_domain *pd_to_genpd(struct dev_pm_domain *pd)
>> --
>> 2.1.4
>>

Thank you so much Ulf for the review.

--Lina
