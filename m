From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [RFT][PATCH v2 1/2] PM / domains: Rework governor code to be more consistent
Date: Mon, 6 Nov 2017 13:10:03 +0100
Message-ID: <CAPDyKFox_5XN1bV1rG_DJvADnpQLqBQcJFDamkEvpRXRMP7mag@mail.gmail.com>
References: <5770848.Kdi5IjVKeE@aspire.rjw.lan> <2520927.XkLgALY3I0@aspire.rjw.lan>
 <1780873.Ca3tjQj9XB@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-it0-f67.google.com ([209.85.214.67]:56461 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752362AbdKFMKF (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 6 Nov 2017 07:10:05 -0500
Received: by mail-it0-f67.google.com with SMTP id r127so4794820itb.5
        for <linux-pm@vger.kernel.org>; Mon, 06 Nov 2017 04:10:04 -0800 (PST)
In-Reply-To: <1780873.Ca3tjQj9XB@aspire.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Tero Kristo <t-kristo@ti.com>, Reinette Chatre <reinette.chatre@intel.com>, Ramesh Thomas <ramesh.thomas@intel.com>, Alex Shi <alex.shi@linaro.org>

On 3 November 2017 at 12:47, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> The genpd governor currently uses negative PM QoS values to indicate
> the "no suspend" condition and 0 as "no restriction", but it doesn't
> use them consistently.  Moreover, it tries to refresh QoS values for
> already suspended devices in a quite questionable way.
>
> For the above reasons, rework it to be a bit more consistent.
>
> First off, note that dev_pm_qos_read_value() in
> dev_update_qos_constraint() and __default_power_down_ok() is
> evaluated for devices in suspend.  Moreover, that only happens if the
> effective_constraint_ns value for them is negative (meaning "no
> suspend").  It is not evaluated in any other cases, so effectively
> the QoS values are only updated for devices in suspend that should
> not have been suspended in the first place.  In all of the other
> cases, the QoS values taken into account are the effective ones from
> the time before the device has been suspended, so generally devices
> need to be resumed and suspended again for new QoS values to take
> effect anyway.  Thus evaluating dev_update_qos_constraint() in
> those two places doesn't make sense at all, so drop it.
>
> Second, initialize effective_constraint_ns to 0 ("no constraint")
> rather than to (-1) ("no suspend"), which makes more sense in
> general and in case effective_constraint_ns is never updated
> (the device is in suspend all the time or it is never suspended)
> it doesn't affect the device's parent and so on.
>
> Finally, rework default_suspend_ok() to explicitly handle the
> "no restriction" special case.
>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  drivers/base/power/domain.c          |    2 -
>  drivers/base/power/domain_governor.c |   61 +++++++++++++++++++++--------------
>  2 files changed, 38 insertions(+), 25 deletions(-)
>
> Index: linux-pm/drivers/base/power/domain.c
> ===================================================================
> --- linux-pm.orig/drivers/base/power/domain.c
> +++ linux-pm/drivers/base/power/domain.c
> @@ -1331,7 +1331,7 @@ static struct generic_pm_domain_data *ge
>
>         gpd_data->base.dev = dev;
>         gpd_data->td.constraint_changed = true;
> -       gpd_data->td.effective_constraint_ns = -1;
> +       gpd_data->td.effective_constraint_ns = 0;
>         gpd_data->nb.notifier_call = genpd_dev_pm_qos_notifier;
>
>         spin_lock_irq(&dev->power.lock);
> Index: linux-pm/drivers/base/power/domain_governor.c
> ===================================================================
> --- linux-pm.orig/drivers/base/power/domain_governor.c
> +++ linux-pm/drivers/base/power/domain_governor.c
> @@ -14,22 +14,22 @@
>  static int dev_update_qos_constraint(struct device *dev, void *data)
>  {
>         s64 *constraint_ns_p = data;
> -       s32 constraint_ns = -1;
> -
> -       if (dev->power.subsys_data && dev->power.subsys_data->domain_data)
> -               constraint_ns = dev_gpd_data(dev)->td.effective_constraint_ns;
> +       s64 constraint_ns;
>
> -       if (constraint_ns < 0) {
> -               constraint_ns = dev_pm_qos_read_value(dev);
> -               constraint_ns *= NSEC_PER_USEC;
> -       }
> -       if (constraint_ns == 0)
> +       if (!dev->power.subsys_data || !dev->power.subsys_data->domain_data)
>                 return 0;
>
>         /*
> -        * constraint_ns cannot be negative here, because the device has been
> -        * suspended.
> +        * Only take suspend-time QoS constraints of devices into account,
> +        * because constraints updated after the device has been suspended are
> +        * not guaranteed to be taken into account anyway.  In order for them
> +        * to take effect, the device has to be resumed and suspended again.
>          */

This means a change in behavior, because earlier we took into account
QoS values for child devices that were not attached to a genpd.

Is there any reason you think we should change this, or is it just
something you overlooked here?

I understand, that if the QoS constraint has been updated after such
child device has been suspended, it's tricky to take a correct
decision.

To really solve this, we would either have to register a QoS notifier
for all children devices that has its parent attached to a genpd, or
always runtime resume devices before updating QoS constraints.

Non of these options is perfect, so perhaps we should consider a "best
effort" approach instead? Whatever that may be.

> +       constraint_ns = dev_gpd_data(dev)->td.effective_constraint_ns;
> +       /* 0 means "no constraint" */
> +       if (constraint_ns == 0)
> +               return 0;
> +
>         if (constraint_ns < *constraint_ns_p || *constraint_ns_p == 0)
>                 *constraint_ns_p = constraint_ns;
>
> @@ -76,14 +76,29 @@ static bool default_suspend_ok(struct de
>                 device_for_each_child(dev, &constraint_ns,
>                                       dev_update_qos_constraint);
>
> -       if (constraint_ns > 0) {
> +       if (constraint_ns == 0) {
> +               /* "No restriction", so the device is allowed to suspend. */
> +               td->effective_constraint_ns = 0;
> +               td->cached_suspend_ok = true;
> +       } else {
> +               /*
> +                * constraint_ns must be positive here, because the children
> +                * walked above are all suspended, so effective_constraint_ns
> +                * cannot be negative for them.
> +                */
>                 constraint_ns -= td->suspend_latency_ns +
>                                 td->resume_latency_ns;
> -               if (constraint_ns == 0)
> +               /*
> +                * effective_constraint_ns is negative already and
> +                * cached_suspend_ok is false, so if the computed value is not
> +                * positive, return right away.
> +                */
> +               if (constraint_ns <= 0)
>                         return false;
> +
> +               td->effective_constraint_ns = constraint_ns;
> +               td->cached_suspend_ok = true;
>         }
> -       td->effective_constraint_ns = constraint_ns;
> -       td->cached_suspend_ok = constraint_ns >= 0;
>
>         /*
>          * The children have been suspended already, so we don't need to take
> @@ -144,18 +159,16 @@ static bool __default_power_down_ok(stru
>                  */
>                 td = &to_gpd_data(pdd)->td;
>                 constraint_ns = td->effective_constraint_ns;
> -               /* default_suspend_ok() need not be called before us. */
> -               if (constraint_ns < 0) {
> -                       constraint_ns = dev_pm_qos_read_value(pdd->dev);
> -                       constraint_ns *= NSEC_PER_USEC;
> -               }
> +               /*
> +                * Negative values mean "no suspend at all" and this runs only
> +                * when all devices in the domain are suspended, so it must be
> +                * 0 at least.
> +                *
> +                * 0 means "no constraint"
> +                */
>                 if (constraint_ns == 0)
>                         continue;
>
> -               /*
> -                * constraint_ns cannot be negative here, because the device has
> -                * been suspended.
> -                */
>                 if (constraint_ns <= off_on_time_ns)
>                         return false;
>
>

Kind regards
Uffe
