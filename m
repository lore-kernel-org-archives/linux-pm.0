From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v5 0/8] mfd: introduce a driver for LPSS devices on SPT
Date: Fri, 24 Jul 2015 18:29:01 +0300
Message-ID: <1437751741.29746.72.camel@linux.intel.com>
References: <1436185334-34275-1-git-send-email-andriy.shevchenko@linux.intel.com>
	 <1437651621.29746.24.camel@linux.intel.com> <20150724151613.GK3436@x1>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:31197 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754484AbbGXPbR (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 24 Jul 2015 11:31:17 -0400
In-Reply-To: <20150724151613.GK3436@x1>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Vinod Koul <vinod.koul@intel.com>, Andrew Morton <akpm@linux-foundation.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, Heikki Krogerus <heikki.krogerus@linux.intel.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, mturquette@baylibre.com, Stephen Boyd <sboyd@codeaurora.org>

On Fri, 2015-07-24 at 16:16 +0100, Lee Jones wrote:
> On Thu, 23 Jul 2015, Andy Shevchenko wrote:
> 
> > On Mon, 2015-07-06 at 15:22 +0300, Andy Shevchenko wrote:
> > > The new coming Intel platforms such as Skylake will contain 
> > > Sunrisepoint PCH.
> > > 
> > > The driver is based on MFD framework since the main device, i.e. 
> > > serial bus
> > > controller, contains register space for itself, DMA part, and an 
> > > additional
> > > address space (convergence layer). 
> > > 
> > > The public specification of the register map is avaiable in [1].
> > > 
> > > This is fifth generation of the patch series to bring support 
> > > LPSS 
> > > devices
> > > found on Intel Sunrisepoint (Intel Skylake PCH). Previous one can 
> > > be 
> > > found here
> > > [2].
> > > 
> > > The series has few logical parts:
> > > - patches 1-3 prepares PM core, ACPI, and driver core (PM) to 
> > > handle 
> > > our case
> > > - patches 4-6 introduce unregistering platform devices in MFD in 
> > > reversed
> > >   order
> > > - patch 7 implements iDMA 64-bit driver
> > > - patch 8 introduces an MFD driver for LPSS devices
> > > 
> > > The patch 7 can be applied independently, though it's better if 
> > > it 
> > > goes before
> > > patch 8.
> > > 
> > > The driver has been tested with SPI and UART on Intel Skylake 
> > > PCH.
> > > 
> > > [1] https://download.01.org/future-platform-configuration
> > > -hub/skylake/register-definitions/332219-002.pdf
> > > [2] http://www.spinics.net/lists/linux-acpi/msg58622.html
> > 
> > Lee, can we move forward this thing somehow?
> > 
> > We may create a topic branch for you where we apply already Acked
> > patches (1-5) to reduce burden on reviewers. Would it help?
> 
> I just need one of the clock guys to take a look at the MFD patch
> before I apply the set.

Understood, thanks for clarification. I hope Stephen will find time to
answer soon.

> 
> What other Acks are you waiting on?

Vinod's only, though you may apply everything else w/o idma64. JFYI,
besides Vinod's comments our Q/A found a bug in idma64 (it will be fixe
d in next iteration next week).

> 
> NB: I don't need a branch, it's easier for me to apply patches from 
> my
> mbox.

Okay, let's stick this approach.

> 
> > > Changelog v5:
> > >   - rebase on top of v4.2-rc1
> > >   - patch 3 is modified accordingly to new changes in 
> > > drivers/base/dd.c
> > >   - correct Rafael's email in patch 3
> > > 
> > > Changelog v4:
> > >   - replace patch 3 by Rafael's suggession
> > >   - append ACKs from Rafael
> > >   - rebase on top of v4.1-rc8
> > > 
> > > Changelog v3:
> > >   - rework patch 3 to be used for all kind of devices (address 
> > > Alan 
> > > comment)
> > >   - iDMA 64-bit driver improvements:
> > >     - fix burst-to-register conversion
> > >     - remove excessive locking
> > >   - do not expose core part to the user (Kconfig)
> > >   - address most of Lee's comments
> > >   - append ACKs
> > >   - rebase on top of v4.1-rc6
> > > 
> > > Changelog v2:
> > >   - new DMA driver to fully support iDMA 64-bit IP
> > >   - patch 3 is added to wake up parent devices when ->probe(), 
> > > ->remove(), or
> > >     ->shutdown()
> > >   - MFD core is unregistering devices in reversed order
> > >   - address few Lee's comments on v1
> > >   - address Russel's comment, therefore use clkdev_create() 
> > > helper
> > >   - intel-lpss{,-acpi,-pci} are modified regarding to above 
> > > changes
> > > 
> > > Andy Shevchenko (5):
> > >   klist: implement klist_prev()
> > >   driver core: implement device_for_each_child_reverse()
> > >   mfd: make mfd_remove_devices() iterate in reverse order
> > >   dmaengine: add a driver for Intel integrated DMA 64-bit
> > >   mfd: Add support for Intel Sunrisepoint LPSS devices
> > > 
> > > Mika Westerberg (2):
> > >   PM / QoS: Make it possible to expose device latency tolerance 
> > > to
> > >     userspace
> > >   ACPI / PM: Attach ACPI power domain only once
> > > 
> > > Rafael J. Wysocki (1):
> > >   Driver core: wakeup the parent device before trying probe
> > > 
> > >  drivers/acpi/device_pm.c      |   8 +
> > >  drivers/acpi/internal.h       |   2 +
> > >  drivers/acpi/scan.c           |  46 ++-
> > >  drivers/base/core.c           |  43 +++
> > >  drivers/base/dd.c             |  20 ++
> > >  drivers/base/power/power.h    |   2 +
> > >  drivers/base/power/qos.c      |  37 +++
> > >  drivers/base/power/sysfs.c    |  11 +
> > >  drivers/dma/Kconfig           |   5 +
> > >  drivers/dma/Makefile          |   1 +
> > >  drivers/dma/idma64.c          | 724 
> > > ++++++++++++++++++++++++++++++++++++++++++
> > >  drivers/dma/idma64.h          | 232 ++++++++++++++
> > >  drivers/mfd/Kconfig           |  23 ++
> > >  drivers/mfd/Makefile          |   3 +
> > >  drivers/mfd/intel-lpss-acpi.c |  84 +++++
> > >  drivers/mfd/intel-lpss-pci.c  | 113 +++++++
> > >  drivers/mfd/intel-lpss.c      | 524 
> > > ++++++++++++++++++++++++++++++
> > >  drivers/mfd/intel-lpss.h      |  62 ++++
> > >  drivers/mfd/mfd-core.c        |   2 +-
> > >  include/linux/device.h        |   2 +
> > >  include/linux/klist.h         |   1 +
> > >  include/linux/pm_qos.h        |   5 +
> > >  lib/klist.c                   |  41 +++
> > >  23 files changed, 1974 insertions(+), 17 deletions(-)
> > >  create mode 100644 drivers/dma/idma64.c
> > >  create mode 100644 drivers/dma/idma64.h
> > >  create mode 100644 drivers/mfd/intel-lpss-acpi.c
> > >  create mode 100644 drivers/mfd/intel-lpss-pci.c
> > >  create mode 100644 drivers/mfd/intel-lpss.c
> > >  create mode 100644 drivers/mfd/intel-lpss.h
> > > 
> > 
> 

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
