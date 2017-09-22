From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] PM: Document rules on using pm_runtime_resume() in system suspend callbacks
Date: Sat, 23 Sep 2017 00:29:10 +0200
Message-ID: <1840950.0t1NqvggrK@aspire.rjw.lan>
References: <1849600.vI30ccvhCD@aspire.rjw.lan> <CAJZ5v0h2gZJbtF2E=+9Ya5NtZCRy+5eVh=OaJJA81rTZR0907g@mail.gmail.com> <CAPDyKFoEexNtj02S2y-HxpL2rnLnX8MrRMnZ4kO6sKfofrLO9Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:42750 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752083AbdIVWiS (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 22 Sep 2017 18:38:18 -0400
In-Reply-To: <CAPDyKFoEexNtj02S2y-HxpL2rnLnX8MrRMnZ4kO6sKfofrLO9Q@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Alan Stern <stern@rowland.harvard.edu>, Mika Westerberg <mika.westerberg@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Kevin Hilman <khilman@kernel.org>, LKML <linux-kernel@vger.kernel.org>

On Friday, September 22, 2017 9:22:47 AM CEST Ulf Hansson wrote:
> [...]
> 
> >>> Second, leaving devices in runtime suspend in the "suspend" phase of system
> >>> suspend is fishy even when their runtime PM is disabled, because that doesn't
> >>> guarantee anything regarding their children or possible consumers.  Runtime
> >>> PM may still be enabled for those devices at that time and runtime resume may
> >>> be triggered for them later, in which case it all quickly falls apart.
> >>
> >> This is true, although to me this is a about a different problem and
> >> has very little to do with pm_runtime_force_suspend().
> >>
> >> More precisely, whether runtime PM becomes disabled in the suspend
> >> phase or suspend_late phase, really doesn't matter. Because in the end
> >> this is about suspending/resuming devices in the correct order.
> >
> > Yes, it is, but this is not my point (I didn't make it clear enough I guess).
> >
> > At the time you make the decision to disable runtime PM for a parent
> > (say) and leave it in runtime suspend, all of its children are
> > suspended just fine (otherwise the parent wouldn't have been suspended
> > too).  However, you *also* need to make sure that there will be no
> > attempts to resume any of them *after* that point, which practically
> > means that either runtime PM has to have been disabled already for all
> > of them at the time it is disabled for the parent, or there has to be
> > another guarantee in place.
> >
> > That's why the core tries to enforce the "runtime PM disabled for the
> > entire hierarchy below" guarantee for the devices with direct_complete
> > set, but that may just be overkill in many cases.  I guess it may be
> > better to use WARN_ON() to catch the cases in which things may really
> > go wrong.
> 
> Yes, using WARN_ON() is some clever way, seems like a great idea.
> 
> My point is, disabling runtime PM in a hierarchical manner, isn't a
> solution to the suspend/resume ordering problem.
> 
> >
> >>> IOW, there are reasons why the PM core bumps up the runtime PM usage counters
> >>> of all devices during system suspend and they also apply to runtime suspend
> >>> callbacks being invoked directly with runtime PM disabled for the given device.
> >>> Frankly, it generally is only safe to leave a device in runtime suspend during
> >>> system suspend if it can be guarateed that the system suspend callbacks in the
> >>> subsequent suspend phases will not be invoked for it at all.
> >>
> >> I understand this is perfectly true for some of the non-trivial middle
> >> layers, however just to be clear, this statement don't have to serve
> >> as a general rule for all cases, right?
> >
> > Well, a really general version of it is something like "it is only
> > safe to leave a device in runtime suspend during system suspend if it
> > can be guaranteed that the system suspend callbacks in the subsequent
> > suspend phases will not change its state" and the most effective way
> > to make that guarantee is to prevent them from being invoked at all.
> > :-)
> >
> >> Moreover, bumping the runtime PM usage count
> >> (pm_runtime_get_noresume()) in the device_prepare/suspend() phase, was
> >> originally added to prevent the runtime PM core from runtime
> >> suspending a device, in cases when runtime PM has been enabled for it.
> >> Preventing the ->runtime_suspend() callback from being invoked when
> >> runtime PM is disabled, just doesn't make any sense to me.
> >
> > The problem is that the functionality of ->runtime_suspend() in
> > principle overlaps with the functionality of ->suspend(),
> > ->suspend_late() and ->suspend_noirq() combined, but it need not be
> > entirely the same.  Therefore if you invoke ->runtime_suspend()
> > anywhere between the beginning of ->suspend() and the end of
> > ->suspend_noirq(), the remaining code in the system sleep callbacks
> > needs to know about that in order to avoid, for example, attempting to
> > power down the device for the second time in a row, which very well
> > may kill the system in some extreme cases.
> 
> Agree, this may be a bit tricky to deal with for the more complex middle layers.
> 
> However, this is also very good reason to why it's useful keep the
> runtime PM status up to date, always reflecting the HW status of the
> device - even during system suspend phases.
> 
> >
> > Of course, if those callbacks are trivial, this problem goes away, but
> > they need not be trivial and if you are a platform driver (or an
> > i2c/spi driver too for that matter), you aren't guaranteed that they
> > will always be trivial.  That is quite a bit of an issue to me.
> 
> I understand your concern, but I don't share it. :-)
> 
> To me, I would rather keep things as simple as possible, then deal
> with the complexity once we have a valid case for it.

But we have valid cases, actually, which is why we are talking about that
in the first place.

The point is how to address them and *none* of the choices at hand are
particuarly simple.  Some of them are simply plain unacceptable to me, though,
and I have tried very hard to explain why this is the case, but at this point
I'm just totally out of patience, so please accept the fact.

Thanks,
Rafael
