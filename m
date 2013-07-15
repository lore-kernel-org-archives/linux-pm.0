From: Yanmin Zhang <yanmin_zhang@linux.intel.com>
Subject: Re: [PATCH] PM: avoid 'autosleep' in shutdown progress
Date: Mon, 15 Jul 2013 08:51:26 +0800
Message-ID: <1373849486.4432.127.camel@ymzhang.sh.intel.com>
References: <1373609651.4432.122.camel@ymzhang.sh.intel.com>
	 <Pine.LNX.4.44L0.1307121034180.1469-100000@iolanthe.rowland.org>
	 <20130713115631.GA16473@amd.pavel.ucw.cz>
Reply-To: yanmin_zhang@linux.intel.com
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:18620 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753732Ab3GOAvl (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Sun, 14 Jul 2013 20:51:41 -0400
In-Reply-To: <20130713115631.GA16473@amd.pavel.ucw.cz>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Alan Stern <stern@rowland.harvard.edu>, shuox.liu@intel.com, linux-kernel@vger.kernel.org, len.brown@intel.com, rjw@sisk.pl, linux-pm@vger.kernel.org

On Sat, 2013-07-13 at 13:56 +0200, Pavel Machek wrote:
> On Fri 2013-07-12 10:37:33, Alan Stern wrote:
> > On Fri, 12 Jul 2013, Yanmin Zhang wrote:
> > 
> > > On Thu, 2013-07-11 at 16:03 +0800, shuox.liu@intel.com wrote:
> > > > From: Liu ShuoX <shuox.liu@intel.com>
> > > > 
> > > > In shutdown progress, system is possible to do power transition
> > > > (such as suspend-to-ram) in parallel. It is unreasonable. So,
> > > > fixes it by adding a system_state checking and queue try_to_suspend
> > > > again when system status is not running.
> > > > 
> > > > Signed-off-by: Liu ShuoX <shuox.liu@intel.com>
> > > > ---
> > > >  kernel/power/autosleep.c |    3 ++-
> > > >  1 files changed, 2 insertions(+), 1 deletions(-)
> > > > 
> > > Without this patch, we hit an hang issue on Android.
> > > 
> > > Scenario:
> > > Kernel starts shutdown and calls all device driver's shutdown callback.
> > > When a driver's shutdown is called, the last wakelock is released and
> > > suspend-to-ram starts. However, as some driver's shut down callbacks
> > > already shut down devices and disable runtime pm, the suspend-to-ram
> > > calls driver's suspend callback without noticing that device is already
> > > off and causes crash.
> > > We know the drivers should be fixed, but can we also change generic
> > > codes a little to make it stronger?
> > 
> > Indeed, this does seem like the sort of thing we want to have.  
> > Allowing an "automatic" or "opportunistic" sleep in the middle of a
> > shutdown makes no sense at all.  In fact, it might be a good idea to
> > disable system sleep completely at this time -- not even a write to
> > /sys/power/state should be allowed to interrupt a shutdown.
> 
> I'm not completely sure, but as long as userland is running, we should
> have system_state == RUNNING, no?
No. The reboot/shutdown is started by application processes, then kernel
changes system_state quickly. See kernel_restart_prepare, kernel_shutdown_prepare.

But indeed, it's a good question. We hit many other issues around rebooting.
When system is rebooting, user space processes are still running. There is no
freeze step. Some processes might jump in to access devices. To avoid it, we
have to add some tricks in some device drivers. It's a little crazy.


