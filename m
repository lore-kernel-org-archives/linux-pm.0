From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH] PM: Document rules on using pm_runtime_resume() in system
 suspend callbacks
Date: Wed, 20 Sep 2017 12:15:50 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1709201201210.1563-100000@iolanthe.rowland.org>
References: <CAJZ5v0h2gZJbtF2E=+9Ya5NtZCRy+5eVh=OaJJA81rTZR0907g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:44596 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1751581AbdITQPv (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 20 Sep 2017 12:15:51 -0400
In-Reply-To: <CAJZ5v0h2gZJbtF2E=+9Ya5NtZCRy+5eVh=OaJJA81rTZR0907g@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Kevin Hilman <khilman@kernel.org>, LKML <linux-kernel@vger.kernel.org>

On Wed, 20 Sep 2017, Rafael J. Wysocki wrote:

> >> Second, leaving devices in runtime suspend in the "suspend" phase of system
> >> suspend is fishy even when their runtime PM is disabled, because that doesn't
> >> guarantee anything regarding their children or possible consumers.  Runtime
> >> PM may still be enabled for those devices at that time and runtime resume may
> >> be triggered for them later, in which case it all quickly falls apart.
> >
> > This is true, although to me this is a about a different problem and
> > has very little to do with pm_runtime_force_suspend().
> >
> > More precisely, whether runtime PM becomes disabled in the suspend
> > phase or suspend_late phase, really doesn't matter. Because in the end
> > this is about suspending/resuming devices in the correct order.
> 
> Yes, it is, but this is not my point (I didn't make it clear enough I guess).
> 
> At the time you make the decision to disable runtime PM for a parent
> (say) and leave it in runtime suspend, all of its children are
> suspended just fine (otherwise the parent wouldn't have been suspended
> too).  However, you *also* need to make sure that there will be no
> attempts to resume any of them *after* that point, which practically
> means that either runtime PM has to have been disabled already for all
> of them at the time it is disabled for the parent, or there has to be
> another guarantee in place.
> 
> That's why the core tries to enforce the "runtime PM disabled for the
> entire hierarchy below" guarantee for the devices with direct_complete
> set, but that may just be overkill in many cases.  I guess it may be
> better to use WARN_ON() to catch the cases in which things may really
> go wrong.

That's a good idea.

> >> IOW, there are reasons why the PM core bumps up the runtime PM usage counters
> >> of all devices during system suspend and they also apply to runtime suspend
> >> callbacks being invoked directly with runtime PM disabled for the given device.
> >> Frankly, it generally is only safe to leave a device in runtime suspend during
> >> system suspend if it can be guarateed that the system suspend callbacks in the
> >> subsequent suspend phases will not be invoked for it at all.
> >
> > I understand this is perfectly true for some of the non-trivial middle
> > layers, however just to be clear, this statement don't have to serve
> > as a general rule for all cases, right?
> 
> Well, a really general version of it is something like "it is only
> safe to leave a device in runtime suspend during system suspend if it
> can be guaranteed that the system suspend callbacks in the subsequent
> suspend phases will not change its state" and the most effective way
> to make that guarantee is to prevent them from being invoked at all.
> :-)

Of course, this can be overkill.  It's probably common for there to be
little physical difference between a device's "suspended" state and
its "runtime-suspended" state.  In such cases, the middle layer and
the subsequent callbacks merely have to recognize that the device is
already at low power (by checking an internal flag, for instance) and
then do nothing when they see that it is.

> > Moreover, bumping the runtime PM usage count
> > (pm_runtime_get_noresume()) in the device_prepare/suspend() phase, was
> > originally added to prevent the runtime PM core from runtime
> > suspending a device, in cases when runtime PM has been enabled for it.
> > Preventing the ->runtime_suspend() callback from being invoked when
> > runtime PM is disabled, just doesn't make any sense to me.
> 
> The problem is that the functionality of ->runtime_suspend() in
> principle overlaps with the functionality of ->suspend(),
> ->suspend_late() and ->suspend_noirq() combined, but it need not be
> entirely the same.  Therefore if you invoke ->runtime_suspend()
> anywhere between the beginning of ->suspend() and the end of
> ->suspend_noirq(), the remaining code in the system sleep callbacks
> needs to know about that in order to avoid, for example, attempting to
> power down the device for the second time in a row, which very well
> may kill the system in some extreme cases.

Another possibility is the arrival of an ill-timed runtime resume after
some of the suspend callbacks have run (because of a wakeup request,
for example).  In short, system PM and runtime PM do overlap
considerably, and this means that it would be easy for either one to
interfere with the other unless the developers are very careful.

> Of course, if those callbacks are trivial, this problem goes away, but
> they need not be trivial and if you are a platform driver (or an
> i2c/spi driver too for that matter), you aren't guaranteed that they
> will always be trivial.  That is quite a bit of an issue to me.

Indeed.  It may not be possible to come up with a firm set of detailed
rules that apply everywhere.  But we should make sure that people are
aware of the issues.

Alan Stern
