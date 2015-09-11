From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] driver core: Ensure proper suspend/resume ordering
Date: Sat, 12 Sep 2015 00:28:13 +0200
Message-ID: <5347923.qphJvWEeRm@vostro.rjw.lan>
References: <Pine.LNX.4.44L0.1509111445020.1667-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:64539 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1753922AbbIKWAT (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 11 Sep 2015 18:00:19 -0400
In-Reply-To: <Pine.LNX.4.44L0.1509111445020.1667-100000@iolanthe.rowland.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Thierry Reding <thierry.reding@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Grygorii Strashko <grygorii.strashko@ti.com>, Tomeu Vizoso <tomeu.vizoso@collabora.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

On Friday, September 11, 2015 03:01:14 PM Alan Stern wrote:
> On Fri, 11 Sep 2015, Thierry Reding wrote:
> 
> > On Fri, Sep 11, 2015 at 12:08:02AM +0200, Rafael J. Wysocki wrote:
> > > On Thursday, September 10, 2015 12:19:03 PM Thierry Reding wrote:
> > > > From: Thierry Reding <treding@nvidia.com>
> > > > 
> > > > Deferred probe can lead to strange situations where a device that is a
> > > > dependency for others will be moved to the end of the dpm_list. At the
> > > > same time the dependers may not be moved because at the time they will
> > > > be probed the dependee may already have been successfully reprobed and
> > > > they will not have to defer the probe themselves.
> > > 
> > > So there's a bug in the implementation of deferred probing IMO.
> > 
> > Well, yeah. The root problem here is that we don't have dependency
> > information and deferred probing is supposed to fix that. It does so
> > fairly well, but it breaks in this particular case.
> > 
> > > > One example where this happens is the Jetson TK1 board (Tegra124). The
> > > > gpio-keys driver exposes the power key of the board as an input device
> > > > that can also be used as a wakeup source. Commit 17cdddf0fb68 ("ARM:
> > > > tegra: Add gpio-ranges property") results in the gpio-tegra driver
> > > > deferring probe because one of its dependencies, the pinctrl-tegra
> > > > driver, has not successfully completed probing. Currently the deferred
> > > > probe code will move the corresponding gpio-tegra device to the end of
> > > > the dpm_list, but by the time the gpio-keys device, depending on the
> > > > gpio-tegra device, is probed, gpio-tegra has already been reprobed, so
> > > > the gpio-keys device is not moved to the end of dpm_list itself. As a
> > > > result, the suspend ordering becomes pinctrl-tegra -> gpio-keys ->
> > > > gpio-tegra. That's problematic because the gpio-keys driver requests
> > > > the power key to be a wakeup source. However, the programming of the
> > > > wakeup interrupt registers happens in the gpio-tegra driver's suspend
> > > > callback, which is now called before that of the gpio-keys driver. The
> > > > result is that the wrong values are programmed and leaves the system
> > > > unable to be resumed using the power key.
> > > > 
> > > > To fix this situation, always move devices to the end of the dpm_list
> > > > before probing them. Technically this should only be done for devices
> > > > that have been successfully probed, but that won't work for recursive
> > > > probing of devices (think an I2C master that instantiates children in
> > > > its ->probe()). Effectively the dpm_list will end up ordered the same
> > > > way that devices were probed, hence taking care of dependencies.
> 
> I'm not worried about the overhead involved in moving a device to the 
> end of the list every time it is probed.  That ought to be relatively 
> small.
> 
> There are a few things to watch out for.  Since the dpm_list gets
> modified during system sleep transitions, we would have to make sure
> that nothing gets probed during those times.  In principle, that's what
> the "prepare" stage is meant for, but there's still a race.  As long as
> no other kernel thread (such as the deferred probing mechanism) tries
> to probe a device once everything has been frozen, we should be okay.
> But if not, there will be trouble -- after the ->prepare callback runs, 
> the device is no longer on the dpm_list and so we don't want this patch 
> to put it back on that list.

Right.

> There's also an issue about other types of dependencies.  For instance,
> it's conceivable that device B might be discovered and depend on device
> A, even before A has been bound to a driver.  (B might be discovered by 
> A's subsystem rather than A's driver.)  In that case, moving A to the 
> end of the list would cause B to come before A even though B depends on 
> A.  Of course, deferred probing already has this problem.

That may actually happen for PCIe ports and devices below them AFAICS.

Devices below PCIe ports are discovered by the PCI subsystem and the PCIe
ports need not be probed before those devices are probed.

> An easy way to check for this sort of thing would be to verify that a 
> device about to be probed doesn't have any children.  This wouldn't 
> catch all the potential dependencies, but it would be a reasonable 
> start.

That would address the PCIe ports issue.

> Do we currently check that after a device has been unbound, it 
> doesn't have any remaining children?  We should do that too.

We don't and if the device is something like a PCIe port, it'd be OK for it
to still have active children after unbind.

Thanks,
Rafael

