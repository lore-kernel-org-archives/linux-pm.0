From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v7 1/2] PM / sleep: Go direct_complete if driver has no callbacks
Date: Wed, 30 Sep 2015 15:23:54 +0200
Message-ID: <CAPDyKFrRZhU7qwWkTaPDioiBih-WBZjoM4irEuJcDyxNk4hVCA@mail.gmail.com>
References: <1443607098-26666-1-git-send-email-tomeu.vizoso@collabora.com>
	<1443607098-26666-2-git-send-email-tomeu.vizoso@collabora.com>
	<CAPDyKFoSWLEzeLUWC0gPY2_a0Mvo3vbbWm5e0f-_rjZbwdY0Sw@mail.gmail.com>
	<8277579.lpDi4B1kd8@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f177.google.com ([209.85.212.177]:38488 "EHLO
	mail-wi0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932934AbbI3NXz (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 30 Sep 2015 09:23:55 -0400
Received: by wiclk2 with SMTP id lk2so61751092wic.1
        for <linux-pm@vger.kernel.org>; Wed, 30 Sep 2015 06:23:54 -0700 (PDT)
In-Reply-To: <8277579.lpDi4B1kd8@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Tomeu Vizoso <tomeu.vizoso@collabora.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Alan Stern <stern@rowland.harvard.edu>, martyn.welch@collabora.co.uk, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Len Brown <len.brown@intel.com>, Kevin Hilman <khilman@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Pavel Machek <pavel@ucw.cz>

[...]

>> > diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
>> > index 16550c63d611..3cae1aa1885b 100644
>> > --- a/drivers/base/power/domain.c
>> > +++ b/drivers/base/power/domain.c
>> > @@ -20,6 +20,8 @@
>> >  #include <linux/suspend.h>
>> >  #include <linux/export.h>
>> >
>> > +#include "power.h"
>> > +
>> >  #define GENPD_RETRY_MAX_MS     250             /* Approximate */
>> >
>> >  #define GENPD_DEV_CALLBACK(genpd, type, callback, dev)         \
>> > @@ -1305,6 +1307,7 @@ int __pm_genpd_add_device(struct generic_pm_domain *genpd, struct device *dev,
>> >
>> >         list_add_tail(&gpd_data->base.list_node, &genpd->dev_list);
>> >
>> > +       device_check_pm_callbacks(dev);
>>
>> Don't do this while the genpd mutex is held as there is no need to.
>> Please move it outside the lock and only do it for non-error case.
>>
>> >   out:
>> >         mutex_unlock(&genpd->lock);
>> >
>> > @@ -1369,6 +1372,8 @@ int pm_genpd_remove_device(struct generic_pm_domain *genpd,
>> >
>> >         genpd_free_dev_data(dev, gpd_data);
>> >
>> > +       device_check_pm_callbacks(dev);
>> > +
>> >         return 0;
>>
>> I can't tell whether this is an interesting feature to use for devices
>> that gets attached to the ACPI PM domain. Although, you currently
>> doesn't deal with that case, and too me I think this looks a bit
>> weird/unsymmetrical.
>
> Good point.
>
> It needs to be done in every situation where a PM domain is or can be used.
>
> I guess we might require all PM domains to be attached to devices after
> a successful probe at the latest (no PM domains should be attached/detached
> after probe succeeds IOW), in which case it should be sufficient to do the
> device_check_pm_callbacks() thing each time after probe successds.
>
> Thoughts?

Ohh, I just realize that my comment was wrong. Sorry for the noise.

Why genpd needs special treatment is to take care off the
"non-probing" case. In other words when devices gets added to genpd
directly by using the pm_genpd_add_device() API. Perhaps that deserves
a comment though.

>
>> >   out:
>> > diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
>> > index 1710c26ba097..5af45d20b677 100644
>> > --- a/drivers/base/power/main.c
>> > +++ b/drivers/base/power/main.c
>> > @@ -131,6 +131,8 @@ void device_pm_add(struct device *dev)
>> >                         dev_name(dev->parent));
>> >         list_add_tail(&dev->power.entry, &dpm_list);
>> >         mutex_unlock(&dpm_list_mtx);
>> > +
>> > +       device_check_pm_callbacks(dev);
>> >  }
>> >
>> >  /**
>> > @@ -1569,6 +1571,11 @@ static int device_prepare(struct device *dev, pm_message_t state)
>> >
>> >         dev->power.wakeup_path = device_may_wakeup(dev);
>> >
>> > +       if (dev->power.no_pm_callbacks) {
>> > +               ret = 1;        /* Let device go direct_complete */
>> > +               goto unlock;
>> > +       }
>> > +
>> >         if (dev->pm_domain) {
>> >                 info = "preparing power domain ";
>> >                 callback = dev->pm_domain->ops.prepare;
>> > @@ -1591,6 +1598,7 @@ static int device_prepare(struct device *dev, pm_message_t state)
>> >         if (callback)
>> >                 ret = callback(dev);
>> >
>> > +unlock:
>> >         device_unlock(dev);
>> >
>> >         if (ret < 0) {
>> > diff --git a/drivers/base/power/power.h b/drivers/base/power/power.h
>> > index 998fa6b23084..f665a7850016 100644
>> > --- a/drivers/base/power/power.h
>> > +++ b/drivers/base/power/power.h
>> > @@ -29,6 +29,8 @@ struct wake_irq {
>> >  extern void dev_pm_arm_wake_irq(struct wake_irq *wirq);
>> >  extern void dev_pm_disarm_wake_irq(struct wake_irq *wirq);
>> >
>> > +extern void device_check_pm_callbacks(struct device *dev);
>> > +
>> >  #ifdef CONFIG_PM_SLEEP
>> >
>> >  extern int device_wakeup_attach_irq(struct device *dev,
>> > @@ -102,6 +104,10 @@ static inline void dev_pm_disarm_wake_irq(struct wake_irq *wirq)
>> >  {
>> >  }
>> >
>> > +static inline void device_check_pm_callbacks(struct device *dev)
>> > +{
>> > +}
>> > +
>> >  #endif
>> >
>> >  #ifdef CONFIG_PM_SLEEP
>> > diff --git a/include/linux/pm.h b/include/linux/pm.h
>> > index 35d599e7250d..e334b9b8cd46 100644
>> > --- a/include/linux/pm.h
>> > +++ b/include/linux/pm.h
>> > @@ -566,6 +566,7 @@ struct dev_pm_info {
>> >         bool                    ignore_children:1;
>> >         bool                    early_init:1;   /* Owned by the PM core */
>> >         bool                    direct_complete:1;      /* Owned by the PM core */
>> > +       bool                    no_pm_callbacks:1;      /* Owned by the PM core */
>>
>> This flag is only being used while CONFIG_PM is set. I suggest we move
>> within that ifdef.
>
> I guess you mean CONFIG_PM_SLEEP?

Yes!

Kind regards
Uffe
