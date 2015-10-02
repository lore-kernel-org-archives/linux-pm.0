From: Tomeu Vizoso <tomeu.vizoso@collabora.com>
Subject: Re: [PATCH v8 3/4] PM / sleep: Go direct_complete if driver has no callbacks
Date: Fri, 2 Oct 2015 10:10:15 +0200
Message-ID: <CAAObsKBM2tto0cFAu-pyvatGQevB6ynvuuSNghHNQGQSgfLzdA@mail.gmail.com>
References: <1443770071-2570-1-git-send-email-tomeu.vizoso@collabora.com>
 <1443770071-2570-4-git-send-email-tomeu.vizoso@collabora.com> <CAPDyKFo_tqf_ism-YYNw2L7Wp=EnqztbggU52aX_Azwn4OJLMg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f170.google.com ([209.85.212.170]:37898 "EHLO
	mail-wi0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750709AbbJBIKh (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 2 Oct 2015 04:10:37 -0400
In-Reply-To: <CAPDyKFo_tqf_ism-YYNw2L7Wp=EnqztbggU52aX_Azwn4OJLMg@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Alan Stern <stern@rowland.harvard.edu>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, martyn.welch@collabora.co.uk, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Len Brown <len.brown@intel.com>, Kevin Hilman <khilman@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Pavel Machek <pavel@ucw.cz>

On 2 October 2015 at 09:48, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> On 2 October 2015 at 09:14, Tomeu Vizoso <tomeu.vizoso@collabora.com> wrote:
>> If a suitable prepare callback cannot be found for a given device and
>> its driver has no PM callbacks at all, assume that it can go direct to
>> complete when the system goes to sleep.
>>
>> The reason for this is that there's lots of devices in a system that do
>> no PM at all and there's no reason for them to prevent their ancestors
>> to do direct_complete if they can support it.
>>
>> Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
>> ---
>>
>> Changes in v8:
>> - Move no_pm_callbacks field into CONFIG_PM_SLEEP
>> - Call device_check_pm_callbacks only after a device is bound or unbound
>
> Devices that don't use a driver, will not get this feature for "free".
> I expect in those cases, they will have to call
> device_check_pm_callbacks() themselves, right?

You are right, but wonder if we shouldn't go back to calling
device_check_pm_callbacks() from device_pm_add() and
dev_pm_domain_set() so they don't have to.

Thanks,

Tomeu

> Perhaps we should mention that, at least in the change log.
>
>>
>> Changes in v7:
>> - Reduce indentation by adding a label in device_prepare()
>>
>> Changes in v6:
>> - Add stub for !CONFIG_PM.
>> - Move implementation of device_check_pm_callbacks to power/main.c as it
>>   doesn't belong to CONFIG_PM_SLEEP.
>> - Take dev->power.lock before modifying flag.
>>
>> Changes in v5:
>> - Check for all dev_pm_ops instances associated to a device, updating a
>>   no_pm_callbacks flag at the times when that could change.
>>
>>  drivers/base/dd.c           |  3 +++
>>  drivers/base/power/domain.c |  2 ++
>>  drivers/base/power/main.c   | 33 +++++++++++++++++++++++++++++++++
>>  drivers/base/power/power.h  |  6 ++++++
>>  include/linux/pm.h          |  1 +
>>  5 files changed, 45 insertions(+)
>>
>> diff --git a/drivers/base/dd.c b/drivers/base/dd.c
>> index f2007fa7316f..2e3809affb06 100644
>> --- a/drivers/base/dd.c
>> +++ b/drivers/base/dd.c
>> @@ -210,6 +210,8 @@ static void driver_bound(struct device *dev)
>>
>>         klist_add_tail(&dev->p->knode_driver, &dev->driver->p->klist_devices);
>>
>> +       device_check_pm_callbacks(dev);
>> +
>>         /*
>>          * Make sure the device is no longer in one of the deferred lists and
>>          * kick off retrying all pending devices
>> @@ -700,6 +702,7 @@ static void __device_release_driver(struct device *dev)
>>                         dev->pm_domain->dismiss(dev);
>>
>>                 klist_remove(&dev->p->knode_driver);
>> +               device_check_pm_callbacks(dev);
>>                 if (dev->bus)
>>                         blocking_notifier_call_chain(&dev->bus->p->bus_notifier,
>>                                                      BUS_NOTIFY_UNBOUND_DRIVER,
>> diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
>> index b75d02aa8d93..9dc1ce9c573b 100644
>> --- a/drivers/base/power/domain.c
>> +++ b/drivers/base/power/domain.c
>> @@ -20,6 +20,8 @@
>>  #include <linux/suspend.h>
>>  #include <linux/export.h>
>>
>> +#include "power.h"
>> +
>
> Seems like a leftover from the earlier version of the patch...
>
>>  #define GENPD_RETRY_MAX_MS     250             /* Approximate */
>>
>>  #define GENPD_DEV_CALLBACK(genpd, type, callback, dev)         \
>> diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
>> index 1710c26ba097..43b44f8251c7 100644
>> --- a/drivers/base/power/main.c
>> +++ b/drivers/base/power/main.c
>> @@ -1569,6 +1569,11 @@ static int device_prepare(struct device *dev, pm_message_t state)
>>
>>         dev->power.wakeup_path = device_may_wakeup(dev);
>>
>> +       if (dev->power.no_pm_callbacks) {
>> +               ret = 1;        /* Let device go direct_complete */
>> +               goto unlock;
>> +       }
>> +
>>         if (dev->pm_domain) {
>>                 info = "preparing power domain ";
>>                 callback = dev->pm_domain->ops.prepare;
>> @@ -1591,6 +1596,7 @@ static int device_prepare(struct device *dev, pm_message_t state)
>>         if (callback)
>>                 ret = callback(dev);
>>
>> +unlock:
>>         device_unlock(dev);
>>
>>         if (ret < 0) {
>> @@ -1719,3 +1725,30 @@ void dpm_for_each_dev(void *data, void (*fn)(struct device *, void *))
>>         device_pm_unlock();
>>  }
>>  EXPORT_SYMBOL_GPL(dpm_for_each_dev);
>> +
>> +static bool pm_ops_is_empty(const struct dev_pm_ops *ops)
>> +{
>> +       if (!ops)
>> +               return true;
>> +
>> +       return !ops->prepare &&
>> +              !ops->suspend &&
>> +              !ops->suspend_late &&
>> +              !ops->suspend_noirq &&
>> +              !ops->resume_noirq &&
>> +              !ops->resume_early &&
>> +              !ops->resume &&
>> +              !ops->complete;
>> +}
>> +
>> +void device_check_pm_callbacks(struct device *dev)
>> +{
>> +       spin_lock_irq(&dev->power.lock);
>> +       dev->power.no_pm_callbacks =
>> +               (!dev->bus || pm_ops_is_empty(dev->bus->pm)) &&
>> +               (!dev->class || pm_ops_is_empty(dev->class->pm)) &&
>> +               (!dev->type || pm_ops_is_empty(dev->type->pm)) &&
>> +               (!dev->pm_domain || pm_ops_is_empty(&dev->pm_domain->ops)) &&
>> +               (!dev->driver || pm_ops_is_empty(dev->driver->pm));
>> +       spin_unlock_irq(&dev->power.lock);
>> +}
>> diff --git a/drivers/base/power/power.h b/drivers/base/power/power.h
>> index 998fa6b23084..b3e35e825cd8 100644
>> --- a/drivers/base/power/power.h
>> +++ b/drivers/base/power/power.h
>> @@ -37,6 +37,8 @@ extern void device_wakeup_detach_irq(struct device *dev);
>>  extern void device_wakeup_arm_wake_irqs(void);
>>  extern void device_wakeup_disarm_wake_irqs(void);
>>
>> +extern void device_check_pm_callbacks(struct device *dev);
>> +
>>  #else
>>
>>  static inline int
>> @@ -58,6 +60,10 @@ static inline void device_wakeup_disarm_wake_irqs(void)
>>  {
>>  }
>>
>> +static inline void device_check_pm_callbacks(struct device *dev)
>> +{
>> +}
>> +
>>  #endif /* CONFIG_PM_SLEEP */
>>
>>  /*
>> diff --git a/include/linux/pm.h b/include/linux/pm.h
>> index 35d599e7250d..7943acb74ae4 100644
>> --- a/include/linux/pm.h
>> +++ b/include/linux/pm.h
>> @@ -573,6 +573,7 @@ struct dev_pm_info {
>>         struct wakeup_source    *wakeup;
>>         bool                    wakeup_path:1;
>>         bool                    syscore:1;
>> +       bool                    no_pm_callbacks:1;      /* Owned by the PM core */
>>  #else
>>         unsigned int            should_wakeup:1;
>>  #endif
>> --
>> 2.4.3
>>
>
> Kind regards
> Uffe
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
