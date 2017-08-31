From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v3 1/8] PM / Sleep: Make the runtime PM centric path known
 to the PM core
Date: Thu, 31 Aug 2017 11:06:05 +0200
Message-ID: <CAPDyKFoOJzciMNMWkc+ci+Fn2iD8vwsg25TQjcx=xw2ftg5rug@mail.gmail.com>
References: <1504018610-10822-1-git-send-email-ulf.hansson@linaro.org>
 <13933269.sbLfAJfmVU@aspire.rjw.lan> <CAPDyKFqujAbw9RAxG-kRhgnhEtAZeojBiL=v5F+JS3T9eaxfgQ@mail.gmail.com>
 <2403318.HVB4k3qRsK@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-i2c-owner@vger.kernel.org>
In-Reply-To: <2403318.HVB4k3qRsK@aspire.rjw.lan>
Sender: linux-i2c-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Wolfram Sang <wsa@the-dreams.de>, Len Brown <lenb@kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Kevin Hilman <khilman@kernel.org>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Jisheng Zhang <jszhang@marvell.com>, John Stultz <john.stultz@linaro.org>, Guodong Xu <guodong.xu@linaro.org>, Sumit Semwal <sumit.semwal@linaro.org>, Haojian Zhuang <haojian.zhuang@linaro.org>, Johannes Stezenbach <js@sig21.net>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

[...]

>> >> diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
>> >> index ea1732e..865737a 100644
>> >> --- a/drivers/base/power/main.c
>> >> +++ b/drivers/base/power/main.c
>> >> @@ -1549,14 +1549,16 @@ static int __device_suspend(struct device *dev, pm_message_t state, bool async)
>> >>               if (parent) {
>> >>                       spin_lock_irq(&parent->power.lock);
>> >>
>> >> -                     dev->parent->power.direct_complete = false;
>> >> +                     if (!dev->power.is_rpm_sleep)
>> >> +                             dev->parent->power.direct_complete = false;
>> >
>> > This doesn't look good to me at all.
>> >
>> > It potentially breaks the fundamental assumption of the direct_complete
>> > mechanism that no devices with that flag set will ever be runtime resumed
>> > during system suspend.
>> >
>> > Which can happen with this change if a device with power.is_rpm_sleep is
>> > resumed causing the parent to be resumed too.
>>
>> Doesn't the exact same problem you describe, already exist prior my change!?
>
> No, it doesn't.
>
>> That is, if the current device is runtime suspended and the
>> direct_complete flag is set for it, then __device_suspend() has
>> already disabled runtime PM for the device, when we reach this point.
>> That means, a following attempts to runtime resume the device will
>> fail and thus also to runtime resume its parent.
>
> That's because any devices with direct_complete set *cannot* be runtime
> resumed after __device_suspend().  That's intentional and how the thing
> is designed.  It cannot work differently, sorry.
>
>> So to me, this is a different problem, related how to work out the
>> correct order of how to suspend devices.
>
> The ordering matters here, but it is not the problem.
>
> Setting direct_complete means that PM callbacks for this device won't be
> invoked going forward.  However, if the state of the device was to change
> (like as a result of runtime PM resume), it would be necessary to run those
> callbacks after all, but after __device_suspend() it may be too late for
> that, because the ->suspend callback may have been skipped already.
>
> The only way to address that is to prevent runtime PM resume of the device
> from happening at the point the PM core decides to use direct_complete for it,
> but that requires runtime PM to be disabled for it.  Moreover, since the
> device is now suspended with runtime PM disabled and its children might rely
> on it if they were active, the children must be suspended with runtime PM
> disabled at this point too.  That's why direct_complete can only be set
> for a device if it is set for the entire hierarchy below it.

Thanks, this was a very nice description of the direct_complete path!

>
> Summary: If you allow a device to be runtime resumed during system susped,
> direct_complete cannot be set for it and it cannot be set for its parent and
> so on.

Yes, this is what it seems to boils done to!

Perhaps the ACPI PM domain is special in this case, because in its
->prepare() callback it asks the ACPI FW about whether the
direct_complete path is possible for a device. In other words, the
ACPI FW seems to be capable of providing information about if a device
may become runtime resumed during system suspend. But, really, isn't
that just a best guess? No?

On those ARM SoCs I am working on, non-ACPI, the information about
whether a device may become runtime resumed during system suspend,
most often can't be find out in a deterministic way. That's because
this information depends on how a device is being used by other
devices, which changes dynamically and from one system suspend
sequence to another. In cases like the i2c-designware-plat driver used
in Hikey (ARM64 board), it can't ever know before hand, if someone is
going to request an i2c transfer during system suspend or not.

To really deal with these devices properly, we have to suspend them in
the correct order.

My point is, doesn't the ordering problem exists also for a device,
which the PM core runs the direct_complete path for, even if the ACPI
PM domain is attached to the device? Just because runtime PM is
disabled for a device, doesn't mean the ordering issue disappears,
right?

>
> [cut]
>
>> >> @@ -1709,11 +1711,14 @@ static int device_prepare(struct device *dev, pm_message_t state)
>> >>        * A positive return value from ->prepare() means "this device appears
>> >>        * to be runtime-suspended and its state is fine, so if it really is
>> >>        * runtime-suspended, you can leave it in that state provided that you
>> >> -      * will do the same thing with all of its descendants".  This only
>> >> -      * applies to suspend transitions, however.
>> >> +      * will do the same thing with all of its descendants". To allow this,
>> >> +      * the is_rpm_sleep flag must not be set, which is default false, but
>> >> +      * may have been changed by a driver. This only applies to suspend
>> >> +      * transitions, however.
>> >>        */
>> >>       spin_lock_irq(&dev->power.lock);
>> >> -     dev->power.direct_complete = ret > 0 && state.event == PM_EVENT_SUSPEND;
>> >> +     dev->power.direct_complete = ret > 0 && !dev->power.is_rpm_sleep &&
>> >> +                             state.event == PM_EVENT_SUSPEND;
>> >
>> > The only problem addressed by avoiding direct_complete is when runtime PM needs
>> > to work during __device_suspend() for devices with direct_complete set.  You
>> > said that this was not the case with the i2c designware driver, so I'm not sure
>> > what the purpose of this is.
>>
>> I should probably work more on my changelog, because I tried to
>> explain it there.
>>
>> Anyway, let me quote the important parts, and this is not specific for
>> the i2c-designware-driver, but generic to drivers using
>> pm_runtime_force_suspend|resume().
>>
>> "In the runtime PM centric path, the driver is expected to make use of
>> the pm_runtime_force_suspend|resume() helpers, to deploy system sleep
>> support. More precisely it may assign the system sleep callbacks to
>> these helpers or may call them from its own callbacks, in case it
>> needs to perform additional actions during system sleep.
>>
>> In other words, the PM core must always invoke the system sleep
>> callbacks for the device when they are present, to allow the driver to
>> deal with the system sleep operations."
>>
>> A concrete example is drivers/spi/spi-fsl-espi.c, but one can easily find more.
>
> In fact, the new flag introduced here means "assume that that the driver of this
> device points ->late_suspend and ->early_resume to pm_runtime_force_suspend()
> and pm_runtime_force_resume(), respectively."  Which then implies that
> direct_complete cannot be used with it and (and with its parent and so on)
> and that it is not necessary to runtime resume it during system suspend.
>
> However, there are (or at least there may be) devices that need not be
> runtime resumed during system suspend even though their drivers don't use
> _force_suspend/resume().
>
> Also there are devices whose drivers don't want direct_complete to be used with
> them, even though they don't use _force_suspend/resume() and they *do* need
> their devices to be runtime resumed during system suspend.
>
> Moreover, some drivers may not mind direct_complete even though their devices
> need not be runtime resumed during system suspend.  All of that doesn't have
> to be related to using _force_suspend/resume() at all.
>
> So I don't see any reason whatever for combining all of these three *different*
> conditions under one flag.

Okay!

>
> Thanks,
> Rafael
>

Kind regards
Uffe
