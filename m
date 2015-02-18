From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 3/8] pm: domains: sync runtime PM status with PM domains
Date: Wed, 18 Feb 2015 17:52:25 +0100
Message-ID: <1790876.GQ4uCu6bPH@vostro.rjw.lan>
References: <Pine.LNX.4.44L0.1502181007320.1245-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:52275 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751712AbbBRQ3M (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 18 Feb 2015 11:29:12 -0500
In-Reply-To: <Pine.LNX.4.44L0.1502181007320.1245-100000@iolanthe.rowland.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, Andrew Lunn <andrew@lunn.ch>, Jason Cooper <jason@lakedaemon.net>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Len Brown <len.brown@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-pm@vger.kernel.org

On Wednesday, February 18, 2015 10:12:17 AM Alan Stern wrote:
> On Wed, 18 Feb 2015, Russell King - ARM Linux wrote:
> 
> > On Wed, Feb 18, 2015 at 08:02:30AM +0100, Rafael J. Wysocki wrote:
> > > On Tuesday, February 17, 2015 07:42:43 PM Russell King - ARM Linux wrote:
> > > > It's worse than that.  If, in the probe, we decide at a point to query
> > > > the PM domain status, and transfer it into the RPM status, how does the
> > > > driver know whether it needs to do a "put" to cause a transition from
> > > > active to suspended?
> > > 
> > > When ->probe() runs, the cases are:
> > > (1) There are no power domains, so the device is "active" when the clock is
> > >     enabled and "suspended" when it is disabled.
> > > (2) There is a power domain which is initially off.  The RPM status of the
> > >     device has to be "suspended" or the domain needs to be powered up.
> > 
> > (quick reply)
> > 
> > That's not entirely correct.
> > 
> > As a result of 2ed127697eb13 (PM / Domains: Power on the PM domain right
> > after attach completes) the power domain will _always_ be powered on prior
> > to ->probe() being called, if the device was attached to the PM domain
> > just before ->probe() is called, inspite of the domain being powered off
> > before the device was attached to the domain.
> > 
> > If the PM domain is attached earlier, and pm_genpd_poweroff_unused() is
> > called (before they're attached, but in the kernel boot sequence) the
> > work for powering down the PM domains will be queued until a point where
> > it can be scheduled - which will be after devices are attached.  That can
> > allow the PM domain(s) to be powered down (as no driver is attached) which
> > then results in the driver's ->probe function being called with the PM
> > domain OFF.
> > 
> > So, right now, there's no way for a driver to know with certainty whether
> > the device it is about to probe is powered up or powered down.
> 
> Russell:
> 
> I'm not totally familiar with how PM domains are intended to work.  The 
> impression I get from looking through the code is that they are highly 
> over-engineered

Well, that very likely is my fault. :-)

> -- but that could just be a result of my ignorance.

You may be right anyway, though ...

> At any rate, I don't have a clear picture of the problem you are trying
> to solve.  What's the general outline?  Are you talking about a device
> that _belongs_ to a PM domain or one that _depends_ on a PM domain?  
> If the device belongs to the domain, how does it get added (i.e., by
> its driver during probe or by some other mechanism)?
> 
> Are you asking about how the driver can tell what the PM domain's 
> runtime status is?  Or would you like to add a way for the driver to 
> set the PM domain's runtime status?

The problem, as I see it, is that drivers have certain expectations about the
initial power states of devices that may or may not be met if power domains
are in use.

Those drivers might have been developed on systems without direct control of
power domains where the conditions for the driver at the ->probe() time were
always the same.  With power domains, though, they may change depending on
what's going on with the other devices in the domain, for example.

So the question is how we can address that in the cleanest way possible.

Rafael

