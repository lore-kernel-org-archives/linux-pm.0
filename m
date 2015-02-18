From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 3/8] pm: domains: sync runtime PM status with PM domains
Date: Wed, 18 Feb 2015 15:42:16 +0000
Message-ID: <20150218154216.GU8656@n2100.arm.linux.org.uk>
References: <20150218100322.GT8656@n2100.arm.linux.org.uk>
 <Pine.LNX.4.44L0.1502181007320.1245-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from pandora.arm.linux.org.uk ([78.32.30.218]:48704 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752487AbbBRPme (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 18 Feb 2015 10:42:34 -0500
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.1502181007320.1245-100000@iolanthe.rowland.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Andrew Lunn <andrew@lunn.ch>, Jason Cooper <jason@lakedaemon.net>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Len Brown <len.brown@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-pm@vger.kernel.org

On Wed, Feb 18, 2015 at 10:12:17AM -0500, Alan Stern wrote:
> Russell:
> 
> I'm not totally familiar with how PM domains are intended to work.  The 
> impression I get from looking through the code is that they are highly 
> over-engineered -- but that could just be a result of my ignorance.
> 
> At any rate, I don't have a clear picture of the problem you are trying
> to solve.  What's the general outline?  Are you talking about a device
> that _belongs_ to a PM domain or one that _depends_ on a PM domain?  
> If the device belongs to the domain, how does it get added (i.e., by
> its driver during probe or by some other mechanism)?
> 
> Are you asking about how the driver can tell what the PM domain's 
> runtime status is?  Or would you like to add a way for the driver to 
> set the PM domain's runtime status?
> 
> What else am I missing?

The problem is that the PM domain stuff doesn't work very well, and I
believe it's problems are just being hacked around rather than being
viewed from a higher level and fixed properly. :)

The issue that I'm seeing with 3.19 is that I have a device which
does not need to be powered up to probe.  It's default state when the
kernel initially starts to boot is that the power domain associated
with it is powered down.

Hence, the driver is written such that its probe function does this:

        pm_runtime_use_autosuspend(vi->dev);
        pm_runtime_set_autosuspend_delay(vi->dev, 100);
        pm_runtime_enable(vi->dev);

The driver lives as a module on the filesystem, and so it's loaded
after the kernel has mounted its rootfs and udev has started.

Now, I boot this platform in two ways: I have a DT mode (which I have
found is not that stable - in that it causes problems with HDMI), and
a legacy mode.

When I boot in legacy mode, the PM domain is created early in the
kernel boot (at arch_initcall time).  As part of the PM domain
initialisation, I read the current state of the hardware and tell
PM domains whether it was enabled or not.  In this case, it starts
off disabled.

Right after they're created, I call pm_genpd_poweroff_unused() and
then register a notifier for platform devices.  The call to
pm_genpd_poweroff_unused() causes a work to be queued, which will
only get executed when we reach a scheduling or preemption point.

The platform devices then get created, and the notifier attaches the
appropriate PM domains to the devices.

In 3.18 and previous kernels, this resulted in the PM domains being
left in their initial state.  This means that the presumption by the
driver that the device is suspended is correct and valid.

In 3.19, this causes the PM domain to be powered up immediately.
However, because we get to a preemption or scheduling point before
the driver module is inserted, this allows the PM domain to power
back down.

The module is then loaded, and everything works correctly.  The PM
domain debugfs file indicates that the PM domain is off.


Now, if I boot in DT mode, the game changes.  In this case, the
PM domains are created as above, but without the platform device
notifier - we rely on the generic code to attach the PM domain to
the device a driver probe time.

What this means is that when the pm_genpd_poweroff_unused() work
executes, it finds that the domain is already powered down.

The module is then loaded as in the legacy case, and at this point,
the PM domain is attached to the device just before the driver is
probed.  This causes the device to be powered on at this point.
However, the runtime PM state remains as its initialisation default
- suspended.

Time passes, and the PM domain debug file continues to indicate that
the runtime PM state of the device is suspended, but the PM domain
state is "on".


So, if I boot in legacy mode, things work fine, but only because of
the fluke that the pm_genpd_poweroff_unused() happens to be executed
before the device is probed, undoing the powering up of the domain
at attachment time.  If I boot in DT mode, the order changes, and I'm
left with the PM domain and RPM in an inconsistent state.

Right now, there is _no_ way for a device driver to know whether the
PM domain attached to its device is powered up or not.  As runtime PM
needs to know (from the device driver) the initial state of the device,
the device driver can not determine whether it is powered up or not.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
