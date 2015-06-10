From: Lina Iyer <lina.iyer@linaro.org>
Subject: Re: [PATCH RFC 2/3] PM / Domains: Support atomic PM domains
Date: Wed, 10 Jun 2015 10:13:23 -0600
Message-ID: <20150610161323.GA4497@linaro.org>
References: <1433456946-53296-1-git-send-email-lina.iyer@linaro.org>
 <1433456946-53296-3-git-send-email-lina.iyer@linaro.org>
 <55740D00.1030203@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f175.google.com ([209.85.192.175]:35837 "EHLO
	mail-pd0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754262AbbFJQN0 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 10 Jun 2015 12:13:26 -0400
Received: by pdbnf5 with SMTP id nf5so41030473pdb.2
        for <linux-pm@vger.kernel.org>; Wed, 10 Jun 2015 09:13:25 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <55740D00.1030203@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Cc: rjw@rjwysocki.net, ulf.hansson@linaro.org, khilman@linaro.org, mathieu.poirier@linaro.org, linux-pm@vger.kernel.org, galak@codeaurora.org, msivasub@codeaurora.org, agross@codeaurora.org, linux-arm-kernel@lists.infradead.org

On Sun, Jun 07 2015 at 03:21 -0600, Krzysztof Kozlowski wrote:
>W dniu 05.06.2015 o 07:29, Lina Iyer pisze:
>> Power Domains currently support turning on/off only in process context.
>> This restricts the usage of PM domains to devices and domains that
>> could be powered on/off in irq disabled contexts as the mutexes used in
>> GenPD allows for cpu sleep while waiting for locks.
>
>I can find also other use case: currently the power domain with irq_safe
>devices is always powered on. With the patch it could be powered off (of
>course if the driver/mach code is irq-safe).
>
Yes, absolutely.

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
>
>So an irq-safe device can be put in irq-safe subdomain which can be a
>child of non-irq-safe topdomain?
>
Yes, the container need not be irq-safe but the contained need to be
irqsafe.

>>
>> Cc: Ulf Hansson <ulf.hansson@linaro.org>
>> Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
>> Cc: Kevin Hilman <khilman@linaro.org>
>> Signed-off-by: Lina Iyer <lina.iyer@linaro.org>
>> ---
>>  drivers/base/power/domain.c | 200 ++++++++++++++++++++++++++++++++++----------
>>  include/linux/pm_domain.h   |  11 ++-
>
>Documentation should also be reflected.
>
Yes, will add.

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
>> +					unsigned int subclass)
>> +	__acquires(&genpd->slock)
>> +{
>> +	unsigned long flags;
>> +
>> +	if (unlikely(subclass > 0))
>> +		spin_lock_irqsave_nested(&genpd->slock, flags, subclass);
>> +	else
>> +		spin_lock_irqsave(&genpd->slock, flags);
>> +
>> +	genpd->flags = flags;
>> +
>> +	return 0;
>> +}
>> +
>> +static inline int genpd_unlock_domain_noirq(struct generic_pm_domain *genpd)
>> +	__releases(&genpd->slock)
>> +{
>> +	spin_unlock_irqrestore(&genpd->slock, genpd->lock_flags);
>> +	return 0;
>> +}
>> +
>> +static inline int genpd_lock_domain_irq(struct generic_pm_domain *genpd,
>> +					unsigned int subclass)
>> +	__acquires(&genpd->mlock)
>> +{
>> +	if (unlikely(subclass > 0))
>> +		mutex_lock_nested(&genpd->mlock, subclass);
>> +	else
>> +		mutex_lock(&genpd->mlock);
>> +
>> +	return 0;
>> +}
>> +
>> +static inline int genpd_lock_domain_interruptible_irq(
>> +				struct generic_pm_domain *genpd)
>> +	__acquires(&genpd->mlock)
>> +{
>> +	return mutex_lock_interruptible(&genpd->mlock);
>> +}
>> +
>> +static inline int genpd_unlock_domain_irq(struct generic_pm_domain *genpd)
>> +	__releases(&genpd->mlock)
>> +{
>> +	mutex_unlock(&genpd->mlock);
>> +	return 0;
>> +}
>> +
>> +#define genpd_lock_domain(genpd)				\
>> +	(genpd->irq_safe ? genpd_lock_domain_noirq(genpd, 0)	\
>> +			: genpd_lock_domain_irq(genpd, 0))
>> +
>> +#define genpd_lock_domain_nested(genpd)				\
>> +	(genpd->irq_safe ? genpd_lock_domain_noirq(genpd, SINGLE_DEPTH_NESTING)\
>> +			: genpd_lock_domain_irq(genpd, SINGLE_DEPTH_NESTING))
>> +
>> +#define genpd_unlock_domain(genpd)				\
>> +	(genpd->irq_safe ? genpd_unlock_domain_noirq(genpd)	\
>> +			: genpd_unlock_domain_irq(genpd))
>> +
>> +#define genpd_lock_domain_interruptible(genpd)			\
>> +	(genpd->irq_safe ? genpd_lock_domain_noirq(genpd, 0)	\
>> +			: genpd_lock_domain_interruptible_irq(genpd))
>
>Why macros? You are not using here benefits of a macro and they are
>called just like ordinary functions.
>
Well, I didnt see a need for a function that might show up in the stack.
But I have no strong preference either way.

>You added "domain" prefix but genpd already contains this. genod_lock(),
>genpd_lock_nested() etc. should be sufficient, unless there is a
>conflict, similar name planned or you plan to lock something else
>(genpd_lock_device?).
>
Sigh. Yes, you are right. Its redundant. Will remove.

>
>> +
>>  static struct generic_pm_domain *pm_genpd_lookup_name(const char *domain_name)
>>  {
>>  	struct generic_pm_domain *genpd = NULL, *gpd;
>> @@ -262,9 +327,9 @@ int pm_genpd_poweron(struct generic_pm_domain *genpd)
>>  {
>>  	int ret;
>>
>> -	mutex_lock(&genpd->lock);
>> +	genpd_lock_domain(genpd);
>>  	ret = __pm_genpd_poweron(genpd);
>> -	mutex_unlock(&genpd->lock);
>> +	genpd_unlock_domain(genpd);
>>  	return ret;
>>  }
>>
>> @@ -326,9 +391,9 @@ static int genpd_dev_pm_qos_notifier(struct notifier_block *nb,
>>  		spin_unlock_irq(&dev->power.lock);
>>
>>  		if (!IS_ERR(genpd)) {
>> -			mutex_lock(&genpd->lock);
>> +			genpd_lock_domain(genpd);
>>  			genpd->max_off_time_changed = true;
>> -			mutex_unlock(&genpd->lock);
>> +			genpd_unlock_domain(genpd);
>>  		}
>>
>>  		dev = dev->parent;
>> @@ -387,7 +452,7 @@ static int pm_genpd_poweroff(struct generic_pm_domain *genpd)
>>  			return -EBUSY;
>>
>>  		if (pdd->dev->driver && (!pm_runtime_suspended(pdd->dev)
>> -		    || pdd->dev->power.irq_safe))
>> +			|| (pdd->dev->power.irq_safe && !genpd->irq_safe)))
>>  			not_suspended++;
>>  	}
>>
>> @@ -453,9 +518,9 @@ static void genpd_power_off_work_fn(struct work_struct *work)
>>
>>  	genpd = container_of(work, struct generic_pm_domain, power_off_work);
>>
>> -	mutex_lock(&genpd->lock);
>> +	genpd_lock_domain(genpd);
>>  	pm_genpd_poweroff(genpd);
>
>Ipm_genpd_poweroff() calls __pm_genpd_save_device() which grabs mutex.
>At least in next-20150604 but maybe the patches, which this depends on,
>changed it?
>
Yes. Ulf's patch remvoed that call.

>
>> -	mutex_unlock(&genpd->lock);
>> +	genpd_unlock_domain(genpd);
>>  }
>>
>>  /**
>> @@ -478,12 +543,8 @@ static int pm_genpd_runtime_suspend(struct device *dev)
>>  	if (IS_ERR(genpd))
>>  		return -EINVAL;
>>
>> -	/*
>> -	 * We can't allow to power off the PM domain if it holds an irq_safe
>> -	 * device. That's beacuse we use mutexes to protect data while power
>> -	 * off and on the PM domain, thus we can't execute in atomic context.
>> -	 */
>> -	if (dev->power.irq_safe)
>> +	/* We can't allow to power off a domain that is also not irq safe. */
>> +	if (dev->power.irq_safe && !genpd->irq_safe)
>>  		return -EBUSY;
>>
>>  	stop_ok = genpd->gov ? genpd->gov->stop_ok : NULL;
>> @@ -500,11 +561,19 @@ static int pm_genpd_runtime_suspend(struct device *dev)
>>  		return ret;
>>  	}
>>
>> -	mutex_lock(&genpd->lock);
>> +	/*
>> +	 * If power.irq_safe is set, this routine will be run with interrupts
>> +	 * off, so suspend only if the power domain is irq_safe.
>> +	 */
>> +	if (dev->power.irq_safe && !genpd->irq_safe)
>> +		return 0;
>> +
>> +	genpd_lock_domain(genpd);
>> +
>>  	genpd->in_progress++;
>>  	pm_genpd_poweroff(genpd);
>>  	genpd->in_progress--;
>> -	mutex_unlock(&genpd->lock);
>> +	genpd_unlock_domain(genpd);
>>
>>  	return 0;
>>  }
>> @@ -528,13 +597,16 @@ static int pm_genpd_runtime_resume(struct device *dev)
>>  	if (IS_ERR(genpd))
>>  		return -EINVAL;
>>
>> -	/* If power.irq_safe, the PM domain is never powered off. */
>> -	if (dev->power.irq_safe)
>> +	/*
>> +	 * If power.irq_safe and domain is not, then
>> +	 * the PM domain is never powered off.
>> +	 */
>> +	if (dev->power.irq_safe && !genpd->irq_safe)
>>  		return genpd_start_dev_no_timing(genpd, dev);
>>
>> -	mutex_lock(&genpd->lock);
>> +	genpd_lock_domain(genpd);
>>  	ret = __pm_genpd_poweron(genpd);
>> -	mutex_unlock(&genpd->lock);
>> +	genpd_unlock_domain(genpd);
>>
>>  	if (ret)
>>  		return ret;
>> @@ -729,14 +801,14 @@ static int pm_genpd_prepare(struct device *dev)
>>  	if (resume_needed(dev, genpd))
>>  		pm_runtime_resume(dev);
>>
>> -	mutex_lock(&genpd->lock);
>> +	genpd_lock_domain(genpd);
>>
>>  	if (genpd->prepared_count++ == 0) {
>>  		genpd->suspended_count = 0;
>>  		genpd->suspend_power_off = genpd->status == GPD_STATE_POWER_OFF;
>>  	}
>>
>> -	mutex_unlock(&genpd->lock);
>> +	genpd_unlock_domain(genpd);
>>
>>  	if (genpd->suspend_power_off) {
>>  		pm_runtime_put_noidle(dev);
>> @@ -754,12 +826,12 @@ static int pm_genpd_prepare(struct device *dev)
>>
>>  	ret = pm_generic_prepare(dev);
>>  	if (ret) {
>> -		mutex_lock(&genpd->lock);
>> +		genpd_lock_domain(genpd);
>>
>>  		if (--genpd->prepared_count == 0)
>>  			genpd->suspend_power_off = false;
>>
>> -		mutex_unlock(&genpd->lock);
>> +		genpd_unlock_domain(genpd);
>>  		pm_runtime_enable(dev);
>>  	}
>>
>> @@ -1116,13 +1188,13 @@ static void pm_genpd_complete(struct device *dev)
>>  	if (IS_ERR(genpd))
>>  		return;
>>
>> -	mutex_lock(&genpd->lock);
>> +	genpd_lock_domain(genpd);
>>
>>  	run_complete = !genpd->suspend_power_off;
>>  	if (--genpd->prepared_count == 0)
>>  		genpd->suspend_power_off = false;
>>
>> -	mutex_unlock(&genpd->lock);
>> +	genpd_unlock_domain(genpd);
>>
>>  	if (run_complete) {
>>  		pm_generic_complete(dev);
>> @@ -1266,11 +1338,18 @@ int __pm_genpd_add_device(struct generic_pm_domain *genpd, struct device *dev,
>>  	if (IS_ERR_OR_NULL(genpd) || IS_ERR_OR_NULL(dev))
>>  		return -EINVAL;
>>
>> +	/* Devices in an IRQ safe PM Domain have to be irq safe too */
>
>Why? Can you add this information here? Previously there was a reason in
>case of irq_safe devices which you removed leaving only policy.
>
Sorry, your question is not clear to me.
I believe this is a new requirement that enforces the contained devices
of an irq-safe domain to be irq-safe as well.

Thanks for your review.

-- Lina
