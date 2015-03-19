From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v2] driver core / PM: Add PM domain callbacks for device setup/cleanup
Date: Thu, 19 Mar 2015 15:42:03 -0700
Message-ID: <CAKdAkRRkmSGTxb8USPznmtKgW4AXosvd2JQQo6YvKcNpvy1BuA@mail.gmail.com>
References: <3533423.QQDErEmeTO@vostro.rjw.lan>
	<3998390.WErrfO4Yno@vostro.rjw.lan>
	<5975784.LhOHuiUKGO@vostro.rjw.lan>
	<1810625.BTgaNclHRk@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-la0-f42.google.com ([209.85.215.42]:36804 "EHLO
	mail-la0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752447AbbCSWmF (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 19 Mar 2015 18:42:05 -0400
Received: by lamx15 with SMTP id x15so74250905lam.3
        for <linux-pm@vger.kernel.org>; Thu, 19 Mar 2015 15:42:03 -0700 (PDT)
In-Reply-To: <1810625.BTgaNclHRk@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alan Stern <stern@rowland.harvard.edu>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Kevin Hilman <khilman@linaro.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Russell King <linux@arm.linux.org.uk>, Mark Brown <broonie@kernel.org>, Wolfram Sang <wsa@the-dreams.de>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Thu, Mar 19, 2015 at 2:51 PM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Subject: driver core / PM: Add PM domain callbacks for device setup/cleanup
>
> If PM domains are in use, it may be necessary to prepare the code
> handling a PM domain for driver probing.  For example, in some
> cases device drivers rely on the ability to power on the devices
> with the help of the IO runtime PM framework and the PM domain
> code needs to be ready for that.  Also, if that code has not been
> fully initialized yet, the driver probing should be deferred.
>
> Moreover, after the probing is complete, it may be necessary to
> put the PM domain in question into the state reflecting the current
> needs of the devices in it, for example, so that power is not drawn
> in vain.  The same should be done after removing a driver from
> a device, as the PM domain state may need to be changed to reflect
> the new situation.
>
> For these reasons, introduce new PM domain callbacks, ->activate
> and ->sync, called, respectively, before probing for a device
> driver and after the probing has been completed or the driver
> has been removed.
>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>> ---
>>
>> This is an update without the additional bus type callbacks.  This should
>> be suffucient at this point for the use cases we have.
>>
>> I've decided to also call ->sync on driver removal as that is consistent
>> with what happens for failing probe.
>>
>> ---
>
> One more update.
>
> I've realized that in the PM domain's ->sync callback is called after
> clearing the device's driver field (in the failed probe or driver removal
> case) rather than before it, that could be used to distinguish between the
> two cases (successful probe vs no driver), so I reworked the patch accordingly.

That is very non-obvious. dev->drv belongs to driver core and maybe
bus, nothing else should really be looking at it. Why can't we add an
explicit argument to the callback indicating device state?

Thanks.

>
> ---
>  drivers/base/dd.c  |   16 ++++++++++++++++
>  include/linux/pm.h |    6 ++++++
>  2 files changed, 22 insertions(+)
>
> Index: linux-pm/include/linux/pm.h
> ===================================================================
> --- linux-pm.orig/include/linux/pm.h
> +++ linux-pm/include/linux/pm.h
> @@ -603,10 +603,16 @@ extern void dev_pm_put_subsys_data(struc
>   * Power domains provide callbacks that are executed during system suspend,
>   * hibernation, system resume and during runtime PM transitions along with
>   * subsystem-level and driver-level callbacks.
> + *
> + * @detach: Called when removing a device from the domain.
> + * @activate: Called before executing probe routines for bus types and drivers.
> + * @sync: Called after driver probe and removal.
>   */
>  struct dev_pm_domain {
>         struct dev_pm_ops       ops;
>         void (*detach)(struct device *dev, bool power_off);
> +       int (*activate)(struct device *dev);
> +       void (*sync)(struct device *dev);
>  };
>
>  /*
> Index: linux-pm/drivers/base/dd.c
> ===================================================================
> --- linux-pm.orig/drivers/base/dd.c
> +++ linux-pm/drivers/base/dd.c
> @@ -279,6 +279,7 @@ static int really_probe(struct device *d
>  {
>         int ret = 0;
>         int local_trigger_count = atomic_read(&deferred_trigger_count);
> +       struct dev_pm_domain *pm_domain = dev->pm_domain;
>
>         atomic_inc(&probe_count);
>         pr_debug("bus: '%s': %s: probing driver %s with device %s\n",
> @@ -298,6 +299,12 @@ static int really_probe(struct device *d
>                 goto probe_failed;
>         }
>
> +       if (pm_domain && pm_domain->activate) {
> +               ret = pm_domain->activate(dev);
> +               if (ret)
> +                       goto probe_failed;
> +       }
> +
>         if (dev->bus->probe) {
>                 ret = dev->bus->probe(dev);
>                 if (ret)
> @@ -308,6 +315,9 @@ static int really_probe(struct device *d
>                         goto probe_failed;
>         }
>
> +       if (pm_domain && pm_domain->sync)
> +               pm_domain->sync(dev);
> +
>         driver_bound(dev);
>         ret = 1;
>         pr_debug("bus: '%s': %s: bound device %s to driver %s\n",
> @@ -319,6 +329,8 @@ probe_failed:
>         driver_sysfs_remove(dev);
>         dev->driver = NULL;
>         dev_set_drvdata(dev, NULL);
> +       if (pm_domain && pm_domain->sync)
> +               pm_domain->sync(dev);
>
>         if (ret == -EPROBE_DEFER) {
>                 /* Driver requested deferred probing */
> @@ -522,9 +534,13 @@ static void __device_release_driver(stru
>                         dev->bus->remove(dev);
>                 else if (drv->remove)
>                         drv->remove(dev);
> +
>                 devres_release_all(dev);
>                 dev->driver = NULL;
>                 dev_set_drvdata(dev, NULL);
> +               if (dev->pm_domain && dev->pm_domain->sync)
> +                       dev->pm_domain->sync(dev);
> +
>                 klist_remove(&dev->p->knode_driver);
>                 if (dev->bus)
>                         blocking_notifier_call_chain(&dev->bus->p->bus_notifier,
>



-- 
Dmitry
