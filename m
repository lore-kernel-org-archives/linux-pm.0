From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v3 1/8] PM / Sleep: Make the runtime PM centric path known
 to the PM core
Date: Wed, 30 Aug 2017 15:37:08 +0200
Message-ID: <2403318.HVB4k3qRsK@aspire.rjw.lan>
References: <1504018610-10822-1-git-send-email-ulf.hansson@linaro.org>
 <13933269.sbLfAJfmVU@aspire.rjw.lan>
 <CAPDyKFqujAbw9RAxG-kRhgnhEtAZeojBiL=v5F+JS3T9eaxfgQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <CAPDyKFqujAbw9RAxG-kRhgnhEtAZeojBiL=v5F+JS3T9eaxfgQ@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Jisheng Zhang <jszhang@marvell.com>, Johannes Stezenbach <js@sig21.net>, Guodong Xu <guodong.xu@linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Wolfram Sang <wsa@the-dreams.de>, Kevin Hilman <khilman@kernel.org>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Haojian Zhuang <haojian.zhuang@linaro.org>, John Stultz <john.stultz@linaro.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Sumit Semwal <sumit.semwal@linaro.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Len Brown <lenb@kernel.org>
List-Id: linux-pm@vger.kernel.org

On Wednesday, August 30, 2017 9:13:47 AM CEST Ulf Hansson wrote:
> On 29 August 2017 at 17:15, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> > On Tuesday, August 29, 2017 4:56:43 PM CEST Ulf Hansson wrote:
> >> The main principle behind the runtime PM centric path, is to re-use the
> >> runtime PM callbacks to implement system sleep - and while doing that also
> >> achieve a fully optimized behaviour from PM point of view.
> >>
> >> More precisely, avoid to wake up a device from its low power state during
> >> system sleep, unless the device is really needed to be operational. That
> >> does not only mean avoiding to waste power, but may also decrease system
> >> suspend/resume time for a device.
> >>
> >> However, using the runtime PM centric path for a device, does put some
> >> requirements on the behaviour of the PM core and a potential PM domain that
> >> may be attached to the device. So far, these requirements are not being
> >> specially considered, except by the generic PM domain.
> >>
> >> To move forward and to make it possible to deploy the runtime PM centric
> >> path for cross SoC drivers, which may have different PM domains attached to
> >> its devices depending on the SoC, we must address how to deal with these
> >> requirements. This change starts by making some adoptions to the PM core,
> >> while other parts, such as the ACPI PM domain needs to be taken care of
> >> separately.
> >>
> >> In the runtime PM centric path, the driver is expected to make use of the
> >> pm_runtime_force_suspend|resume() helpers, to deploy system sleep support.
> >> More precisely it may assign the system sleep callbacks to these helpers or
> >> may call them from its own callbacks, in case it needs to perform
> >> additional actions during system sleep.
> >>
> >> In other words, the PM core must always invoke the system sleep callbacks
> >> for the device when they are present, to allow the driver to deal with
> >> the system sleep operations.
> >>
> >> In case the PM core decides to run the direct_complete path for the device,
> >> it skips invoking most of the system sleep callbacks, besides
> >> ->prepare|complete(). Therefore using the direct_complete path in
> >> combination with the runtime PM centric patch for a device, does not play
> >> well.
> >>
> >> To deal with this issue, let's add a flag 'is_rpm_sleep', to the struct
> >> dev_pm_info. The driver that deploys the runtime PM centric path, shall set
> >> the flag for the device during ->probe(), to inform the PM core about that
> >> it must not use the direct_complete path for the device.
> >>
> >> Note, not allowing the direct_complete path for a device, doesn't implicit
> >> need to propagate to the device's parent/suppliers. Therefore make the PM
> >> core check this condition in device_suspend(), before it decides to abandon
> >> the direct_complete path for parent/suppliers.
> >>
> >> To make the is_rpm_sleep flag internal to the PM core, let's add two APIs.
> >>       - dev_pm_use_rpm_sleep(): It sets the flag and should be called by
> >>         the driver during ->probe().
> >>       - dev_pm_is_rpm_sleep(): Makes it possible for users of the device,
> >>         like a PM domain, to fetch the state of the flag.
> >>
> >> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> >> ---
> >>
> >> Changes in v3:
> >>       - New patch.
> >>       - This replaces the earlier method of adding the no_direct_complete to
> >>       the ACPI structures, according to comments from Rafael.
> >>       - This change also address the consern Rafael had around that
> >>       direct_complete should not have to be disabled for parent/suppliers, in
> >>       case a device use the runtime PM centric path for system sleep.
> >>
> >> ---
> >>  drivers/base/power/main.c    | 49 +++++++++++++++++++++++++++++++++++++++-----
> >>  drivers/base/power/runtime.c |  1 +
> >>  include/linux/pm.h           |  7 +++++++
> >>  3 files changed, 52 insertions(+), 5 deletions(-)
> >>
> >> diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
> >> index ea1732e..865737a 100644
> >> --- a/drivers/base/power/main.c
> >> +++ b/drivers/base/power/main.c
> >> @@ -1549,14 +1549,16 @@ static int __device_suspend(struct device *dev, pm_message_t state, bool async)
> >>               if (parent) {
> >>                       spin_lock_irq(&parent->power.lock);
> >>
> >> -                     dev->parent->power.direct_complete = false;
> >> +                     if (!dev->power.is_rpm_sleep)
> >> +                             dev->parent->power.direct_complete = false;
> >
> > This doesn't look good to me at all.
> >
> > It potentially breaks the fundamental assumption of the direct_complete
> > mechanism that no devices with that flag set will ever be runtime resumed
> > during system suspend.
> >
> > Which can happen with this change if a device with power.is_rpm_sleep is
> > resumed causing the parent to be resumed too.
> 
> Doesn't the exact same problem you describe, already exist prior my change!?

No, it doesn't.

> That is, if the current device is runtime suspended and the
> direct_complete flag is set for it, then __device_suspend() has
> already disabled runtime PM for the device, when we reach this point.
> That means, a following attempts to runtime resume the device will
> fail and thus also to runtime resume its parent.

That's because any devices with direct_complete set *cannot* be runtime
resumed after __device_suspend().  That's intentional and how the thing
is designed.  It cannot work differently, sorry.

> So to me, this is a different problem, related how to work out the
> correct order of how to suspend devices.

The ordering matters here, but it is not the problem.

Setting direct_complete means that PM callbacks for this device won't be
invoked going forward.  However, if the state of the device was to change
(like as a result of runtime PM resume), it would be necessary to run those
callbacks after all, but after __device_suspend() it may be too late for
that, because the ->suspend callback may have been skipped already.

The only way to address that is to prevent runtime PM resume of the device
from happening at the point the PM core decides to use direct_complete for it,
but that requires runtime PM to be disabled for it.  Moreover, since the
device is now suspended with runtime PM disabled and its children might rely
on it if they were active, the children must be suspended with runtime PM
disabled at this point too.  That's why direct_complete can only be set
for a device if it is set for the entire hierarchy below it.

Summary: If you allow a device to be runtime resumed during system susped,
direct_complete cannot be set for it and it cannot be set for its parent and
so on.

[cut]

> >> @@ -1709,11 +1711,14 @@ static int device_prepare(struct device *dev, pm_message_t state)
> >>        * A positive return value from ->prepare() means "this device appears
> >>        * to be runtime-suspended and its state is fine, so if it really is
> >>        * runtime-suspended, you can leave it in that state provided that you
> >> -      * will do the same thing with all of its descendants".  This only
> >> -      * applies to suspend transitions, however.
> >> +      * will do the same thing with all of its descendants". To allow this,
> >> +      * the is_rpm_sleep flag must not be set, which is default false, but
> >> +      * may have been changed by a driver. This only applies to suspend
> >> +      * transitions, however.
> >>        */
> >>       spin_lock_irq(&dev->power.lock);
> >> -     dev->power.direct_complete = ret > 0 && state.event == PM_EVENT_SUSPEND;
> >> +     dev->power.direct_complete = ret > 0 && !dev->power.is_rpm_sleep &&
> >> +                             state.event == PM_EVENT_SUSPEND;
> >
> > The only problem addressed by avoiding direct_complete is when runtime PM needs
> > to work during __device_suspend() for devices with direct_complete set.  You
> > said that this was not the case with the i2c designware driver, so I'm not sure
> > what the purpose of this is.
> 
> I should probably work more on my changelog, because I tried to
> explain it there.
> 
> Anyway, let me quote the important parts, and this is not specific for
> the i2c-designware-driver, but generic to drivers using
> pm_runtime_force_suspend|resume().
> 
> "In the runtime PM centric path, the driver is expected to make use of
> the pm_runtime_force_suspend|resume() helpers, to deploy system sleep
> support. More precisely it may assign the system sleep callbacks to
> these helpers or may call them from its own callbacks, in case it
> needs to perform additional actions during system sleep.
> 
> In other words, the PM core must always invoke the system sleep
> callbacks for the device when they are present, to allow the driver to
> deal with the system sleep operations."
> 
> A concrete example is drivers/spi/spi-fsl-espi.c, but one can easily find more.

In fact, the new flag introduced here means "assume that that the driver of this
device points ->late_suspend and ->early_resume to pm_runtime_force_suspend()
and pm_runtime_force_resume(), respectively."  Which then implies that
direct_complete cannot be used with it and (and with its parent and so on)
and that it is not necessary to runtime resume it during system suspend.

However, there are (or at least there may be) devices that need not be
runtime resumed during system suspend even though their drivers don't use
_force_suspend/resume().

Also there are devices whose drivers don't want direct_complete to be used with
them, even though they don't use _force_suspend/resume() and they *do* need
their devices to be runtime resumed during system suspend.

Moreover, some drivers may not mind direct_complete even though their devices
need not be runtime resumed during system suspend.  All of that doesn't have
to be related to using _force_suspend/resume() at all.

So I don't see any reason whatever for combining all of these three *different*
conditions under one flag.

Thanks,
Rafael
