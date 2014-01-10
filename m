From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: Allow runtime suspend during system resume
Date: Sat, 11 Jan 2014 00:02:18 +0100
Message-ID: <66174540.xyTk2QCVeJ@vostro.rjw.lan>
References: <Pine.LNX.4.44L0.1401101012400.1399-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:64780 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751304AbaAJWs1 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 10 Jan 2014 17:48:27 -0500
In-Reply-To: <Pine.LNX.4.44L0.1401101012400.1399-100000@iolanthe.rowland.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Phillip Susi <psusi@ubuntu.com>, Aaron Lu <aaron.lu@intel.com>, Linux-pm mailing list <linux-pm@vger.kernel.org>

On Friday, January 10, 2014 10:25:32 AM Alan Stern wrote:
> On Fri, 10 Jan 2014, Rafael J. Wysocki wrote:
> 
> > On Thursday, January 09, 2014 10:32:37 AM Alan Stern wrote:
> > > On Thu, 9 Jan 2014, Rafael J. Wysocki wrote:
> > > 
> > > > > The situation isn't quite so simple.
> > > > > 
> > > > > We're talking specifically about disk drives.  Depending on the drive,
> > > > > it may or may not spin up all by itself when the system wakes up.  If
> > > > > it does spin up, the final state should be RPM_ACTIVE (the way it is
> > > > > now).  If it doesn't, we want the final state to be RPM_SUSPENDED.
> > > > > This is true regardless of the runtime status before the system sleep.
> > > > 
> > > > OK
> > > > 
> > > > We can do all that in .resume_early() which runs with runtime PM disabled.
> > > 
> > > Either the .resume_early or the .resume routine would be okay, as far
> > > as I'm concerned.  Is there any strong reason to prefer one over the
> > > other, besides the fact that in .resume_early the pm_runtime_disable
> > > and _enable calls wouldn't be needed?
> > 
> > Not so much, at least I don't have anything like that in mind right now, but
> > I'm not a big fan of disabling/enabling runtime PM temporarily to have a look
> > at the "current" status.  That just doesn't seem quite right. :-)
> 
> The disable/enable is in order to _set_ the status, not to have a look 
> at it.

Right.

I should have said that in my opinion disabling runtime PM in order to do
anything with the fields owned by it and re-enabling it right after that
wasn't quite right in principle.  Re-adjusting those fields *before* we
re-enable runtime PM during system resume is quite different from doing
the on-off trick *after* we've re-enabled runtime PM.

So, my opinion is that the runtime PM internal information should be made
reflect the actual (and/or desirable) state of things before it is re-enabled,
which practically means in the .resume_noirq()/.resume_early() time frame.

Doing it after that might actually work, but is questionable from the
overall consistency perspective (it basically would mean that we ran with
wrong runtime PM data for a while after we'd re-enabled it and before it
got adjusted, so we shouldn't have re-enabled it in the first place).

> > > I had in mind something more like this for the driver's .resume (or
> > > .resume_early) routine:
> > > 
> > > 	bool leave_suspended = false;
> > > 	int rc = 0;
> > > 
> > > 	if (!pm_runtime_in_use(dev) && !disk_is_spinning(dev))
> > > 		leave_suspended = true;
> > > 	else
> > > 		rc = spin_up_the_disk(dev);
> > > 
> > > 	if (rc == 0) {
> > > 		pm_runtime_disable(dev);
> > > 		if (leave_suspended)
> > > 			pm_runtime_set_suspended(dev);
> > > 		else
> > > 			pm_runtime_set_active(dev);
> > > 		pm_runtime_enable(dev);
> > > 	}
> > > 	return rc;
> > > 
> > > That wouldn't need any special support from the PM core, other than the
> > > new pm_runtime_in_use routine.
> > 
> > That looks reasonable, but in .resume_early() you can do it like this I think:
> > 
> > 	bool disk_spinning = disk_is_spinning(dev);
> > 	int rc = 0;
> > 
> > 	if (!pm_runtime_in_use(dev) && !disk_spinning) {
> > 		pm_runtime_set_suspended(dev);
> > 	} else {
> > 		pm_runtime_set_active(dev);
> > 		if (!disk_spinning)
> > 			rc = spin_up_the_disk(dev);
> > 	}
> > 
> > and of course there needs to be a flag to pass to .resume() in case the
> > device is supposed to be left in the suspended state.
> 
> Agreed, there are various ways to get the same end result.  My question 
> here is: How should we implement pm_runtime_in_use()?

In my opinion what really matters is (a) whether or not the pm_runtime_enable()
in device_resume_early() will actually enable runtime PM and (b) whether or not
the pm_runtime_put() in device_complete() will actually make it possible to
suspend the device.  So, these are the conditions that I would check.

> > > > > In addition, we only want to end up in RPM_SUSPENDED if the usage
> > > > > counters are 0 (in particular, power/control = "auto").  Otherwise, we
> > > > > want the resume routine always to spin up the drive, if it hasn't spun
> > > > > up by itself.
> > > > 
> > > > That still can be done in .resume_early().  Or in .resume_noirq() if device
> > > > interrupts are not requisite for that.
> > > 
> > > No, currently it cannot be done.
> > > 
> > > In both resume_early and resume_noirq, the usage counter is _always_ >
> > > 0.  This is because device_prepare calls pm_runtime_get_noresume, and
> > > the corresponding pm_runtime_put doesn't occur until device_complete.  
> > > That's the problem I need to fix.
> > 
> > Hmm.  Why do you have to compare usage_count with 0 and not with 1?
> 
> It is an awkward problem.  During a system sleep transition,
> pm_runtime_in_use() should return 0 if the usage_count is 1 (because of
> the pm_runtime_get_noresume() in device_prepare()).
> 
> But at other times (i.e., during normal operation), pm_runtime_in_use()  
> should return 0 if the usage_count is 0.
> 
> I suppose a simple way to solve the problem is to document that
> pm_runtime_in_use() should only be invoked from within a system sleep
> callback routine.  Then we can compare against 1 and not worry about
> the normal-operation case.  Maybe call it
> pm_runtime_usage_during_sleep() to make this restriction explicit.
> 
> Would that be acceptable?

Yes, it would, as far as I'm concerned.

In my opinion it only is really useful to call it before calling
pm_runtime_enable() in device_resume_early().

Thanks,
Rafael

