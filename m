From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH v2 0/8] mfd: introduce a driver for LPSS devices on SPT
Date: Tue, 26 May 2015 09:21:55 +0530
Message-ID: <20150526035155.GN3140@localhost>
References: <1432570172-86963-1-git-send-email-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1432570172-86963-1-git-send-email-andriy.shevchenko@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Lee Jones <lee.jones@linaro.org>, Andrew Morton <akpm@linux-foundation.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, Heikki Krogerus <heikki.krogerus@linux.intel.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>
List-Id: linux-pm@vger.kernel.org

On Mon, May 25, 2015 at 07:09:24PM +0300, Andy Shevchenko wrote:
> The new coming Intel platforms such as Skylake will contain Sunrisepoint PCH.
> 
> The driver is based on MFD framework since the main device, i.e. serial bus
> controller, contains register space for itself, DMA part, and an additional
> address space (convergence layer). 
> 
> The public specification of the register map is avaiable in [3].
or [1]...?

-- 
~Vinod

> 
> This is second generation of the patch series to bring support LPSS devices
> found on Intel Sunrisepoint (Intel Skylake PCH). First one can be found here
> [2].
> 
> The series has few logical parts:
> - patches 1-3 prepares PM core, ACPI, and driver core (PM) to handle our case
> - patches 4-6 introduce unregistering platform devices in MFD in reversed
>   order
> - patch 7 implements iDMA 64-bit driver
> - patch 8 introduces an MFD driver for LPSS devices
> 
> The patch 8 depends on clkdev_create() helper that has been introduced by
> Russel King in [3].
> 
> The driver has been tested with SPI and UART on Intel Skylake PCH.
> 
> [1] https://download.01.org/future-platform-configuration-hub/skylake/register-definitions/332219_001_Final.pdf
> [2] https://lkml.org/lkml/2015/3/31/255
> [3] https://patchwork.linuxtv.org/patch/28464/
> 
> Changelog v2:
> - new DMA driver to fully support iDMA 64-bit IP
> - patch 3 is added to wake up parent devices when ->probe(), ->remove(), or
>   ->shutdown()
> - MFD core is unregistering devices in reversed order
> - address few Lee's comments on v1
> - address Russel's comment, therefore use clkdev_create() helper
> - intel-lpss{,-acpi,-pci} are modified regarding to above changes
> 
> Andy Shevchenko (5):
>   klist: implement klist_prev()
>   driver core: implement device_for_each_child_reverse()
>   mfd: make mfd_remove_devices() iterate in reverse order
>   dmaengine: add a driver for Intel integrated DMA 64-bit
>   mfd: Add support for Intel Sunrisepoint LPSS devices
> 
> Heikki Krogerus (1):
>   core: platform: wakeup the parent before trying any driver operations
> 
> Mika Westerberg (2):
>   PM / QoS: Make it possible to expose device latency tolerance to
>     userspace
>   ACPI / PM: Attach ACPI power domain only once
> 
>  drivers/acpi/device_pm.c      |   8 +
>  drivers/acpi/internal.h       |   2 +
>  drivers/acpi/scan.c           |  46 ++-
>  drivers/base/core.c           |  43 +++
>  drivers/base/platform.c       |  21 +-
>  drivers/base/power/power.h    |   2 +
>  drivers/base/power/qos.c      |  37 +++
>  drivers/base/power/sysfs.c    |  11 +
>  drivers/dma/Kconfig           |   5 +
>  drivers/dma/Makefile          |   1 +
>  drivers/dma/idma64.c          | 749 ++++++++++++++++++++++++++++++++++++++++++
>  drivers/dma/idma64.h          | 233 +++++++++++++
>  drivers/mfd/Kconfig           |  24 ++
>  drivers/mfd/Makefile          |   3 +
>  drivers/mfd/intel-lpss-acpi.c |  84 +++++
>  drivers/mfd/intel-lpss-pci.c  | 113 +++++++
>  drivers/mfd/intel-lpss.c      | 534 ++++++++++++++++++++++++++++++
>  drivers/mfd/intel-lpss.h      |  62 ++++
>  drivers/mfd/mfd-core.c        |   2 +-
>  include/linux/device.h        |   2 +
>  include/linux/klist.h         |   1 +
>  include/linux/pm_qos.h        |   5 +
>  lib/klist.c                   |  41 +++
>  23 files changed, 2011 insertions(+), 18 deletions(-)
>  create mode 100644 drivers/dma/idma64.c
>  create mode 100644 drivers/dma/idma64.h
>  create mode 100644 drivers/mfd/intel-lpss-acpi.c
>  create mode 100644 drivers/mfd/intel-lpss-pci.c
>  create mode 100644 drivers/mfd/intel-lpss.c
>  create mode 100644 drivers/mfd/intel-lpss.h
> 
> -- 
> 2.1.4
> 

-- 
