From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] PM / runtime: Rework pm_runtime_force_suspend/resume()
Date: Tue, 02 Jan 2018 20:07:55 +0100
Message-ID: <2760744.Zsn8Ys48yq@aspire.rjw.lan>
References: <20180102130404.GA23434@wunner.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.pl ([79.96.170.134]:51503 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751127AbeABTRV (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 2 Jan 2018 14:17:21 -0500
In-Reply-To: <20180102130404.GA23434@wunner.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lukas Wunner <lukas@wunner.de>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Kevin Hilman <khilman@kernel.org>, LKML <linux-kernel@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Geert Uytterhoeven <geert@linux-m68k.org>

On Tuesday, January 2, 2018 2:04:04 PM CET Lukas Wunner wrote:
> On Tue, Jan 02, 2018 at 12:02:18PM +0100, Rafael J. Wysocki wrote:
> > On Tue, Jan 2, 2018 at 11:51 AM, Lukas Wunner <lukas@wunner.de> wrote:
> > > On Tue, Jan 02, 2018 at 01:56:28AM +0100, Rafael J. Wysocki wrote:
> > >> +     if (atomic_read(&dev->power.usage_count) <= 1 &&
> > >> +         atomic_read(&dev->power.child_count) == 0)
> > >> +             pm_runtime_set_suspended(dev);
> > >>
> > >> -     pm_runtime_set_suspended(dev);
> > >
> > > The ->runtime_suspend callback *has* been executed at this point.
> > > If the status is only updated conditionally, it may not reflect
> > > the device's actual power state correctly.  That doesn't seem to
> > > be a good idea.
> > 
> > It doesn't matter, because this is done with runtime PM disabled, isn't it?
> 
> It might not make a difference for the use case I have in mind, but
> pm_runtime_status_suspended() will return an incorrect result and is
> called from 47 files in 4.15-rc6 according to lxr.free-electrons.com.

Generally, the runtime PM status is only meaningful for devices with runtime PM
enabled.

There is an exception, which is during system suspend/resume, when runtime PM
is automatically disabled by the core, but that only under certain assumptions.

Basically, you have to assume that no one else will mess up with the device
between the times you call pm_runtime_status_suspended() to check its runtime
PM status (or between the first time you do that and the last time runtime PM
has been enabled for the device).

This patch doesn't change the situation in that respect.

> > > The kerneldoc says:
> > >
> > >     Typically this function may be invoked from a system suspend callback
> > >     to make sure the device is put into low power state.
> > >
> > > That portion is not modified by your patch.
> > >
> > > "Typically" implies that it's legal to call pm_runtime_force_suspend() in
> > > *other* contexts than as a ->suspend hook.
> > 
> > It should only be used during system suspend anyway, however.
> 
> Then the kerneldoc is wrong.

It isn't wrong.  It may be incomplete, but the information in it is correct.

And making it more complete is not part of this patch IMO.

> > >> One addition that would be really helpful:  pm_runtime_force_suspend()
> > >> should also force-suspend all children and consumers of the given
> > >> device.  Likewise, those should be resumed on pm_runtime_force_resume().
> > >> Then I could just add a device link from the audio PCI device on the GPU
> > >> to the graphics PCI device and just call pm_runtime_force_*() on the
> > >> graphics device (supplier) to magically power them both off and on.
> > >
> > > Actually, the assumption is that pm_runtime_force_suspend() must be
> > > called for the children before it is called for the parent even
> > > without my patch, so it is just not going to work this way.
> > 
> > Moreover, what if those devices have nonzero usage counters?  There
> > may be other reasons for that than just dependencies, like for example
> > user space might have written "on" to their "control" files in sysfs.
> 
> In that case pm_runtime_force_suspend() should return a negative errno.

In which case it wouldn't be suitable for the system-wide PM callback role.

> I envision amending control_store() so that "off" can be written to the
> "control" file, allowing userspace to invoke pm_runtime_force_suspend()
> to force certain devices into runtime suspend.

But it isn't a good tool for the purpose which I'm trying to tell you.

You need something else.

> The user would get back
> an error if the call failed for some reason (such as an active child or
> consumer of the to be force-suspended device).  That would be a clean
> replacement for the ON/OFF options we currently have for the
> vga_switcheroo debugfs control file.

Well, it looks like you are looking for an interface to invoke
pm_runtime_suspend() for the device as it behaves exactly the way you want. :-)

Thanks,
Rafael
