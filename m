From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [RFD] Functional dependencies between devices
Date: Tue, 17 Nov 2015 15:31:29 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.1511171521000.1680-100000@iolanthe.rowland.org>
References: <564B224D.3050904@samsung.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:43691 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752058AbbKQUba (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 17 Nov 2015 15:31:30 -0500
In-Reply-To: <564B224D.3050904@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Andrzej Hajda <a.hajda@samsung.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM list <linux-pm@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Grant Likely <grant.likely@linaro.org>, Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, Tomeu Vizoso <tomeu.vizoso@collabora.com>, Thierry Reding <treding@nvidia.com>, Dmitry Torokhov <dtor@google.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Michael Turquette <mturquette@baylibre.com>

On Tue, 17 Nov 2015, Andrzej Hajda wrote:

> > and I'd like the driver core to track them and act on them in certain cases
> > where they matter.  The argument for doing that in the driver core is that
> > there are quite a few distinct use cases related to that, they are relatively
> > hard to get right in a driver (if one wants to address all of them properly)
> > and it only gets worse if multiplied by the number of drivers potentially
> > needing to do it.  Morever, at least one case (asynchronous system suspend/resume)
> > cannot be handled in a single driver at all, because it requires the driver of A
> > to wait for B to suspend (during system suspend) and the driver of B to wait for
> > A to resume (during system resume).
> 
> Could you elaborate these distinct use cases. I am curious because I have
> proposed resource tracking framework [1] which should solve most of the issues
> described here. It was not designed to solve suspend/resume issues, but it could
> be easily extended to support it, I suppose.
> 
> [1]: https://lkml.org/lkml/2014/12/10/342

The dependencies Rafael has in mind include the following (and 
undoubtedly include more):

	The consumer device requires some resource from a provider
	device before it can be probed.  Resources can be clocks,
	phys, gpios, and so on.

	The consumer device can't be at full power unless a provider
	device is also at full power.

> Regarding fundamental things, maybe it is just my impression but parsing private
> DT device nodes by kernel core assumes that convention about using resource
> specifiers in DT is a strict rule, it should not be true.
> 
> As I wrote before I have send some early RFC with framework which solves most of
> the problems described here[1], the missing part is suspend/resume support which
> should be quite easy to add, I suspect. Moreover it solves problem of device
> driver hot bind/unbind.
> Could you take a look at it, I will be glad to know it is worth to continue work
> on it?

It looks like the major difference is that you propose to use callbacks
or notifications to do a lot of the work.  For example, a driver
probing a device could register a bunch of dependencies on various
resources, and a callback would be invoked when all those dependencies
were satisfied, at which point the probe procedure could complete.  No 
need for deferrals.

It's an interesting idea.  I'm not sure how well it applies to power
dependencies, though.

Also, there's a real problem that needs to be solved concerning how 
resources are identified in the absence of DT (or ACPI or something 
similar).

Alan Stern

