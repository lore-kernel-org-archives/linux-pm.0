From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: Allow runtime suspend during system resume
Date: Sat, 11 Jan 2014 17:50:40 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.1401111735050.16586-100000@netrider.rowland.org>
References: <52D0A79E.6080905@ubuntu.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from netrider.rowland.org ([192.131.102.5]:39819 "HELO
	netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1750800AbaAKWul (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sat, 11 Jan 2014 17:50:41 -0500
In-Reply-To: <52D0A79E.6080905@ubuntu.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Phillip Susi <psusi@ubuntu.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Aaron Lu <aaron.lu@intel.com>, Linux-pm mailing list <linux-pm@vger.kernel.org>

On Fri, 10 Jan 2014, Phillip Susi wrote:

> On 01/10/2014 06:02 PM, Rafael J. Wysocki wrote:
> > So, my opinion is that the runtime PM internal information should
> > be made reflect the actual (and/or desirable) state of things
> > before it is re-enabled, which practically means in the
> > .resume_noirq()/.resume_early() time frame.
> > 
> > Doing it after that might actually work, but is questionable from
> > the overall consistency perspective (it basically would mean that
> > we ran with wrong runtime PM data for a while after we'd re-enabled
> > it and before it got adjusted, so we shouldn't have re-enabled it
> > in the first place).
> 
> But we don't want to block the system resume path for too long while
> we figure out what the correct state is.

We won't.  The resume_early routine will set the status to RPM_ACTIVE 
or RPM_SUSPENDED, according to the result from 
pm_runtime_usage_during_sleep.  It will also do a pm_runtime_get_sync 
on the disk's parent, to prevent the parent from going into runtime 
suspend before the async routine can run.

Then the async routine will do the following:

	If the status is RPM_ACTIVE, spin up the disk.

	Else (the status is RPM_SUSPENDED) check whether the disk has
	spun up by itself.  If it has, or if you can't tell, call 
	pm_runtime_resume to set the status correctly and do an 
	explicit spin-up.

	Call pm_runtime_put_sync on the parent.

I think this will give the desired result.  But there is one potential
problem: If the disk has a child device (such as a partition) and the
child's driver needs to do I/O as part of its resume routine, the I/O
is likely to hang if the disk is runtime suspended.  However, I don't
know of any child devices like this.

Alan Stern

