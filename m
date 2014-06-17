From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH 1/1] PM / Runtime: let rpm_resume fail if rpm disabled
 and device suspended.
Date: Tue, 17 Jun 2014 10:11:32 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1406171007000.1187-100000@iolanthe.rowland.org>
References: <1901328.MvkshKEuEq@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:38545 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S932316AbaFQOLd (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 17 Jun 2014 10:11:33 -0400
In-Reply-To: <1901328.MvkshKEuEq@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Allen Yu <alleny@nvidia.com>, Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

On Mon, 16 Jun 2014, Rafael J. Wysocki wrote:

> > For reasons having nothing to do with Allen's suggested change, I
> > wonder if we shouldn't replace this line with something like:
> > 
> > -	else if (dev->power.disable_depth == 1 && dev->power.is_suspended
> > +	else if (dev->power.disable > 0 && !dev->power.is_suspended
> > 	    && dev->power.runtime_status == RPM_ACTIVE)
> > 		retval = 1;
> > 
> > It seems that I've been bitten by this several times in the past.  
> > When a device is disabled for runtime PM, and more or less permanently
> > stuck in the RPM_ACTIVE state, calls to pm_runtime_resume() or
> > pm_runtime_get_sync() shouldn't fail.
> > 
> > For example, suppose some devices of a certain type support runtime 
> > power management but others don't.  We naturally want to call 
> > pm_runtime_disable() for the ones that don't.  But we also want the 
> > same driver to work for all the devices, which means that 
> > pm_runtime_get_sync() should return success -- otherwise the driver 
> > will think that something has gone wrong.
> > 
> > Rafael, what do you think?
> 
> That condition is there specifically to take care of the system suspend
> code path.  It means that if runtime PM is disabled, but it only has been
> disabled by the system suspend code path, we should treat the device as
> "active" (ie. return 1).  That won't work after the proposed change.

Ah, yes, quite true.  Okay, suppose we replace that line with just:

+	else if (dev->power.disable > 0

> I guess drivers that want to work with devices where runtime PM may be
> disabled can just check the return value of rpm_resume() for -EACCES?

They could, but it's extra work and it's extremely easy to forget 
about.  I'd prefer not to do things that way.

Alan Stern

