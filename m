From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v5 0/8] mfd: introduce a driver for LPSS devices on SPT
Date: Fri, 24 Jul 2015 16:16:13 +0100
Message-ID: <20150724151613.GK3436@x1>
References: <1436185334-34275-1-git-send-email-andriy.shevchenko@linux.intel.com>
 <1437651621.29746.24.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1437651621.29746.24.camel@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Vinod Koul <vinod.koul@intel.com>, Andrew Morton <akpm@linux-foundation.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, Heikki Krogerus <heikki.krogerus@linux.intel.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, mturquette@baylibre.com, Stephen Boyd <sboyd@codeaurora.org>
List-Id: linux-pm@vger.kernel.org

On Thu, 23 Jul 2015, Andy Shevchenko wrote:

> On Mon, 2015-07-06 at 15:22 +0300, Andy Shevchenko wrote:
> > The new coming Intel platforms such as Skylake will contain=20
> > Sunrisepoint PCH.
> >=20
> > The driver is based on MFD framework since the main device, i.e.=20
> > serial bus
> > controller, contains register space for itself, DMA part, and an=20
> > additional
> > address space (convergence layer).=20
> >=20
> > The public specification of the register map is avaiable in [1].
> >=20
> > This is fifth generation of the patch series to bring support LPSS=20
> > devices
> > found on Intel Sunrisepoint (Intel Skylake PCH). Previous one can b=
e=20
> > found here
> > [2].
> >=20
> > The series has few logical parts:
> > - patches 1-3 prepares PM core, ACPI, and driver core (PM) to handl=
e=20
> > our case
> > - patches 4-6 introduce unregistering platform devices in MFD in=20
> > reversed
> >   order
> > - patch 7 implements iDMA 64-bit driver
> > - patch 8 introduces an MFD driver for LPSS devices
> >=20
> > The patch 7 can be applied independently, though it's better if it=20
> > goes before
> > patch 8.
> >=20
> > The driver has been tested with SPI and UART on Intel Skylake PCH.
> >=20
> > [1] https://download.01.org/future-platform-configuration
> > -hub/skylake/register-definitions/332219-002.pdf
> > [2] http://www.spinics.net/lists/linux-acpi/msg58622.html
>=20
> Lee, can we move forward this thing somehow?
>=20
> We may create a topic branch for you where we apply already Acked
> patches (1-5) to reduce burden on reviewers. Would it help?

I just need one of the clock guys to take a look at the MFD patch
before I apply the set.

What other Acks are you waiting on?

NB: I don't need a branch, it's easier for me to apply patches from my
mbox.

> > Changelog v5:
> >   - rebase on top of v4.2-rc1
> >   - patch 3 is modified accordingly to new changes in=20
> > drivers/base/dd.c
> >   - correct Rafael's email in patch 3
> >=20
> > Changelog v4:
> >   - replace patch 3 by Rafael's suggession
> >   - append ACKs from Rafael
> >   - rebase on top of v4.1-rc8
> >=20
> > Changelog v3:
> >   - rework patch 3 to be used for all kind of devices (address Alan=
=20
> > comment)
> >   - iDMA 64-bit driver improvements:
> >     - fix burst-to-register conversion
> >     - remove excessive locking
> >   - do not expose core part to the user (Kconfig)
> >   - address most of Lee's comments
> >   - append ACKs
> >   - rebase on top of v4.1-rc6
> >=20
> > Changelog v2:
> >   - new DMA driver to fully support iDMA 64-bit IP
> >   - patch 3 is added to wake up parent devices when ->probe(),=20
> > ->remove(), or
> >     ->shutdown()
> >   - MFD core is unregistering devices in reversed order
> >   - address few Lee's comments on v1
> >   - address Russel's comment, therefore use clkdev_create() helper
> >   - intel-lpss{,-acpi,-pci} are modified regarding to above changes
> >=20
> > Andy Shevchenko (5):
> >   klist: implement klist_prev()
> >   driver core: implement device_for_each_child_reverse()
> >   mfd: make mfd_remove_devices() iterate in reverse order
> >   dmaengine: add a driver for Intel integrated DMA 64-bit
> >   mfd: Add support for Intel Sunrisepoint LPSS devices
> >=20
> > Mika Westerberg (2):
> >   PM / QoS: Make it possible to expose device latency tolerance to
> >     userspace
> >   ACPI / PM: Attach ACPI power domain only once
> >=20
> > Rafael J. Wysocki (1):
> >   Driver core: wakeup the parent device before trying probe
> >=20
> >  drivers/acpi/device_pm.c      |   8 +
> >  drivers/acpi/internal.h       |   2 +
> >  drivers/acpi/scan.c           |  46 ++-
> >  drivers/base/core.c           |  43 +++
> >  drivers/base/dd.c             |  20 ++
> >  drivers/base/power/power.h    |   2 +
> >  drivers/base/power/qos.c      |  37 +++
> >  drivers/base/power/sysfs.c    |  11 +
> >  drivers/dma/Kconfig           |   5 +
> >  drivers/dma/Makefile          |   1 +
> >  drivers/dma/idma64.c          | 724=20
> > ++++++++++++++++++++++++++++++++++++++++++
> >  drivers/dma/idma64.h          | 232 ++++++++++++++
> >  drivers/mfd/Kconfig           |  23 ++
> >  drivers/mfd/Makefile          |   3 +
> >  drivers/mfd/intel-lpss-acpi.c |  84 +++++
> >  drivers/mfd/intel-lpss-pci.c  | 113 +++++++
> >  drivers/mfd/intel-lpss.c      | 524 ++++++++++++++++++++++++++++++
> >  drivers/mfd/intel-lpss.h      |  62 ++++
> >  drivers/mfd/mfd-core.c        |   2 +-
> >  include/linux/device.h        |   2 +
> >  include/linux/klist.h         |   1 +
> >  include/linux/pm_qos.h        |   5 +
> >  lib/klist.c                   |  41 +++
> >  23 files changed, 1974 insertions(+), 17 deletions(-)
> >  create mode 100644 drivers/dma/idma64.c
> >  create mode 100644 drivers/dma/idma64.h
> >  create mode 100644 drivers/mfd/intel-lpss-acpi.c
> >  create mode 100644 drivers/mfd/intel-lpss-pci.c
> >  create mode 100644 drivers/mfd/intel-lpss.c
> >  create mode 100644 drivers/mfd/intel-lpss.h
> >=20
>=20

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
