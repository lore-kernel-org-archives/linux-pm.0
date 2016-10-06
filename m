From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 7/8] PM / Domains: Support IRQ safe PM domains
Date: Thu, 6 Oct 2016 13:34:58 +0200
Message-ID: <CAPDyKFoqx9demH=NXj13s5NqG9zJw+OnYRki+FSXYmULhirU_A@mail.gmail.com>
References: <1475699519-109623-1-git-send-email-lina.iyer@linaro.org> <1475699519-109623-8-git-send-email-lina.iyer@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <1475699519-109623-8-git-send-email-lina.iyer@linaro.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Lina Iyer <lina.iyer@linaro.org>
Cc: Kevin Hilman <khilman@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Andy Gross <andy.gross@linaro.org>, Stephen Boyd <sboyd@codeaurora.org>, "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>, Brendan Jackman <brendan.jackman@arm.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Sudeep Holla <sudeep.holla@arm.com>, Juri Lelli <Juri.Lelli@arm.com>
List-Id: linux-pm@vger.kernel.org

On 5 October 2016 at 22:31, Lina Iyer <lina.iyer@linaro.org> wrote:
> Generic Power Domains currently support turning on/off only in process
> context. This prevents the usage of PM domains for domains that could be
> powered on/off in a context where IRQs are disabled. Many such domains
> exist today and do not get powered off, when the IRQ safe devices in
> that domain are powered off, because of this limitation.
>
> However, not all domains can operate in IRQ safe contexts. Genpd
> therefore, has to support both cases where the domain may or may not
> operate in IRQ safe contexts. Configuring genpd to use an appropriate
> lock for that domain, would allow domains that have IRQ safe devices to
> runtime suspend and resume, in atomic context.
>
> To achieve domain specific locking, set the domain's ->flag to
> GENPD_FLAG_IRQ_SAFE while defining the domain. This indicates that genpd
> should use a spinlock instead of a mutex for locking the domain. Locking
> is abstracted through genpd_lock() and genpd_unlock() functions that use
> the flag to determine the appropriate lock to be used for that domain.
>
> Domains that have lower latency to suspend and resume and can operate
> with IRQs disabled may now be able to save power, when the component
> devices and sub-domains are idle at runtime.
>
> The restriction this imposes on the domain hierarchy is that non-IRQ
> safe domains may not have IRQ-safe subdomains, but IRQ safe domains may
> have IRQ safe and non-IRQ safe subdomains and devices.
>
> Cc: Ulf Hansson <ulf.hansson@linaro.org>
> Cc: Kevin Hilman <khilman@kernel.org>
> Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
> Signed-off-by: Lina Iyer <lina.iyer@linaro.org>
> ---
>  drivers/base/power/domain.c | 107 +++++++++++++++++++++++++++++++++++++++-----
>  include/linux/pm_domain.h   |  10 ++++-
>  2 files changed, 106 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
> index 82e6a33..77e92c2 100644
> --- a/drivers/base/power/domain.c
> +++ b/drivers/base/power/domain.c
> @@ -74,11 +74,61 @@ static const struct genpd_lock_fns genpd_mtx_fns  = {
>         .unlock = genpd_unlock_mtx,
>  };
>
> +static void genpd_lock_spin(struct generic_pm_domain *genpd)
> +       __acquires(&genpd->slock)
> +{
> +       unsigned long flags;
> +
> +       spin_lock_irqsave(&genpd->slock, flags);
> +       genpd->lock_flags = flags;
> +}
> +
> +static void genpd_lock_nested_spin(struct generic_pm_domain *genpd,
> +                                       int depth)
> +       __acquires(&genpd->slock)
> +{
> +       unsigned long flags;
> +
> +       spin_lock_irqsave_nested(&genpd->slock, flags, depth);
> +       genpd->lock_flags = flags;
> +}
> +
> +static int genpd_lock_interruptible_spin(struct generic_pm_domain *genpd)
> +       __acquires(&genpd->slock)
> +{
> +       unsigned long flags;
> +
> +       spin_lock_irqsave(&genpd->slock, flags);
> +       genpd->lock_flags = flags;
> +       return 0;
> +}
> +
> +static void genpd_unlock_spin(struct generic_pm_domain *genpd)
> +       __releases(&genpd->slock)
> +{
> +       spin_unlock_irqrestore(&genpd->slock, genpd->lock_flags);
> +}
> +
> +static const struct genpd_lock_fns genpd_spin_fns = {
> +       .lock = genpd_lock_spin,
> +       .lock_nested = genpd_lock_nested_spin,
> +       .lock_interruptible = genpd_lock_interruptible_spin,
> +       .unlock = genpd_unlock_spin,
> +};
> +
>  #define genpd_lock(p)                  p->lock_fns->lock(p)
>  #define genpd_lock_nested(p, d)                p->lock_fns->lock_nested(p, d)
>  #define genpd_lock_interruptible(p)    p->lock_fns->lock_interruptible(p)
>  #define genpd_unlock(p)                        p->lock_fns->unlock(p)
>
> +#define genpd_is_irq_safe(genpd)       (genpd->flags & GENPD_FLAG_IRQ_SAFE)
> +
> +static inline bool irq_safe_dev_in_no_sleep_domain(struct device *dev,
> +               struct generic_pm_domain *genpd)
> +{
> +       return pm_runtime_is_irq_safe(dev) && !genpd_is_irq_safe(genpd);
> +}
> +
>  /*
>   * Get the generic PM domain for a particular struct device.
>   * This validates the struct device pointer, the PM domain pointer,
> @@ -343,7 +393,12 @@ static int genpd_poweroff(struct generic_pm_domain *genpd, bool is_async)
>                 if (stat > PM_QOS_FLAGS_NONE)
>                         return -EBUSY;
>
> -               if (!pm_runtime_suspended(pdd->dev) || pdd->dev->power.irq_safe)
> +               /*
> +                * Do not allow PM domain to be powered off, when an IRQ safe
> +                * device is part of a non-IRQ safe domain.
> +                */
> +               if (!pm_runtime_suspended(pdd->dev) ||
> +                       irq_safe_dev_in_no_sleep_domain(pdd->dev, genpd))
>                         not_suspended++;
>         }
>
> @@ -506,10 +561,10 @@ static int genpd_runtime_suspend(struct device *dev)
>         }
>
>         /*
> -        * If power.irq_safe is set, this routine will be run with interrupts
> -        * off, so it can't use mutexes.
> +        * If power.irq_safe is set, this routine may be run with
> +        * IRQs disabled, so suspend only if the PM domain also is irq_safe.
>          */
> -       if (dev->power.irq_safe)
> +       if (irq_safe_dev_in_no_sleep_domain(dev, genpd))
>                 return 0;
>
>         genpd_lock(genpd);
> @@ -543,8 +598,11 @@ static int genpd_runtime_resume(struct device *dev)
>         if (IS_ERR(genpd))
>                 return -EINVAL;
>
> -       /* If power.irq_safe, the PM domain is never powered off. */
> -       if (dev->power.irq_safe) {
> +       /*
> +        * As we don't power off a non IRQ safe domain, which holds
> +        * an IRQ safe device, we don't need to restore power to it.
> +        */
> +       if (irq_safe_dev_in_no_sleep_domain(dev, genpd)) {
>                 timed = false;
>                 goto out;
>         }
> @@ -586,7 +644,8 @@ static int genpd_runtime_resume(struct device *dev)
>  err_stop:
>         genpd_stop_dev(genpd, dev);
>  err_poweroff:
> -       if (!dev->power.irq_safe) {
> +       if (!dev->power.irq_safe ||
> +               (dev->power.irq_safe && genpd_is_irq_safe(genpd))) {

Please take the opportunity to convert into use
pm_runtime_is_irq_safe(), in favour of checking "dev->power.irq_safe".

>                 genpd_lock(genpd);
>                 genpd_poweroff(genpd, 0);
>                 genpd_unlock(genpd);
> @@ -1111,6 +1170,11 @@ static int genpd_add_device(struct generic_pm_domain *genpd, struct device *dev,
>         if (IS_ERR(gpd_data))
>                 return PTR_ERR(gpd_data);
>
> +       /* Check if we are adding an IRQ safe device to non-IRQ safe domain */
> +       if (irq_safe_dev_in_no_sleep_domain(dev, genpd))
> +               dev_warn_once(dev, "PM domain %s will not be powered off\n",
> +                               genpd->name);
> +

It may turn out that a subsystem/driver decides to enable
pm_runtime_irq_safe() for the device at a later point, while probing.
Due to that, this warning is not going to be printed.

If we want this warning printed, I think we should strive towards a
more consistent behaviour. Perhaps we should move this print inside
irq_safe_dev_in_no_sleep_domain()?

[...]

One more thing that popped up in my mind. We currently also have the
"pm_domain_always_on_gov". If we checked for such configuration and
before taking the lock for the genpd during runtime suspend, we would
be able to allow IRQ safe device to be suspended when they reside in
these types of always-on domains, don't you think?

Anyway, you don't need to do that change as part of $subject patch,
but perhaps we might want to extend the support for irq safe devices
later on?

Besides the minor nitpicks, this looks good to me!

Kind regards
Uffe
