From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH] PM: avoid 'autosleep' in shutdown progress
Date: Fri, 12 Jul 2013 10:37:33 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1307121034180.1469-100000@iolanthe.rowland.org>
References: <1373609651.4432.122.camel@ymzhang.sh.intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:32952 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1757461Ab3GLOhe (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 12 Jul 2013 10:37:34 -0400
In-Reply-To: <1373609651.4432.122.camel@ymzhang.sh.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Yanmin Zhang <yanmin_zhang@linux.intel.com>
Cc: shuox.liu@intel.com, linux-kernel@vger.kernel.org, len.brown@intel.com, pavel@ucw.cz, rjw@sisk.pl, linux-pm@vger.kernel.org

On Fri, 12 Jul 2013, Yanmin Zhang wrote:

> On Thu, 2013-07-11 at 16:03 +0800, shuox.liu@intel.com wrote:
> > From: Liu ShuoX <shuox.liu@intel.com>
> > 
> > In shutdown progress, system is possible to do power transition
> > (such as suspend-to-ram) in parallel. It is unreasonable. So,
> > fixes it by adding a system_state checking and queue try_to_suspend
> > again when system status is not running.
> > 
> > Signed-off-by: Liu ShuoX <shuox.liu@intel.com>
> > ---
> >  kernel/power/autosleep.c |    3 ++-
> >  1 files changed, 2 insertions(+), 1 deletions(-)
> > 
> Without this patch, we hit an hang issue on Android.
> 
> Scenario:
> Kernel starts shutdown and calls all device driver's shutdown callback.
> When a driver's shutdown is called, the last wakelock is released and
> suspend-to-ram starts. However, as some driver's shut down callbacks
> already shut down devices and disable runtime pm, the suspend-to-ram
> calls driver's suspend callback without noticing that device is already
> off and causes crash.
> We know the drivers should be fixed, but can we also change generic
> codes a little to make it stronger?

Indeed, this does seem like the sort of thing we want to have.  
Allowing an "automatic" or "opportunistic" sleep in the middle of a
shutdown makes no sense at all.  In fact, it might be a good idea to
disable system sleep completely at this time -- not even a write to
/sys/power/state should be allowed to interrupt a shutdown.

Alan Stern

