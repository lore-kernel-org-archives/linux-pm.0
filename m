From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v3 8/8] mfd: Add support for Intel Sunrisepoint LPSS
 devices
Date: Tue, 2 Jun 2015 10:44:04 +0100
Message-ID: <20150602094404.GJ3329@x1>
References: <1433170082-117462-1-git-send-email-andriy.shevchenko@linux.intel.com>
 <1433170082-117462-9-git-send-email-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1433170082-117462-9-git-send-email-andriy.shevchenko@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Vinod Koul <vinod.koul@intel.com>, Andrew Morton <akpm@linux-foundation.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, Heikki Krogerus <heikki.krogerus@linux.intel.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, Mike Turquette <mturquette@linaro.org>
List-Id: linux-pm@vger.kernel.org

Mike,

Can you review the clock implementation please?  It looks fragile to
me as it relies heavily on device names constructed of MFD cell names
and IDA numbers cat'ed together!

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
>  drivers/mfd/Kconfig           |  23 ++
>  drivers/mfd/Makefile          |   3 +
>  drivers/mfd/intel-lpss-acpi.c |  84 +++++++
>  drivers/mfd/intel-lpss-pci.c  | 113 +++++++++
>  drivers/mfd/intel-lpss.c      | 524 ++++++++++++++++++++++++++++++++=
++++++++++
>  drivers/mfd/intel-lpss.h      |  62 +++++
>  6 files changed, 809 insertions(+)
>  create mode 100644 drivers/mfd/intel-lpss-acpi.c
>  create mode 100644 drivers/mfd/intel-lpss-pci.c
>  create mode 100644 drivers/mfd/intel-lpss.c
>  create mode 100644 drivers/mfd/intel-lpss.h

[...]

> +static void intel_lpss_unregister_clock_tree(struct clk *clk)
> +{
> +	struct clk *parent;
> +
> +	while (clk) {
> +		parent =3D clk_get_parent(clk);
> +		clk_unregister(clk);
> +		clk =3D parent;
> +	}
> +}
> +
> +static int intel_lpss_register_clock_divider(struct intel_lpss *lpss=
,
> +					     const char *devname,
> +					     struct clk **clk)
> +{
> +	char name[32];
> +	struct clk *tmp =3D *clk;
> +
> +	snprintf(name, sizeof(name), "%s-enable", devname);
> +	tmp =3D clk_register_gate(NULL, name, __clk_get_name(tmp), 0,
> +				lpss->priv, 0, 0, NULL);
> +	if (IS_ERR(tmp))
> +		return PTR_ERR(tmp);
> +
> +	snprintf(name, sizeof(name), "%s-div", devname);
> +	tmp =3D clk_register_fractional_divider(NULL, name, __clk_get_name(=
tmp),
> +					      0, lpss->priv, 1, 15, 16, 15, 0,
> +					      NULL);
> +	if (IS_ERR(tmp))
> +		return PTR_ERR(tmp);
> +	*clk =3D tmp;
> +
> +	snprintf(name, sizeof(name), "%s-update", devname);
> +	tmp =3D clk_register_gate(NULL, name, __clk_get_name(tmp),
> +				CLK_SET_RATE_PARENT, lpss->priv, 31, 0, NULL);
> +	if (IS_ERR(tmp))
> +		return PTR_ERR(tmp);
> +	*clk =3D tmp;
> +
> +	return 0;
> +}
> +
> +static int intel_lpss_register_clock(struct intel_lpss *lpss)
> +{
> +	const struct mfd_cell *cell =3D lpss->cell;
> +	struct clk *clk;
> +	char devname[24];
> +	int ret;
> +
> +	if (!lpss->info->clk_rate)
> +		return 0;
> +
> +	/* Root clock */
> +	clk =3D clk_register_fixed_rate(NULL, dev_name(lpss->dev), NULL,
> +				      CLK_IS_ROOT, lpss->info->clk_rate);
> +	if (IS_ERR(clk))
> +		return PTR_ERR(clk);
> +
> +	snprintf(devname, sizeof(devname), "%s.%d", cell->name, lpss->devid=
);
> +
> +	/*
> +	 * Support for clock divider only if it has some preset value.
> +	 * Otherwise we assume that the divider is not used.
> +	 */
> +	if (lpss->type !=3D LPSS_DEV_I2C) {
> +		ret =3D intel_lpss_register_clock_divider(lpss, devname, &clk);
> +		if (ret)
> +			goto err_clk_register;
> +	}
> +
> +	ret =3D -ENOMEM;
> +
> +	/* Clock for the host controller */
> +	lpss->clock =3D clkdev_create(clk, lpss->info->clk_con_id, "%s", de=
vname);
> +	if (!lpss->clock)
> +		goto err_clk_register;
> +
> +	lpss->clk =3D clk;
> +
> +	return 0;
> +
> +err_clk_register:
> +	intel_lpss_unregister_clock_tree(clk);
> +
> +	return ret;
> +}
> +
> +static void intel_lpss_unregister_clock(struct intel_lpss *lpss)
> +{
> +	if (IS_ERR_OR_NULL(lpss->clk))
> +		return;
> +
> +	clkdev_drop(lpss->clock);
> +	intel_lpss_unregister_clock_tree(lpss->clk);
> +}
> +
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
> +
> +	lpss->devid =3D ida_simple_get(&intel_lpss_devid_ida, 0, 0, GFP_KER=
NEL);
> +	if (lpss->devid < 0)
> +		return lpss->devid;
> +
> +	ret =3D intel_lpss_register_clock(lpss);
> +	if (ret)
> +		goto err_clk_register;
> +
> +	intel_lpss_ltr_expose(lpss);
> +
> +	ret =3D intel_lpss_debugfs_add(lpss);
> +	if (ret)
> +		dev_warn(dev, "Failed to create debugfs entries\n");
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
> +		intel_lpss_request_dma_module(LPSS_IDMA64_DRIVER_NAME);
> +
> +		ret =3D mfd_add_devices(dev, lpss->devid, &intel_lpss_idma64_cell,
> +				      1, info->mem, info->irq, NULL);
> +		if (ret)
> +			dev_warn(dev, "Failed to add %s, fallback to PIO\n",
> +				 LPSS_IDMA64_DRIVER_NAME);
> +	}
> +
> +	ret =3D mfd_add_devices(dev, lpss->devid, lpss->cell,
> +			      1, info->mem, info->irq, NULL);
> +	if (ret)
> +		goto err_remove_ltr;
> +
> +	return 0;
> +
> +err_remove_ltr:
> +	intel_lpss_debugfs_remove(lpss);
> +	intel_lpss_ltr_hide(lpss);
> +
> +err_clk_register:
> +	ida_simple_remove(&intel_lpss_devid_ida, lpss->devid);
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(intel_lpss_probe);
> +
> +void intel_lpss_remove(struct device *dev)
> +{
> +	struct intel_lpss *lpss =3D dev_get_drvdata(dev);
> +
> +	mfd_remove_devices(dev);
> +	intel_lpss_debugfs_remove(lpss);
> +	intel_lpss_ltr_hide(lpss);
> +	intel_lpss_unregister_clock(lpss);
> +	ida_simple_remove(&intel_lpss_devid_ida, lpss->devid);
> +}
> +EXPORT_SYMBOL_GPL(intel_lpss_remove);
> +
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
> +	return 0;
> +}
> +module_init(intel_lpss_init);
> +
> +static void __exit intel_lpss_exit(void)
> +{
> +	debugfs_remove(intel_lpss_debugfs);
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
