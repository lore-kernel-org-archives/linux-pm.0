From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: Allow runtime suspend during system resume
Date: Sat, 11 Jan 2014 17:34:25 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.1401111730340.16586-100000@netrider.rowland.org>
References: <66174540.xyTk2QCVeJ@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from netrider.rowland.org ([192.131.102.5]:59151 "HELO
	netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1750843AbaAKWe0 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sat, 11 Jan 2014 17:34:26 -0500
In-Reply-To: <66174540.xyTk2QCVeJ@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Phillip Susi <psusi@ubuntu.com>, Aaron Lu <aaron.lu@intel.com>, Linux-pm mailing list <linux-pm@vger.kernel.org>

On Sat, 11 Jan 2014, Rafael J. Wysocki wrote:

> I should have said that in my opinion disabling runtime PM in order to do
> anything with the fields owned by it and re-enabling it right after that
> wasn't quite right in principle.  Re-adjusting those fields *before* we
> re-enable runtime PM during system resume is quite different from doing
> the on-off trick *after* we've re-enabled runtime PM.
> 
> So, my opinion is that the runtime PM internal information should be made
> reflect the actual (and/or desirable) state of things before it is re-enabled,
> which practically means in the .resume_noirq()/.resume_early() time frame.

That makes sense.

> Doing it after that might actually work, but is questionable from the
> overall consistency perspective (it basically would mean that we ran with
> wrong runtime PM data for a while after we'd re-enabled it and before it
> got adjusted, so we shouldn't have re-enabled it in the first place).

Of course, the middle of a system resume is a rather special time.  
Still, I agree with your basic point.

> > Agreed, there are various ways to get the same end result.  My question 
> > here is: How should we implement pm_runtime_in_use()?
> 
> In my opinion what really matters is (a) whether or not the pm_runtime_enable()
> in device_resume_early() will actually enable runtime PM and (b) whether or not
> the pm_runtime_put() in device_complete() will actually make it possible to
> suspend the device.  So, these are the conditions that I would check.

Yes.  The key being that the check will give the correct result only
during the _noirq and _late/_early phases of system sleep, not at other
times.

> > I suppose a simple way to solve the problem is to document that
> > pm_runtime_in_use() should only be invoked from within a system sleep
> > callback routine.  Then we can compare against 1 and not worry about
> > the normal-operation case.  Maybe call it
> > pm_runtime_usage_during_sleep() to make this restriction explicit.
> > 
> > Would that be acceptable?
> 
> Yes, it would, as far as I'm concerned.
> 
> In my opinion it only is really useful to call it before calling
> pm_runtime_enable() in device_resume_early().

Okay, I'll put something together.

Alan Stern

