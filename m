From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 3/8] pm: domains: sync runtime PM status with PM domains
Date: Wed, 18 Feb 2015 17:46:34 +0100
Message-ID: <5660196.YRfrN9xVOy@vostro.rjw.lan>
References: <20150214152659.GI8656@n2100.arm.linux.org.uk> <1685853.blxysuNkEh@vostro.rjw.lan> <20150218100322.GT8656@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:57596 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751925AbbBRQXV (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 18 Feb 2015 11:23:21 -0500
In-Reply-To: <20150218100322.GT8656@n2100.arm.linux.org.uk>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, Jason Cooper <jason@lakedaemon.net>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Len Brown <len.brown@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-pm@vger.kernel.org, Alan Stern <stern@rowland.harvard.edu>

On Wednesday, February 18, 2015 10:03:22 AM Russell King - ARM Linux wrote:
> On Wed, Feb 18, 2015 at 08:02:30AM +0100, Rafael J. Wysocki wrote:
> > On Tuesday, February 17, 2015 07:42:43 PM Russell King - ARM Linux wrote:
> > > It's worse than that.  If, in the probe, we decide at a point to query
> > > the PM domain status, and transfer it into the RPM status, how does the
> > > driver know whether it needs to do a "put" to cause a transition from
> > > active to suspended?
> > 
> > When ->probe() runs, the cases are:
> > (1) There are no power domains, so the device is "active" when the clock is
> >     enabled and "suspended" when it is disabled.
> > (2) There is a power domain which is initially off.  The RPM status of the
> >     device has to be "suspended" or the domain needs to be powered up.
> 
> (quick reply)
> 
> That's not entirely correct.
> 
> As a result of 2ed127697eb13 (PM / Domains: Power on the PM domain right
> after attach completes) the power domain will _always_ be powered on prior
> to ->probe() being called, if the device was attached to the PM domain
> just before ->probe() is called, inspite of the domain being powered off
> before the device was attached to the domain.
> 
> If the PM domain is attached earlier, and pm_genpd_poweroff_unused() is
> called (before they're attached, but in the kernel boot sequence) the
> work for powering down the PM domains will be queued until a point where
> it can be scheduled - which will be after devices are attached.  That can
> allow the PM domain(s) to be powered down (as no driver is attached) which
> then results in the driver's ->probe function being called with the PM
> domain OFF.
> 
> So, right now, there's no way for a driver to know with certainty whether
> the device it is about to probe is powered up or powered down.

And it looks that the driver is in a module which is only loaded after we've
called the pm_genpd_poweroff_unused().  So clearly commit 2ed127697eb13 doesn't
work for that driver.

We might just revert that commit, but that wouldn't make the problem go away.
Namely, the domain may be powered up or down by *another* driver whose device
belongs to it in parallel with your ->probe() anyway.

Rafael

