From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH][RFC] PM / Domains: Add on-off notifiers
Date: Mon, 18 Mar 2013 14:08:30 +0100
Message-ID: <CAPDyKFouP5WLhJdR=iVqPEs63cjWgFXs3k_AOq2twq97YN6A4w@mail.gmail.com>
References: <1363351143-28490-1-git-send-email-rickard.andersson@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-la0-f50.google.com ([209.85.215.50]:44044 "EHLO
	mail-la0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751190Ab3CRNIf (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 18 Mar 2013 09:08:35 -0400
Received: by mail-la0-f50.google.com with SMTP id ec20so6055005lab.37
        for <linux-pm@vger.kernel.org>; Mon, 18 Mar 2013 06:08:30 -0700 (PDT)
In-Reply-To: <1363351143-28490-1-git-send-email-rickard.andersson@stericsson.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rickard Andersson <rickard.andersson@stericsson.com>
Cc: linux-pm@vger.kernel.org

On 15 March 2013 13:39, Rickard Andersson
<rickard.andersson@stericsson.com> wrote:
> Some drivers needs to restore their context directly
> when a power domain is activated. For example a driver
> handling system bus settings must be able to restore
> context before the bus is being used for the first time.
> Other examples could be clock settings hardware blocks and
> special debugging hardware blocks which should be restored
> as early as possible in order to be able to debug direcly
> from waking up. Typically these notifers are needed in
> systems with CPU coupled power domains. The notifiers
> are intended to be trigged by cpuidle driver or the
> suspend ops hooks.
>
> The drivers that needs to use these notifiers are
> some special cases. Most drivers should not use this
> method and instead control their context via the
> pm_runtime interface.
>
> Signed-off-by: Rickard Andersson <rickard.andersson@stericsson.com>
> ---
>  drivers/base/power/domain.c | 64 +++++++++++++++++++++++++++++++++++++++++++++
>  include/linux/pm_domain.h   | 22 ++++++++++++++++
>  2 files changed, 86 insertions(+)
>
> diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
> index 9a6b05a..16fbc52 100644
> --- a/drivers/base/power/domain.c
> +++ b/drivers/base/power/domain.c
> @@ -1955,6 +1955,69 @@ int pm_genpd_name_detach_cpuidle(const char *name)
>         return pm_genpd_detach_cpuidle(pm_genpd_lookup_name(name));
>  }
>
> +/**
> + * pm_genpd_register_on_off_notifier - Register to early power on /
> + * late power off notifications.
> + * Only use this function if absolutly needed. It is only intended to be
> + * used for power domains that are coupled with the CPU, that is, power
> + * domains being controlled from cpuidle and the platform suspend ops hooks.
> + * Also only devices that needs their context to be restored directly when
> + * leaving a sleep state should use this method. Most devices should be
> + * fine handling their context and power domains via pm_runtime.
> + * @dev: Device to register.
> + * @nb: Notifier block to be registered.
> + */
> +int pm_genpd_register_on_off_notifier(struct device *dev,
> +                                     struct notifier_block *nb)
> +{
> +       struct generic_pm_domain *genpd;
> +
> +       dev_dbg(dev, "%s()\n", __func__);
> +
> +       genpd = dev_to_genpd(dev);
> +
> +       return atomic_notifier_chain_register(&genpd->on_off_notifier, nb);
> +}
> +
> +/**
> + * pm_genpd_unregister_on_off_notifier - Unregister to early power on /
> + * late power off notification.
> + * @dev: Device to unregister.
> + * @nb: Notifier block to be unregistered.
> + */
> +int pm_genpd_unregister_on_off_notifier(struct device *dev,
> +                                       struct notifier_block *nb)
> +{
> +       struct generic_pm_domain *genpd;
> +
> +       dev_dbg(dev, "%s()\n", __func__);
> +
> +       genpd = dev_to_genpd(dev);
> +
> +       return atomic_notifier_chain_unregister(&genpd->on_off_notifier, nb);
> +}
> +
> +/**
> + * pm_genpd_notify_power_on_off - Notify that the CPU coupled power
> + * domain is going to be powered off or has been powered on.
> + * Intended users of this function are cpuidle drivers and the platform
> + * suspend operations implementation.
> + * @genpd: pm domain that will change state.
> + * @nb: true = has been powered on, false = will power off.
> + */
> +int pm_genpd_notify_power_on_off(struct generic_pm_domain *genpd,
> +                                bool power_on_off)
> +{
> +       if (IS_ERR_OR_NULL(genpd))
> +               return -EINVAL;
> +
> +       atomic_notifier_call_chain((&genpd->on_off_notifier),
> +                                  power_on_off, NULL);
> +
> +       return 0;
> +}
> +
> +
>  /* Default device callbacks for generic PM domains. */
>
>  /**
> @@ -2136,6 +2199,7 @@ void pm_genpd_init(struct generic_pm_domain *genpd,
>         atomic_set(&genpd->sd_count, 0);
>         genpd->status = is_off ? GPD_STATE_POWER_OFF : GPD_STATE_ACTIVE;
>         init_waitqueue_head(&genpd->status_wait_queue);
> +       ATOMIC_INIT_NOTIFIER_HEAD(&genpd->on_off_notifier);
>         genpd->poweroff_task = NULL;
>         genpd->resume_count = 0;
>         genpd->device_count = 0;
> diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
> index 7c1d252..a0a9cf7 100644
> --- a/include/linux/pm_domain.h
> +++ b/include/linux/pm_domain.h
> @@ -82,6 +82,7 @@ struct generic_pm_domain {
>         bool cached_power_down_ok;
>         struct device_node *of_node; /* Node in device tree */
>         struct gpd_cpu_data *cpu_data;
> +       struct atomic_notifier_head on_off_notifier;
>  };
>
>  static inline struct generic_pm_domain *pd_to_genpd(struct dev_pm_domain *pd)
> @@ -159,6 +160,12 @@ extern int pm_genpd_attach_cpuidle(struct generic_pm_domain *genpd, int state);
>  extern int pm_genpd_name_attach_cpuidle(const char *name, int state);
>  extern int pm_genpd_detach_cpuidle(struct generic_pm_domain *genpd);
>  extern int pm_genpd_name_detach_cpuidle(const char *name);
> +extern int pm_genpd_register_on_off_notifier(struct device *dev,
> +                                            struct notifier_block *nb);
> +int pm_genpd_unregister_on_off_notifier(struct device *dev,
> +                                       struct notifier_block *nb);
> +int pm_genpd_notify_power_on_off(struct generic_pm_domain *genpd,
> +                                 bool power_on_off);
>  extern void pm_genpd_init(struct generic_pm_domain *genpd,
>                           struct dev_power_governor *gov, bool is_off);
>
> @@ -243,6 +250,21 @@ static inline int pm_genpd_name_detach_cpuidle(const char *name)
>  {
>         return -ENOSYS;
>  }
> +static inline int pm_genpd_register_on_off_notifier(struct device *dev,
> +                                            struct notifier_block *nb)
> +{
> +       return -ENOSYS;
> +}
> +int pm_genpd_unregister_on_off_notifier(struct device *dev,
> +                                       struct notifier_block *nb)
> +{
> +       return -ENOSYS;
> +}
> +int pm_genpd_notify_power_on_off(struct generic_pm_domain *genpd,
> +                                 bool power_on_off)
> +{
> +       return -ENOSYS;
> +}
>  static inline void pm_genpd_init(struct generic_pm_domain *genpd,
>                                  struct dev_power_governor *gov, bool is_off)
>  {
> --
> 1.8.0
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pm" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

This makes sense to me.
Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
