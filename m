From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH 3/8] pm: domains: sync runtime PM status with PM domains
Date: Tue, 17 Feb 2015 14:42:34 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.1502171433330.1362-100000@iolanthe.rowland.org>
References: <1582000.j702YZSJy3@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:41368 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1753008AbbBQTmf (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 17 Feb 2015 14:42:35 -0500
In-Reply-To: <1582000.j702YZSJy3@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Russell King <rmk+kernel@arm.linux.org.uk>, Andrew Lunn <andrew@lunn.ch>, Jason Cooper <jason@lakedaemon.net>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Len Brown <len.brown@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-pm@vger.kernel.org

On Tue, 17 Feb 2015, Rafael J. Wysocki wrote:

> On Saturday, February 14, 2015 03:27:40 PM Russell King wrote:
> > Synchronise the PM domain status with runtime PM's status.  This
> > provides a better solution to the problem than commit 2ed127697eb1
> > ("PM / Domains: Power on the PM domain right after attach completes").
> > 
> > The above commit added a call to power up the PM domain when a device
> > attaches to the domain.  The assumption is that the device driver
> > will cause a runtime PM transition, which will synchronise the PM
> > domain state with the runtime PM state.
> > 
> > However, runtime PM will, by default, assume that the device is
> > initially suspended.  So we have two subsystems which have differing
> > initial state expectations.  This is silly.

As Rafael says, that's putting it a little strongly.  The runtime PM 
status is initialized to RPM_SUSPENDED, simply because it has to be 
initialized to _something_.  But the core doesn't expect that value to 
be meaningful initially.

> > Runtime PM requires that pm_runtime_set_active() is called before
> > pm_runtime_enable() if the device is already powered up.
> 
> Well, this is an oversimplification of sorts.
> 
> What really is expected is that the RPM status of the device will agree
> with its actual state at the moment when pm_runtime_enable() is called.
> 
> If the actual state of the device is "not powered", then it is invalid to
> call pm_runtime_set_active() before pm_runtime_enable() even.

In practice it wouldn't make any difference, so long as
pm_runtime_set_suspended() is called later on but before
pm_runtime_enable().

> > However, PM domains are not informed of this, and this is where the problem
> > really lies.  We need to keep PM domains properly and fully informed of their
> > associated device status.
> 
> This goes backwards.  Rather, PM domains should tell everyone about what they
> have done to the device IMO.  That is, since PM domains power up the device,
> it would be logical to change its RPM status at that point to me.
> 
> That may lead to one subtle problem, though.
> 
> Suppose that, in addition to either having or not having a power domain under
> it, the device has a clock that is managed directly by the driver.  The driver
> may then want to do the clock management in its runtime PM callbacks.
> However, if genpd changes the device's RPM status to "active", the runtime
> PM framework will not execute the resume callback for the device, so things
> will break if the clock is not actually enabled to start with.
> 
> IOW, we need a way for the driver and genpd to agree on what the RPM status
> of the device should be set to before pm_runtime_enable() is executed.

Agreed.  For example, the PM domain may simply have a policy that all
devices must start out in the active state, and require member drivers
to enforce that policy.  Or the PM domain might directly invoke a
driver's runtime-PM callback routine if the device appears to be in the
"wrong" state initially.

> > We fix this by adding a new callback - runtime_set_status() which is
> 
> I'm not sure if that's the way to address that, though.
> 
> Our intention for the pm_runtime_set_active() etc. calls was that they didn't
> trigger any callbacks, since were are supposed to be executed with runtime
> PM disabled.
> 
> Moreover ->
...
> -> That is specific to PM domains and arguably not needed otherwise, so I would
> define it in struct dev_pm_domain outside of dev_pm_ops.

My thought exactly.

Alan Stern

