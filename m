From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH] driver core: Ensure proper suspend/resume ordering
Date: Fri, 11 Sep 2015 10:05:39 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1509111004480.1667-100000@iolanthe.rowland.org>
References: <10787470.V3kIoIEDW3@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:49429 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751795AbbIKOFk (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 11 Sep 2015 10:05:40 -0400
In-Reply-To: <10787470.V3kIoIEDW3@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Thierry Reding <thierry.reding@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Grygorii Strashko <grygorii.strashko@ti.com>, Tomeu Vizoso <tomeu.vizoso@collabora.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

On Fri, 11 Sep 2015, Rafael J. Wysocki wrote:

> On Thursday, September 10, 2015 12:19:03 PM Thierry Reding wrote:
> > From: Thierry Reding <treding@nvidia.com>
> > 
> > Deferred probe can lead to strange situations where a device that is a
> > dependency for others will be moved to the end of the dpm_list. At the
> > same time the dependers may not be moved because at the time they will
> > be probed the dependee may already have been successfully reprobed and
> > they will not have to defer the probe themselves.
> 
> So there's a bug in the implementation of deferred probing IMO.
> 
> > One example where this happens is the Jetson TK1 board (Tegra124). The
> > gpio-keys driver exposes the power key of the board as an input device
> > that can also be used as a wakeup source. Commit 17cdddf0fb68 ("ARM:
> > tegra: Add gpio-ranges property") results in the gpio-tegra driver
> > deferring probe because one of its dependencies, the pinctrl-tegra
> > driver, has not successfully completed probing. Currently the deferred
> > probe code will move the corresponding gpio-tegra device to the end of
> > the dpm_list, but by the time the gpio-keys device, depending on the
> > gpio-tegra device, is probed, gpio-tegra has already been reprobed, so
> > the gpio-keys device is not moved to the end of dpm_list itself. As a
> > result, the suspend ordering becomes pinctrl-tegra -> gpio-keys ->
> > gpio-tegra. That's problematic because the gpio-keys driver requests
> > the power key to be a wakeup source. However, the programming of the
> > wakeup interrupt registers happens in the gpio-tegra driver's suspend
> > callback, which is now called before that of the gpio-keys driver. The
> > result is that the wrong values are programmed and leaves the system
> > unable to be resumed using the power key.
> > 
> > To fix this situation, always move devices to the end of the dpm_list
> > before probing them. Technically this should only be done for devices
> > that have been successfully probed, but that won't work for recursive
> > probing of devices (think an I2C master that instantiates children in
> > its ->probe()). Effectively the dpm_list will end up ordered the same
> > way that devices were probed, hence taking care of dependencies.
> > 
> > Signed-off-by: Thierry Reding <treding@nvidia.com>
> > ---
> > Note that this commit is kind of the PM equivalent of 52cdbdd49853
> > ("driver core: correct device's shutdown order) and that we have two
> > lists that are essentially the same (dpm_list and devices_kset). I'm
> > wondering if it would be worth looking into getting rid of one of
> > them? I don't see any reason why the ordering for shutdown and
> > suspend/resume should be different, and having a single list would
> > help keep this in sync.
> 
> We move away things from dpm_list during suspend and add them back to it
> during resume to handle the situations in which some devices go away or
> appear during suspend/resume.  That makes this idea potentially problematic.

> Alan, what do you think about this?

It's a tricky problem.  Let me give it some thought and I'll get back 
to you.

Alan Stern

