From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [BUGFIX] PM: Fix active child counting when disabled and forbidden
Date: Tue, 13 Nov 2012 11:10:49 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.1211131102330.1292-100000@iolanthe.rowland.org>
References: <1352783539.7176.212.camel@yhuang-dev>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:57716 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1753733Ab2KMQKu (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 13 Nov 2012 11:10:50 -0500
In-Reply-To: <1352783539.7176.212.camel@yhuang-dev>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Huang Ying <ying.huang@intel.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org

On Tue, 13 Nov 2012, Huang Ying wrote:

> > This is not quite right.  Consider a device that is in runtime suspend 
> > when a system sleep starts.  When the system sleep ends, the device 
> > will be resumed but the PM core will still think its state is 
> > SUSPENDED.  The subsystem has to tell the PM core that the device is 
> > now ACTIVE.  Currently, subsystems do this by calling 
> > pm_runtime_disable, pm_runtime_set_active, pm_runtime_enable.  Under 
> > your scheme this wouldn't work; the pm_runtime_set_active call would 
> > fail because the device was !forbidden.
> 
> Thanks for your information.  For this specific situation, is it
> possible to call pm_runtime_resume() or pm_request_resume() for the
> device?

No, because the device already is at full power.  The subsystem just
needs to tell the PM core that it is.

> > > PM.  Device can always work with full power.
> > 
> > It can't if the parent is in SUSPEND.  If necessary, the user can write 
> > "on" to the parent's power/control attribute first.
> 
> Is it possible to call pm_runtime_set_active() for the parent if the
> parent is disabled and SUSPENDED.

Doing that is possible, but it might not work.  The parent might
actually be at low power; calling pm_runtime_set_active wouldn't change
the physical power level.  Basically, it's not safe to assume anything
about devices that are disabled for runtime PM.

> It appears that there is race condition between this and the
> pm_runtime_disable, pm_runtime_set_active, pm_runtime_enable sequence
> you mentioned ealier.
> 
> thread 1			thread 2
> pm_runtime_disable
> pm_runtime_set_active
> 				pm_runtime_allow
> 				  pm_runtime_set_suspended
> pm_runtime_enable

This can't happen in the situation I described earlier because during
system sleep transitions, no other user threads are allowed to run.  
All of them except the one actually carrying out the transition are
frozen.

Alan Stern

