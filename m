From: Darren Hart <dvhart@infradead.org>
Subject: Re: [PATCH v4 4/4] platform/x86: Add Intel Cherry Trail ACPI INT33FE
 device driver
Date: Tue, 4 Apr 2017 08:57:13 -0700
Message-ID: <20170404155713.GC5936@fury>
References: <20170403110914.30323-1-hdegoede@redhat.com>
 <20170403110914.30323-4-hdegoede@redhat.com>
 <20170403224147.GB17322@fury>
 <50ceaabf-c6dd-1b6d-b56f-d3d271836693@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <50ceaabf-c6dd-1b6d-b56f-d3d271836693@redhat.com>
Sender: linux-i2c-owner@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Andy Shevchenko <andy@infradead.org>, Wolfram Sang <wsa@the-dreams.de>, Mika Westerberg <mika.westerberg@linux.intel.com>, Sebastian Reichel <sre@kernel.org>, platform-driver-x86@vger.kernel.org, Takashi Iwai <tiwai@suse.de>, linux-i2c@vger.kernel.org, linux-pm@vger.kernel.org, Rafael Wysocki <rafael.j.wysocki@intel.com>
List-Id: linux-pm@vger.kernel.org

On Tue, Apr 04, 2017 at 11:39:16AM +0200, Hans de Goede wrote:
> Hi,
> 
> On 04-04-17 00:41, Darren Hart wrote:
> > On Mon, Apr 03, 2017 at 01:09:14PM +0200, Hans de Goede wrote:
> > > The INT33FE ACPI device has a CRS table with I2cSerialBusV2 resources for
> > > 3 devices: Maxim MAX17047 Fuel Gauge Controller, FUSB300C USB Type-C
> > > Controller and PI3USB30532 USB switch.
> > 
> > +Rafael
> > 
> > > 
> > > This commit adds a driver for this ACPI device which instantiates
> > > i2c-clients for these, so that the standard i2c drivers for these chips
> > > can bind to the them.
> > 
> > Out of curiosity, has Intel provided any documentation for this HID?
> 
> Nope, it took me a while to figure it out, in the end the info was in the
> DSDT, Cherry Trail DSDTs have this weirdness where they not only use
> _OSI, but also have a BIOS setting which OS you plan to boot which sets
> a variable called OSID, this INT33FE device is only present when the OSID
> is set to Windows, when the BIOS is set to run Android the OS instead
> gets one ACPI node per device which is how I found out what exactly was
> at the 3 different i2c addresses.

#facepalm

This is all too common unfortunately. Firmware really needs to describe the
platform independently from the OS. Dell has presented some compelling arguments
for why this isn't always feasible, but all too often there is no good reason
for it. Unfortunately, nothing we can do about it for shipping devices other
than work around the mess.

For the Intel folks on Cc, I'd suggest raising this with Mark as well to get his
help in stamping out as much of this as we can going forward.

> 
> > If not, Mika, Andy, this would be a good opportunity to push on the "Default to
> > open" policy for ACPI device specs. I'd suggest raising with Mark Doran as he's
> > been helping us with that in the past. This is independent of this patch, just
> > something that will require constant tending and nagging to affect change there.
> > 
> > A few comments/questions below...
> > 
> > > 
> > > Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> > > ---
> > > Changes in v4:
> > > -This is a new patch in v4 of this patch-set replacing the
> > >  cht_wc_fuel_gauge driver which was binding to the INT33FE device before
> > >  I figured out this is some sort of meta device describing 3 devices
> > >  and that the fuel-guage really is just a Maxim MAX17047. The
> > >  cht_wc_fuel_gauge driver will be replaced by a max17047 driver which I
> > >  will submit seperately
> > > ---
> > >  drivers/platform/x86/Kconfig             |  13 +++
> > >  drivers/platform/x86/Makefile            |   1 +
> > >  drivers/platform/x86/intel_cht_int33fe.c | 144 +++++++++++++++++++++++++++++++
> > >  3 files changed, 158 insertions(+)
> > >  create mode 100644 drivers/platform/x86/intel_cht_int33fe.c
> > > 
> > > diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
> > > index 6a5b79c..57f7c1d 100644
> > > --- a/drivers/platform/x86/Kconfig
> > > +++ b/drivers/platform/x86/Kconfig
> > > @@ -772,6 +772,19 @@ config ACPI_CMPC
> > >  	  keys as input device, backlight device, tablet and accelerometer
> > >  	  devices.
> > > 
> > > +config INTEL_CHT_INT33FE
> > > +	tristate "Intel Cherry Trail ACPI INT33FE Driver"
> > > +	depends on X86 && ACPI
> > > +	---help---
> > > +	  This driver add support for the INT33FE ACPI device found on
> > > +	  some Intel Cherry Trail devices.
> > > +
> > > +	  The INT33FE ACPI device has a CRS table with I2cSerialBusV2
> > > +	  resources for 3 devices: Maxim MAX17047 Fuel Gauge Controller,
> > > +	  FUSB300C USB Type-C Controller and PI3USB30532 USB switch.
> > > +	  This driver instantiates i2c-clients for these, so that standard
> > > +	  i2c drivers for these chips can bind to the them.
> > > +
> > >  config INTEL_HID_EVENT
> > >  	tristate "INTEL HID Event"
> > >  	depends on ACPI
> > > diff --git a/drivers/platform/x86/Makefile b/drivers/platform/x86/Makefile
> > > index 6d4b01a..6731893 100644
> > > --- a/drivers/platform/x86/Makefile
> > > +++ b/drivers/platform/x86/Makefile
> > > @@ -44,6 +44,7 @@ obj-$(CONFIG_ACPI_TOSHIBA)	+= toshiba_acpi.o
> > >  obj-$(CONFIG_TOSHIBA_BT_RFKILL)	+= toshiba_bluetooth.o
> > >  obj-$(CONFIG_TOSHIBA_HAPS)	+= toshiba_haps.o
> > >  obj-$(CONFIG_TOSHIBA_WMI)	+= toshiba-wmi.o
> > > +obj-$(CONFIG_INTEL_CHT_INT33FE)	+= intel_cht_int33fe.o
> > >  obj-$(CONFIG_INTEL_HID_EVENT)	+= intel-hid.o
> > >  obj-$(CONFIG_INTEL_VBTN)	+= intel-vbtn.o
> > >  obj-$(CONFIG_INTEL_SCU_IPC)	+= intel_scu_ipc.o
> > > diff --git a/drivers/platform/x86/intel_cht_int33fe.c b/drivers/platform/x86/intel_cht_int33fe.c
> > > new file mode 100644
> > > index 0000000..3a06426
> > > --- /dev/null
> > > +++ b/drivers/platform/x86/intel_cht_int33fe.c
> > > @@ -0,0 +1,144 @@
> > > +/*
> > > + * Intel Cherry Trail ACPI INT33FE pseudo device driver
> > > + *
> > > + * Copyright (C) 2017 Hans de Goede <hdegoede@redhat.com>
> > > + *
> > > + * This program is free software; you can redistribute it and/or modify
> > > + * it under the terms of the GNU General Public License version 2 as
> > > + * published by the Free Software Foundation.
> > > + *
> > > + * Some Intel Cherry Trail based device which ship with Windows 10, have
> > > + * this weird INT33FE ACPI device with a CRS table with 4 I2cSerialBusV2
> > > + * resources, for 4 different chips attached to various i2c busses:
> > > + * 1. The Whiskey Cove pmic, which is also described by the INT34D3 ACPI device
> > > + * 2. Maxim MAX17047 Fuel Gauge Controller
> > > + * 3. FUSB300C USB Type-C Controller
> > > + * 4. PI3USB30532 USB switch
> > > + *
> > > + * So this driver is a stub / pseudo driver whose only purpose is to
> > > + * instantiate i2c-clients for chips 2 - 4, so that standard i2c drivers
> > > + * for these chips can bind to the them.
> > 
> > What about 1. Whiskey Cove PMIC? Are we ignoring that resource in lieu of the
> > INT34D3 HID?
> 
> Yes.
> 
> > Do they both provide the same resources?
> 
> No, the INT34D3 ACPI resource actually provides proper interrupt
> info for the PMIC, which the INT33FE device does not. Actually
> 2 of the 3 gpio-interrupt resources in the INT33FE device's
> CRS table point to gpio-s on the PMIC. I really don't have
> a clue why the duplicate Whiskey Cove PMIC I2cSerialBus
> resource is there.
> 
> 
> 
> 
> > 
> > > + */
> > > +
> > > +#include <linux/acpi.h>
> > > +#include <linux/i2c.h>
> > > +#include <linux/interrupt.h>
> > > +#include <linux/module.h>
> > > +#include <linux/power/acpi.h>
> 
> As the kbuild-test bot pointed out, this line needs to be removed,
> it is a left-over from previous attempts at getting the fuel-gauge
> going.
> 
> > > +#include <linux/slab.h>
> > > +
> > > +#define EXPECTED_PTYPE		4
> > > +
> > > +struct cht_int33fe_data {
> > > +	struct i2c_client *max17047;
> > > +	struct i2c_client *fusb300c;
> > > +	struct i2c_client *pi3usb30532;
> > > +};
> > > +
> > > +static int cht_int33fe_probe(struct i2c_client *client)
> > > +{
> > > +	struct device *dev = &client->dev;
> > > +	struct i2c_board_info board_info;
> > > +	struct cht_int33fe_data *data;
> > > +	acpi_status status;
> > > +	unsigned long long ptyp;
> > 
> > Minor nit, prefered ordering is longest to shortest, "Reverse Christmas Tree
> > Order", just move ptyp up a line.
> 
> Ok, can do :)
> 
> > > +	int fusb300c_irq;
> > > +
> > > +	status = acpi_evaluate_integer(ACPI_HANDLE(dev), "PTYP", NULL, &ptyp);
> > > +	if (ACPI_FAILURE(status)) {
> > > +		dev_err(dev, "Error getting PTYPE\n");
> > > +		return -ENODEV;
> > > +	}
> > > +
> > > +	/*
> > > +	 * The same ACPI HID is used for different configurations check PTYP
> > > +	 * to ensure that we are dealing with the expected config.
> > > +	 */
> > > +	if (ptyp != EXPECTED_PTYPE)
> > > +		return -ENODEV;
> > > +
> > 
> > Are any of the other configurations known and relevant?
> 
> Known no, relevant maybe ?
> 

Based on the above, I understand the situation a bit better now. You can't know
without the documentation. This serves as a canary, if it changes, then one of
our assumptions is likely wrong and all bets are off.

> > > +	/* The FUSB300C uses the irq at index 1 and is the only irq user */
> > > +	fusb300c_irq = acpi_dev_gpio_irq_get(ACPI_COMPANION(dev), 1);
> > > +	if (fusb300c_irq < 0) {
> > > +		if (fusb300c_irq != -EPROBE_DEFER)
> > > +			dev_err(dev, "Error getting FUSB300C irq\n");
> > > +		return fusb300c_irq;
> > > +	}
> > 
> > Since this driver is a dependency for 3 devices, is it correct to abort here if
> > 1 of the 3 fails? I could see it making sense to issue the warning, but continue
> > on so the other two devices could be setup. On the other hand, if PTYP 4 means
> > the USB irq should be defined, then perhaps if that fails we don't trust any of
> > it and just bail out. What was your rationale for the chosen approach?
> 
> Well we certainly need to handle -EPROBE_DEFER here for proper
> ordering and if the ACPI resource points to a non existing / non
> supported gpio-controller then we will end up with -EPROBE_DEFER too,
> so changing this will not help with that case. As for other errors
> those should really never happen, so I did not give that much
> thought.
> 
> As for the other -EPROBE_DEFER returns, at least on my test system
> (a GPDwin) all 3 devices are on the same i2c-bus, so once one succeed
> they will all 3 succeed, but I guess this might be different on
> other boards.
> 
> Note that the bus all 3 devices are on is different from the bus
> used for the PMIC, which is the bus used to instantiate the i2c-client
> for the duplicate PMIC I2cSerialBus entry which leads to our probe
> being called, so the bus for the 3 devices may not have been
> probed yet.
> 

Right, OK. Too many possibilities to try and account for. Support the known set
and adjust if new owns appear in the wild, or if we get a specification from
Intel.

I'll look for a v2 based on the two minor points above.

Thanks,

-- 
Darren Hart
VMware Open Source Technology Center
