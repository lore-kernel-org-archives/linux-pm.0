From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 0/5] PM: Enable option of re-use runtime PM callbacks at system suspend
Date: Fri, 29 Nov 2013 22:20:42 +0100
Message-ID: <4994754.y6gINBtP7i@vostro.rjw.lan>
References: <Pine.LNX.4.44L0.1311291014020.27250-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:55275 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1753886Ab3K2VHv (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 29 Nov 2013 16:07:51 -0500
In-Reply-To: <Pine.LNX.4.44L0.1311291014020.27250-100000@netrider.rowland.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Kevin Hilman <khilman@linaro.org>

On Friday, November 29, 2013 10:30:57 AM Alan Stern wrote:
> On Fri, 29 Nov 2013, Rafael J. Wysocki wrote:
> 
> > That should have been
> > 
> >  	driver->runtime_suspend(dev)
> >  	do_X(dev)
> > 
> > because do_Y(dev) is for runtime suspend.  Sorry.
> > 
> > And of course, the subsystem-level code you're developing the driver for may not
> > do the do_X(dev) thing at all, in which case all will work.  But what if someone
> > tries to use the driver with a different subsystem-level code (like a new PM
> > domain)?
> 
> It sounds like the problem is one of division of responsibilities.  
> What part of the work is done by the subsystem, and what part is done 
> by the driver?  Obviously the answer will vary from one subsystem to 
> another.
> 
> As I understand it, in Ulf's situation the subsystem knows that the
> operations needed for the suspend_late phase of system suspend are the
> same as those carried out by the driver's runtime_suspend callback (if
> the device isn't already in a runtime-PM low-power state).  Or perhaps
> it knows they are the same as those carried out by the subsystem's
> runtime_suspend callback.  Or perhaps the _driver_ knows that the
> operations it needs for suspend_late are the same as those carried out
> by its own runtime_suspend callback (if the device isn't already in a
> low-power state).
> 
> Regardless, under those conditions the suspend_late routine merely has
> to invoke the appropriate runtime_suspend routine, after checking the
> device's runtime PM status.  We can't do this by calling
> pm_runtime_suspend, because runtime PM is disabled during suspend_late.  
> Instead, we have to call the proper runtime-suspend routine directly.

That would be kind of OK, if the driver's .suspend_late() only invoked its own
.runtime_suspend(), what you did below.

But, in the Ulf's approach the driver calls .runtime_suspend() from
its *subsystem* in the hope that it will all work out properly (or
perhaps based on the knowledge about this particular subsystem).

As I said, that may lead to problems when the same driver is attempted to
be used with a different subsystem-level code (for example, a different PM
domain).

> The amount of code needed is quite small; basically nothing more than:
> 
> 	if (!pm_runtime_status_suspended(dev))
> 		dev->driver->pm->runtime_suspend(dev);
> 
> The problems are:
> 
>      1. Which callback does this code belong in?
> 
>      2. Which runtime_suspend callback should be invoked?  The example 
> 	above uses dev->driver->pm->runtime_suspend, but this may not 
> 	always be the right one.

Well, none of them may always be the right one, which is my point.

I don't think we can come up with a really generic set of routines that will
be generally useful regardless of the subsystem/driver combination in question,
so in my opinion the PM core is not the right place to put such routines into.

I wouldn't have problems with them being defined in the OMAP PM code.  As part
of that code they are free to do whatever they like if that code's maintainers
are fine with that.  But I don't want to see such confusing stuff in the core.

Anyway, I'd like to understand what problems in particular those things would
be useful to solve, as I suspect that they may be addressed differently and
more cleanly.

Thanks,
Rafael

