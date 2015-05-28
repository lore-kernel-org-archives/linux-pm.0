From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v2 8/8] mfd: Add support for Intel Sunrisepoint LPSS
 devices
Date: Thu, 28 May 2015 14:17:23 +0300
Message-ID: <1432811843.26331.18.camel@linux.intel.com>
References: <1432570172-86963-1-git-send-email-andriy.shevchenko@linux.intel.com>
	 <1432570172-86963-9-git-send-email-andriy.shevchenko@linux.intel.com>
	 <20150527102241.GC11677@x1>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <20150527102241.GC11677@x1>
Sender: linux-acpi-owner@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Vinod Koul <vinod.koul@intel.com>, Andrew Morton <akpm@linux-foundation.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, Heikki Krogerus <heikki.krogerus@linux.intel.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>
List-Id: linux-pm@vger.kernel.org

On Wed, 2015-05-27 at 11:22 +0100, Lee Jones wrote:
> On Mon, 25 May 2015, Andy Shevchenko wrote:
>=20
> > The new coming Intel platforms such as Skylake will contain Sunrise=
point PCH.
> > The main difference to the previous platforms is that the LPSS devi=
ces are
> > compound devices where usually main (SPI, HSUART, or I2C) and DMA I=
Ps are
> > present.
> >=20
> > This patch brings the driver for such devices found on Sunrisepoint=
 PCH.

Thanks for comments.
My answers below.

> > --- /dev/null
> > +++ b/drivers/mfd/intel-lpss-acpi.c
> > @@ -0,0 +1,84 @@
> > +/*
> > + * Intel LPSS ACPI support.
> > + *
> > + * Copyright (C) 2015, Intel Corporation
> > + *
> > + * Authors: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > + *          Mika Westerberg <mika.westerberg@linux.intel.com>
> > + *
> > + * This program is free software; you can redistribute it and/or m=
odify
> > + * it under the terms of the GNU General Public License version 2 =
as
> > + * published by the Free Software Foundation.
> > + */
> > +
> > +#include <linux/acpi.h>
> > +#include <linux/ioport.h>
> > +#include <linux/kernel.h>
> > +#include <linux/module.h>
> > +#include <linux/pm.h>
> > +#include <linux/pm_runtime.h>
> > +#include <linux/platform_device.h>
>=20
> [...]
>=20
> > +#include "intel-lpss.h"
> > +int intel_lpss_probe(struct device *dev,
> > +		     const struct intel_lpss_platform_info *info)
> > +{
> > +	struct intel_lpss *lpss;
> > +	int ret;
> > +
> > +	if (!info || !info->mem || info->irq <=3D 0)
> > +		return -EINVAL;
> > +
> > +	lpss =3D devm_kzalloc(dev, sizeof(*lpss), GFP_KERNEL);
> > +	if (!lpss)
> > +		return -ENOMEM;
> > +
> > +	lpss->priv =3D devm_ioremap(dev, info->mem->start + LPSS_PRIV_OFF=
SET,
> > +				  LPSS_PRIV_SIZE);
> > +	if (!lpss->priv)
> > +		return -ENOMEM;
> > +
> > +	lpss->info =3D info;
> > +	lpss->dev =3D dev;
> > +	lpss->caps =3D readl(lpss->priv + LPSS_PRIV_CAPS);
> > +
> > +	dev_set_drvdata(dev, lpss);
> > +
> > +	ret =3D intel_lpss_assign_devs(lpss);
> > +	if (ret)
> > +		return ret;
> > +
> > +	intel_lpss_init_dev(lpss);
>=20
> [...]
>=20
> > +	lpss->devid =3D ida_simple_get(&intel_lpss_devid_ida, 0, 0, GFP_K=
ERNEL);
> > +	if (lpss->devid < 0)
> > +		return lpss->devid;
> > +
> > +	ret =3D intel_lpss_register_clock(lpss);
> > +	if (ret < 0)
> > +		goto err_clk_register;
>=20
> Still not convinced by this.  I'd like Mike (who you *still* have not
> CC'ed), to review.

I will include him on next iteration.

> > +	intel_lpss_ltr_expose(lpss);
> > +
> > +	ret =3D intel_lpss_debugfs_add(lpss);
> > +	if (ret)
> > +		dev_warn(lpss->dev, "Failed to create debugfs entries\n");
> > +
> > +	if (intel_lpss_has_idma(lpss)) {
> > +		/*
> > +		 * Ensure the DMA driver is loaded before the host
> > +		 * controller device appears, so that the host controller
> > +		 * driver can request its DMA channels as early as
> > +		 * possible.
> > +		 *
> > +		 * If the DMA module is not there that's OK as well.
> > +		 */
> > +		intel_lpss_request_dma_module(LPSS_IDMA_DRIVER_NAME);
> > +
> > +		ret =3D mfd_add_devices(dev, lpss->devid, lpss->devs, 2,
> > +				      info->mem, info->irq, NULL);
> > +	} else {
> > +		ret =3D mfd_add_devices(dev, lpss->devid, lpss->devs + 1, 1,
> > +				      info->mem, info->irq, NULL);
> > +	}
>=20
> I'm still not happy with the mfd_cells being manipulated in this way,
> or with the duplication you have within them.  Why don't you place th=
e
> IDMA device it its own mfd_cell, then:
>=20
> > +	if (intel_lpss_has_idma(lpss)) {
> > +		intel_lpss_request_dma_module(LPSS_IDMA_DRIVER_NAME);
> > +
> > +		ret =3D mfd_add_devices(dev, TBC, idma_dev, ARRAY_SIZE(idma_dev)=
,
> > +				      info->mem, info->irq, NULL);
> > +             /* Error check */
> > +	}
> > +
> > +	ret =3D mfd_add_devices(dev, TBC, proto_dev, ARRAY_SIZE(proto_dev=
),
> > +				      info->mem, info->irq, NULL);

Would be nicer to export mfd_add_device() in that case?

> > +	if (ret < 0)
>=20
> if (!ret)

Do you mean a) if (ret) or b) if (!ret) return 0; ?

Will be fixed for option a).

> > +static int resume_lpss_device(struct device *dev, void *data)
> > +{
> > +	pm_runtime_resume(dev);
> > +	return 0;
> > +}
> > +
> > +int intel_lpss_prepare(struct device *dev)
> > +{
> > +	/*
> > +	 * Resume both child devices before entering system sleep. This
> > +	 * ensures that they are in proper state before they get suspende=
d.
> > +	 */
> > +	device_for_each_child_reverse(dev, NULL, resume_lpss_device);
>=20
> Why can't you do this in intel_lpss_suspend()?
>=20
> Then you can get rid of all the hand-rolled nonsense you have in the
> header file and use SET_SYSTEM_SLEEP_PM_OPS instead.
>=20
> Does something happen after .prepare() and before .suspend() that
> prevents this from working?

I rely on what Mika answered you.

> > +static int __init intel_lpss_init(void)
> > +{
> > +	intel_lpss_debugfs =3D debugfs_create_dir("intel_lpss", NULL);
>=20
> Any reason this can't be done in .probe()?

->probe is called per device, but we have one global folder for all of =
them.

So,
intel_lpss/
  dev_name 1/
    capabilities
    ...
  dev_name 2/
    capabilities
    ...
  ...

I doubt debugfs_create_dir() works like 'mkdir -p'.

> > +	return 0;
> > +}
> > +module_init(intel_lpss_init);
> > +
> > +static void __exit intel_lpss_exit(void)
> > +{
> > +	debugfs_remove(intel_lpss_debugfs);
>=20
> .remove()?

See above.

> > +++ b/drivers/mfd/intel-lpss.h

[]

> > +#ifdef CONFIG_PM_SLEEP
> > +#define INTEL_LPSS_SLEEP_PM_OPS			\
> > +	.prepare =3D intel_lpss_prepare,		\
> > +	.suspend =3D intel_lpss_suspend,		\
> > +	.resume =3D intel_lpss_resume,		\
> > +	.freeze =3D intel_lpss_suspend,		\
> > +	.thaw =3D intel_lpss_resume,		\
> > +	.poweroff =3D intel_lpss_suspend,		\
> > +	.restore =3D intel_lpss_resume,
> > +#endif
> > +
> > +#define INTEL_LPSS_RUNTIME_PM_OPS		\
> > +	.runtime_suspend =3D intel_lpss_suspend,	\
> > +	.runtime_resume =3D intel_lpss_resume,
> > +
> > +#else /* !CONFIG_PM */
> > +#define INTEL_LPSS_SLEEP_PM_OPS
> > +#define INTEL_LPSS_RUNTIME_PM_OPS
> > +#endif /* CONFIG_PM */
> > +
> > +#define INTEL_LPSS_PM_OPS(name)			\
> > +const struct dev_pm_ops name =3D {		\
> > +	INTEL_LPSS_SLEEP_PM_OPS			\
> > +	INTEL_LPSS_RUNTIME_PM_OPS		\

> If you _really_ need .prepare, then it's likely that some other
> platform might too.  It will be the same amount of code to just make
> this generic, so do that instead please.

In 'linux/pm.h' ->prepare() is excluded since it's quite exotic to be=20
in device drivers. That is my understanding why it makes not much sense
to provide a generic definition for that.

$ git grep -n '\.prepare[ \t]*=3D.*pm' drivers/ | wc -l
33
$ git grep -n SET_SYSTEM_SLEEP_PM_OPS drivers/ | wc -l
114
$ git grep -n UNIVERSAL_DEV_PM_OPS drivers/ | wc -l
9
=E2=80=A6and there are a lot of drivers (hundreds+) that do
not use mentioned macros, and has no ->prepare() callback defined.

I can try to summon up Rafael to clarify this.

--=20
Andy Shevchenko <andriy.shevchenko@intel.com>
Intel Finland Oy

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
