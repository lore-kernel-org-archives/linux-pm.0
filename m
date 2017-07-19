From: "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>
Subject: Re: [PATCH v16 2/7] power: add power sequence library
Date: Wed, 19 Jul 2017 13:34:11 +0200
Message-ID: <4318803.QsccSH3mIv@aspire.rjw.lan>
References: <1498027328-25078-1-git-send-email-peter.chen@nxp.com> <CAJZ5v0hGbJuqqY6Pq5cYPrawSGW-zdhYHj0ovhJ9zXRAkBPCRQ@mail.gmail.com> <20170719025559.GC26218@b29397-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170719025559.GC26218@b29397-desktop>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Peter Chen <hzpeterchen-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: "Rafael J. Wysocki" <rafael-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Peter Chen <peter.chen-3arQi8VN3Tc@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, Stephen Boyd <stephen.boyd-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, frank.li-3arQi8VN3Tc@public.gmane.org, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Gary Bisson <gary.bisson-Q5RJGjKts06CY9SHAMCTRUEOCMrvLtNR@public.gmane.org>, Fabio Estevam <festevam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Joshua Clayton <stillcompiling-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Dmitry Eremin-Solenikov <dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Vaibhav Hiremath <vaibhav.hiremath-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Krzysztof Kozlowski <krzk-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, mka-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, mail-APzI5cXaD1zVlRWJc41N0YvC60bnQu0Y@public.gmane.org, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

On Wednesday, July 19, 2017 10:56:00 AM Peter Chen wrote:
> On Tue, Jul 18, 2017 at 07:06:05PM +0200, Rafael J. Wysocki wrote:
> > On Tue, Jul 18, 2017 at 6:29 AM, Peter Chen <hzpeterchen-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> > > On Mon, Jul 17, 2017 at 03:39:07PM +0200, Rafael J. Wysocki wrote:
> > >> > Sorry, I should describe more.
> > >> >
> > >> > Let's take USB bus as an example, when the new USB device is at the
> > >> > host port, the device structure at device model is not created until
> > >> > it is discoverable by the USB bus. If this new USB device needs to be
> > >> > powered on before can be discoverable by the bus, the device structure
> > >> > will be not created without powering on operation. The code usb_alloc_dev
> > >> > (drivers/usb/core/usb.c) is only called for discoverable device.
> > >> >
> > >> > Unlike the other bus, eg, platform bus, it creates device structure
> > >> > according to DT node. The USB bus was designed for hot plug model, the
> > >> > device structure is for discoverable device. In recent years, we begin
> > >> > to have some hard-wired USB device, Eg, onboard USB-hub, onboard USB 4G
> > >> > Modem, etc at the market. It needs some board level power operation before
> > >> > it can be found by the USB bus. This patch set is designed primarily for
> > >> > fix this kind of problem. You will see at at pwrseq_generic.c, we use DT
> > >> > version clock API of_clk_get and DT version gpio API of_get_named_gpio_flags
> > >> > instead of device structure version, like devm_clk_get and
> > >> > devm_gpiod_get_optional.
> > >> >
> > >> > MMC system has similar use case, it creates power sequence platform
> > >> > device for this issue, but all those power stuffs (clock, gpio, etc)
> > >> > may not be suitable as a dedicated virtual device at DT, they are belonged
> > >> > to one physical device, so this patch set is created to see if this issue
> > >> > can be fixed better.
> > >>
> > >> OK, thanks for the explanation.
> > >>
> > >> The above needs to be part of your problem statement.
> > >
> > > Ok, I will add it to cover letter.
> > >
> > >> >
> > >> > The bus will power up all device nodes in this bus according to DT
> > >> > information, the device structure has not created at this time.
> > >>
> > >> OK
> > >>
> > >> I still think that the information on power resources depended on by devices
> > >> should be used for power management as well as for the initial power-up.
> > >>
> > >> The most straightforward way to arrange for that would be to make it possible
> > >> to find the DT node matching the device after the device has been discovered
> > >> and struct device created for it, say by USB.  That would require adding some
> > >> more information on the device to the DT node, probably.
> > >
> > > After the device is created, the device node structure is under struct
> > > device, say dev->of_node. The most difficulty for this issue is the
> > > device creation is dynamic and is after the physical device is
> > > discovered by the bus, the initial power-up is needed before the device
> > > can be discovered by the bus.
> > 
> > So you power up all devices on the bus using the information from
> > of_nodes upfront.
> > 
> 
> I think your mean call pm_device_power_up(struct device *dev) for bus
> level device (eg, USB HUB for USB), yeah, I can do that. But we still
> have below problem:
> 
> Where we can put the kinds of power sequence implementation
> (eg, pwrseq_generic.c) and the match mechanism between device
> node and kinds of power sequence(eg, of_pwrseq_on at core.c)? These
> stuffs can be shared among subsystems, and is better to use
> one framework for it. MMC subsystem adds such things at its core
> folder (drivers/mmc/core/pwrseq*) currently.

The power sequence handling code can be generic IMO, because it doesn't
depend on what bus the devices are on.  It just needs to provide some
services to its users, but you need a clean interface between it and its
users, of course.

There basically are two categories of devices, let's refer to them as USB-type
and MMC-type.  The difference between them, as far as power sequences go,
boils down to initialization and discovery.

For the USB-type ones you need an upfront power-up pass over of_nodes
under the bus controller.  That needs to be initiated by the controller driver,
but may be carried out by the common code.

After that, you need to match of_nodes to devices while discovering them.
That also needs to be initiated by the bus controller, but there may be
a helper function in the common code for that.  It may take a struct device
for the just discovered device and the bus controller's of_node as arguments,
look for an of_node under the bus controller matching the device and then
attach the power sequence information to the struct device as appropriate.

After the power sequence information has been attached to the struct
device, it can just be used for controlling its power state in a generic
fashion.

In the MMC-type devices case the discovery if through of_node lookup IIUC,
so then you may power up things as you discover them and attach the
power sequence information to their struct device objects right away.

Again, once you have done that, the power sequence information is
there and it can be used for controlling the power states of devices
generically.

Thanks,
Rafael

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
