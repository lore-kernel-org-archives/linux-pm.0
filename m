From: Johannes Stezenbach <js@sig21.net>
Subject: Re: [PATCH] PM: Document rules on using pm_runtime_resume() in
 system suspend callbacks
Date: Wed, 20 Sep 2017 18:27:31 +0200
Message-ID: <20170920162731.wopbh7iwggu2xouk@sig21.net>
References: <1849600.vI30ccvhCD@aspire.rjw.lan>
 <CAPDyKFrPGA9OproyQHwVTY5EfAQJnLZuHL+cnJv+1fPYXLLW2w@mail.gmail.com>
 <CAJZ5v0h2gZJbtF2E=+9Ya5NtZCRy+5eVh=OaJJA81rTZR0907g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.sig21.net ([80.244.240.74]:44168 "EHLO mail.sig21.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751499AbdITQ1t (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 20 Sep 2017 12:27:49 -0400
Content-Disposition: inline
In-Reply-To: <CAJZ5v0h2gZJbtF2E=+9Ya5NtZCRy+5eVh=OaJJA81rTZR0907g@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>, Alan Stern <stern@rowland.harvard.edu>, Mika Westerberg <mika.westerberg@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Kevin Hilman <khilman@kernel.org>, LKML <linux-kernel@vger.kernel.org>

On Wed, Sep 20, 2017 at 04:01:32PM +0200, Rafael J. Wysocki wrote:
> On Wed, Sep 20, 2017 at 2:28 PM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> > On 20 September 2017 at 02:26, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> >>
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

I read this half a dozen times and I'm still confused.
Moreover, Documentation/driver-api/pm/devices.rst says:

    Runtime Power Management model:

        Devices may also be put into low-power states while the system is
        running, independently of other power management activity in principle.
        However, devices are not generally independent of each other (for
        example, a parent device cannot be suspended unless all of its child
        devices have been suspended).  ...

However, isn't this a fundamental difference of runtime suspend
vs. system suspend that parent devices *can* be runtime suspended
before their children?  E.g. an audio codec could keep running
while the i2c bus used to program its registers can be runtime suspended.
If this is correct I think it would be useful to spell it out explicitly
in the documentation.

During system suspend, pm core will suspend children first,
and if the child's ->suspend hook uses the i2c bus to access registers,
it will implicitly runtime resume the i2c bus (e.g. due to pm_runtime_get_sync()
in i2c_dw_xfer()).  Later pm core will ->suspend the i2c bus.

I have a hunch the root of the problem is that ->prepare walks the tree
in top-down order, and its return value is used to decide about
direct-complete.  Why does it do that?  Shouldn't pm core check
the direct_complete flag during ->suspend if the device
is in runtime suspend, to decide whether to skip runtime resume + ->suspend
for *this* device?


Johannes
