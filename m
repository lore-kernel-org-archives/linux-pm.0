From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] driver core: Ensure proper suspend/resume ordering
Date: Wed, 16 Sep 2015 03:28:59 +0200
Message-ID: <1475011.GNmxQvg88W@vostro.rjw.lan>
References: <Pine.LNX.4.44L0.1509151505040.1420-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:45482 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752372AbbIPBA7 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 15 Sep 2015 21:00:59 -0400
In-Reply-To: <Pine.LNX.4.44L0.1509151505040.1420-100000@iolanthe.rowland.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Thierry Reding <thierry.reding@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Grygorii Strashko <grygorii.strashko@ti.com>, Tomeu Vizoso <tomeu.vizoso@collabora.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

On Tuesday, September 15, 2015 03:18:19 PM Alan Stern wrote:
> On Tue, 15 Sep 2015, Thierry Reding wrote:
> 
> > > There are a few things to watch out for.  Since the dpm_list gets
> > > modified during system sleep transitions, we would have to make sure
> > > that nothing gets probed during those times.  In principle, that's what
> > > the "prepare" stage is meant for, but there's still a race.  As long as
> > > no other kernel thread (such as the deferred probing mechanism) tries
> > > to probe a device once everything has been frozen, we should be okay.
> > > But if not, there will be trouble -- after the ->prepare callback runs, 
> > > the device is no longer on the dpm_list and so we don't want this patch 
> > > to put it back on that list.
> > 
> > Perhaps moving to the end of the list needs to be a little smarter. That
> > is it could check whether the device has been prepared for suspension or
> > not and only move when it hasn't?
> 
> Maybe.  But doesn't that mean it won't solve your problem completely?
> 
> > Then again, shouldn't the core even prohibit new probes once the suspend
> > has been triggered? Sounds like asking for a lot of trouble if it didn't
> > ...
> 
> The core prohibits new devices from being registered.  It does not 
> prohibit probes of existing devices, because they currently do not 
> affect the dpm_list.

Which may be a mistake, because it does affect callbacks executed during
suspend/resume (after successful probe the device potentially has a different
set of PM callbacks than before).

> In general, we rely on subsystems not to do any probing once a device 
> is suspended.  It's probably reasonable to ask them not to do any 
> probing once a device has gone through the "prepare" stage.

Right.

Question is when it should be allowed to probe again.  I guess at the same
time we allow registrations to to take place again?

Thanks,
Rafael

