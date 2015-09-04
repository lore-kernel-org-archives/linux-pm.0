From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v2 2/7] PM / Domains: Support IRQ safe PM domains
Date: Fri, 4 Sep 2015 12:02:54 +0200
Message-ID: <CAPDyKFoW1FBXvvQhTnyjQK06=6ovh7+jM2Ob9-rfaZgYcLykrA@mail.gmail.com>
References: <1441310314-8857-1-git-send-email-lina.iyer@linaro.org>
	<1441310314-8857-3-git-send-email-lina.iyer@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f176.google.com ([209.85.212.176]:38540 "EHLO
	mail-wi0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751107AbbIDKC4 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 4 Sep 2015 06:02:56 -0400
Received: by wiclk2 with SMTP id lk2so12390634wic.1
        for <linux-pm@vger.kernel.org>; Fri, 04 Sep 2015 03:02:54 -0700 (PDT)
In-Reply-To: <1441310314-8857-3-git-send-email-lina.iyer@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lina Iyer <lina.iyer@linaro.org>
Cc: Kevin Hilman <khilman@linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Geert Uytterhoeven <geert@linux-m68k.org>, =?UTF-8?Q?Krzysztof_Koz=C5=82owski?= <k.kozlowski@samsung.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, msivasub@codeaurora.org, Andy Gross <agross@codeaurora.org>, Stephen Boyd <sboyd@codeaurora.org>

On 3 September 2015 at 21:58, Lina Iyer <lina.iyer@linaro.org> wrote:
> Generic Power Domains currently support turning on/off only in proces=
s
> context. This prevents the usage of PM domains for domains that could=
 be
> powered on/off in a context where IRQs are disabled. Many such domain=
s
> exist today and do not get powered off, when the IRQ safe devices in
> that domain are powered off, because of this limitation.
>
> However, not all domains can operate in IRQ safe contexts. Genpd
> therefore, has to support both cases where the domain may or may not
> operate in IRQ safe contexts. Configuring genpd to use an appropriate
> lock for that domain, would allow domains that have IRQ safe devices =
to
> runtime suspend and resume, in atomic context.
>
> To achieve domain specific locking, set the domain's ->flag to
> GENPD_FLAG_IRQ_SAFE while defining the domain. This indicates that ge=
npd
> should use a spinlock instead of a mutex for locking the domain. Lock=
ing
> is abstracted through genpd_lock() and genpd_unlock() functions that =
use
> the flag to determine the appropriate lock to be used for that domain=
=2E
> Domains that have lower latency to suspend and resume and can operate
> with IRQs disabled may now be able to save power, when the component
> devices and sub-domains are idle at runtime.
>
> The restriction this imposes on the domain hierarchy is that sub-doma=
ins
> and all devices in the IRQ safe domain's hierarchy also have to be IR=
Q
> safe, so that we dont try to lock a mutex, while holding a spinlock.

Moreover we can't have IRQ safe domains mixed with non-IRQ safe
subdomains domains, right?

> Non-IRQ safe domains may continue to have devices and sub-domains tha=
t
> may or may not be IRQ safe.
>
> Cc: Ulf Hansson <ulf.hansson@linaro.org>
> Cc: Kevin Hilman <khilman@linaro.org>
> Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> Cc: Krzysztof Koz=C5=82owski <k.kozlowski@samsung.com>
> Signed-off-by: Lina Iyer <lina.iyer@linaro.org>
> ---
>  Documentation/power/devices.txt |  11 ++-
>  drivers/base/power/domain.c     | 212 ++++++++++++++++++++++++++++++=
++--------
>  include/linux/pm_domain.h       |  11 ++-
>  3 files changed, 189 insertions(+), 45 deletions(-)
>
> diff --git a/Documentation/power/devices.txt b/Documentation/power/de=
vices.txt
> index 8ba6625..bde6141 100644
> --- a/Documentation/power/devices.txt
> +++ b/Documentation/power/devices.txt
> @@ -607,7 +607,16 @@ individually.  Instead, a set of devices sharing=
 a power resource can be put
>  into a low-power state together at the same time by turning off the =
shared
>  power resource.  Of course, they also need to be put into the full-p=
ower state
>  together, by turning the shared power resource on.  A set of devices=
 with this
> -property is often referred to as a power domain.
> +property is often referred to as a power domain. A power domain may =
also be
> +nested inside another power domain.

This seems like a separate change.

> +
> +Devices, by default, operate in process context and if a device can =
operate in
> +IRQ safe context, has to be explicitly set as IRQ safe. Power domain=
s by
> +default, operate in process context but could have devices that are =
IRQ safe.
> +Such power domains cannot be powered on/off during runtime PM. On th=
e other
> +hand, an IRQ safe PM domain that can be powered on/off and suspended=
 or resumed
> +in an atomic context, may contain IRQ safe devices. Such domains may=
 only
> +contain IRQ safe devices or IRQ safe sub-domains.

This is combination of describing the current behaviour and the
changed behaviour after @subject patch. Could you please split this
into separate patches?

>
>  Support for power domains is provided through the pm_domain field of=
 struct
>  device.  This field is a pointer to an object of type struct dev_pm_=
domain,
> diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.=
c
> index ef8d19f..9849338 100644
> --- a/drivers/base/power/domain.c
> +++ b/drivers/base/power/domain.c
> @@ -53,6 +53,80 @@
>  static LIST_HEAD(gpd_list);
>  static DEFINE_MUTEX(gpd_list_lock);
>
> +static inline int genpd_lock_nosleep(struct generic_pm_domain *genpd=
,
> +                                       unsigned int subclass)
> +       __acquires(&genpd->slock)
> +{
> +       unsigned long flags;
> +
> +       if (subclass > 0)
> +               spin_lock_irqsave_nested(&genpd->slock, flags, subcla=
ss);
> +       else
> +               spin_lock_irqsave(&genpd->slock, flags);
> +
> +       genpd->lock_flags =3D flags;
> +       return 0;
> +}
> +
> +static inline void genpd_unlock_nosleep(struct generic_pm_domain *ge=
npd)
> +       __releases(&genpd->slock)
> +{
> +       spin_unlock_irqrestore(&genpd->slock, genpd->lock_flags);
> +}
> +
> +static inline int genpd_lock_irq(struct generic_pm_domain *genpd,
> +                                       unsigned int subclass)
> +       __acquires(&genpd->mlock)
> +{
> +       if (subclass > 0)
> +               mutex_lock_nested(&genpd->mlock, subclass);
> +       else
> +               mutex_lock(&genpd->mlock);
> +       return 0;
> +}
> +
> +static inline int genpd_lock_interruptible_irq(struct generic_pm_dom=
ain *genpd)
> +       __acquires(&genpd->mlock)
> +{
> +       return mutex_lock_interruptible(&genpd->mlock);
> +}
> +
> +static inline void genpd_unlock_irq(struct generic_pm_domain *genpd)
> +       __releases(&genpd->mlock)
> +{
> +       mutex_unlock(&genpd->mlock);
> +}
> +
> +static inline int genpd_lock(struct generic_pm_domain *genpd)
> +{
> +       return genpd->irq_safe ? genpd_lock_nosleep(genpd, 0)
> +                       : genpd_lock_irq(genpd, 0);
> +}
> +
> +static inline int genpd_lock_nested(struct generic_pm_domain *genpd)
> +{
> +       return genpd->irq_safe ? genpd_lock_nosleep(genpd, SINGLE_DEP=
TH_NESTING)
> +                       : genpd_lock_irq(genpd, SINGLE_DEPTH_NESTING)=
;
> +}
> +
> +static inline int genpd_lock_interruptible(struct generic_pm_domain =
*genpd)
> +{
> +       return genpd->irq_safe ? genpd_lock_nosleep(genpd, 0)
> +                       : genpd_lock_interruptible_irq(genpd);
> +}
> +
> +static inline void genpd_unlock(struct generic_pm_domain *genpd)
> +{
> +       return genpd->irq_safe ? genpd_unlock_nosleep(genpd)
> +                       : genpd_unlock_irq(genpd);
> +}

I think all the above functions that check the genpd->irq_safe flag
can be converted into dealing only with one type of lock, and then
assigned as functions pointers at initialization, depending on the
configuration.

This would mean we don't need to check the genpd->irq_safe each time
we acquire or release a lock.

> +
> +static inline bool irq_safe_dev_in_no_sleep_domain(struct device *de=
v,
> +               struct generic_pm_domain *genpd)
> +{
> +       return dev->power.irq_safe && !genpd->irq_safe;
> +}
> +
>  static struct generic_pm_domain *pm_genpd_lookup_name(const char *do=
main_name)
>  {
>         struct generic_pm_domain *genpd =3D NULL, *gpd;
> @@ -273,9 +347,9 @@ int pm_genpd_poweron(struct generic_pm_domain *ge=
npd)
>  {
>         int ret;
>
> -       mutex_lock(&genpd->lock);
> +       genpd_lock(genpd);
>         ret =3D __pm_genpd_poweron(genpd);
> -       mutex_unlock(&genpd->lock);
> +       genpd_unlock(genpd);
>         return ret;
>  }
>
> @@ -335,9 +409,9 @@ static int genpd_dev_pm_qos_notifier(struct notif=
ier_block *nb,
>                 spin_unlock_irq(&dev->power.lock);
>
>                 if (!IS_ERR(genpd)) {
> -                       mutex_lock(&genpd->lock);
> +                       genpd_lock(genpd);
>                         genpd->max_off_time_changed =3D true;
> -                       mutex_unlock(&genpd->lock);
> +                       genpd_unlock(genpd);
>                 }
>
>                 dev =3D dev->parent;
> @@ -394,8 +468,17 @@ static int pm_genpd_poweroff(struct generic_pm_d=
omain *genpd)
>                 if (stat > PM_QOS_FLAGS_NONE)
>                         return -EBUSY;
>
> -               if (!pm_runtime_suspended(pdd->dev) || pdd->dev->powe=
r.irq_safe)

I don't remember having above line in genpd. I guess you missed to
include the below patch within in this patchset:
"PM / Domains: Remove dev->driver check for runtime PM".

> +               /*
> +                * We do not want to power off the domain if the devi=
ce is
> +                * not suspended or an IRQ safe device is part of thi=
s
> +                * non-IRQ safe domain.
> +                */
> +               if (!pm_runtime_suspended(pdd->dev) ||
> +                       irq_safe_dev_in_no_sleep_domain(pdd->dev, gen=
pd))
>                         not_suspended++;
> +               WARN_ONCE(irq_safe_dev_in_no_sleep_domain(pdd->dev, g=
enpd),
> +                               "PM domain %s will not be powered off=
\n",
> +                               genpd->name);
>         }
>
>         if (not_suspended > genpd->in_progress)
> @@ -460,9 +543,9 @@ static void genpd_power_off_work_fn(struct work_s=
truct *work)
>
>         genpd =3D container_of(work, struct generic_pm_domain, power_=
off_work);
>
> -       mutex_lock(&genpd->lock);
> +       genpd_lock(genpd);
>         pm_genpd_poweroff(genpd);
> -       mutex_unlock(&genpd->lock);
> +       genpd_unlock(genpd);
>  }
>
>  /**
> @@ -500,17 +583,21 @@ static int pm_genpd_runtime_suspend(struct devi=
ce *dev)
>         }
>
>         /*
> -        * If power.irq_safe is set, this routine will be run with in=
terrupts
> -        * off, so it can't use mutexes.
> +        * If power.irq_safe is set, this routine may be run with
> +        * IRQ disabled, so suspend only if the power domain is
> +        * irq_safe.

Maybe elaborate on that the locking mechanism differ, which is why we
can't proceed in some cases...

>          */
> -       if (dev->power.irq_safe)
> +       WARN_ONCE(irq_safe_dev_in_no_sleep_domain(dev, genpd),
> +                       "genpd %s will not be powered off\n", genpd->=
name);

Perhaps, unless the string becomes too long, some information about *wh=
y*.

> +       if (irq_safe_dev_in_no_sleep_domain(dev, genpd))
>                 return 0;
>
> -       mutex_lock(&genpd->lock);
> +       genpd_lock(genpd);
> +
>         genpd->in_progress++;
>         pm_genpd_poweroff(genpd);
>         genpd->in_progress--;
> -       mutex_unlock(&genpd->lock);
> +       genpd_unlock(genpd);
>
>         return 0;
>  }
> @@ -535,15 +622,18 @@ static int pm_genpd_runtime_resume(struct devic=
e *dev)
>         if (IS_ERR(genpd))
>                 return -EINVAL;
>
> -       /* If power.irq_safe, the PM domain is never powered off. */
> -       if (dev->power.irq_safe) {
> +       /*
> +        * As we dont power off a non IRQ safe domain, which holds
> +        * an IRQ safe device, we dont need to restore power to it.
> +        */
> +       if (dev->power.irq_safe && !genpd->irq_safe) {
>                 timed =3D false;
>                 goto out;
>         }
>
> -       mutex_lock(&genpd->lock);
> +       genpd_lock(genpd);
>         ret =3D __pm_genpd_poweron(genpd);
> -       mutex_unlock(&genpd->lock);
> +       genpd_unlock(genpd);
>
>         if (ret)
>                 return ret;
> @@ -743,14 +833,14 @@ static int pm_genpd_prepare(struct device *dev)
>         if (resume_needed(dev, genpd))
>                 pm_runtime_resume(dev);
>
> -       mutex_lock(&genpd->lock);
> +       genpd_lock(genpd);
>
>         if (genpd->prepared_count++ =3D=3D 0) {
>                 genpd->suspended_count =3D 0;
>                 genpd->suspend_power_off =3D genpd->status =3D=3D GPD=
_STATE_POWER_OFF;
>         }
>
> -       mutex_unlock(&genpd->lock);
> +       genpd_unlock(genpd);
>
>         if (genpd->suspend_power_off) {
>                 pm_runtime_put_noidle(dev);
> @@ -768,12 +858,12 @@ static int pm_genpd_prepare(struct device *dev)
>
>         ret =3D pm_generic_prepare(dev);
>         if (ret) {
> -               mutex_lock(&genpd->lock);
> +               genpd_lock(genpd);
>
>                 if (--genpd->prepared_count =3D=3D 0)
>                         genpd->suspend_power_off =3D false;
>
> -               mutex_unlock(&genpd->lock);
> +               genpd_unlock(genpd);
>                 pm_runtime_enable(dev);
>         }
>
> @@ -1130,13 +1220,13 @@ static void pm_genpd_complete(struct device *=
dev)
>         if (IS_ERR(genpd))
>                 return;
>
> -       mutex_lock(&genpd->lock);
> +       genpd_lock(genpd);
>
>         run_complete =3D !genpd->suspend_power_off;
>         if (--genpd->prepared_count =3D=3D 0)
>                 genpd->suspend_power_off =3D false;
>
> -       mutex_unlock(&genpd->lock);
> +       genpd_unlock(genpd);
>
>         if (run_complete) {
>                 pm_generic_complete(dev);
> @@ -1280,11 +1370,18 @@ int __pm_genpd_add_device(struct generic_pm_d=
omain *genpd, struct device *dev,
>         if (IS_ERR_OR_NULL(genpd) || IS_ERR_OR_NULL(dev))
>                 return -EINVAL;
>
> +       if (genpd->irq_safe && !dev->power.irq_safe) {
> +               dev_err(dev,
> +                       "PM Domain %s is IRQ safe; device has to IRQ =
safe.\n",

/s/; device has to IRQ safe/, but device isn't.

> +                       genpd->name);
> +               return -EINVAL;
> +       }
> +
>         gpd_data =3D genpd_alloc_dev_data(dev, genpd, td);
>         if (IS_ERR(gpd_data))
>                 return PTR_ERR(gpd_data);
>
> -       mutex_lock(&genpd->lock);
> +       genpd_lock(genpd);
>
>         if (genpd->prepared_count > 0) {
>                 ret =3D -EAGAIN;
> @@ -1301,7 +1398,7 @@ int __pm_genpd_add_device(struct generic_pm_dom=
ain *genpd, struct device *dev,
>         list_add_tail(&gpd_data->base.list_node, &genpd->dev_list);
>
>   out:
> -       mutex_unlock(&genpd->lock);
> +       genpd_unlock(genpd);
>
>         if (ret)
>                 genpd_free_dev_data(dev, gpd_data);
> @@ -1345,7 +1442,7 @@ int pm_genpd_remove_device(struct generic_pm_do=
main *genpd,
>         gpd_data =3D to_gpd_data(pdd);
>         dev_pm_qos_remove_notifier(dev, &gpd_data->nb);
>
> -       mutex_lock(&genpd->lock);
> +       genpd_lock(genpd);
>
>         if (genpd->prepared_count > 0) {
>                 ret =3D -EAGAIN;
> @@ -1360,14 +1457,14 @@ int pm_genpd_remove_device(struct generic_pm_=
domain *genpd,
>
>         list_del_init(&pdd->list_node);
>
> -       mutex_unlock(&genpd->lock);
> +       genpd_unlock(genpd);
>
>         genpd_free_dev_data(dev, gpd_data);
>
>         return 0;
>
>   out:
> -       mutex_unlock(&genpd->lock);
> +       genpd_unlock(genpd);
>         dev_pm_qos_add_notifier(dev, &gpd_data->nb);
>
>         return ret;
> @@ -1388,12 +1485,23 @@ int pm_genpd_add_subdomain(struct generic_pm_=
domain *genpd,
>             || genpd =3D=3D subdomain)
>                 return -EINVAL;
>
> +       /*
> +        * If the domain can be powered on/off in an IRQ safe
> +        * context, ensure that the subdomain can also be
> +        * powered on/off in that context.
> +        */
> +       if (genpd->irq_safe && !subdomain->irq_safe) {

Is this really enough? What if the subdomain is IRQ safe but its
parent isn't, that's not allowed either, right?

> +               WARN("Sub-domain (%s) in an IRQ-safe domain (%s) has =
to be IRQ safe\n",
> +                               subdomain->name, genpd->name);
> +               return -EINVAL;
> +       }
> +
>         link =3D kzalloc(sizeof(*link), GFP_KERNEL);
>         if (!link)
>                 return -ENOMEM;
>
> -       mutex_lock(&genpd->lock);
> -       mutex_lock_nested(&subdomain->lock, SINGLE_DEPTH_NESTING);
> +       genpd_lock(genpd);
> +       genpd_lock_nested(subdomain);
>
>         if (genpd->status =3D=3D GPD_STATE_POWER_OFF
>             &&  subdomain->status !=3D GPD_STATE_POWER_OFF) {
> @@ -1416,8 +1524,8 @@ int pm_genpd_add_subdomain(struct generic_pm_do=
main *genpd,
>                 genpd_sd_counter_inc(genpd);
>
>   out:
> -       mutex_unlock(&subdomain->lock);
> -       mutex_unlock(&genpd->lock);
> +       genpd_unlock(subdomain);
> +       genpd_unlock(genpd);
>         if (ret)
>                 kfree(link);
>         return ret;
> @@ -1466,13 +1574,13 @@ int pm_genpd_remove_subdomain(struct generic_=
pm_domain *genpd,
>         if (IS_ERR_OR_NULL(genpd) || IS_ERR_OR_NULL(subdomain))
>                 return -EINVAL;
>
> -       mutex_lock(&genpd->lock);
> +       genpd_lock(genpd);
>
>         list_for_each_entry(link, &genpd->master_links, master_node) =
{
>                 if (link->slave !=3D subdomain)
>                         continue;
>
> -               mutex_lock_nested(&subdomain->lock, SINGLE_DEPTH_NEST=
ING);
> +               genpd_lock_nested(subdomain);
>
>                 list_del(&link->master_node);
>                 list_del(&link->slave_node);
> @@ -1480,13 +1588,13 @@ int pm_genpd_remove_subdomain(struct generic_=
pm_domain *genpd,
>                 if (subdomain->status !=3D GPD_STATE_POWER_OFF)
>                         genpd_sd_counter_dec(genpd);
>
> -               mutex_unlock(&subdomain->lock);
> +               genpd_unlock(subdomain);
>
>                 ret =3D 0;
>                 break;
>         }
>
> -       mutex_unlock(&genpd->lock);
> +       genpd_unlock(genpd);
>
>         return ret;
>  }
> @@ -1510,11 +1618,17 @@ int pm_genpd_attach_cpuidle(struct generic_pm=
_domain *genpd, int state)
>         if (IS_ERR_OR_NULL(genpd) || state < 0)
>                 return -EINVAL;
>
> +       if (genpd->irq_safe) {
> +               WARN("Domain %s is IRQ safe, cannot attach to cpuidle=
\n",
> +                               genpd->name);
> +               return -EINVAL;
> +       }
> +
>         cpuidle_data =3D kzalloc(sizeof(*cpuidle_data), GFP_KERNEL);
>         if (!cpuidle_data)
>                 return -ENOMEM;
>
> -       mutex_lock(&genpd->lock);
> +       genpd_lock(genpd);
>
>         if (genpd->cpuidle_data) {
>                 ret =3D -EEXIST;
> @@ -1541,7 +1655,7 @@ int pm_genpd_attach_cpuidle(struct generic_pm_d=
omain *genpd, int state)
>         genpd_recalc_cpu_exit_latency(genpd);
>
>   out:
> -       mutex_unlock(&genpd->lock);
> +       genpd_unlock(genpd);
>         return ret;
>
>   err:
> @@ -1578,7 +1692,7 @@ int pm_genpd_detach_cpuidle(struct generic_pm_d=
omain *genpd)
>         if (IS_ERR_OR_NULL(genpd))
>                 return -EINVAL;
>
> -       mutex_lock(&genpd->lock);
> +       genpd_lock(genpd);
>
>         cpuidle_data =3D genpd->cpuidle_data;
>         if (!cpuidle_data) {
> @@ -1596,7 +1710,7 @@ int pm_genpd_detach_cpuidle(struct generic_pm_d=
omain *genpd)
>         kfree(cpuidle_data);
>
>   out:
> -       mutex_unlock(&genpd->lock);
> +       genpd_unlock(genpd);
>         return ret;
>  }
>
> @@ -1657,6 +1771,17 @@ static int pm_genpd_default_restore_state(stru=
ct device *dev)
>         return cb ? cb(dev) : 0;
>  }
>
> +static void genpd_lock_init(struct generic_pm_domain *genpd)
> +{
> +       if (genpd->flags & GENPD_FLAG_IRQ_SAFE) {
> +               spin_lock_init(&genpd->slock);
> +               genpd->irq_safe =3D true;
> +       } else {
> +               mutex_init(&genpd->mlock);
> +               genpd->irq_safe =3D false;
> +       }

As I stated earlier around having function pointers, this would be the
place where to assign them I guess.

> +}
> +
>  /**
>   * pm_genpd_init - Initialize a generic I/O PM domain object.
>   * @genpd: PM domain object to initialize.
> @@ -1672,7 +1797,7 @@ void pm_genpd_init(struct generic_pm_domain *ge=
npd,
>         INIT_LIST_HEAD(&genpd->master_links);
>         INIT_LIST_HEAD(&genpd->slave_links);
>         INIT_LIST_HEAD(&genpd->dev_list);
> -       mutex_init(&genpd->lock);
> +       genpd_lock_init(genpd);
>         genpd->gov =3D gov;
>         INIT_WORK(&genpd->power_off_work, genpd_power_off_work_fn);
>         genpd->in_progress =3D 0;
> @@ -2067,7 +2192,7 @@ static int pm_genpd_summary_one(struct seq_file=
 *s,
>         struct gpd_link *link;
>         int ret;
>
> -       ret =3D mutex_lock_interruptible(&genpd->lock);
> +       ret =3D genpd_lock_interruptible(genpd);
>         if (ret)
>                 return -ERESTARTSYS;
>
> @@ -2087,7 +2212,8 @@ static int pm_genpd_summary_one(struct seq_file=
 *s,
>         }
>
>         list_for_each_entry(pm_data, &genpd->dev_list, list_node) {
> -               kobj_path =3D kobject_get_path(&pm_data->dev->kobj, G=
=46P_KERNEL);
> +               kobj_path =3D kobject_get_path(&pm_data->dev->kobj,
> +                               genpd->irq_safe ? GFP_ATOMIC : GFP_KE=
RNEL);
>                 if (kobj_path =3D=3D NULL)
>                         continue;
>
> @@ -2098,7 +2224,7 @@ static int pm_genpd_summary_one(struct seq_file=
 *s,
>
>         seq_puts(s, "\n");
>  exit:
> -       mutex_unlock(&genpd->lock);
> +       genpd_unlock(genpd);
>
>         return 0;
>  }
> diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
> index b2725e6..dc7cb53 100644
> --- a/include/linux/pm_domain.h
> +++ b/include/linux/pm_domain.h
> @@ -16,9 +16,11 @@
>  #include <linux/of.h>
>  #include <linux/notifier.h>
>  #include <linux/cpuidle.h>
> +#include <linux/spinlock.h>
>
>  /* Defines used for the flags field in the struct generic_pm_domain =
*/
>  #define GENPD_FLAG_PM_CLK      (1U << 0) /* PM domain uses PM clk */
> +#define GENPD_FLAG_IRQ_SAFE    (1U << 1) /* PM domain operates in at=
omic */
>
>  enum gpd_status {
>         GPD_STATE_ACTIVE =3D 0,   /* PM domain is active */
> @@ -49,7 +51,6 @@ struct generic_pm_domain {
>         struct list_head master_links;  /* Links with PM domain as a =
master */
>         struct list_head slave_links;   /* Links with PM domain as a =
slave */
>         struct list_head dev_list;      /* List of devices */
> -       struct mutex lock;
>         struct dev_power_governor *gov;
>         struct work_struct power_off_work;
>         const char *name;
> @@ -74,6 +75,14 @@ struct generic_pm_domain {
>         void (*detach_dev)(struct generic_pm_domain *domain,
>                            struct device *dev);
>         unsigned int flags;             /* Bit field of configs for g=
enpd */
> +       bool irq_safe;

If you convert to functions pointers, perhaps you can remove the
irq_safe bool here, and instead only use the flags field.

> +       union {
> +               struct mutex mlock;
> +               struct {
> +                       spinlock_t slock;
> +                       unsigned long lock_flags;
> +               };
> +       };
>  };
>
>  static inline struct generic_pm_domain *pd_to_genpd(struct dev_pm_do=
main *pd)
> --
> 2.1.4
>

Kind regards
Uffe
