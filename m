From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v2 1/7] mfd: Add support for DA9150 combined charger &
 fuel-gauge device
Date: Wed, 10 Sep 2014 10:49:51 +0100
Message-ID: <20140910094951.GN30307@lee--X1>
References: <cover.1409145187.git.Adam.Thomson.Opensource@diasemi.com>
 <d6c7de200c9447dbafa74ee76739da943a0b73b2.1409145187.git.Adam.Thomson.Opensource@diasemi.com>
 <20140828163608.GY24579@lee--X1>
 <2E89032DDAA8B9408CB92943514A0337AB5144CE@SW-EX-MBX01.diasemi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ig0-f182.google.com ([209.85.213.182]:43845 "EHLO
	mail-ig0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751260AbaIJJt6 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 10 Sep 2014 05:49:58 -0400
Received: by mail-ig0-f182.google.com with SMTP id h18so778641igc.15
        for <linux-pm@vger.kernel.org>; Wed, 10 Sep 2014 02:49:58 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <2E89032DDAA8B9408CB92943514A0337AB5144CE@SW-EX-MBX01.diasemi.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Opensource [Adam Thomson]" <Adam.Thomson.Opensource@diasemi.com>
Cc: Samuel Ortiz <sameo@linux.intel.com>, Jonathan Cameron <jic23@kernel.org>, "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Joe Perches <joe@perches.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Support Opensource <Support.Opensource@diasemi.com>

On Tue, 09 Sep 2014, Opensource [Adam Thomson] wrote:

> On August 28, 2014 17:36, Lee Jones wrote:
>=20
> Thanks for the feedback. As a general comment a couple of the items y=
ou've
> identified relate to future updates (additional functionality being a=
dded).
> I already have code in place for this but have stripped out a couple =
of the
> drivers just to reduce the churn and size of patch submission. These =
will be
> added once these patches have been accepted.
>=20
> Where this is the case, I have added notes in-line against the releva=
nt
> comments you made.
>=20
> > On Thu, 28 Aug 2014, Adam Thomson wrote:
> >=20
> > > DA9150 is a combined Charger and Fuel-Gauge IC, with additional
> > > GPIO and GPADC functionality.
> > >
> > > Signed-off-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
> > > ---
> > >  drivers/mfd/Kconfig                  |   12 +
> > >  drivers/mfd/Makefile                 |    2 +
> > >  drivers/mfd/da9150-core.c            |  332 ++++++++++
> > >  drivers/mfd/da9150-i2c.c             |  176 ++++++
> >=20
> > Do you also have another, say SPI version?
>=20
> No, not yet, but this is something that we may add later as the devic=
e does
> support SPI.

I'm not sure we want to split up the files like this for an 'if we
decide to produce an SPI variant in the future'.  If you do, then you
can split the files up.  Until then, stick everything in -core.


> > >  include/linux/mfd/da9150/core.h      |   80 +++
> > >  include/linux/mfd/da9150/pdata.h     |   21 +
> > >  include/linux/mfd/da9150/registers.h | 1153
> > ++++++++++++++++++++++++++++++++++
> > >  7 files changed, 1776 insertions(+)
> > >  create mode 100644 drivers/mfd/da9150-core.c
> > >  create mode 100644 drivers/mfd/da9150-i2c.c
> > >  create mode 100644 include/linux/mfd/da9150/core.h
> > >  create mode 100644 include/linux/mfd/da9150/pdata.h
> > >  create mode 100644 include/linux/mfd/da9150/registers.h
> > >
> > > diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> > > index de5abf2..76adb2c 100644
> > > --- a/drivers/mfd/Kconfig
> > > +++ b/drivers/mfd/Kconfig
> > > @@ -183,6 +183,18 @@ config MFD_DA9063
> > >  	  Additional drivers must be enabled in order to use the functi=
onality
> > >  	  of the device.
> > >
> > > +config MFD_DA9150
> > > +	bool "Dialog Semiconductor DA9150 Charger Fuel-Gauge chip"
> >=20
> > Why can't this be built as a module?
>=20
> No reason. Will change it.
>=20
> >=20
> > > +	depends on I2C=3Dy
> > > +	select MFD_CORE
> > > +	select REGMAP_I2C
> > > +	select REGMAP_IRQ
> > > +	help
> > > +	  This adds support for the DA9150 integrated charger and fuel-=
gauge
> > > +	  chip. This driver provides common support for accessing the d=
evice.
> > > +	  Additional drivers must be enabled in order to use the specif=
ic
> > > +	  features of the device.
> > > +
> > >  config MFD_MC13XXX
> > >  	tristate
> > >  	depends on (SPI_MASTER || I2C)
> > > diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
> > > index f001487..098dfa1 100644
> > > --- a/drivers/mfd/Makefile
> > > +++ b/drivers/mfd/Makefile
> > > @@ -114,6 +114,8 @@ obj-$(CONFIG_MFD_DA9055)	+=3D da9055.o
> > >  da9063-objs			:=3D da9063-core.o da9063-irq.o da9063-i2c.o
> > >  obj-$(CONFIG_MFD_DA9063)	+=3D da9063.o
> > >
> > > +obj-$(CONFIG_MFD_DA9150)	+=3D da9150-core.o da9150-i2c.o
> > > +
> >=20
> > Do the other drivers smell?  Please butt up against them.
> >=20
> > I'm not entirely sure why there are so many '\n's in the Makefile!
>=20
> Okey dokey. Will change.
>=20
> >=20
> > >  obj-$(CONFIG_MFD_MAX14577)	+=3D max14577.o
> > >  obj-$(CONFIG_MFD_MAX77686)	+=3D max77686.o
> > >  obj-$(CONFIG_MFD_MAX77693)	+=3D max77693.o
> > > diff --git a/drivers/mfd/da9150-core.c b/drivers/mfd/da9150-core.=
c
> > > new file mode 100644
> > > index 0000000..029a30b
> > > --- /dev/null
> > > +++ b/drivers/mfd/da9150-core.c
> > > @@ -0,0 +1,332 @@
> > > +/*
> > > + * DA9150 Core MFD Driver
> > > + *
> > > + * Copyright (c) 2014 Dialog Semiconductor
> > > + *
> > > + * Author: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
> > > + *
> > > + * This program is free software; you can redistribute  it and/o=
r modify it
> > > + * under  the terms of  the GNU General  Public License as publi=
shed by the
> > > + * Free Software Foundation;  either version 2 of the  License, =
or (at your
> > > + * option) any later version.
> > > + */
> > > +
> > > +#include <linux/kernel.h>
> > > +#include <linux/module.h>
> > > +#include <linux/platform_device.h>
> > > +#include <linux/slab.h>
> > > +#include <linux/irq.h>
> > > +#include <linux/interrupt.h>
> > > +#include <linux/mfd/core.h>
> > > +
> >=20
> > No real need for this '\n'.
>=20
> I can change this, but my reason was to separate common kernel includ=
es from
> device specific ones, for readability.=20

It isn't any less readable with the '\n' removed.

> > > +#include <linux/mfd/da9150/core.h>
> > > +#include <linux/mfd/da9150/registers.h>
> > > +#include <linux/mfd/da9150/pdata.h>
> > > +
> > > +u8 da9150_reg_read(struct da9150 *da9150, u16 reg)
> > > +{
> > > +	int val, ret;
> > > +
> > > +	ret =3D regmap_read(da9150->regmap, reg, &val);
> > > +	if (ret < 0)
> >=20
> > What if ret > 0?  Is that a good thing? :)
> >=20
> > Just 'if (ret)'.
>=20
> Fine, will change.
>=20
> >=20
> > > +		dev_err(da9150->dev, "Failed to read from reg 0x%x: %d\n",
> > > +			reg, ret);
> > > +
> > > +	return (u8) val;
> > > +}
> > > +EXPORT_SYMBOL_GPL(da9150_reg_read);
> >=20
> > Not sure I like this abstraction stuff.  I could understand if ther=
e
> > were locking involved, but there isn't.  You don't appear to check =
for
> > errors in the subordinate drivers either, rather you just plough on
> > ahead.  Not sure that's a good idea either.
> >=20
> > Anyone have a second opinion?
>=20
> The reason for these is because future patches to add additional func=
tionality
> will introduce I2C access functions which do not use regmap and acces=
s the
> device via a separate I2C address for this purpose. I will need to pr=
ovide
> access functions for that, and so having a common style of I2C access=
 makes
> sense for this driver. Means any access just needs to provide the MFD=
 private
> data, and the relevant functions take care of the rest. I think this =
is cleaner
> in this instance.

So long as these appear soon.  Otherwise it's just cruft.

[...]

> > > +/* Helper functions for sub-devices to request/free IRQs */
> > > +int da9150_register_irq(struct platform_device *pdev, void *dev_=
id,
> > > +			irq_handler_t handler, const char *name)
> > > +{
> > > +	int irq, ret;
> > > +
> > > +	irq =3D platform_get_irq_byname(pdev, name);
> > > +	if (irq < 0)
> > > +		return irq;
> > > +
> > > +	ret =3D devm_request_threaded_irq(&pdev->dev, irq, NULL, handle=
r,
> > > +					IRQF_ONESHOT, name, dev_id);
> > > +	if (ret)
> > > +		dev_err(&pdev->dev, "Failed to request IRQ %d: %d\n", irq, ret=
);
> > > +
> > > +	return ret;
> > > +}
> > > +EXPORT_SYMBOL_GPL(da9150_register_irq);
> >=20
> > Why do they need help?  What problem does adding these layers solve=
?
>=20
> Means I don't have to keep adding print error lines everywhere else i=
f this
> function takes care of it. Thought that would be cleaner.

You only need to request each IRQ once.  It's just more abstraction
for the sake of it.  I would prefer if you removed them.

> > > +void da9150_release_irq(struct platform_device *pdev, void *dev_=
id,
> > > +		       const char *name)
> > > +{
> > > +	int irq;
> > > +
> > > +	irq =3D platform_get_irq_byname(pdev, name);
> > > +	if (irq < 0)
> > > +		return;
> > > +
> > > +	devm_free_irq(&pdev->dev, irq, dev_id);
> > > +}
> > > +EXPORT_SYMBOL_GPL(da9150_release_irq);
> >=20
> > Do you ever release the IRQ and not unbind the driver?
> >=20
> > Are there ordering issues at play here?
> >=20
> > If not, there's no need to conduct a manual free.
>=20
> In the charger driver, in the remove function there is a need I belie=
ve to
> free the IRQs before other items are cleared up (e.g. power_supply cl=
asses),
> so this is why I have added this in here.

Can you handle this separately in the Charger driver then please?

[...]

> > > +	if (pdata)
> > > +		da9150->irq_base =3D pdata->irq_base;
> > > +	else
> > > +		da9150->irq_base =3D -1;
> >=20
> > pdata ? pdata->irq_base : -1;
>=20
> This is left this way as later updates to add additional functionalit=
y will
> require addtional work to be done with the platform data. Seemed poin=
tless
> changing it here just to change it back later.

You're not changing anything, as this is the introduction of the code.
I can't tell you how many times I've heard "I will change it later",
or "doing it this way will support subsequent submissions", then
received no more patches.  It's okay to do it nicely now and expand
it back out in the new patches.

[...]

> > > +	da9150 =3D devm_kzalloc(&client->dev, sizeof(struct da9150), GF=
P_KERNEL);
> >=20
> > sizeof(*da9150)
>=20
> Same difference, but ok.

It's more succinct and almost always done this way because of it.

[...]

> > > +struct da9150_pdata {
> > > +	int irq_base;
> > > +};
> >=20
> > Just put this in core.h and do away witht this header file.
>=20
> The reason for this is that I will add more platform data items later=
 with
> subsequent submissions for additional features. It felt cleaner to se=
parate out
> these structures than throw it in the core.h header. However if it's =
going to
> be a problem I'll fold this into core.h

More "I will"s. :)

Please do what's right for 'this submission'.  If things change later
you can act accordingly.

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
