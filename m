From: Lee Jones <lee.jones@linaro.org>
Subject: [GIT PULL] mfd: Immutable branch between MFD, Base, ACPI and DMA
Date: Tue, 28 Jul 2015 10:00:37 +0100
Message-ID: <20150728090037.GS14943@x1>
References: <1438009443-55317-1-git-send-email-andriy.shevchenko@linux.intel.com>
 <20150728085930.GR14943@x1>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150728085930.GR14943@x1>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Vinod Koul <vinod.koul@intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, Heikki Krogerus <heikki.krogerus@linux.intel.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, mturquette@baylibre.com, sboyd@codeaurora.org
List-Id: linux-pm@vger.kernel.org

With more explicit $SUBJECT line this time.

Sorry for the noise.

> Enjoy,
>=20
> The following changes since commit bc0195aad0daa2ad5b0d76cce22b167bc3=
435590:
>=20
>   Linux 4.2-rc2 (2015-07-12 15:10:30 -0700)
>=20
> are available in the git repository at:
>=20
>   git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git tags/ib-m=
fd-base-acpi-dma-v4.3
>=20
> for you to fetch changes up to 4b45efe8526359a11ca60a299bef3aebf413fd=
77:
>=20
>   mfd: Add support for Intel Sunrisepoint LPSS devices (2015-07-28 09=
:56:47 +0100)
>=20
> ----------------------------------------------------------------
> Immutable branch between MFD, Base, ACPI and DMA due for v4.3
>=20
> ----------------------------------------------------------------
> Andy Shevchenko (5):
>       klist: implement klist_prev()
>       driver core: implement device_for_each_child_reverse()
>       mfd: make mfd_remove_devices() iterate in reverse order
>       dmaengine: add a driver for Intel integrated DMA 64-bit
>       mfd: Add support for Intel Sunrisepoint LPSS devices
>=20
> Mika Westerberg (2):
>       PM / QoS: Make it possible to expose device latency tolerance t=
o userspace
>       ACPI / PM: Attach ACPI power domain only once
>=20
> Rafael J. Wysocki (1):
>       Driver core: wakeup the parent device before trying probe
>=20
>  drivers/acpi/device_pm.c      |   8 +
>  drivers/acpi/internal.h       |   2 +
>  drivers/acpi/scan.c           |  46 ++-
>  drivers/base/core.c           |  43 +++
>  drivers/base/dd.c             |  20 ++
>  drivers/base/power/power.h    |   2 +
>  drivers/base/power/qos.c      |  37 +++
>  drivers/base/power/sysfs.c    |  11 +
>  drivers/dma/Kconfig           |   8 +
>  drivers/dma/Makefile          |   1 +
>  drivers/dma/idma64.c          | 710 ++++++++++++++++++++++++++++++++=
++++++++++
>  drivers/dma/idma64.h          | 233 ++++++++++++++
>  drivers/mfd/Kconfig           |  23 ++
>  drivers/mfd/Makefile          |   3 +
>  drivers/mfd/intel-lpss-acpi.c |  84 +++++
>  drivers/mfd/intel-lpss-pci.c  | 113 +++++++
>  drivers/mfd/intel-lpss.c      | 524 +++++++++++++++++++++++++++++++
>  drivers/mfd/intel-lpss.h      |  62 ++++
>  drivers/mfd/mfd-core.c        |   2 +-
>  include/linux/device.h        |   2 +
>  include/linux/klist.h         |   1 +
>  include/linux/pm_qos.h        |   5 +
>  lib/klist.c                   |  41 +++
>  23 files changed, 1964 insertions(+), 17 deletions(-)
>  create mode 100644 drivers/dma/idma64.c
>  create mode 100644 drivers/dma/idma64.h
>  create mode 100644 drivers/mfd/intel-lpss-acpi.c
>  create mode 100644 drivers/mfd/intel-lpss-pci.c
>  create mode 100644 drivers/mfd/intel-lpss.c
>  create mode 100644 drivers/mfd/intel-lpss.h
>=20

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
