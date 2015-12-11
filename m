From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [Intel-gfx] [PATCH v2] PM / Runtime: Introduce pm_runtime_get_noidle
Date: Fri, 11 Dec 2015 16:40:43 +0100
Message-ID: <1751844.P6fyPGmQAC@vostro.rjw.lan>
References: <1449675920-12986-1-git-send-email-joonas.lahtinen@linux.intel.com> <5590453.QflIsWdzXr@vostro.rjw.lan> <1449838485.11262.20.camel@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:49674 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1753951AbbLKPKl (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 11 Dec 2015 10:10:41 -0500
In-Reply-To: <1449838485.11262.20.camel@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: imre.deak@intel.com
Cc: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, Intel graphics driver community testing & development <intel-gfx@lists.freedesktop.org>, linux-pm@vger.kernel.org

On Friday, December 11, 2015 02:54:45 PM Imre Deak wrote:
> On to, 2015-12-10 at 23:14 +0100, Rafael J. Wysocki wrote:
> > On Thursday, December 10, 2015 11:20:40 PM Imre Deak wrote:
> > > On Thu, 2015-12-10 at 22:42 +0100, Rafael J. Wysocki wrote:
> > > > On Thursday, December 10, 2015 10:36:37 PM Rafael J. Wysocki
> > > > wrote:
> > > > > On Thursday, December 10, 2015 11:43:50 AM Imre Deak wrote:
> > > > > > On Thu, 2015-12-10 at 01:58 +0100, Rafael J. Wysocki wrote:
> > > > > > > On Wednesday, December 09, 2015 06:22:19 PM Joonas Lahtinen
> > > > > > > wrote:
> > > > > > > > Introduce pm_runtime_get_noidle to for situations where
> > > > > > > > it is
> > > > > > > > not
> > > > > > > > desireable to touch an idling device. One use scenario is
> > > > > > > > periodic
> > > > > > > > hangchecks performed by the drm/i915 driver which can be
> > > > > > > > omitted
> > > > > > > > on a device in a runtime idle state.
> > > > > > > > 
> > > > > > > > v2:
> > > > > > > > - Fix inconsistent return value when !CONFIG_PM.
> > > > > > > > - Update documentation for bool return value
> > > > > > > > 
> > > > > > > > Signed-off-by: Joonas Lahtinen <joonas.lahtinen@linux.int
> > > > > > > > el.c
> > > > > > > > om>
> > > > > > > > Reported-by: Chris Wilson <chris@chris-wilson.co.uk>
> > > > > > > > Cc: Chris Wilson <chris@chris-wilson.co.uk>
> > > > > > > > Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> > > > > > > > Cc: linux-pm@vger.kernel.org
> > > > > > > 
> > > > > > > Well, I don't quite see how this can be used in a non-racy
> > > > > > > way
> > > > > > > without doing an additional pm_runtime_resume() or
> > > > > > > something
> > > > > > > like
> > > > > > > that in the same code path.
> > > > > > 
> > > > > > We don't want to resume, that would be the whole point. We'd
> > > > > > like
> > > > > > to
> > > > > > ensure that we hold a reference _and_ the device is already
> > > > > > active. So
> > > > > > AFAICS we'd need to check runtime_status == RPM_ACTIVE in
> > > > > > addition
> > > > > > after taking the reference.
> > > > > 
> > > > > Right, and that under the lock.
> > > > 
> > > > Which basically means you can call pm_runtime_resume() just fine,
> > > > because it will do nothing if the status is RPM_ACTIVE already.
> > > > 
> > > > So really, why don't you use pm_runtime_get_sync()?
> > > 
> > > The difference would be that if the status is not RPM_ACTIVE
> > > already we
> > > would drop the reference and report error. The caller would in this
> > > case forego of doing something, since we the device is suspended or
> > > on
> > > the way to being suspended. One example of such a scenario is a
> > > watchdog like functionality: the watchdog work would
> > > call pm_runtime_get_noidle() and check if the device is ok by doing
> > > some HW access, but only if the device is powered. Otherwise the
> > > work
> > > item would do nothing (meaning it also won't reschedule itself).
> > > The
> > > watchdog work would get rescheduled next time the device is woken
> > > up
> > > and some work is submitted to the device.
> > 
> > So first of all the name "pm_runtime_get_noidle" doesn't make sense.
> > 
> > I guess what you need is something like
> > 
> > bool pm_runtime_get_if_active(struct device *dev)
> > {
> > 	unsigned log flags;
> > 	bool ret;
> > 
> > 	spin_lock_irqsave(&dev->power.lock, flags);
> > 
> > 	if (dev->power.runtime_status == RPM_ACTIVE) {
> 
> But here usage_count could be zero, meaning that the device is already
> on the way to be suspended (autosuspend or ASYNC suspend), no?

The usage counter equal to 0 need not mean that the device is being suspended
right now.

Also even if that's the case, the usage counter may be incremented at this very
moment by a concurrent thread and you'll lose the opportunity to do what you
want.

> In that case we don't want to return success. That would unnecessarily prolong
> the time the device is kept active.

Why?

If you have something to do if the device is active, then do it is the status
is "active".  It really shouldn't matter when the device is going to be suspended
going forward.

> > 		atomic_inc(&dev->power.usage_count);
> > 		ret = true;
> > 	} else {
> > 		ret = false;
> > 	}
> > 
> > 	spin_unlock_irqrestore(&dev->power.lock, flags);
> > }
> > 
> > and the caller will simply bail out if "false" is returned, but if
> > "true"
> > is returned, it will have to drop the usage count, right?
> 
> Yes.

OK, I'll send a patch adding this function then.

Thanks,
Rafael

