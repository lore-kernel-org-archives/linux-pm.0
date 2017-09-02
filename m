From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v3 1/8] PM / Sleep: Make the runtime PM centric path known to the PM core
Date: Sat, 02 Sep 2017 16:48:26 +0200
Message-ID: <1702559.yU4llTGfcI@aspire.rjw.lan>
References: <1504018610-10822-1-git-send-email-ulf.hansson@linaro.org> <2403318.HVB4k3qRsK@aspire.rjw.lan> <CAPDyKFoOJzciMNMWkc+ci+Fn2iD8vwsg25TQjcx=xw2ftg5rug@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <CAPDyKFoOJzciMNMWkc+ci+Fn2iD8vwsg25TQjcx=xw2ftg5rug@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Wolfram Sang <wsa@the-dreams.de>, Len Brown <lenb@kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Kevin Hilman <khilman@kernel.org>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Jisheng Zhang <jszhang@marvell.com>, John Stultz <john.stultz@linaro.org>, Guodong Xu <guodong.xu@linaro.org>, Sumit Semwal <sumit.semwal@linaro.org>, Haojian Zhuang <haojian.zhuang@linaro.org>, Johannes Stezenbach <js@sig21.net>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Thursday, August 31, 2017 11:06:05 AM CEST Ulf Hansson wrote:
> [...]
> 
> >> >> diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
> >> >> index ea1732e..865737a 100644
> >> >> --- a/drivers/base/power/main.c
> >> >> +++ b/drivers/base/power/main.c
> >> >> @@ -1549,14 +1549,16 @@ static int __device_suspend(struct device *dev, pm_message_t state, bool async)
> >> >>               if (parent) {
> >> >>                       spin_lock_irq(&parent->power.lock);
> >> >>
> >> >> -                     dev->parent->power.direct_complete = false;
> >> >> +                     if (!dev->power.is_rpm_sleep)
> >> >> +                             dev->parent->power.direct_complete = false;
> >> >
> >> > This doesn't look good to me at all.
> >> >
> >> > It potentially breaks the fundamental assumption of the direct_complete
> >> > mechanism that no devices with that flag set will ever be runtime resumed
> >> > during system suspend.
> >> >
> >> > Which can happen with this change if a device with power.is_rpm_sleep is
> >> > resumed causing the parent to be resumed too.
> >>
> >> Doesn't the exact same problem you describe, already exist prior my change!?
> >
> > No, it doesn't.
> >
> >> That is, if the current device is runtime suspended and the
> >> direct_complete flag is set for it, then __device_suspend() has
> >> already disabled runtime PM for the device, when we reach this point.
> >> That means, a following attempts to runtime resume the device will
> >> fail and thus also to runtime resume its parent.
> >
> > That's because any devices with direct_complete set *cannot* be runtime
> > resumed after __device_suspend().  That's intentional and how the thing
> > is designed.  It cannot work differently, sorry.
> >
> >> So to me, this is a different problem, related how to work out the
> >> correct order of how to suspend devices.
> >
> > The ordering matters here, but it is not the problem.
> >
> > Setting direct_complete means that PM callbacks for this device won't be
> > invoked going forward.  However, if the state of the device was to change
> > (like as a result of runtime PM resume), it would be necessary to run those
> > callbacks after all, but after __device_suspend() it may be too late for
> > that, because the ->suspend callback may have been skipped already.
> >
> > The only way to address that is to prevent runtime PM resume of the device
> > from happening at the point the PM core decides to use direct_complete for it,
> > but that requires runtime PM to be disabled for it.  Moreover, since the
> > device is now suspended with runtime PM disabled and its children might rely
> > on it if they were active, the children must be suspended with runtime PM
> > disabled at this point too.  That's why direct_complete can only be set
> > for a device if it is set for the entire hierarchy below it.
> 
> Thanks, this was a very nice description of the direct_complete path!
> 
> >
> > Summary: If you allow a device to be runtime resumed during system susped,
> > direct_complete cannot be set for it and it cannot be set for its parent and
> > so on.
> 
> Yes, this is what it seems to boils done to!
> 
> Perhaps the ACPI PM domain is special in this case, because in its
> ->prepare() callback it asks the ACPI FW about whether the
> direct_complete path is possible for a device. In other words, the
> ACPI FW seems to be capable of providing information about if a device
> may become runtime resumed during system suspend. But, really, isn't
> that just a best guess? No?

I wouldn't call it a guess, but it may go too far.

The part that the ACPI PM domain can figure out is whether or not the power
state of the device needs to be updated due to differences between runtime
PM and system suspend configuration requirements.  If it doesn't need to be
updated, acpi_subsys_prepare() returns 1 which may me overoptimistic.

For many devices that works, because the only possible reason why they may
need to be accessed during system suspend is to update their power state.

It may not work for some devices, though, because there may be other reasons
for accessing them during system suspend and that's where some opt-out way
is needed.

> On those ARM SoCs I am working on, non-ACPI, the information about
> whether a device may become runtime resumed during system suspend,
> most often can't be find out in a deterministic way. That's because
> this information depends on how a device is being used by other
> devices, which changes dynamically and from one system suspend
> sequence to another. In cases like the i2c-designware-plat driver used
> in Hikey (ARM64 board), it can't ever know before hand, if someone is
> going to request an i2c transfer during system suspend or not.

Well, I2C is somewhat special in that respect, because dependencies between
devices in there are not tracked AFAICS. 

> To really deal with these devices properly, we have to suspend them in
> the correct order.

Right, but in order to achieve that the right ordering actually needs
to be known.  If it is not known, there is no way to get that right in
general. :-)

The problem basically is that during system suspend you need to disable
the controller at one point, sooner or later, and keep it disabled from
that point on.   Of course, that should happen when it is guaranteed that
there won't be any new transactions going forward, but you cannot actually
guaranee that without knowing that all of its "consumers" have already
been suspended.

> My point is, doesn't the ordering problem exists also for a device,
> which the PM core runs the direct_complete path for, even if the ACPI
> PM domain is attached to the device? Just because runtime PM is
> disabled for a device, doesn't mean the ordering issue disappears,
> right?

The ordering issue is there if there are dependencies between devices the
PM core doesn't know about.  Otherwise, the rule that direct_complete can
only be used for a given device if it also is used for the entire hierarchy
below it (and for all of the device's "consumers" and everything that depends
on them too for that matter) makes it go away (it serves as a guarantee that
all of the device's "consumers" have already been suspended).

Thanks,
Rafael

