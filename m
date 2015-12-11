From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [Intel-gfx] [PATCH v2] PM / Runtime: Introduce pm_runtime_get_noidle
Date: Sat, 12 Dec 2015 00:21:43 +0100
Message-ID: <2275921.by5gDRlTiV@vostro.rjw.lan>
References: <1449675920-12986-1-git-send-email-joonas.lahtinen@linux.intel.com> <1751844.P6fyPGmQAC@vostro.rjw.lan> <1449848828.11262.68.camel@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:54347 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752973AbbLKWvk (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 11 Dec 2015 17:51:40 -0500
In-Reply-To: <1449848828.11262.68.camel@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: imre.deak@intel.com
Cc: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, Intel graphics driver community testing & development <intel-gfx@lists.freedesktop.org>, linux-pm@vger.kernel.org

On Friday, December 11, 2015 05:47:08 PM Imre Deak wrote:
> On pe, 2015-12-11 at 16:40 +0100, Rafael J. Wysocki wrote:
> > On Friday, December 11, 2015 02:54:45 PM Imre Deak wrote:
> > > On to, 2015-12-10 at 23:14 +0100, Rafael J. Wysocki wrote:
> > > > On Thursday, December 10, 2015 11:20:40 PM Imre Deak wrote:
> > > > > On Thu, 2015-12-10 at 22:42 +0100, Rafael J. Wysocki wrote:
> > > > > > On Thursday, December 10, 2015 10:36:37 PM Rafael J. Wysocki
> > > > > > wrote:
> > > > > > > On Thursday, December 10, 2015 11:43:50 AM Imre Deak wrote:
> > > > > > > > On Thu, 2015-12-10 at 01:58 +0100, Rafael J. Wysocki
> > > > > > > > wrote:
> > > > > > > > > On Wednesday, December 09, 2015 06:22:19 PM Joonas
> > > > > > > > > Lahtinen
> > > > > > > > > wrote:
> > > > > > > > > > Introduce pm_runtime_get_noidle to for situations
> > > > > > > > > > where
> > > > > > > > > > it is
> > > > > > > > > > not
> > > > > > > > > > desireable to touch an idling device. One use
> > > > > > > > > > scenario is
> > > > > > > > > > periodic
> > > > > > > > > > hangchecks performed by the drm/i915 driver which can
> > > > > > > > > > be
> > > > > > > > > > omitted
> > > > > > > > > > on a device in a runtime idle state.
> > > > > > > > > > 
> > > > > > > > > > v2:
> > > > > > > > > > - Fix inconsistent return value when !CONFIG_PM.
> > > > > > > > > > - Update documentation for bool return value
> > > > > > > > > > 
> > > > > > > > > > Signed-off-by: Joonas Lahtinen <joonas.lahtinen@linux
> > > > > > > > > > .int
> > > > > > > > > > el.c
> > > > > > > > > > om>
> > > > > > > > > > Reported-by: Chris Wilson <chris@chris-wilson.co.uk>
> > > > > > > > > > Cc: Chris Wilson <chris@chris-wilson.co.uk>
> > > > > > > > > > Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> > > > > > > > > > Cc: linux-pm@vger.kernel.org
> > > > > > > > > 
> > > > > > > > > Well, I don't quite see how this can be used in a non-
> > > > > > > > > racy
> > > > > > > > > way
> > > > > > > > > without doing an additional pm_runtime_resume() or
> > > > > > > > > something
> > > > > > > > > like
> > > > > > > > > that in the same code path.
> > > > > > > > 
> > > > > > > > We don't want to resume, that would be the whole point.
> > > > > > > > We'd
> > > > > > > > like
> > > > > > > > to
> > > > > > > > ensure that we hold a reference _and_ the device is
> > > > > > > > already
> > > > > > > > active. So
> > > > > > > > AFAICS we'd need to check runtime_status == RPM_ACTIVE in
> > > > > > > > addition
> > > > > > > > after taking the reference.
> > > > > > > 
> > > > > > > Right, and that under the lock.
> > > > > > 
> > > > > > Which basically means you can call pm_runtime_resume() just
> > > > > > fine,
> > > > > > because it will do nothing if the status is RPM_ACTIVE
> > > > > > already.
> > > > > > 
> > > > > > So really, why don't you use pm_runtime_get_sync()?
> > > > > 
> > > > > The difference would be that if the status is not RPM_ACTIVE
> > > > > already we
> > > > > would drop the reference and report error. The caller would in
> > > > > this
> > > > > case forego of doing something, since we the device is
> > > > > suspended or
> > > > > on
> > > > > the way to being suspended. One example of such a scenario is a
> > > > > watchdog like functionality: the watchdog work would
> > > > > call pm_runtime_get_noidle() and check if the device is ok by
> > > > > doing
> > > > > some HW access, but only if the device is powered. Otherwise
> > > > > the
> > > > > work
> > > > > item would do nothing (meaning it also won't reschedule
> > > > > itself).
> > > > > The
> > > > > watchdog work would get rescheduled next time the device is
> > > > > woken
> > > > > up
> > > > > and some work is submitted to the device.
> > > > 
> > > > So first of all the name "pm_runtime_get_noidle" doesn't make
> > > > sense.
> > > > 
> > > > I guess what you need is something like
> > > > 
> > > > bool pm_runtime_get_if_active(struct device *dev)
> > > > {
> > > > 	unsigned log flags;
> > > > 	bool ret;
> > > > 
> > > > 	spin_lock_irqsave(&dev->power.lock, flags);
> > > > 
> > > > 	if (dev->power.runtime_status == RPM_ACTIVE) {
> > > 
> > > But here usage_count could be zero, meaning that the device is
> > > already
> > > on the way to be suspended (autosuspend or ASYNC suspend), no?
> > 
> > The usage counter equal to 0 need not mean that the device is being
> > suspended
> > right now.
> 
> From the driver's point of view it means there is no need to keep the
> device active, and that's the only thing that matters for the driver.
> It doesn't matter at what exact point the actual suspend will happen
> after the 1->0 transition.

I'm not following you, sorry.

You seem to be talking about a *specific* driver which I guess is i915.
That surely isn't the case for all drivers.

I don't even think this is the case for i915 to be honest, because some
code paths in the core do pm_runtime_get_noresume() without resuming the
device later or pm_runtime_put_noidle().

> > Also even if that's the case, the usage counter may be incremented at
> > this very
> > moment by a concurrent thread and you'll lose the opportunity to do
> > what you
> > want.
> 
> In that case the other thread makes sure that the work what we want to
> do (run the watchdog check) is rescheduled.

Yes, in *your* driver.  What about other drivers that may want to use this
new function?

If you want something that will be suitable to your driver only, you need
to open code it in there.

> We need to handle that kind
> of race anyway, since an increment from 0->1 and setting runtime_status
> to RPM_ACTIVE could happen even after we have already determined here
> that the device is not active and so we return failure.

Right, but my point is that the usage counter value generally doesn't
indicate what the status is and can change independently of the status
at any time.

Yes, my suggested function can be written like this:

bool pm_runtime_get_if_active(struct device *dev)
{
        unsigned log flags;
        bool ret = false;

        spin_lock_irqsave(&dev->power.lock, flags);

        if (dev->power.runtime_status == RPM_ACTIVE) {
                if (atomic_inc_return(&dev->power.usage_count) > 1)
                	ret = true;
		else
			atomic_dec(&dev->power.usage_count);
        }

        spin_unlock_irqrestore(&dev->power.lock, flags);
	return ret;
}

but this is obviously racy with respect to anyone concurrently changing the
usage counter.

> > > In that case we don't want to return success. That would
> > > unnecessarily prolong
> > > the time the device is kept active.
> > 
> > Why?
> > 
> > If you have something to do if the device is active, then do it is
> > the status
> > is "active".  It really shouldn't matter when the device is going to
> > be suspended
> > going forward.
> 
> Let's say the last usage_counter reference is dropped and a suspend is
> scheduled with some delay. Our watchdog gets to run now and sees that
> the device has an RPM_ACTIVE state, while usage_count is 0. We know
> that doing the watchdog check at this point is redundant, since nobody
> is using the device. Also if the watchdog work would take a rpm
> usage_count reference at this point, and the pending rpm_suspend
> handler would run while the reference is held, it couldn't suspend the
> device, the suspend would be delayed unnecessarily.

I see.  Then what about the function above?

Thanks,
Rafael

