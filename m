From: Peter Chen <hzpeterchen@gmail.com>
Subject: Re: [PATCH v16 2/7] power: add power sequence library
Date: Fri, 7 Jul 2017 16:01:07 +0800
Message-ID: <20170707080107.GC21909@b29397-desktop>
References: <1498027328-25078-1-git-send-email-peter.chen@nxp.com>
 <1868803.ffQpiaMTN5@aspire.rjw.lan>
 <20170705115400.GA17226@b29397-desktop>
 <2629938.X3D3UTyHBr@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-co1nam03on0079.outbound.protection.outlook.com ([104.47.40.79]:51072
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751001AbdGGIBo (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 7 Jul 2017 04:01:44 -0400
Content-Disposition: inline
In-Reply-To: <2629938.X3D3UTyHBr@aspire.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Peter Chen <peter.chen@nxp.com>, mark.rutland@arm.com, ulf.hansson@linaro.org, heiko@sntech.de, stephen.boyd@linaro.org, frank.li@nxp.com, linux-kernel@vger.kernel.org, gary.bisson@boundarydevices.com, festevam@gmail.com, stillcompiling@gmail.com, arnd@arndb.de, dbaryshkov@gmail.com, vaibhav.hiremath@linaro.org, krzk@kernel.org, mka@chromium.org, stern@rowland.harvard.edu, devicetree@vger.kernel.org, mail@maciej.szmigiero.name, pawel.moll@arm.com, linux-pm@vger.kernel.org, s.hauer@pengutronix.de, troy.kisky@boundarydevices.com, robh+dt@kernel.org, linux-arm-kernel@lists.infradead.org, hverkuil@xs4all.nl, oscar@naiandei.net, gregkh@linuxfoundation.org, linux-usb@vger.kernel.org, sre@kernel.org, broonie@kernel.org, p.zabel@pe

On Fri, Jul 07, 2017 at 03:13:48AM +0200, Rafael J. Wysocki wrote:
> > 
> > - Can I write new code for it or I need to depend on something?
> 
> There is nothing this code needs to depend on AFAICS, but there are existing
> solutions in this problem space (ACPI power management, genpd), so it needs to
> be careful enough about possible overlaps etc.
> 
> > I find there is already "power state" concept at documentation.
> > Documentation/ABI/testing/sysfs-devices-power_state
> 
> This is ACPI-specific and only in sysfs directories representing ACPI device
> objects (which aren't physical devices).
> 
> Anyway, since ACPI covers the problem space you are working in already,
> your code has to be mutually exclusive with it.
> 
> > - If I can write the new code for it, except the problems I want
> > to fix, are there any other use cases I need to consider?
> 
> I would start simple and focus on the particular problem at hand, that is
> devices with two power states ("on" and "off") where the "on" state
> depends on a number of clocks and/or GPIOs.  Still, I'd also avoid making
> design choices that might prevent it from being extended in the future
> if need be.
> 
> One major problem I can see is how to "attach" the power states framework
> to a particular device (once we have discovered that it should be used with
> that device).
> 
> For bus types that don't do power management of their own you could follow
> ACPI (and genpd) and provide a PM domain for this purpose, but bus types
> doing their own PM (like USB) will probably need to be treated differently.
> In those cases the bus type code will have to know that it should call some
> helpers to switch power states of devices.
> 

After thinking more, using a power state framework is seems too heavy
for this use case. This use case is just do some clock and gpio
operations before device is created, and do some put operations
after device is deleted. We just need some helpers in one structure
(called "power sequence" or "power state") for this purpose.

For the use case, the clock and gpio operation can be done after device
is created, the power domain is more suitable.

> > > 
> > > Moreover, it assumes that all of the platforms including the IP block driven
> > > by the controller driver in question will use the "power sequences" model,
> > > but what if there are more generally defined power domains on them?
> > 
> > No, the IP block doesn't need this "power sequence", the power stuffs
> > (clock, gpio, regulator) are described at firmware (eg, DT), and power
> > operations are carried out during the probe, the device and driver match
> > happens before power operation.
> > 
> > But for devices on the bus (bus is controlled by controller), the match
> > information (eg, product id/vendor id) is stored at device's firmware, the
> > controller device needs to talk with its child first to get the match
> > information before the child device's probe.
> 
> Actually, that may vary from bus to bus.  In some cases the enumeration is
> entirely firmware-based and in some cases devices are discoverable.
> 
> I guess you mean the latter situation and you are saying that subordinate
> devices may need to be turned "on" (by means of a "power sequence") in order
> to be enumerated.
> 
> Fair enough, but this is not what I meant.
> 
> The concern was that if drivers started to use "power sequences", they would
> become incompatible with alternative solutions in the same problem space,
> like genpd, but that need not be the case, so never mind.

"power sequence" is just used before the device is created and after the
device is deleted from the bus. I don't want to overlap with power
domain.

> 
> > > 
> > > It looks like the power management should really be carried out by an
> > > additional layer of code to avoid imposing platform dependencies on
> > > controller drivers.
> > > 
> > > Further, what if there are "power sequences" for the host controllers
> > > themselves?  Who's expected to operate those "power sequences" then?
> > 
> > See above.
> 
> Let me rephrase.  Assume that your host controller is a platform device and
> it is not "on" when the SoC comes up.  It has to be turned "on" via a "power
> sequence".  Who's expected to do that for it?
> 

We can use power domain for it, doesn't need "power sequence" in this
series introduces.

-- 

Best Regards,
Peter Chen
