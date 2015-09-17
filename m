From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH] driver core: Ensure proper suspend/resume ordering
Date: Thu, 17 Sep 2015 17:06:55 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1509171641270.1270-100000@iolanthe.rowland.org>
References: <CAJZ5v0gAsgsA+P_oL=KnAwBpkdJY_P733jBnXnGPdFOs5yiUfw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:53844 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751633AbbIQVG4 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 17 Sep 2015 17:06:56 -0400
In-Reply-To: <CAJZ5v0gAsgsA+P_oL=KnAwBpkdJY_P733jBnXnGPdFOs5yiUfw@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Thierry Reding <thierry.reding@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Grygorii Strashko <grygorii.strashko@ti.com>, Tomeu Vizoso <tomeu.vizoso@collabora.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>

On Thu, 17 Sep 2015, Rafael J. Wysocki wrote:

> Note: Problems also may happen if device A depends on device B and its
> driver to be present and functional and then the B's driver module is
> unloaded.  The core doesn't prevent that from happening AFAICS.

It also doesn't prevent B's driver from being unbound from the B 
device.

To some extent the kernel _does_ prevent driver modules from being
unloaded.  If A's driver uses code resources provided by B's driver
then the module's refcount would be larger than 0.

> I'd like to go back to my initial hunch that the driver knowing about
> a dependency on another one should tell the core about that, so the
> core can make the right things happen at various times (like system
> suspend/resume etc).
> 
> What if we introduce a mechanism allowing drivers to say "I depend on
> device X and its driver to be present and functional from now on" and
> store that information somewhere for the core to use?
> 
> Some time ago (a few years ago actually IIRC) I proposed something
> called "PM links".  The idea was to have objects representing such
> dependencies, although I was not taking the "the driver of the device
> I depend on should be present and functional going forward" condition.
> 
> Say, if a driver wants to check the presence of the device+driver it
> needs to be functional, it will do something like
> 
> ret = create_pm_link(dev, producer);
> 
> and that will return -EPROBE_DEFER if the producer device is not
> functional.  If success is returned, the link has been created and now
> the core will take it into account.
> 
> On driver removal the core may just delete the links where the device
> is the "consumer".  Also there may be a delete_pm_link(dev, producer)
> operation if needed.
> 
> The creation of a link may then include the reordering of dpm_list as
> appropriate so all "producers" are now followed by all of their
> "consumers".  Going forward, though, the core may use the links to
> make all "producers" wait for the PM callbacks of their "consumers" to
> complete during system suspend etc.  It also may use them to prevent
> drivers being depended on from being unloaded and/or to force the
> removal of drivers that depend on something being removed.  In
> principle it may also use those links to coordinate runtime PM
> transitions, but I guess that's not going to be useful in all cases,
> so there needs to be an opt-in mechanism for that.
> 
> Please tell me what you think.

Sounds familiar.  I recall this basic approach from a Plumbers
conference some years ago -- maybe that was when you first proposed it!

You might want to categorize the dependencies into different types.  I 
can think of three types offhand:

	The target device must be present before the current device
	can be probed (hard to imagine how that could be stored as a PM
	link if the target device isn't present, though);

	The target device must be bound to a driver before the current
	device can be probed;

	The target device must be at full power whenever the current
	device is.

Maybe you can think of others.

[Oddly enough, the USB subsystem has some dependencies that don't fall 
into any of these categories.  They have to do with the peculiar way in 
which a low- or full-speed device is handed off from a high-speed 
controller to its companion low/full-speed controller, and they apply 
only to system resume, not to normal operation.  (That is, device A 
requires device B to be at full power when A is being resumed from a 
system sleep, but not when A is operating normally or when A is being 
runtime-resumed.)  For such things, we should keep the existing 
device_pm_wait_for_dev() API.]

This sounds like a big change, but it might be worthwhile.

Alan Stern

