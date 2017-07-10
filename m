From: Peter Chen <hzpeterchen-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v16 2/7] power: add power sequence library
Date: Mon, 10 Jul 2017 10:28:15 +0800
Message-ID: <20170710022815.GA8720@b29397-desktop>
References: <1498027328-25078-1-git-send-email-peter.chen@nxp.com>
 <2042394.b4eZkzrJ5f@aspire.rjw.lan>
 <20170708055115.GA25873@b29397-desktop>
 <10723509.cz5GGA4OTz@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <10723509.cz5GGA4OTz-yvgW3jdyMHm1GS7QM15AGw@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>
Cc: Peter Chen <peter.chen-3arQi8VN3Tc@public.gmane.org>, mark.rutland-5wv7dgnIgG8@public.gmane.org, ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org, stephen.boyd-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, frank.li-3arQi8VN3Tc@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, gary.bisson-Q5RJGjKts06CY9SHAMCTRUEOCMrvLtNR@public.gmane.org, festevam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, stillcompiling-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, vaibhav.hiremath-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, krzk-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mka-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, mail-APzI5cXaD1zVlRWJc41N0YvC60bnQu0Y@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, troy.kisky-Q5RJGjKts06CY9SHAMCTRUEOCMrvLtNR@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, hverkuil-qWit8jRvyhVmR6Xm/wNWPw@public.gmane.org, oscar-Bdbr4918Nnnk1uMJSBkQmQ@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, p.zabel@pe
List-Id: linux-pm@vger.kernel.org

On Sat, Jul 08, 2017 at 02:14:56PM +0200, Rafael J. Wysocki wrote:
> On Saturday, July 08, 2017 01:51:15 PM Peter Chen wrote:
> > On Fri, Jul 07, 2017 at 03:03:06PM +0200, Rafael J. Wysocki wrote:
> > > On Friday, July 07, 2017 04:01:07 PM Peter Chen wrote:
> > > > On Fri, Jul 07, 2017 at 03:13:48AM +0200, Rafael J. Wysocki wrote:
> > > > > > 
> > > > > > - Can I write new code for it or I need to depend on something?
> > > > > 
> > > > > There is nothing this code needs to depend on AFAICS, but there are existing
> > > > > solutions in this problem space (ACPI power management, genpd), so it needs to
> > > > > be careful enough about possible overlaps etc.
> > > > > 
> > > > > > I find there is already "power state" concept at documentation.
> > > > > > Documentation/ABI/testing/sysfs-devices-power_state
> > > > > 
> > > > > This is ACPI-specific and only in sysfs directories representing ACPI device
> > > > > objects (which aren't physical devices).
> > > > > 
> > > > > Anyway, since ACPI covers the problem space you are working in already,
> > > > > your code has to be mutually exclusive with it.
> > > > > 
> > > > > > - If I can write the new code for it, except the problems I want
> > > > > > to fix, are there any other use cases I need to consider?
> > > > > 
> > > > > I would start simple and focus on the particular problem at hand, that is
> > > > > devices with two power states ("on" and "off") where the "on" state
> > > > > depends on a number of clocks and/or GPIOs.  Still, I'd also avoid making
> > > > > design choices that might prevent it from being extended in the future
> > > > > if need be.
> > > > > 
> > > > > One major problem I can see is how to "attach" the power states framework
> > > > > to a particular device (once we have discovered that it should be used with
> > > > > that device).
> > > > > 
> > > > > For bus types that don't do power management of their own you could follow
> > > > > ACPI (and genpd) and provide a PM domain for this purpose, but bus types
> > > > > doing their own PM (like USB) will probably need to be treated differently.
> > > > > In those cases the bus type code will have to know that it should call some
> > > > > helpers to switch power states of devices.
> > > > > 
> > > > 
> > > > After thinking more, using a power state framework is seems too heavy
> > > > for this use case. This use case is just do some clock and gpio
> > > > operations before device is created, and do some put operations
> > > > after device is deleted. We just need some helpers in one structure
> > > > (called "power sequence" or "power state") for this purpose.
> > > > 
> > > > For the use case, the clock and gpio operation can be done after device
> > > > is created, the power domain is more suitable.
> > > 
> > > There is a problem with PM domains that they only provide hooks for runtime PM
> > > and system suspend/resume (including hibernation) and not for generic
> > > "power up" and "power down" operations that may need to be carried out at
> > > probe time before the runtime PM framework can be used (and analogously
> > > at remove time).
> > > 
> > > I would consider starting with the patch below or similar.
> > > 
> > > Then you can define something like POWER_STATE_SEQUENCE type for your
> > > case and basically use almost what you have already with it, except that
> > > struct pwrsec_generic will now become struct power_state_sequence and
> > > struct power_state_info will be embedded in it instead of struct pwrsec.
> > > 
> > > The major comceptual difference is that ->power_up and ->power_down are
> > > now available at the level of the device that needs the power sequence and
> > > pm_device_power_up/down() can be used wherever necessary (in the code,
> > > in a bus type, in a controller driver or even in the driver for this particular
> > > device).
> > 
> > Rafeal, thanks for your patch.
> > 
> > The biggest problem for my use case is the device is still not created.
> > How can I call pm_device_power_up(dev)?
> 
> Can you please elaborate on that a bit?
> 

Sorry, I should describe more.

Let's take USB bus as an example, when the new USB device is at the
host port, the device structure at device model is not created until
it is discoverable by the USB bus. If this new USB device needs to be
powered on before can be discoverable by the bus, the device structure
will be not created without powering on operation. The code usb_alloc_dev
(drivers/usb/core/usb.c) is only called for discoverable device.

Unlike the other bus, eg, platform bus, it creates device structure
according to DT node. The USB bus was designed for hot plug model, the
device structure is for discoverable device. In recent years, we begin
to have some hard-wired USB device, Eg, onboard USB-hub, onboard USB 4G
Modem, etc at the market. It needs some board level power operation before
it can be found by the USB bus. This patch set is designed primarily for
fix this kind of problem. You will see at at pwrseq_generic.c, we use DT
version clock API of_clk_get and DT version gpio API of_get_named_gpio_flags
instead of device structure version, like devm_clk_get and
devm_gpiod_get_optional.

MMC system has similar use case, it creates power sequence platform
device for this issue, but all those power stuffs (clock, gpio, etc)
may not be suitable as a dedicated virtual device at DT, they are belonged
to one physical device, so this patch set is created to see if this issue
can be fixed better.

> You surely need a device object before probing the device and why would the
> device be accessed before that point?

See above.

> 
> I guess you have a bus with devices that are discoverable in principle, but
> they cannot be discovered before being powered up,
       
Yes.

> so you need the information
> on which devices to power up in a DT, right?
> 

The bus will power up all device nodes in this bus according to DT
information, the device structure has not created at this time.

-- 

Best Regards,
Peter Chen
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
