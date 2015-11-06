From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v2] PM / sleep: prohibit devices probing during suspend/hibernation
Date: Fri, 06 Nov 2015 03:04:10 +0100
Message-ID: <5530449.00gvFOj9K4@vostro.rjw.lan>
References: <1445288064-25299-1-git-send-email-grygorii.strashko@ti.com> <19065758.fKD2xM4Ypl@vostro.rjw.lan> <20151106000957.GB10347@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:61317 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1031194AbbKFBe7 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 5 Nov 2015 20:34:59 -0500
In-Reply-To: <20151106000957.GB10347@kroah.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Grygorii Strashko <grygorii.strashko@ti.com>, stern@rowland.harvard.edu, linux-pm@vger.kernel.org, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, linux-kernel@vger.kernel.org, Thierry Reding <thierry.reding@gmail.com>

On Thursday, November 05, 2015 04:09:57 PM Greg Kroah-Hartman wrote:
> On Thu, Nov 05, 2015 at 11:38:23PM +0100, Rafael J. Wysocki wrote:
> > On Monday, November 02, 2015 02:25:00 AM Rafael J. Wysocki wrote:
> > > On Monday, October 19, 2015 11:54:24 PM Grygorii Strashko wrote:
> > > > It is unsafe [1] if probing of devices will happen during suspend or
> > > > hibernation and system behavior will be unpredictable in this case
> > > > (for example: after successful probe the device potentially has a different
> > > >  set of PM callbacks than before [2]).
> > > > So, let's prohibit device's probing in dpm_prepare() and defer their
> > > > probes instead. The normal behavior will be restored in dpm_complete().
> > > > 
> > > > This patch introduces new DD core APIs:
> > > >  device_defer_all_probes_enable()
> > > >    It will disable probing of devices and defer their probes.
> > > >  device_defer_all_probes_disable()
> > > >    It will restore normal behavior and trigger re-probing of deferred
> > > >    devices.
> > > > 
> > > > [1] https://lkml.org/lkml/2015/9/11/554
> > > > [2] https://lkml.org/lkml/2015/9/15/1039
> > > > Cc: Alan Stern <stern@rowland.harvard.edu>
> > > > Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
> > > > Cc: Thierry Reding <thierry.reding@gmail.com>
> > > > Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
> > > 
> > > Greg, any objections against this one?
> > 
> > Greg, if this isn't problematic, I'd still like to take it for v4.4.
> 
> What?  The merge window for new stuff closed a few weeks ago, how can
> you add this for 4.4 when it needs to be in linux-next for a while
> first?

Well, it's not really scary and it was posted way before the merge window,
but no one has had the time to look at it since then, apparently.

Of course, I can queue it up for the next release too.

> I don't have any real objection to it, but I don't see how defering
> probing until "later" really solves anything, no one should be "changing
> pm callbacks" after some other probe succeeds, that sounds like someone
> just wants to have a broken system.

This really is about preventing things from being probed during system
suspend/resume, because (successful) probing effectively changes the
set of PM callbacks for the probed device (the ones provided by the
driver are now available), so allowing it to happen during suspend/resume
is a bad idea (as you said).

This is just a safety measure to provide certain guarantee ("your callbacks
are not going to change in the middle of a suspend/resume sequence").

Thanks,
Rafael

