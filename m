From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: Allow runtime suspend during system resume
Date: Wed, 8 Jan 2014 16:34:35 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.1401081627110.1659-100000@iolanthe.rowland.org>
References: <52CDC069.6050703@ubuntu.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:59289 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1757599AbaAHVeg (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 8 Jan 2014 16:34:36 -0500
In-Reply-To: <52CDC069.6050703@ubuntu.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Phillip Susi <psusi@ubuntu.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Aaron Lu <aaron.lu@intel.com>, Linux-pm mailing list <linux-pm@vger.kernel.org>

On Wed, 8 Jan 2014, Phillip Susi wrote:

> On 1/8/2014 3:44 PM, Alan Stern wrote:
> > Right now the PM core does pm_runtime_get_noresume() during the
> > prepare phase of system sleep, and pm_runtime_put() during the
> > complete phase. Maybe we should cut down the range of coverage.
> > 
> > For example, we could do the pm_runtime_put() during dpm_resume(),
> > or even earlier.  That way, the resume routine could do something
> > like:
> > 
> > if (!pm_runtime_in_use(dev)) { pm_runtime_disable(dev); 
> > pm_runtime_set_suspended(dev); pm_runtime_enable(dev); return 0; }
> > 
> 
> I'm a little unclear on the problem you are describing.  Is it just
> with pm_runtime_in_use()?

Note that currently there is no pm_runtime_in_use().  One of the things
I'm proposing is to add it.

If it were already present and you used it properly, you would find
that it always returned non-zero.  Therefore you would never execute
the pm_runtime_set_suspended.  _That_'s the problem I'm trying to
address here.

>  Because in one of my earlier patch
> iterations, I had used the disable/set_suspended/enable to force the
> device into suspend without checking runtime_in_use.

That is not a valid thing to do.  The user may have disabled runtime 
suspend for the disk; you must not override the user's policy.

>  It worked, but
> that allowed the port device to auto suspend since its use counter
> dropped to zero, so I couldn't issue the REQUEST SENSE command
> disable/set_active/enable to reverse the process ( since the port was
> suspended ).

That's a separate problem, to be discussed back in the earlier email 
thread.

Alan Stern

