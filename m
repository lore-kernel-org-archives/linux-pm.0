From: Alan Stern <stern@rowland.harvard.edu>
Subject: Allow runtime suspend during system resume
Date: Wed, 8 Jan 2014 15:44:53 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.1401081522240.1659-100000@iolanthe.rowland.org>
References: <Pine.LNX.4.44L0.1401081318040.1659-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:59256 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1757026AbaAHUoy (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 8 Jan 2014 15:44:54 -0500
In-Reply-To: <Pine.LNX.4.44L0.1401081318040.1659-100000@iolanthe.rowland.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Phillip Susi <psusi@ubuntu.com>
Cc: Aaron Lu <aaron.lu@intel.com>, Linux-pm mailing list <linux-pm@vger.kernel.org>

On Wed, 8 Jan 2014, Alan Stern wrote:

> On Wed, 8 Jan 2014, Alan Stern wrote:
> 
> > In essence, you want your disk's state to move directly from unpowered
> > (system asleep) to runtime-suspended with no intermediate active -- but
> > only if the disk doesn't spin up all by itself.
> 
> > In the end, it sounds like what you want can be done fairly easily.  
> 
> It turns out there is a snag.  The PM core is set up such that during
> system sleep transitions, there's no way to tell whether or not
> userspace has permitted runtime PM for a device.  (This is because the
> core wants to prevent untimely runtime suspends from occurring in the
> middle of a system sleep transition, and to do so it uses the same
> mechanism as it does when userspace disallows runtime suspend.)
> 
> As a result, we must not go directly from unpowered to
> runtime-suspended.  Not without some sort of change to the PM core.

Rafael:

Right now the PM core does pm_runtime_get_noresume() during the prepare 
phase of system sleep, and pm_runtime_put() during the complete phase.  
Maybe we should cut down the range of coverage.

For example, we could do the pm_runtime_put() during dpm_resume(), or 
even earlier.  That way, the resume routine could do something like:

	if (!pm_runtime_in_use(dev)) {
		pm_runtime_disable(dev);
		pm_runtime_set_suspended(dev);
		pm_runtime_enable(dev);
		return 0;
	}

where pm_runtime_in_use() would check the device's usage counters.  
The device would come out of system sleep in a powered-down state, and
could remain runtime-suspended with no need for an extra
power-up/power-down cycle.  Isn't this the sort of thing the embedded
people want to do?

As it is, drivers have no way to safely put devices directly into 
runtime suspend when coming out of system sleep.

What do you think?

Alan Stern

