From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: Allow runtime suspend during system resume
Date: Thu, 9 Jan 2014 10:32:37 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.1401091015200.1493-100000@iolanthe.rowland.org>
References: <3104675.qB4bqA84zs@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:49108 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1753998AbaAIPci (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 9 Jan 2014 10:32:38 -0500
In-Reply-To: <3104675.qB4bqA84zs@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Phillip Susi <psusi@ubuntu.com>, Aaron Lu <aaron.lu@intel.com>, Linux-pm mailing list <linux-pm@vger.kernel.org>

On Thu, 9 Jan 2014, Rafael J. Wysocki wrote:

> > The situation isn't quite so simple.
> > 
> > We're talking specifically about disk drives.  Depending on the drive,
> > it may or may not spin up all by itself when the system wakes up.  If
> > it does spin up, the final state should be RPM_ACTIVE (the way it is
> > now).  If it doesn't, we want the final state to be RPM_SUSPENDED.
> > This is true regardless of the runtime status before the system sleep.
> 
> OK
> 
> We can do all that in .resume_early() which runs with runtime PM disabled.

Either the .resume_early or the .resume routine would be okay, as far
as I'm concerned.  Is there any strong reason to prefer one over the
other, besides the fact that in .resume_early the pm_runtime_disable
and _enable calls wouldn't be needed?

> > This means we can't skip the resume routine.  At the very least, the
> > routine needs to ask the disk whether or not it is spinning.  Depending
> > on the result, it would then set the RPM status appropriately.
> 
> Yes, .resume_early() can do that.  And it can set a (internal) flag for
> a device telling the driver/bus type .resume() and .complete() to
> leave the device alone.

I had in mind something more like this for the driver's .resume (or
.resume_early) routine:

	bool leave_suspended = false;
	int rc = 0;

	if (!pm_runtime_in_use(dev) && !disk_is_spinning(dev))
		leave_suspended = true;
	else
		rc = spin_up_the_disk(dev);

	if (rc == 0) {
		pm_runtime_disable(dev);
		if (leave_suspended)
			pm_runtime_set_suspended(dev);
		else
			pm_runtime_set_active(dev);
		pm_runtime_enable(dev);
	}
	return rc;

That wouldn't need any special support from the PM core, other than the
new pm_runtime_in_use routine.

> > In addition, we only want to end up in RPM_SUSPENDED if the usage
> > counters are 0 (in particular, power/control = "auto").  Otherwise, we
> > want the resume routine always to spin up the drive, if it hasn't spun
> > up by itself.
> 
> That still can be done in .resume_early().  Or in .resume_noirq() if device
> interrupts are not requisite for that.

No, currently it cannot be done.

In both resume_early and resume_noirq, the usage counter is _always_ >
0.  This is because device_prepare calls pm_runtime_get_noresume, and
the corresponding pm_runtime_put doesn't occur until device_complete.  
That's the problem I need to fix.

Alan Stern

