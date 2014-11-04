From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH v8 3/5] amba: Don't unprepare the clocks if device driver
 wants IRQ safe runtime PM
Date: Tue, 4 Nov 2014 11:42:04 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.1411041139370.966-100000@iolanthe.rowland.org>
References: <1464221.Cac76ZHBQl@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:51302 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1750869AbaKDQmF (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 4 Nov 2014 11:42:05 -0500
In-Reply-To: <1464221.Cac76ZHBQl@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, Linux-pm mailing list <linux-pm@vger.kernel.org>

[CC: list drastically pruned]

On Tue, 4 Nov 2014, Rafael J. Wysocki wrote:

> > > callbacks are called in depends on whether the driver itself has
> > > marked the device as having IRQ-safe callbacks.
> > > 
> > > That's fine, but the bus and PM domain level code then /really/ needs
> > > to know what context they're being called in, so they know whether
> > > they can sleep or not, or they must to be written to always use
> > > non-sleeping functions so they work in both contexts.  If we assume
> > > the former, then that implies that the irq-safe flag must never change
> > > state between a suspend and a resume.
> > 
> > If a bus subsystem or PM domain is going to allow its drivers to choose
> > between IRQ-safe and non-IRQ-safe runtime PM, then it is up to the
> > subsystem to come up with a way for drivers to indicate their choice.
> > 
> > I tend to agree with Rafael that testing dev->power.irq_safe should be 
> > good enough, with no real need for a wrapper.  But the subsystem can 
> > use a different mechanism if it wants.
> > 
> > Bear in mind, however, that once the irq_safe flag has been set, the 
> > runtime PM core offers no way to turn it off again.
> 
> There is a problem with it, though.  Say, a driver handles a device that
> may or may not be in a power domain.  Or in other words, the power domain
> the device is in may or may not be always on.  If the domain is always on,
> the runtime PM callbacks are IRQ-safe (they depend on the driver only).
> If it isn't, they may not be IRQ-safe.  How's the driver going to decide
> whether or not to set power.irq_safe?

We already handle that sort of problem for devices that don't belong to 
a power domain.  When the irq_safe flag is turned on, we permanently 
increment the parent's usage counter.  After that, the parent can never 
be runtime suspended.

Something along the same lines should work for power domains.

Alan Stern

