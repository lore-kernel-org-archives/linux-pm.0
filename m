From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v16 2/7] power: add power sequence library
Date: Fri, 07 Jul 2017 03:13:48 +0200
Message-ID: <2629938.X3D3UTyHBr@aspire.rjw.lan>
References: <1498027328-25078-1-git-send-email-peter.chen@nxp.com> <1868803.ffQpiaMTN5@aspire.rjw.lan> <20170705115400.GA17226@b29397-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170705115400.GA17226@b29397-desktop>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Chen <hzpeterchen@gmail.com>
Cc: Peter Chen <peter.chen@nxp.com>, mark.rutland@arm.com, ulf.hansson@linaro.org, heiko@sntech.de, stephen.boyd@linaro.org, frank.li@nxp.com, linux-kernel@vger.kernel.org, gary.bisson@boundarydevices.com, festevam@gmail.com, stillcompiling@gmail.com, arnd@arndb.de, dbaryshkov@gmail.com, vaibhav.hiremath@linaro.org, krzk@kernel.org, mka@chromium.org, stern@rowland.harvard.edu, devicetree@vger.kernel.org, mail@maciej.szmigiero.name, pawel.moll@arm.com, linux-pm@vger.kernel.org, s.hauer@pengutronix.de, troy.kisky@boundarydevices.com, robh+dt@kernel.org, linux-arm-kernel@lists.infradead.org, hverkuil@xs4all.nl, oscar@naiandei.net, gregkh@linuxfoundation.org, linux-usb@vger.kernel.org, sre@kernel.org, broonie@kernel.org, p.zabel@pengutronix.de, shawnguo@kernel.org, jun.li@nxp.com
List-Id: linux-pm@vger.kernel.org

On Wednesday, July 05, 2017 07:54:00 PM Peter Chen wrote:
> On Wed, Jul 05, 2017 at 02:44:56AM +0200, Rafael J. Wysocki wrote:
> > On Wednesday, June 21, 2017 02:42:03 PM Peter Chen wrote:
> > > We have an well-known problem that the device needs to do some power
> > > sequence before it can be recognized by related host, the typical
> > > example like hard-wired mmc devices and usb devices.
> > > 
> > > This power sequence is hard to be described at device tree and handled by
> > > related host driver, so we have created a common power sequence
> > > library to cover this requirement. The core code has supplied
> > > some common helpers for host driver, and individual power sequence
> > > libraries handle kinds of power sequence for devices. The pwrseq
> > > librares always need to allocate extra instance for compatible
> > > string match.
> > > 
> > > pwrseq_generic is intended for general purpose of power sequence, which
> > > handles gpios and clocks currently, and can cover other controls in
> > > future. The host driver just needs to call of_pwrseq_on/of_pwrseq_off
> > > if only one power sequence is needed, else call of_pwrseq_on_list
> > > /of_pwrseq_off_list instead (eg, USB hub driver).
> > > 
> > > For new power sequence library, it needs to add its compatible string
> > > and allocation function at pwrseq_match_table_list, then the pwrseq
> > > core will match it with DT's, and choose this library at runtime.
> > > 
> > > Signed-off-by: Peter Chen <peter.chen@nxp.com>
> > > Tested-by: Maciej S. Szmigiero <mail@maciej.szmigiero.name>
> > > Tested-by Joshua Clayton <stillcompiling@gmail.com>
> > > Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
> > > Tested-by: Matthias Kaehlcke <mka@chromium.org>
> > 
> > The executive summary here is that I'm not going to apply this patch (and the
> > following series depending on it), because in my opinion it is misguided and
> > I quite fundamentally disagree with the basic concept.
> > 
> > The code has problems too, but we first need to agree on the basics.
> > 
> 
> Thanks for valuable comments, let's agree on the concept and design
> first.
> 
> > > ---
> > >  Documentation/power/power-sequence/design.rst |  54 +++++
> > >  MAINTAINERS                                   |   9 +
> > >  drivers/power/Kconfig                         |   1 +
> > >  drivers/power/Makefile                        |   1 +
> > >  drivers/power/pwrseq/Kconfig                  |  20 ++
> > >  drivers/power/pwrseq/Makefile                 |   2 +
> > >  drivers/power/pwrseq/core.c                   | 293 ++++++++++++++++++++++++++
> > >  drivers/power/pwrseq/pwrseq_generic.c         | 210 ++++++++++++++++++
> > >  include/linux/power/pwrseq.h                  |  84 ++++++++
> > >  9 files changed, 674 insertions(+)
> > >  create mode 100644 Documentation/power/power-sequence/design.rst
> > >  create mode 100644 drivers/power/pwrseq/Kconfig
> > >  create mode 100644 drivers/power/pwrseq/Makefile
> > >  create mode 100644 drivers/power/pwrseq/core.c
> > >  create mode 100644 drivers/power/pwrseq/pwrseq_generic.c
> > >  create mode 100644 include/linux/power/pwrseq.h
> > > 
> > > diff --git a/Documentation/power/power-sequence/design.rst b/Documentation/power/power-sequence/design.rst
> > > new file mode 100644
> > > index 0000000..554608e
> > > --- /dev/null
> > > +++ b/Documentation/power/power-sequence/design.rst
> > > @@ -0,0 +1,54 @@
> > > +====================================
> > > +Power Sequence Library
> > > +====================================
> > > +
> > > +:Date: Feb, 2017
> > > +:Author: Peter Chen <peter.chen@nxp.com>
> > > +
> > > +
> > > +Introduction
> > > +============
> > > +
> > > +We have an well-known problem that the device needs to do a power
> > > +sequence before it can be recognized by related host, the typical
> > > +examples are hard-wired mmc devices and usb devices. The host controller
> > > +can't know what kinds of this device is in its bus if the power
> > > +sequence has not done, since the related devices driver's probe calling
> > > +is determined by runtime according to eunumeration results. Besides,
> > > +the devices may have custom power sequence, so the power sequence library
> > > +which is independent with the devices is needed.
> > 
> > In other words, devices can be in different power states and there are power
> > states in which they are not accessible to software.  In order to be accessed
> > by software, they need to be put into power states in which that is actually
> > possible.
> > 
> > That has been known for over 20 years and by no means it is limited to MMC
> > or USB.
> > 
> > Moreover, power states of devices generally depend on the platform and if
> > the same IP block is used in two different platforms (or even in two different
> > SoCs for that matter), the power states of it can be defined differently in
> > each case.
> > 
> > It also is quite well known how to define a power state of a device.  There
> > usually is a list of power resources (clocks, regulators, etc) that have to
> > be "on" for the device to be in the given power state.  In addition to that,
> > it may be necessary to carry out some operations after turning those
> > power resources "on" in order to trigger the power state change (like
> > toggling a GPIO or writing to a specific register etc).
> > 
> > Now, of course, it is not generally guaranteed that devices will be in
> > software-accessible power states initially, so it is necessary to put them
> > into those power states before trying to access them.
> > 
> > Again, this isn't anything new, but it has always been about power states.
> > 
> > By defining a "power sequence" you generally define two power states for
> > the device, say "on" and "off", and a way to switch between them, but what
> > about simply treating power states as the primary concept in the first place?
> > 
> > That would be more general, because there are platforms with more than
> > two power states per device.  In those cases, the power state choice may
> > depend on additional factors, like say during system suspend it may matter
> > whether or not the device is a wakeup one (and it may not be able to
> > generate wakeup signals from certain power states).  Using a single "power
> > sequence" would not be sufficient then.
> 
> I agree on the concept of "power state" for it,
> but I have several questions for above:
> 
> - Can I write new code for it or I need to depend on something?

There is nothing this code needs to depend on AFAICS, but there are existing
solutions in this problem space (ACPI power management, genpd), so it needs to
be careful enough about possible overlaps etc.

> I find there is already "power state" concept at documentation.
> Documentation/ABI/testing/sysfs-devices-power_state

This is ACPI-specific and only in sysfs directories representing ACPI device
objects (which aren't physical devices).

Anyway, since ACPI covers the problem space you are working in already,
your code has to be mutually exclusive with it.

> - If I can write the new code for it, except the problems I want
> to fix, are there any other use cases I need to consider?

I would start simple and focus on the particular problem at hand, that is
devices with two power states ("on" and "off") where the "on" state
depends on a number of clocks and/or GPIOs.  Still, I'd also avoid making
design choices that might prevent it from being extended in the future
if need be.

One major problem I can see is how to "attach" the power states framework
to a particular device (once we have discovered that it should be used with
that device).

For bus types that don't do power management of their own you could follow
ACPI (and genpd) and provide a PM domain for this purpose, but bus types
doing their own PM (like USB) will probably need to be treated differently.
In those cases the bus type code will have to know that it should call some
helpers to switch power states of devices.

> > 
> > > +
> > > +Design
> > > +============
> > > +
> > > +The power sequence library includes the core file and customer power
> > > +sequence library. The core file exports interfaces are called by
> > > +host controller driver for power sequence and customer power sequence
> > > +library files to register its power sequence instance to global
> > > +power sequence list. The custom power sequence library creates power
> > > +sequence instance and implement custom power sequence.
> > 
> > The above paragraph is really hard to decode.
> > 
> > There is no explanation of basic concepts at all.  What exactly do you mean by
> > "power sequence"?  What is a "power sequence instance"?  What do you mean
> > by "custom power sequence"?
> 
> "power sequence" means the sequence for power on/off device
> "power sequence instance" means when carry out power on, it
> need to allocate one "power sequence" structure, and this structure
> includes all operations during power on/off sequence.
> "custom power sequence" means different devices need different
> power on sequence, eg, one may need to open regulator before
> toggle gpio, but another may need opposite sequence.

OK, confusing. :-)

> > 
> > > +
> > > +Since the power sequence describes hardware design, the description is
> > > +located at board description file, eg, device tree dts file. And
> > > +a specific power sequence belongs to device, so its description
> > > +is under the device node, please refer to:
> > > +Documentation/devicetree/bindings/power/pwrseq/pwrseq-generic.txt
> > 
> > This, again, is really difficult to understand, especially the difference between
> > "the power sequence" and "a specific power sequence" is quite unclear.
> > 
> 
> "a specific power sequence" for one custom power sequence
> 
> > > +
> > > +Custom power sequence library allocates one power sequence instance at
> > > +bootup periods using postcore_initcall, this static allocated instance is
> > > +used to compare with device-tree (DT) node to see if this library can be
> > > +used for the node or not.
> > 
> > Same here.
> > 
> > > When the result is matched, the core API will
> > > +try to get resourses (->get, implemented at each library) for power
> > > +sequence, if all resources are got, it will try to allocate another
> > > +instance for next possible request from host driver.
> > > +
> > > +Then, the host controller driver can carry out power sequence on for this
> > > +DT node, the library will do corresponding operations, like open clocks,
> > > +toggle gpio, etc. The power sequence off routine will close and free the
> > > +resources, and is called when the parent is removed. And the power
> > > +sequence suspend and resume routine can be called at host driver's
> > > +suspend and resume routine if needed.
> > 
> > Let me try to say what I understood from this.
> > 
> > If there is a DT node with a matching "compatible" string, the initialization
> > code will try to acquire resources needed for "power sequencing" of the
> > corresponding device.  It is expected that host controller drivers will
> > then use the provided helper functions to turn the subordinate devices
> > "on" during enumeration and "off" on the (host controller) driver removal.
> > They also are expected to use the "suspend" and "resume" helpers when
> > the host controller is suspended or resumed, respectively.
> > 
> > If the above is what you intended, then it is not the right model IMO.
> > 
> > In particular, I don't see why the controller driver suspend and resume
> > should operate "power sequences" of subordinate devices directly as the
> > subordinate devices are expected to be suspended (in which case they
> > also should have been turned "off" already) when the controller is
> > suspending and the controller resume need not affect the subordinate
> > devices at all.
> 
> For example, one device's clock needs to be opened before it can be
> seen by the controller, but the device's clock isn't controlled by
> controller driver, controller driver only operate its own clocks.
> So, after the controller suspends the device, it can turn off
> device's clock for power consumption, and when the controller
> resumes, it needs to turn on the device's clock before talking
> to device.

Well, the device isn't suspended by the controller.  It is suspended
by the driver operating it.  And "suspended" basically means, it can be turned
off right away regardless of what the controller driver is doing.

Of course, it has to be turned on whenever the controller driver (or any other
piece of code for that matter) attempts to access it, but that's what the
runtime PM framework is for.

Anyway, (runtime) suspend/resume of subordinate devices is basically
independent of the controller suspend/resume except that some buses
require the controller to be "on" as long as at least one subordinate device
under it is "on" (for example, turning the controller off might cut power from
the subordinate device).

> > 
> > Moreover, it assumes that all of the platforms including the IP block driven
> > by the controller driver in question will use the "power sequences" model,
> > but what if there are more generally defined power domains on them?
> 
> No, the IP block doesn't need this "power sequence", the power stuffs
> (clock, gpio, regulator) are described at firmware (eg, DT), and power
> operations are carried out during the probe, the device and driver match
> happens before power operation.
> 
> But for devices on the bus (bus is controlled by controller), the match
> information (eg, product id/vendor id) is stored at device's firmware, the
> controller device needs to talk with its child first to get the match
> information before the child device's probe.

Actually, that may vary from bus to bus.  In some cases the enumeration is
entirely firmware-based and in some cases devices are discoverable.

I guess you mean the latter situation and you are saying that subordinate
devices may need to be turned "on" (by means of a "power sequence") in order
to be enumerated.

Fair enough, but this is not what I meant.

The concern was that if drivers started to use "power sequences", they would
become incompatible with alternative solutions in the same problem space,
like genpd, but that need not be the case, so never mind.

> > 
> > It looks like the power management should really be carried out by an
> > additional layer of code to avoid imposing platform dependencies on
> > controller drivers.
> > 
> > Further, what if there are "power sequences" for the host controllers
> > themselves?  Who's expected to operate those "power sequences" then?
> 
> See above.

Let me rephrase.  Assume that your host controller is a platform device and
it is not "on" when the SoC comes up.  It has to be turned "on" via a "power
sequence".  Who's expected to do that for it?

Thanks,
Rafael
