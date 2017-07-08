From: "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>
Subject: Re: [PATCH v16 2/7] power: add power sequence library
Date: Sat, 08 Jul 2017 14:14:56 +0200
Message-ID: <10723509.cz5GGA4OTz@aspire.rjw.lan>
References: <1498027328-25078-1-git-send-email-peter.chen@nxp.com> <2042394.b4eZkzrJ5f@aspire.rjw.lan> <20170708055115.GA25873@b29397-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170708055115.GA25873@b29397-desktop>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Peter Chen <hzpeterchen-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Peter Chen <peter.chen-3arQi8VN3Tc@public.gmane.org>, mark.rutland-5wv7dgnIgG8@public.gmane.org, ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org, stephen.boyd-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, frank.li-3arQi8VN3Tc@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, gary.bisson-Q5RJGjKts06CY9SHAMCTRUEOCMrvLtNR@public.gmane.org, festevam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, stillcompiling-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, vaibhav.hiremath-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, krzk-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mka-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, mail-APzI5cXaD1zVlRWJc41N0YvC60bnQu0Y@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, troy.kisky-Q5RJGjKts06CY9SHAMCTRUEOCMrvLtNR@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, hverkuil-qWit8jRvyhVmR6Xm/wNWPw@public.gmane.org, oscar-Bdbr4918Nnnk1uMJSBkQmQ@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, p.zabel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, shawnguo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, jun.li-3arQi8VN3Tc@public.gmane.org
List-Id: linux-pm@vger.kernel.org

On Saturday, July 08, 2017 01:51:15 PM Peter Chen wrote:
> On Fri, Jul 07, 2017 at 03:03:06PM +0200, Rafael J. Wysocki wrote:
> > On Friday, July 07, 2017 04:01:07 PM Peter Chen wrote:
> > > On Fri, Jul 07, 2017 at 03:13:48AM +0200, Rafael J. Wysocki wrote:
> > > > > 
> > > > > - Can I write new code for it or I need to depend on something?
> > > > 
> > > > There is nothing this code needs to depend on AFAICS, but there are existing
> > > > solutions in this problem space (ACPI power management, genpd), so it needs to
> > > > be careful enough about possible overlaps etc.
> > > > 
> > > > > I find there is already "power state" concept at documentation.
> > > > > Documentation/ABI/testing/sysfs-devices-power_state
> > > > 
> > > > This is ACPI-specific and only in sysfs directories representing ACPI device
> > > > objects (which aren't physical devices).
> > > > 
> > > > Anyway, since ACPI covers the problem space you are working in already,
> > > > your code has to be mutually exclusive with it.
> > > > 
> > > > > - If I can write the new code for it, except the problems I want
> > > > > to fix, are there any other use cases I need to consider?
> > > > 
> > > > I would start simple and focus on the particular problem at hand, that is
> > > > devices with two power states ("on" and "off") where the "on" state
> > > > depends on a number of clocks and/or GPIOs.  Still, I'd also avoid making
> > > > design choices that might prevent it from being extended in the future
> > > > if need be.
> > > > 
> > > > One major problem I can see is how to "attach" the power states framework
> > > > to a particular device (once we have discovered that it should be used with
> > > > that device).
> > > > 
> > > > For bus types that don't do power management of their own you could follow
> > > > ACPI (and genpd) and provide a PM domain for this purpose, but bus types
> > > > doing their own PM (like USB) will probably need to be treated differently.
> > > > In those cases the bus type code will have to know that it should call some
> > > > helpers to switch power states of devices.
> > > > 
> > > 
> > > After thinking more, using a power state framework is seems too heavy
> > > for this use case. This use case is just do some clock and gpio
> > > operations before device is created, and do some put operations
> > > after device is deleted. We just need some helpers in one structure
> > > (called "power sequence" or "power state") for this purpose.
> > > 
> > > For the use case, the clock and gpio operation can be done after device
> > > is created, the power domain is more suitable.
> > 
> > There is a problem with PM domains that they only provide hooks for runtime PM
> > and system suspend/resume (including hibernation) and not for generic
> > "power up" and "power down" operations that may need to be carried out at
> > probe time before the runtime PM framework can be used (and analogously
> > at remove time).
> > 
> > I would consider starting with the patch below or similar.
> > 
> > Then you can define something like POWER_STATE_SEQUENCE type for your
> > case and basically use almost what you have already with it, except that
> > struct pwrsec_generic will now become struct power_state_sequence and
> > struct power_state_info will be embedded in it instead of struct pwrsec.
> > 
> > The major comceptual difference is that ->power_up and ->power_down are
> > now available at the level of the device that needs the power sequence and
> > pm_device_power_up/down() can be used wherever necessary (in the code,
> > in a bus type, in a controller driver or even in the driver for this particular
> > device).
> 
> Rafeal, thanks for your patch.
> 
> The biggest problem for my use case is the device is still not created.
> How can I call pm_device_power_up(dev)?

Can you please elaborate on that a bit?

You surely need a device object before probing the device and why would the
device be accessed before that point?

I guess you have a bus with devices that are discoverable in principle, but
they cannot be discovered before being powered up, so you need the information
on which devices to power up in a DT, right?

Thanks,
Rafael

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
