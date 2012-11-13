From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [BUGFIX] PM: Fix active child counting when disabled and forbidden
Date: Mon, 12 Nov 2012 21:32:40 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.1211122120140.6961-100000@netrider.rowland.org>
References: <1352769596.7176.194.camel@yhuang-dev>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from netrider.rowland.org ([192.131.102.5]:42685 "HELO
	netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751783Ab2KMCcl (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 12 Nov 2012 21:32:41 -0500
In-Reply-To: <1352769596.7176.194.camel@yhuang-dev>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Huang Ying <ying.huang@intel.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org

On Tue, 13 Nov 2012, Huang Ying wrote:

> Sorry, my original idea is:
> 
> 	pm_runtime_disable will put device into SUSPENDED state if
> 	dev->power.runtime_auto is clear.  pm_runtime_allow will put
> 	device into SUSPENDED state if dev->power.disable_depth > 0.

That's close to what I suggested.

> So in general, my original idea is to manage device runtime power state
> automatically instead of manually, especially when device is in disabled
> state.
> 
> 	disabled + forbidden	-> ACTIVE
> 	disabled + !forbidden	-> SUSPENDED

This is not quite right.  Consider a device that is in runtime suspend 
when a system sleep starts.  When the system sleep ends, the device 
will be resumed but the PM core will still think its state is 
SUSPENDED.  The subsystem has to tell the PM core that the device is 
now ACTIVE.  Currently, subsystems do this by calling 
pm_runtime_disable, pm_runtime_set_active, pm_runtime_enable.  Under 
your scheme this wouldn't work; the pm_runtime_set_active call would 
fail because the device was !forbidden.

> 	enabled + forbidden	-> ACTIVE
> 	enabled + !forbidden	-> auto
> 
> Why we can not do that?

See above.  What we can do instead is:

	disabled + forbidden	-> ACTIVE
	disabled + !forbidden	-> anything

which is basically what I proposed.

> > This means:
> > 
> > 	pm_runtime_set_suspended should fail if dev->power.runtime_auto
> > 	is clear.
> 
> I think we can WARN_ON() here.  Because the caller should responsible
> for state consistence if they decide to manage runtime power state
> manually.

No.  Drivers should not have to worry about whether runtime PM is 
forbidden.  Worrying about that is the PM core's job.

> > 	pm_runtime_forbid should call pm_runtime_set_active if
> > 	dev->power.disable_depth > 0.  (This would run into a problem
> > 	if the parent is suspended and disabled.  Maybe 
> > 	pm_runtime_forbid should fail when this happens.)
> 
> pm_runtime_forbid() may be called via echo "on" > .../power/control.  I
> think it is hard to refuse the request from user space to forbid runtime
> PM.  Device can always work with full power.

It can't if the parent is in SUSPEND.  If necessary, the user can write 
"on" to the parent's power/control attribute first.

> > Finally, we probably should make a third change even though it isn't
> > strictly necessary:
> > 
> > 	pm_runtime_allow should call pm_runtime_set_suspended if
> > 	dev->power.disable_depth > 0.
> 
> I think this is something similar to manage device power state
> automatically if disabled.

Yes, it is similar but not exactly the same as your proposal.

Alan Stern

