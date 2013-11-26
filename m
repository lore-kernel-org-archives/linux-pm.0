From: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2] PM / Sleep: Add pm_generic functions to re-use runtime
 PM callbacks
Date: Tue, 26 Nov 2013 10:48:56 +0100
Message-ID: <CAPDyKFrS=8_T51hwSo+ONchm49_tj2o-+-H7Uv44ow4izutzfQ@mail.gmail.com>
References: <1385383221-20372-1-git-send-email-ulf.hansson@linaro.org>
	<5827021.HqYFigfrCJ@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <5827021.HqYFigfrCJ-sKB8Sp2ER+y1GS7QM15AGw@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>
Cc: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>, "linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Linux PCI <linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Kevin Hilman <khilman-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

On 26 November 2013 00:10, Rafael J. Wysocki <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org> wrote:
> On Monday, November 25, 2013 01:40:21 PM Ulf Hansson wrote:
>> To put devices into low power state during sleep, it sometimes makes
>> sense at subsystem-level to re-use device's runtime PM callbacks.
>>
>> The PM core will at device_suspend_late disable runtime PM, after that
>> we can safely operate on these callbacks. At suspend_late the device
>> will be put into low power state by invoking the device's
>> runtime_suspend callback, unless the runtime status is already
>> suspended. At resume_early the state is restored by invoking the
>> device's runtime_resume callback. Soon after the PM core will re-enable
>> runtime PM before returning from device_resume_early.
>>
>> The new pm_generic functions are named pm_generic_suspend_late_runtime
>> and pm_generic_resume_early_runtime, they are supposed to be used in
>> pairs.
>
> What happens if the subsystem uses the new functions as its late suspend/
> early resume callbacks, but some of its drivers implement .suspend_late()
> and .resume_early()?

Good point. Normally, I think the decision of using these callbacks
should be taken at the lowest level, in other words in the driver.
Otherwise the lowest layer of .suspend_late will be by-passed.

Do you think "subsystem-level" is too vague to indicate that? Should
we say "driver-level" in the functions comment field instead?

>
> Also, these are system suspend/resume callbacks, so the "runtime" part of
> the names is kind of confusing.  I have no idea for better naming at this
> point, but still.

Somehow I would like to indicate that it is actually the runtime
callbacks that will be indirectly invoked. Besides that, I would
happily change to whatever you propose. :-)

>
>> Do note that these new generic callbacks will work smothly even with
>> and without CONFIG_PM_RUNTIME, as long as the runtime PM callbacks are
>> implemented inside CONFIG_PM instead of CONFIG_PM_RUNTIME.
>>
>> A special thanks to Alan Stern who came up with this idea.
>>
>> Cc: Kevin Hilman <khilman-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
>> Cc: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
>> Signed-off-by: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
>> ---
>>  drivers/base/power/generic_ops.c |   86 ++++++++++++++++++++++++++++++++++++++
>>  include/linux/pm.h               |    2 +
>>  2 files changed, 88 insertions(+)
>>
>> diff --git a/drivers/base/power/generic_ops.c b/drivers/base/power/generic_ops.c
>> index 5ee030a..3132768 100644
>> --- a/drivers/base/power/generic_ops.c
>> +++ b/drivers/base/power/generic_ops.c
>> @@ -93,6 +93,49 @@ int pm_generic_suspend_late(struct device *dev)
>>  EXPORT_SYMBOL_GPL(pm_generic_suspend_late);
>>
>>  /**
>> + * pm_generic_suspend_late_runtime - Generic suspend_late callback for
>> + * subsystems that wants to use runtime_suspend callbacks at suspend_late.
>
> This has to be one line.  You can add more description below the @dev line.

OK

>
>> + * @dev: Device to suspend.
>> + */
>> +int pm_generic_suspend_late_runtime(struct device *dev)
>> +{
>> +     int (*callback)(struct device *);
>> +     int ret = 0;
>> +
>> +     /*
>> +      * PM core has disabled runtime PM in device_suspend_late, thus we can
>> +      * safely check the device's runtime status and decide whether
>> +      * additional actions are needed to put the device into low power state.
>> +      * If so, we invoke the device's runtime_suspend callback.
>> +      * For the !CONFIG_PM_RUNTIME case, pm_runtime_status_suspended() always
>> +      * returns false and therefore the runtime_suspend callback will be
>> +      * invoked.
>> +      */
>> +     if (pm_runtime_status_suspended(dev))
>> +             return 0;
>> +
>> +     if (dev->pm_domain)
>> +             callback = dev->pm_domain->ops.runtime_suspend;
>> +     else if (dev->type && dev->type->pm)
>> +             callback = dev->type->pm->runtime_suspend;
>> +     else if (dev->class && dev->class->pm)
>> +             callback = dev->class->pm->runtime_suspend;
>> +     else if (dev->bus && dev->bus->pm)
>> +             callback = dev->bus->pm->runtime_suspend;
>> +     else
>> +             callback = NULL;
>> +
>> +     if (!callback && dev->driver && dev->driver->pm)
>> +             callback = dev->driver->pm->runtime_suspend;
>> +
>> +     if (callback)
>> +             ret = callback(dev);
>> +
>> +     return ret;
>> +}
>> +EXPORT_SYMBOL_GPL(pm_generic_suspend_late_runtime);
>> +
>> +/**
>>   * pm_generic_suspend - Generic suspend callback for subsystems.
>>   * @dev: Device to suspend.
>>   */
>> @@ -237,6 +280,49 @@ int pm_generic_resume_early(struct device *dev)
>>  EXPORT_SYMBOL_GPL(pm_generic_resume_early);
>>
>>  /**
>> + * pm_generic_resume_early_runtime - Generic resume_early callback for
>> + * subsystems that wants to use runtime_resume callbacks at resume_early.
>
> Same here.

OK

>
>> + * @dev: Device to resume.
>> + */
>> +int pm_generic_resume_early_runtime(struct device *dev)
>> +{
>> +     int (*callback)(struct device *);
>> +     int ret = 0;
>> +
>> +     /*
>> +      * PM core has not yet enabled runtime PM in device_resume_early,
>> +      * thus we can safely check the device's runtime status and restore the
>> +      * previous state we had in device_suspend_late. If restore is needed
>> +      * we invoke the device's runtime_resume callback.
>> +      * For the !CONFIG_PM_RUNTIME case, pm_runtime_status_suspended() always
>> +      * returns false and therefore the runtime_resume callback will be
>> +      * invoked.
>> +      */
>> +     if (pm_runtime_status_suspended(dev))
>> +             return 0;
>> +
>> +     if (dev->pm_domain)
>> +             callback = dev->pm_domain->ops.runtime_resume;
>> +     else if (dev->type && dev->type->pm)
>> +             callback = dev->type->pm->runtime_resume;
>> +     else if (dev->class && dev->class->pm)
>> +             callback = dev->class->pm->runtime_resume;
>> +     else if (dev->bus && dev->bus->pm)
>> +             callback = dev->bus->pm->runtime_resume;
>> +     else
>> +             callback = NULL;
>> +
>> +     if (!callback && dev->driver && dev->driver->pm)
>> +             callback = dev->driver->pm->runtime_resume;
>> +
>> +     if (callback)
>> +             ret = callback(dev);
>> +
>> +     return ret;
>> +}
>> +EXPORT_SYMBOL_GPL(pm_generic_resume_early_runtime);
>> +
>> +/**
>>   * pm_generic_resume - Generic resume callback for subsystems.
>>   * @dev: Device to resume.
>>   */
>> diff --git a/include/linux/pm.h b/include/linux/pm.h
>> index a224c7f..5bce0d4 100644
>> --- a/include/linux/pm.h
>> +++ b/include/linux/pm.h
>> @@ -656,9 +656,11 @@ extern void dpm_for_each_dev(void *data, void (*fn)(struct device *, void *));
>>
>>  extern int pm_generic_prepare(struct device *dev);
>>  extern int pm_generic_suspend_late(struct device *dev);
>> +extern int pm_generic_suspend_late_runtime(struct device *dev);
>>  extern int pm_generic_suspend_noirq(struct device *dev);
>>  extern int pm_generic_suspend(struct device *dev);
>>  extern int pm_generic_resume_early(struct device *dev);
>> +extern int pm_generic_resume_early_runtime(struct device *dev);
>>  extern int pm_generic_resume_noirq(struct device *dev);
>>  extern int pm_generic_resume(struct device *dev);
>>  extern int pm_generic_freeze_noirq(struct device *dev);
>

Thanks for the comments, I will submit a new version soon.

Kind regards
Ulf Hansson



> Thanks!
>
> --
> I speak only for myself.
> Rafael J. Wysocki, Intel Open Source Technology Center.
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
