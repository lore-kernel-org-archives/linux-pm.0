From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v16 2/7] power: add power sequence library
Date: Mon, 17 Jul 2017 15:39:07 +0200
Message-ID: <2659617.dvNVihq86F@aspire.rjw.lan>
References: <1498027328-25078-1-git-send-email-peter.chen@nxp.com> <10723509.cz5GGA4OTz@aspire.rjw.lan> <20170710022815.GA8720@b29397-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:47675 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751335AbdGQNq4 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 17 Jul 2017 09:46:56 -0400
In-Reply-To: <20170710022815.GA8720@b29397-desktop>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Peter Chen <hzpeterchen@gmail.com>
Cc: Peter Chen <peter.chen@nxp.com>, mark.rutland@arm.com, ulf.hansson@linaro.org, heiko@sntech.de, stephen.boyd@linaro.org, frank.li@nxp.com, linux-kernel@vger.kernel.org, gary.bisson@boundarydevices.com, festevam@gmail.com, stillcompiling@gmail.com, arnd@arndb.de, dbaryshkov@gmail.com, vaibhav.hiremath@linaro.org, krzk@kernel.org, mka@chromium.org, stern@rowland.harvard.edu, devicetree@vger.kernel.org, mail@maciej.szmigiero.name, pawel.moll@arm.com, linux-pm@vger.kernel.org, s.hauer@pengutronix.de, troy.kisky@boundarydevices.com, robh+dt@kernel.org, linux-arm-kernel@lists.infradead.org, hverkuil@xs4all.nl, oscar@naiandei.net, gregkh@linuxfoundation.org, linux-usb@vger.kernel.org, sre@kernel.org, broonie@kernel.org, p.zabel@pengutronix.de, shawnguo@kernel.org, jun.li@nxp.com

On Monday, July 10, 2017 10:28:15 AM Peter Chen wrote:
> On Sat, Jul 08, 2017 at 02:14:56PM +0200, Rafael J. Wysocki wrote:
> > On Saturday, July 08, 2017 01:51:15 PM Peter Chen wrote:
> > > On Fri, Jul 07, 2017 at 03:03:06PM +0200, Rafael J. Wysocki wrote:
> > > > On Friday, July 07, 2017 04:01:07 PM Peter Chen wrote:
> > > > > On Fri, Jul 07, 2017 at 03:13:48AM +0200, Rafael J. Wysocki wrote:
> > > > > > > 
> > > > > > > - Can I write new code for it or I need to depend on something?
> > > > > > 
> > > > > > There is nothing this code needs to depend on AFAICS, but there are existing
> > > > > > solutions in this problem space (ACPI power management, genpd), so it needs to
> > > > > > be careful enough about possible overlaps etc.
> > > > > > 
> > > > > > > I find there is already "power state" concept at documentation.
> > > > > > > Documentation/ABI/testing/sysfs-devices-power_state
> > > > > > 
> > > > > > This is ACPI-specific and only in sysfs directories representing ACPI device
> > > > > > objects (which aren't physical devices).
> > > > > > 
> > > > > > Anyway, since ACPI covers the problem space you are working in already,
> > > > > > your code has to be mutually exclusive with it.
> > > > > > 
> > > > > > > - If I can write the new code for it, except the problems I want
> > > > > > > to fix, are there any other use cases I need to consider?
> > > > > > 
> > > > > > I would start simple and focus on the particular problem at hand, that is
> > > > > > devices with two power states ("on" and "off") where the "on" state
> > > > > > depends on a number of clocks and/or GPIOs.  Still, I'd also avoid making
> > > > > > design choices that might prevent it from being extended in the future
> > > > > > if need be.
> > > > > > 
> > > > > > One major problem I can see is how to "attach" the power states framework
> > > > > > to a particular device (once we have discovered that it should be used with
> > > > > > that device).
> > > > > > 
> > > > > > For bus types that don't do power management of their own you could follow
> > > > > > ACPI (and genpd) and provide a PM domain for this purpose, but bus types
> > > > > > doing their own PM (like USB) will probably need to be treated differently.
> > > > > > In those cases the bus type code will have to know that it should call some
> > > > > > helpers to switch power states of devices.
> > > > > > 
> > > > > 
> > > > > After thinking more, using a power state framework is seems too heavy
> > > > > for this use case. This use case is just do some clock and gpio
> > > > > operations before device is created, and do some put operations
> > > > > after device is deleted. We just need some helpers in one structure
> > > > > (called "power sequence" or "power state") for this purpose.
> > > > > 
> > > > > For the use case, the clock and gpio operation can be done after device
> > > > > is created, the power domain is more suitable.
> > > > 
> > > > There is a problem with PM domains that they only provide hooks for runtime PM
> > > > and system suspend/resume (including hibernation) and not for generic
> > > > "power up" and "power down" operations that may need to be carried out at
> > > > probe time before the runtime PM framework can be used (and analogously
> > > > at remove time).
> > > > 
> > > > I would consider starting with the patch below or similar.
> > > > 
> > > > Then you can define something like POWER_STATE_SEQUENCE type for your
> > > > case and basically use almost what you have already with it, except that
> > > > struct pwrsec_generic will now become struct power_state_sequence and
> > > > struct power_state_info will be embedded in it instead of struct pwrsec.
> > > > 
> > > > The major comceptual difference is that ->power_up and ->power_down are
> > > > now available at the level of the device that needs the power sequence and
> > > > pm_device_power_up/down() can be used wherever necessary (in the code,
> > > > in a bus type, in a controller driver or even in the driver for this particular
> > > > device).
> > > 
> > > Rafeal, thanks for your patch.
> > > 
> > > The biggest problem for my use case is the device is still not created.
> > > How can I call pm_device_power_up(dev)?
> > 
> > Can you please elaborate on that a bit?
> > 
> 
> Sorry, I should describe more.
> 
> Let's take USB bus as an example, when the new USB device is at the
> host port, the device structure at device model is not created until
> it is discoverable by the USB bus. If this new USB device needs to be
> powered on before can be discoverable by the bus, the device structure
> will be not created without powering on operation. The code usb_alloc_dev
> (drivers/usb/core/usb.c) is only called for discoverable device.
> 
> Unlike the other bus, eg, platform bus, it creates device structure
> according to DT node. The USB bus was designed for hot plug model, the
> device structure is for discoverable device. In recent years, we begin
> to have some hard-wired USB device, Eg, onboard USB-hub, onboard USB 4G
> Modem, etc at the market. It needs some board level power operation before
> it can be found by the USB bus. This patch set is designed primarily for
> fix this kind of problem. You will see at at pwrseq_generic.c, we use DT
> version clock API of_clk_get and DT version gpio API of_get_named_gpio_flags
> instead of device structure version, like devm_clk_get and
> devm_gpiod_get_optional.
> 
> MMC system has similar use case, it creates power sequence platform
> device for this issue, but all those power stuffs (clock, gpio, etc)
> may not be suitable as a dedicated virtual device at DT, they are belonged
> to one physical device, so this patch set is created to see if this issue
> can be fixed better.

OK, thanks for the explanation.

The above needs to be part of your problem statement.

> > You surely need a device object before probing the device and why would the
> > device be accessed before that point?
> 
> See above.
> 
> > 
> > I guess you have a bus with devices that are discoverable in principle, but
> > they cannot be discovered before being powered up,
>        
> Yes.

I was missing that point before, sorry about that.

I can only say that this wasn't particularly clear from you patch changelogs etc.

> > so you need the information
> > on which devices to power up in a DT, right?
> > 
> 
> The bus will power up all device nodes in this bus according to DT
> information, the device structure has not created at this time.

OK

I still think that the information on power resources depended on by devices
should be used for power management as well as for the initial power-up.

The most straightforward way to arrange for that would be to make it possible
to find the DT node matching the device after the device has been discovered
and struct device created for it, say by USB.  That would require adding some
more information on the device to the DT node, probably.

Then, the DT device nodes would be used for the initial power-up and next, after
discovering a device, you'd do a lookup in the DT, find the node matching it
and read the power resuources information from there to populate the device's
power state structure.  From that point on you can simply use the interface I
suggested.

Thanks,
Rafael
