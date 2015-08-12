From: Lina Iyer <lina.iyer@linaro.org>
Subject: Re: [PATCH 3/9] PM / Domains: Support IRQ safe PM domains
Date: Wed, 12 Aug 2015 14:47:14 -0600
Message-ID: <20150812204714.GN52339@linaro.org>
References: <1438731339-58317-1-git-send-email-lina.iyer@linaro.org>
 <1438731339-58317-4-git-send-email-lina.iyer@linaro.org>
 <7hy4hgmfkq.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f169.google.com ([209.85.192.169]:36231 "EHLO
	mail-pd0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751117AbbHLUqu (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 12 Aug 2015 16:46:50 -0400
Received: by pdco4 with SMTP id o4so11149465pdc.3
        for <linux-pm@vger.kernel.org>; Wed, 12 Aug 2015 13:46:49 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7hy4hgmfkq.fsf@deeprootsystems.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Kevin Hilman <khilman@kernel.org>
Cc: rjw@rjwysocki.net, ulf.hansson@linaro.org, geert@linux-m68k.org, k.kozlowski@samsung.com, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, msivasub@codeaurora.org, agross@codeaurora.org, sboyd@codeaurora.org

On Wed, Aug 12 2015 at 14:12 -0600, Kevin Hilman wrote:
>Lina Iyer <lina.iyer@linaro.org> writes:
>
>> Generic Power Domains currently support turning on/off only in proce=
ss
>> context. This prevents the usage of PM domains for domains that coul=
d be
>> powered on/off in a context where IRQs are disabled. Many such domai=
ns
>> exist today and do not get powered off, when the IRQ safe devices in
>> that domain are powered off, because of this limitation.
>>
>> However, not all domains can operate in IRQ safe contexts. Genpd
>> therefore, has to support both cases where the domain may or may not
>> operate in IRQ safe contexts. Configuring genpd to use an appropriat=
e
>> lock for that domain, would allow domains that have IRQ safe devices=
 to
>> runtime suspend and resume, in atomic context.
>>
>> To achieve domain specific locking, set the domain's ->flag to
>> GENPD_FLAG_IRQ_SAFE while defining the domain. This indicates that g=
enpd
>> should use a spinlock instead of a mutex for locking the domain. Loc=
king
>> is abstracted through genpd_lock() and genpd_unlock() functions that=
 use
>> the flag to determine the appropriate lock to be used for that domai=
n.
>> Domains that have lower latency to suspend and resume and can operat=
e
>> with IRQs disabled may now be able to save power, when the component
>> devices and sub-domains are idle at runtime.
>>
>> The restriction this imposes on the domain hierarchy is that sub-dom=
ains
>> and all devices in the IRQ safe domain's hierarchy also have to be I=
RQ
>> safe, so that we dont try to lock a mutex, while holding a spinlock.
>> Non-IRQ safe domains may continue to have devices and sub-domains th=
at
>> may or may not be IRQ safe.
>>
>> Cc: Ulf Hansson <ulf.hansson@linaro.org>
>> Cc: Kevin Hilman <khilman@linaro.org>
>> Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
>> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
>> Cc: Krzysztof Koz=C5=82owski <k.kozlowski@samsung.com>
>> Signed-off-by: Lina Iyer <lina.iyer@linaro.org>
>
>Approach seems good to me, some cosmetic issues below...
>
Thanks for your review.

>> ---
>>  Documentation/power/devices.txt |  11 ++-
>>  drivers/base/power/domain.c     | 201 +++++++++++++++++++++++++++++=
++---------
>>  include/linux/pm_domain.h       |  11 ++-
>>  3 files changed, 178 insertions(+), 45 deletions(-)
>>
>> diff --git a/Documentation/power/devices.txt b/Documentation/power/d=
evices.txt
>> index 8ba6625..6d8318c 100644
>> --- a/Documentation/power/devices.txt
>> +++ b/Documentation/power/devices.txt
>> @@ -607,7 +607,16 @@ individually.  Instead, a set of devices sharin=
g a power resource can be put
>>  into a low-power state together at the same time by turning off the=
 shared
>>  power resource.  Of course, they also need to be put into the full-=
power state
>>  together, by turning the shared power resource on.  A set of device=
s with this
>> -property is often referred to as a power domain.
>> +property is often referred to as a power domain. A power domain may=
 also be
>> +nested inside another power domain.
>> +
>> +Devices, by default, operate in process context and if a device can=
 operate in
>> +IRQ safe context, has to be explicitly set as IRQ safe. Power domai=
ns by
>> +default, operate in process context but could have devices that are=
 IRQ safe.
>> +Such power domains cannot be powered on/off during runtime PM. On t=
he other
>> +hand, an IRQ safe PM domain that can be powered on/off and suspend =
or resumed
>> +in an atomic context, may contain IRQ safe devices. Such domains ma=
y only
>> +contain IRQ safe devices or IRQ safe sub-domains.
>>
>>  Support for power domains is provided through the pm_domain field o=
f struct
>>  device.  This field is a pointer to an object of type struct dev_pm=
_domain,
>> diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain=
=2Ec
>> index ef8d19f..221feb0 100644
>> --- a/drivers/base/power/domain.c
>> +++ b/drivers/base/power/domain.c
>> @@ -53,6 +53,74 @@
>>  static LIST_HEAD(gpd_list);
>>  static DEFINE_MUTEX(gpd_list_lock);
>>
>> +static inline int genpd_lock_noirq(struct generic_pm_domain *genpd,
>> +					unsigned int subclass)
>
>I don't like the _noirq naming, as in the context of suspend/resume,
>that means no *device* IRQs, not no IRQs at all.  Maybe _atomic is
>better, or _nosleep? or ...
>
I like _nosleep, will change it.

>> +	__acquires(&genpd->slock)
>> +{
>> +	unsigned long flags;
>> +
>> +	if (subclass > 0)
>> +		spin_lock_irqsave_nested(&genpd->slock, flags, subclass);
>> +	else
>> +		spin_lock_irqsave(&genpd->slock, flags);
>> +
>> +	genpd->lock_flags =3D flags;
>> +	return 0;
>> +}
>> +
>> +static inline void genpd_unlock_noirq(struct generic_pm_domain *gen=
pd)
>> +	__releases(&genpd->slock)
>> +{
>> +	spin_unlock_irqrestore(&genpd->slock, genpd->lock_flags);
>> +}
>> +
>> +static inline int genpd_lock_irq(struct generic_pm_domain *genpd,
>> +					unsigned int subclass)
>> +	__acquires(&genpd->mlock)
>> +{
>> +	if (subclass > 0)
>> +		mutex_lock_nested(&genpd->mlock, subclass);
>> +	else
>> +		mutex_lock(&genpd->mlock);
>> +	return 0;
>> +}
>> +
>> +static inline int genpd_lock_interruptible_irq(struct generic_pm_do=
main *genpd)
>> +	__acquires(&genpd->mlock)
>> +{
>> +	return mutex_lock_interruptible(&genpd->mlock);
>> +}
>> +
>> +static inline void genpd_unlock_irq(struct generic_pm_domain *genpd=
)
>> +	__releases(&genpd->mlock)
>> +{
>> +	mutex_unlock(&genpd->mlock);
>> +}
>> +
>> +static inline int genpd_lock(struct generic_pm_domain *genpd)
>> +{
>> +	return genpd->irq_safe ? genpd_lock_noirq(genpd, 0)
>> +			: genpd_lock_irq(genpd, 0);
>> +}
>> +
>> +static inline int genpd_lock_nested(struct generic_pm_domain *genpd=
)
>> +{
>> +	return genpd->irq_safe ? genpd_lock_noirq(genpd, SINGLE_DEPTH_NEST=
ING)
>> +			: genpd_lock_irq(genpd, SINGLE_DEPTH_NESTING);
>> +}
>> +
>> +static inline int genpd_lock_interruptible(struct generic_pm_domain=
 *genpd)
>> +{
>> +	return genpd->irq_safe ? genpd_lock_noirq(genpd, 0)
>> +			: genpd_lock_interruptible_irq(genpd);
>> +}
>> +
>> +static inline void genpd_unlock(struct generic_pm_domain *genpd)
>> +{
>> +	return genpd->irq_safe ? genpd_unlock_noirq(genpd)
>> +			: genpd_unlock_irq(genpd);
>> +}
>> +
>>  static struct generic_pm_domain *pm_genpd_lookup_name(const char *d=
omain_name)
>>  {
>>  	struct generic_pm_domain *genpd =3D NULL, *gpd;
>> @@ -273,9 +341,9 @@ int pm_genpd_poweron(struct generic_pm_domain *g=
enpd)
>>  {
>>  	int ret;
>>
>> -	mutex_lock(&genpd->lock);
>> +	genpd_lock(genpd);
>>  	ret =3D __pm_genpd_poweron(genpd);
>> -	mutex_unlock(&genpd->lock);
>> +	genpd_unlock(genpd);
>>  	return ret;
>>  }
>>
>> @@ -335,9 +403,9 @@ static int genpd_dev_pm_qos_notifier(struct noti=
fier_block *nb,
>>  		spin_unlock_irq(&dev->power.lock);
>>
>>  		if (!IS_ERR(genpd)) {
>> -			mutex_lock(&genpd->lock);
>> +			genpd_lock(genpd);
>>  			genpd->max_off_time_changed =3D true;
>> -			mutex_unlock(&genpd->lock);
>> +			genpd_unlock(genpd);
>>  		}
>>
>>  		dev =3D dev->parent;
>> @@ -394,7 +462,13 @@ static int pm_genpd_poweroff(struct generic_pm_=
domain *genpd)
>>  		if (stat > PM_QOS_FLAGS_NONE)
>>  			return -EBUSY;
>>
>> -		if (!pm_runtime_suspended(pdd->dev) || pdd->dev->power.irq_safe)
>> +		/*
>> +		 * We do not want to power off the domain if the device is
>> +		 * not suspended or an IRQ safe device is part of this
>> +		 * non-IRQ safe domain.
>> +		 */
>> +		if (!pm_runtime_suspended(pdd->dev) ||
>> +			(pdd->dev->power.irq_safe && !genpd->irq_safe))
>>  			not_suspended++;
>
>The !irq_safe check should maybe spit a warning via WARN_ONCE(), as th=
is
>would be useful in debugging domains that are not shutting down.
>
>>  	}
I thought about putting it before, but I figured it might print only
once for all the genpd/devices. So there might be many cases that may
not be reported. Is my assumption of the __section usage for this macro=
,
correct?

>>
>> @@ -460,9 +534,9 @@ static void genpd_power_off_work_fn(struct work_=
struct *work)
>>
>>  	genpd =3D container_of(work, struct generic_pm_domain, power_off_w=
ork);
>>
>> -	mutex_lock(&genpd->lock);
>> +	genpd_lock(genpd);
>>  	pm_genpd_poweroff(genpd);
>> -	mutex_unlock(&genpd->lock);
>> +	genpd_unlock(genpd);
>>  }
>>
>>  /**
>> @@ -500,17 +574,19 @@ static int pm_genpd_runtime_suspend(struct dev=
ice *dev)
>>  	}
>>
>>  	/*
>> -	 * If power.irq_safe is set, this routine will be run with interru=
pts
>> -	 * off, so it can't use mutexes.
>> +	 * If power.irq_safe is set, this routine may be run with
>> +	 * IRQ disabled, so suspend only if the power domain is
>> +	 * irq_safe.
>>  	 */
>> -	if (dev->power.irq_safe)
>> +	if (dev->power.irq_safe && !genpd->irq_safe)
>>  		return 0;
>
>Similarily, a WARN_ONCE() will probably be helpful here.
>
>> -	mutex_lock(&genpd->lock);
>> +	genpd_lock(genpd);
>> +
>>  	genpd->in_progress++;
>>  	pm_genpd_poweroff(genpd);
>>  	genpd->in_progress--;
>> -	mutex_unlock(&genpd->lock);
>> +	genpd_unlock(genpd);
>>
>>  	return 0;
>>  }
>> @@ -535,15 +611,18 @@ static int pm_genpd_runtime_resume(struct devi=
ce *dev)
>>  	if (IS_ERR(genpd))
>>  		return -EINVAL;
>>
>> -	/* If power.irq_safe, the PM domain is never powered off. */
>> -	if (dev->power.irq_safe) {
>> +	/*
>> +	 * As we dont power off a non IRQ safe domain, which holds
>> +	 * an IRQ safe device, we dont need to restore power to it.
>> +	 */
>> +	if (dev->power.irq_safe && !genpd->irq_safe) {
>>  		timed =3D false;
>>  		goto out;
>>  	}
>>
>> -	mutex_lock(&genpd->lock);
>> +	genpd_lock(genpd);
>>  	ret =3D __pm_genpd_poweron(genpd);
>> -	mutex_unlock(&genpd->lock);
>> +	genpd_unlock(genpd);
>>
>>  	if (ret)
>>  		return ret;
>> @@ -743,14 +822,14 @@ static int pm_genpd_prepare(struct device *dev=
)
>>  	if (resume_needed(dev, genpd))
>>  		pm_runtime_resume(dev);
>>
>> -	mutex_lock(&genpd->lock);
>> +	genpd_lock(genpd);
>>
>>  	if (genpd->prepared_count++ =3D=3D 0) {
>>  		genpd->suspended_count =3D 0;
>>  		genpd->suspend_power_off =3D genpd->status =3D=3D GPD_STATE_POWER=
_OFF;
>>  	}
>>
>> -	mutex_unlock(&genpd->lock);
>> +	genpd_unlock(genpd);
>>
>>  	if (genpd->suspend_power_off) {
>>  		pm_runtime_put_noidle(dev);
>> @@ -768,12 +847,12 @@ static int pm_genpd_prepare(struct device *dev=
)
>>
>>  	ret =3D pm_generic_prepare(dev);
>>  	if (ret) {
>> -		mutex_lock(&genpd->lock);
>> +		genpd_lock(genpd);
>>
>>  		if (--genpd->prepared_count =3D=3D 0)
>>  			genpd->suspend_power_off =3D false;
>>
>> -		mutex_unlock(&genpd->lock);
>> +		genpd_unlock(genpd);
>>  		pm_runtime_enable(dev);
>>  	}
>>
>> @@ -1130,13 +1209,13 @@ static void pm_genpd_complete(struct device =
*dev)
>>  	if (IS_ERR(genpd))
>>  		return;
>>
>> -	mutex_lock(&genpd->lock);
>> +	genpd_lock(genpd);
>>
>>  	run_complete =3D !genpd->suspend_power_off;
>>  	if (--genpd->prepared_count =3D=3D 0)
>>  		genpd->suspend_power_off =3D false;
>>
>> -	mutex_unlock(&genpd->lock);
>> +	genpd_unlock(genpd);
>>
>>  	if (run_complete) {
>>  		pm_generic_complete(dev);
>> @@ -1280,11 +1359,17 @@ int __pm_genpd_add_device(struct generic_pm_=
domain *genpd, struct device *dev,
>>  	if (IS_ERR_OR_NULL(genpd) || IS_ERR_OR_NULL(dev))
>>  		return -EINVAL;
>>
>> +	if (genpd->irq_safe && !dev->power.irq_safe) {
>> +		dev_err(dev,
>> +			"Devices in an IRQ safe domain have to be IRQ safe.\n");
>
>This should also dump the PM domain, something like:
>
>            dev_err(dev, "PM domain %s is IRQ safe; device has to be I=
RQ safe.\n")
>
Sure.

>> +		return -EINVAL;
>> +	}
>> +
>>  	gpd_data =3D genpd_alloc_dev_data(dev, genpd, td);
>>  	if (IS_ERR(gpd_data))
>>  		return PTR_ERR(gpd_data);
>>
>> -	mutex_lock(&genpd->lock);
>> +	genpd_lock(genpd);
>>
>>  	if (genpd->prepared_count > 0) {
>>  		ret =3D -EAGAIN;
>> @@ -1301,7 +1386,7 @@ int __pm_genpd_add_device(struct generic_pm_do=
main *genpd, struct device *dev,
>>  	list_add_tail(&gpd_data->base.list_node, &genpd->dev_list);
>>
>>   out:
>> -	mutex_unlock(&genpd->lock);
>> +	genpd_unlock(genpd);
>>
>>  	if (ret)
>>  		genpd_free_dev_data(dev, gpd_data);
>> @@ -1345,7 +1430,7 @@ int pm_genpd_remove_device(struct generic_pm_d=
omain *genpd,
>>  	gpd_data =3D to_gpd_data(pdd);
>>  	dev_pm_qos_remove_notifier(dev, &gpd_data->nb);
>>
>> -	mutex_lock(&genpd->lock);
>> +	genpd_lock(genpd);
>>
>>  	if (genpd->prepared_count > 0) {
>>  		ret =3D -EAGAIN;
>> @@ -1360,14 +1445,14 @@ int pm_genpd_remove_device(struct generic_pm=
_domain *genpd,
>>
>>  	list_del_init(&pdd->list_node);
>>
>> -	mutex_unlock(&genpd->lock);
>> +	genpd_unlock(genpd);
>>
>>  	genpd_free_dev_data(dev, gpd_data);
>>
>>  	return 0;
>>
>>   out:
>> -	mutex_unlock(&genpd->lock);
>> +	genpd_unlock(genpd);
>>  	dev_pm_qos_add_notifier(dev, &gpd_data->nb);
>>
>>  	return ret;
>> @@ -1388,12 +1473,24 @@ int pm_genpd_add_subdomain(struct generic_pm=
_domain *genpd,
>>  	    || genpd =3D=3D subdomain)
>>  		return -EINVAL;
>>
>> +	/*
>> +	 * If the domain can be powered on/off in an IRQ safe
>> +	 * context, ensure that the subdomain can also be
>> +	 * powered on/off in that context.
>> +	 */
>> +	if (genpd->irq_safe && !subdomain->irq_safe) {
>> +		WARN("Sub-domain (%s) in an IRQ-safe domain (%s)"
>> +				"have to be IRQ safe\n",
>
>s/have/has/
>
Argh. Fixed.

>> +				subdomain->name, genpd->name);
>> +		return -EINVAL;
>> +	}
>> +
>
>Kevin

Thank you again for looking through this big patch.
-- Lina
