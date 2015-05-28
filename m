From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v2 8/8] mfd: Add support for Intel Sunrisepoint LPSS
 devices
Date: Thu, 28 May 2015 14:10:52 +0100
Message-ID: <20150528131051.GR11677@x1>
References: <1432570172-86963-1-git-send-email-andriy.shevchenko@linux.intel.com>
 <1432570172-86963-9-git-send-email-andriy.shevchenko@linux.intel.com>
 <20150527102241.GC11677@x1>
 <1432811843.26331.18.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f179.google.com ([209.85.212.179]:38699 "EHLO
	mail-wi0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752299AbbE1NK6 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 28 May 2015 09:10:58 -0400
Received: by wizo1 with SMTP id o1so61574994wiz.1
        for <linux-pm@vger.kernel.org>; Thu, 28 May 2015 06:10:57 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1432811843.26331.18.camel@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Vinod Koul <vinod.koul@intel.com>, Andrew Morton <akpm@linux-foundation.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, Heikki Krogerus <heikki.krogerus@linux.intel.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>

On Thu, 28 May 2015, Andy Shevchenko wrote:
> On Wed, 2015-05-27 at 11:22 +0100, Lee Jones wrote:
> > On Mon, 25 May 2015, Andy Shevchenko wrote:
> >=20
> > > The new coming Intel platforms such as Skylake will contain Sunri=
sepoint PCH.
> > > The main difference to the previous platforms is that the LPSS de=
vices are
> > > compound devices where usually main (SPI, HSUART, or I2C) and DMA=
 IPs are
> > > present.
> > >=20
> > > This patch brings the driver for such devices found on Sunrisepoi=
nt PCH.
>=20
> Thanks for comments.
> My answers below.
>=20
> > > --- /dev/null
> > > +++ b/drivers/mfd/intel-lpss-acpi.c
> > > @@ -0,0 +1,84 @@
> > > +/*
> > > + * Intel LPSS ACPI support.
> > > + *
> > > + * Copyright (C) 2015, Intel Corporation
> > > + *
> > > + * Authors: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > > + *          Mika Westerberg <mika.westerberg@linux.intel.com>
> > > + *
> > > + * This program is free software; you can redistribute it and/or=
 modify
> > > + * it under the terms of the GNU General Public License version =
2 as
> > > + * published by the Free Software Foundation.
> > > + */
> > > +
> > > +#include <linux/acpi.h>
> > > +#include <linux/ioport.h>
> > > +#include <linux/kernel.h>
> > > +#include <linux/module.h>
> > > +#include <linux/pm.h>
> > > +#include <linux/pm_runtime.h>
> > > +#include <linux/platform_device.h>
> >=20
> > [...]
> >=20
> > > +	lpss->devid =3D ida_simple_get(&intel_lpss_devid_ida, 0, 0, GFP=
_KERNEL);
> > > +	if (lpss->devid < 0)
> > > +		return lpss->devid;
> > > +
> > > +	ret =3D intel_lpss_register_clock(lpss);
> > > +	if (ret < 0)
> > > +		goto err_clk_register;
> >=20
> > Still not convinced by this.  I'd like Mike (who you *still* have n=
ot
> > CC'ed), to review.
>=20
> I will include him on next iteration.
>=20
> > > +	intel_lpss_ltr_expose(lpss);
> > > +
> > > +	ret =3D intel_lpss_debugfs_add(lpss);
> > > +	if (ret)
> > > +		dev_warn(lpss->dev, "Failed to create debugfs entries\n");
> > > +
> > > +	if (intel_lpss_has_idma(lpss)) {
> > > +		/*
> > > +		 * Ensure the DMA driver is loaded before the host
> > > +		 * controller device appears, so that the host controller
> > > +		 * driver can request its DMA channels as early as
> > > +		 * possible.
> > > +		 *
> > > +		 * If the DMA module is not there that's OK as well.
> > > +		 */
> > > +		intel_lpss_request_dma_module(LPSS_IDMA_DRIVER_NAME);
> > > +
> > > +		ret =3D mfd_add_devices(dev, lpss->devid, lpss->devs, 2,
> > > +				      info->mem, info->irq, NULL);
> > > +	} else {
> > > +		ret =3D mfd_add_devices(dev, lpss->devid, lpss->devs + 1, 1,
> > > +				      info->mem, info->irq, NULL);
> > > +	}
> >=20
> > I'm still not happy with the mfd_cells being manipulated in this wa=
y,
> > or with the duplication you have within them.  Why don't you place =
the
> > IDMA device it its own mfd_cell, then:
> >=20
> > > +	if (intel_lpss_has_idma(lpss)) {
> > > +		intel_lpss_request_dma_module(LPSS_IDMA_DRIVER_NAME);
> > > +
> > > +		ret =3D mfd_add_devices(dev, TBC, idma_dev, ARRAY_SIZE(idma_de=
v),
> > > +				      info->mem, info->irq, NULL);
> > > +             /* Error check */
> > > +	}
> > > +
> > > +	ret =3D mfd_add_devices(dev, TBC, proto_dev, ARRAY_SIZE(proto_d=
ev),
> > > +				      info->mem, info->irq, NULL);
>=20
> Would be nicer to export mfd_add_device() in that case?

What do you mean by export?  What's wrong with using this code
segment?

> > > +	if (ret < 0)
> >=20
> > if (!ret)
>=20
> Do you mean a) if (ret) or b) if (!ret) return 0; ?
>=20
> Will be fixed for option a).

Right.

> > > +static int __init intel_lpss_init(void)
> > > +{
> > > +	intel_lpss_debugfs =3D debugfs_create_dir("intel_lpss", NULL);
> >=20
> > Any reason this can't be done in .probe()?
>=20
> ->probe is called per device, but we have one global folder for all o=
f them.
>=20
> So,
> intel_lpss/
>   dev_name 1/
>     capabilities
>     ...
>   dev_name 2/
>     capabilities
>     ...
>   ...
>=20
> I doubt debugfs_create_dir() works like 'mkdir -p'.

Ah, multiple devices, yes good point.

[...]

> > > +#ifdef CONFIG_PM_SLEEP
> > > +#define INTEL_LPSS_SLEEP_PM_OPS			\
> > > +	.prepare =3D intel_lpss_prepare,		\
> > > +	.suspend =3D intel_lpss_suspend,		\
> > > +	.resume =3D intel_lpss_resume,		\
> > > +	.freeze =3D intel_lpss_suspend,		\
> > > +	.thaw =3D intel_lpss_resume,		\
> > > +	.poweroff =3D intel_lpss_suspend,		\
> > > +	.restore =3D intel_lpss_resume,
> > > +#endif
> > > +
> > > +#define INTEL_LPSS_RUNTIME_PM_OPS		\
> > > +	.runtime_suspend =3D intel_lpss_suspend,	\
> > > +	.runtime_resume =3D intel_lpss_resume,
> > > +
> > > +#else /* !CONFIG_PM */
> > > +#define INTEL_LPSS_SLEEP_PM_OPS
> > > +#define INTEL_LPSS_RUNTIME_PM_OPS
> > > +#endif /* CONFIG_PM */
> > > +
> > > +#define INTEL_LPSS_PM_OPS(name)			\
> > > +const struct dev_pm_ops name =3D {		\
> > > +	INTEL_LPSS_SLEEP_PM_OPS			\
> > > +	INTEL_LPSS_RUNTIME_PM_OPS		\
>=20
> > If you _really_ need .prepare, then it's likely that some other
> > platform might too.  It will be the same amount of code to just mak=
e
> > this generic, so do that instead please.
>=20
> In 'linux/pm.h' ->prepare() is excluded since it's quite exotic to be=
=20
> in device drivers. That is my understanding why it makes not much sen=
se
> to provide a generic definition for that.
>=20
> $ git grep -n '\.prepare[ \t]*=3D.*pm' drivers/ | wc -l
> 33
> $ git grep -n SET_SYSTEM_SLEEP_PM_OPS drivers/ | wc -l
> 114
> $ git grep -n UNIVERSAL_DEV_PM_OPS drivers/ | wc -l
> 9
> =E2=80=A6and there are a lot of drivers (hundreds+) that do
> not use mentioned macros, and has no ->prepare() callback defined.
>=20
> I can try to summon up Rafael to clarify this.

Yes, let's do that, as I'd like a second opinion on this, thanks.

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
