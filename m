From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: Allow runtime suspend during system resume
Date: Thu, 09 Jan 2014 01:05:34 +0100
Message-ID: <3104675.qB4bqA84zs@vostro.rjw.lan>
References: <Pine.LNX.4.44L0.1401081816330.1659-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:58108 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S932219AbaAHXvp (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 8 Jan 2014 18:51:45 -0500
In-Reply-To: <Pine.LNX.4.44L0.1401081816330.1659-100000@iolanthe.rowland.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Phillip Susi <psusi@ubuntu.com>, Aaron Lu <aaron.lu@intel.com>, Linux-pm mailing list <linux-pm@vger.kernel.org>

> On Wed, 8 Jan 2014, Rafael J. Wysocki wrote:
> > On Wednesday, January 08, 2014 03:44:53 PM Alan Stern wrote:
> > > On Wed, 8 Jan 2014, Alan Stern wrote:
> > > > On Wed, 8 Jan 2014, Alan Stern wrote:
> > > > > In essence, you want your disk's state to move directly from
> > > > > unpowered
> > > > > (system asleep) to runtime-suspended with no intermediate active --
> > > > > but
> > > > > only if the disk doesn't spin up all by itself.
> > > > > 
> > > > > In the end, it sounds like what you want can be done fairly easily.
> > > > 
> > > > It turns out there is a snag.  The PM core is set up such that during
> > > > system sleep transitions, there's no way to tell whether or not
> > > > userspace has permitted runtime PM for a device.  (This is because the
> > > > core wants to prevent untimely runtime suspends from occurring in the
> > > > middle of a system sleep transition, and to do so it uses the same
> > > > mechanism as it does when userspace disallows runtime suspend.)
> > > > 
> > > > As a result, we must not go directly from unpowered to
> > > > runtime-suspended.  Not without some sort of change to the PM core.
> > > 
> > > Rafael:
> > > 
> > > Right now the PM core does pm_runtime_get_noresume() during the prepare
> > > phase of system sleep, and pm_runtime_put() during the complete phase.
> > > Maybe we should cut down the range of coverage.
> > > 
> > > For example, we could do the pm_runtime_put() during dpm_resume(), or
> > > 
> > > even earlier.  That way, the resume routine could do something like:
> > > 	if (!pm_runtime_in_use(dev)) {
> > > 	
> > > 		pm_runtime_disable(dev);
> > > 		pm_runtime_set_suspended(dev);
> > > 		pm_runtime_enable(dev);
> > > 		return 0;
> > > 	
> > > 	}
> > > 
> > > where pm_runtime_in_use() would check the device's usage counters.
> > > The device would come out of system sleep in a powered-down state, and
> > > could remain runtime-suspended with no need for an extra
> > > power-up/power-down cycle.  Isn't this the sort of thing the embedded
> > > people want to do?
> > > 
> > > As it is, drivers have no way to safely put devices directly into
> > > runtime suspend when coming out of system sleep.
> > > 
> > > What do you think?
> > 
> > There are two problems here.
> > 
> > First off, for some devices that were runtime-suspended before system
> > suspend
> > we may not want to touch them at all during system suspend/resume.  I
> > think
> > I know how to address that, but I need to prepare patches yet.  That's
> > going
> > to take a few days at least, sorry about that.
> > 
> > Second, we may want some devices to be set to "runtime suspended" during
> > system resume without touching them, so that runtime PM resumes them when
> > necessary.  I have a patch for that, which hasn't been published yet and
> > which is appended.
> > 
> > The way it works is that whoever wants the system resume of certain device
> > to be skipped, sets the (new) skip_resume flag for that device using
> > device_pm_skip_resume() and that causes the PM core to basically ignore
> > that
> > device's PM callbacks during system resume.
> > 
> > Whether or not doing the pm_request_resume(dev) for devices with
> > skip_resume set in dpm_resume_early() is a good idea is a discussion item
> > in my opinion (evidently, I thought it was when I was preparing this patch).
> 
> The situation isn't quite so simple.
> 
> We're talking specifically about disk drives.  Depending on the drive,
> it may or may not spin up all by itself when the system wakes up.  If
> it does spin up, the final state should be RPM_ACTIVE (the way it is
> now).  If it doesn't, we want the final state to be RPM_SUSPENDED.
> This is true regardless of the runtime status before the system sleep.

OK

We can do all that in .resume_early() which runs with runtime PM disabled.

> This means we can't skip the resume routine.  At the very least, the
> routine needs to ask the disk whether or not it is spinning.  Depending
> on the result, it would then set the RPM status appropriately.

Yes, .resume_early() can do that.  And it can set a (internal) flag for
a device telling the driver/bus type .resume() and .complete() to
leave the device alone.

> In addition, we only want to end up in RPM_SUSPENDED if the usage
> counters are 0 (in particular, power/control = "auto").  Otherwise, we
> want the resume routine always to spin up the drive, if it hasn't spun
> up by itself.

That still can be done in .resume_early().  Or in .resume_noirq() if device
interrupts are not requisite for that.

Thanks,
Rafael

