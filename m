From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v2 8/8] mfd: Add support for Intel Sunrisepoint LPSS
 devices
Date: Wed, 27 May 2015 11:22:41 +0100
Message-ID: <20150527102241.GC11677@x1>
References: <1432570172-86963-1-git-send-email-andriy.shevchenko@linux.intel.com>
 <1432570172-86963-9-git-send-email-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1432570172-86963-9-git-send-email-andriy.shevchenko@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Vinod Koul <vinod.koul@intel.com>, Andrew Morton <akpm@linux-foundation.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, Heikki Krogerus <heikki.krogerus@linux.intel.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>
List-Id: linux-pm@vger.kernel.org

On Mon, 25 May 2015, Andy Shevchenko wrote:

> The new coming Intel platforms such as Skylake will contain Sunrisepo=
int PCH.
> The main difference to the previous platforms is that the LPSS device=
s are
> compound devices where usually main (SPI, HSUART, or I2C) and DMA IPs=
 are
> present.
>=20
> This patch brings the driver for such devices found on Sunrisepoint P=
CH.
>=20
> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/mfd/Kconfig           |  24 ++
>  drivers/mfd/Makefile          |   3 +
>  drivers/mfd/intel-lpss-acpi.c |  84 +++++++
>  drivers/mfd/intel-lpss-pci.c  | 113 +++++++++
>  drivers/mfd/intel-lpss.c      | 534 ++++++++++++++++++++++++++++++++=
++++++++++
>  drivers/mfd/intel-lpss.h      |  62 +++++
>  6 files changed, 820 insertions(+)
>  create mode 100644 drivers/mfd/intel-lpss-acpi.c
>  create mode 100644 drivers/mfd/intel-lpss-pci.c
>  create mode 100644 drivers/mfd/intel-lpss.c
>  create mode 100644 drivers/mfd/intel-lpss.h
>=20
> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> index d5ad04d..8cdaa12 100644
> --- a/drivers/mfd/Kconfig
> +++ b/drivers/mfd/Kconfig
> @@ -325,6 +325,30 @@ config INTEL_SOC_PMIC
>  	  thermal, charger and related power management functions
>  	  on these systems.
> =20
> +config MFD_INTEL_LPSS
> +	tristate
> +	depends on X86
> +	select COMMON_CLK
> +	select MFD_CORE
> +
> +config MFD_INTEL_LPSS_ACPI
> +	tristate "Intel Low Power Subsystem support in ACPI mode"
> +	select MFD_INTEL_LPSS
> +	depends on ACPI
> +	help
> +	  This driver supports Intel Low Power Subsystem (LPSS) devices suc=
h as
> +	  I2C, SPI and HS-UART starting from Intel Sunrisepoint (Intel Skyl=
ake
> +	  PCH) in ACPI mode.
> +
> +config MFD_INTEL_LPSS_PCI
> +	tristate "Intel Low Power Subsystem support in PCI mode"
> +	select MFD_INTEL_LPSS
> +	depends on PCI
> +	help
> +	  This driver supports Intel Low Power Subsystem (LPSS) devices suc=
h as
> +	  I2C, SPI and HS-UART starting from Intel Sunrisepoint (Intel Skyl=
ake
> +	  PCH) in PCI mode.
> +
>  config MFD_INTEL_MSIC
>  	bool "Intel MSIC"
>  	depends on INTEL_SCU_IPC
> diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
> index 0e5cfeb..cdf29b9 100644
> --- a/drivers/mfd/Makefile
> +++ b/drivers/mfd/Makefile
> @@ -161,6 +161,9 @@ obj-$(CONFIG_TPS65911_COMPARATOR)	+=3D tps65911-c=
omparator.o
>  obj-$(CONFIG_MFD_TPS65090)	+=3D tps65090.o
>  obj-$(CONFIG_MFD_AAT2870_CORE)	+=3D aat2870-core.o
>  obj-$(CONFIG_MFD_ATMEL_HLCDC)	+=3D atmel-hlcdc.o
> +obj-$(CONFIG_MFD_INTEL_LPSS)	+=3D intel-lpss.o
> +obj-$(CONFIG_MFD_INTEL_LPSS_PCI)	+=3D intel-lpss-pci.o
> +obj-$(CONFIG_MFD_INTEL_LPSS_ACPI)	+=3D intel-lpss-acpi.o
>  obj-$(CONFIG_MFD_INTEL_MSIC)	+=3D intel_msic.o
>  obj-$(CONFIG_MFD_PALMAS)	+=3D palmas.o
>  obj-$(CONFIG_MFD_VIPERBOARD)    +=3D viperboard.o
> diff --git a/drivers/mfd/intel-lpss-acpi.c b/drivers/mfd/intel-lpss-a=
cpi.c
> new file mode 100644
> index 0000000..0d92d73
> --- /dev/null
> +++ b/drivers/mfd/intel-lpss-acpi.c
> @@ -0,0 +1,84 @@
> +/*
> + * Intel LPSS ACPI support.
> + *
> + * Copyright (C) 2015, Intel Corporation
> + *
> + * Authors: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> + *          Mika Westerberg <mika.westerberg@linux.intel.com>
> + *
> + * This program is free software; you can redistribute it and/or mod=
ify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#include <linux/acpi.h>
> +#include <linux/ioport.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/pm.h>
> +#include <linux/pm_runtime.h>
> +#include <linux/platform_device.h>

[...]

> +#include "intel-lpss.h"
> +int intel_lpss_probe(struct device *dev,
> +		     const struct intel_lpss_platform_info *info)
> +{
> +	struct intel_lpss *lpss;
> +	int ret;
> +
> +	if (!info || !info->mem || info->irq <=3D 0)
> +		return -EINVAL;
> +
> +	lpss =3D devm_kzalloc(dev, sizeof(*lpss), GFP_KERNEL);
> +	if (!lpss)
> +		return -ENOMEM;
> +
> +	lpss->priv =3D devm_ioremap(dev, info->mem->start + LPSS_PRIV_OFFSE=
T,
> +				  LPSS_PRIV_SIZE);
> +	if (!lpss->priv)
> +		return -ENOMEM;
> +
> +	lpss->info =3D info;
> +	lpss->dev =3D dev;
> +	lpss->caps =3D readl(lpss->priv + LPSS_PRIV_CAPS);
> +
> +	dev_set_drvdata(dev, lpss);
> +
> +	ret =3D intel_lpss_assign_devs(lpss);
> +	if (ret)
> +		return ret;
> +
> +	intel_lpss_init_dev(lpss);

[...]

> +	lpss->devid =3D ida_simple_get(&intel_lpss_devid_ida, 0, 0, GFP_KER=
NEL);
> +	if (lpss->devid < 0)
> +		return lpss->devid;
> +
> +	ret =3D intel_lpss_register_clock(lpss);
> +	if (ret < 0)
> +		goto err_clk_register;

Still not convinced by this.  I'd like Mike (who you *still* have not
CC'ed), to review.

> +	intel_lpss_ltr_expose(lpss);
> +
> +	ret =3D intel_lpss_debugfs_add(lpss);
> +	if (ret)
> +		dev_warn(lpss->dev, "Failed to create debugfs entries\n");
> +
> +	if (intel_lpss_has_idma(lpss)) {
> +		/*
> +		 * Ensure the DMA driver is loaded before the host
> +		 * controller device appears, so that the host controller
> +		 * driver can request its DMA channels as early as
> +		 * possible.
> +		 *
> +		 * If the DMA module is not there that's OK as well.
> +		 */
> +		intel_lpss_request_dma_module(LPSS_IDMA_DRIVER_NAME);
> +
> +		ret =3D mfd_add_devices(dev, lpss->devid, lpss->devs, 2,
> +				      info->mem, info->irq, NULL);
> +	} else {
> +		ret =3D mfd_add_devices(dev, lpss->devid, lpss->devs + 1, 1,
> +				      info->mem, info->irq, NULL);
> +	}

I'm still not happy with the mfd_cells being manipulated in this way,
or with the duplication you have within them.  Why don't you place the
IDMA device it its own mfd_cell, then:

> +	if (intel_lpss_has_idma(lpss)) {
> +		intel_lpss_request_dma_module(LPSS_IDMA_DRIVER_NAME);
> +
> +		ret =3D mfd_add_devices(dev, TBC, idma_dev, ARRAY_SIZE(idma_dev),
> +				      info->mem, info->irq, NULL);
> +             /* Error check */
> +	}
> +
> +	ret =3D mfd_add_devices(dev, TBC, proto_dev, ARRAY_SIZE(proto_dev),
> +				      info->mem, info->irq, NULL);
> +	if (ret < 0)

if (!ret)

[...]

> +static int resume_lpss_device(struct device *dev, void *data)
> +{
> +	pm_runtime_resume(dev);
> +	return 0;
> +}
> +
> +int intel_lpss_prepare(struct device *dev)
> +{
> +	/*
> +	 * Resume both child devices before entering system sleep. This
> +	 * ensures that they are in proper state before they get suspended.
> +	 */
> +	device_for_each_child_reverse(dev, NULL, resume_lpss_device);

Why can't you do this in intel_lpss_suspend()?

Then you can get rid of all the hand-rolled nonsense you have in the
header file and use SET_SYSTEM_SLEEP_PM_OPS instead.

Does something happen after .prepare() and before .suspend() that
prevents this from working?

> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(intel_lpss_prepare);
> +
> +int intel_lpss_suspend(struct device *dev)
> +{
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(intel_lpss_suspend);
> +
> +int intel_lpss_resume(struct device *dev)
> +{
> +	struct intel_lpss *lpss =3D dev_get_drvdata(dev);
> +
> +	intel_lpss_init_dev(lpss);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(intel_lpss_resume);
> +
> +static int __init intel_lpss_init(void)
> +{
> +	intel_lpss_debugfs =3D debugfs_create_dir("intel_lpss", NULL);

Any reason this can't be done in .probe()?

> +	return 0;
> +}
> +module_init(intel_lpss_init);
> +
> +static void __exit intel_lpss_exit(void)
> +{
> +	debugfs_remove(intel_lpss_debugfs);

=2Eremove()?

> +}
> +module_exit(intel_lpss_exit);
> +
> +MODULE_AUTHOR("Andy Shevchenko <andriy.shevchenko@linux.intel.com>")=
;
> +MODULE_AUTHOR("Mika Westerberg <mika.westerberg@linux.intel.com>");
> +MODULE_AUTHOR("Heikki Krogerus <heikki.krogerus@linux.intel.com>");
> +MODULE_AUTHOR("Jarkko Nikula <jarkko.nikula@linux.intel.com>");
> +MODULE_DESCRIPTION("Intel LPSS core driver");
> +MODULE_LICENSE("GPL v2");
> diff --git a/drivers/mfd/intel-lpss.h b/drivers/mfd/intel-lpss.h
> new file mode 100644
> index 0000000..f28cb28a
> --- /dev/null
> +++ b/drivers/mfd/intel-lpss.h
> @@ -0,0 +1,62 @@
> +/*
> + * Intel LPSS core support.
> + *
> + * Copyright (C) 2015, Intel Corporation
> + *
> + * Authors: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> + *          Mika Westerberg <mika.westerberg@linux.intel.com>
> + *
> + * This program is free software; you can redistribute it and/or mod=
ify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#ifndef __MFD_INTEL_LPSS_H
> +#define __MFD_INTEL_LPSS_H
> +
> +struct device;
> +struct resource;
> +
> +struct intel_lpss_platform_info {
> +	struct resource *mem;
> +	int irq;
> +	unsigned long clk_rate;
> +	const char *clk_con_id;
> +};
> +
> +int intel_lpss_probe(struct device *dev,
> +		     const struct intel_lpss_platform_info *info);
> +void intel_lpss_remove(struct device *dev);
> +
> +#ifdef CONFIG_PM
> +int intel_lpss_prepare(struct device *dev);
> +int intel_lpss_suspend(struct device *dev);
> +int intel_lpss_resume(struct device *dev);
> +
> +#ifdef CONFIG_PM_SLEEP
> +#define INTEL_LPSS_SLEEP_PM_OPS			\
> +	.prepare =3D intel_lpss_prepare,		\
> +	.suspend =3D intel_lpss_suspend,		\
> +	.resume =3D intel_lpss_resume,		\
> +	.freeze =3D intel_lpss_suspend,		\
> +	.thaw =3D intel_lpss_resume,		\
> +	.poweroff =3D intel_lpss_suspend,		\
> +	.restore =3D intel_lpss_resume,
> +#endif
> +
> +#define INTEL_LPSS_RUNTIME_PM_OPS		\
> +	.runtime_suspend =3D intel_lpss_suspend,	\
> +	.runtime_resume =3D intel_lpss_resume,
> +
> +#else /* !CONFIG_PM */
> +#define INTEL_LPSS_SLEEP_PM_OPS
> +#define INTEL_LPSS_RUNTIME_PM_OPS
> +#endif /* CONFIG_PM */
> +
> +#define INTEL_LPSS_PM_OPS(name)			\
> +const struct dev_pm_ops name =3D {		\
> +	INTEL_LPSS_SLEEP_PM_OPS			\
> +	INTEL_LPSS_RUNTIME_PM_OPS		\
> +}
> +
> +#endif /* __MFD_INTEL_LPSS_H */

If you _really_ need .prepare, then it's likely that some other
platform might too.  It will be the same amount of code to just make
this generic, so do that instead please.

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
