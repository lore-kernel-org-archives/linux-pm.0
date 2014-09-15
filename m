From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v2 1/7] mfd: Add support for DA9150 combined charger &
 fuel-gauge device
Date: Mon, 15 Sep 2014 23:39:24 +0100
Message-ID: <20140915223924.GC25162@lee--X1>
References: <cover.1409145187.git.Adam.Thomson.Opensource@diasemi.com>
 <d6c7de200c9447dbafa74ee76739da943a0b73b2.1409145187.git.Adam.Thomson.Opensource@diasemi.com>
 <20140828163608.GY24579@lee--X1>
 <2E89032DDAA8B9408CB92943514A0337AB5144CE@SW-EX-MBX01.diasemi.com>
 <20140910094951.GN30307@lee--X1>
 <2E89032DDAA8B9408CB92943514A0337AB514846@SW-EX-MBX01.diasemi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ie0-f180.google.com ([209.85.223.180]:49831 "EHLO
	mail-ie0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759220AbaIOWj3 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 15 Sep 2014 18:39:29 -0400
Received: by mail-ie0-f180.google.com with SMTP id rd18so5366935iec.25
        for <linux-pm@vger.kernel.org>; Mon, 15 Sep 2014 15:39:28 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <2E89032DDAA8B9408CB92943514A0337AB514846@SW-EX-MBX01.diasemi.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Opensource [Adam Thomson]" <Adam.Thomson.Opensource@diasemi.com>
Cc: Samuel Ortiz <sameo@linux.intel.com>, Jonathan Cameron <jic23@kernel.org>, "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Joe Perches <joe@perches.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Support Opensource <Support.Opensource@diasemi.com>

On Wed, 10 Sep 2014, Opensource [Adam Thomson] wrote:
> On September 10, 2014 10:50, Lee Jones wrote:
> > On Tue, 09 Sep 2014, Opensource [Adam Thomson] wrote:
> >=20
> > > On August 28, 2014 17:36, Lee Jones wrote:
> > >
> > > Thanks for the feedback. As a general comment a couple of the ite=
ms you've
> > > identified relate to future updates (additional functionality bei=
ng added).
> > > I already have code in place for this but have stripped out a cou=
ple of the
> > > drivers just to reduce the churn and size of patch submission. Th=
ese will be
> > > added once these patches have been accepted.
> > >
> > > Where this is the case, I have added notes in-line against the re=
levant
> > > comments you made.
> > >
> > > > On Thu, 28 Aug 2014, Adam Thomson wrote:
> > > >
> > > > > DA9150 is a combined Charger and Fuel-Gauge IC, with addition=
al
> > > > > GPIO and GPADC functionality.
> > > > >
> > > > > Signed-off-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.=
com>
> > > > > ---
> > > > >  drivers/mfd/Kconfig                  |   12 +
> > > > >  drivers/mfd/Makefile                 |    2 +
> > > > >  drivers/mfd/da9150-core.c            |  332 ++++++++++
> > > > >  drivers/mfd/da9150-i2c.c             |  176 ++++++

[...]

> > > > > +/* Helper functions for sub-devices to request/free IRQs */
> > > > > +int da9150_register_irq(struct platform_device *pdev, void *=
dev_id,
> > > > > +			irq_handler_t handler, const char *name)
> > > > > +{
> > > > > +	int irq, ret;
> > > > > +
> > > > > +	irq =3D platform_get_irq_byname(pdev, name);
> > > > > +	if (irq < 0)
> > > > > +		return irq;
> > > > > +
> > > > > +	ret =3D devm_request_threaded_irq(&pdev->dev, irq, NULL, ha=
ndler,
> > > > > +					IRQF_ONESHOT, name, dev_id);
> > > > > +	if (ret)
> > > > > +		dev_err(&pdev->dev, "Failed to request IRQ %d: %d\n", irq,=
 ret);
> > > > > +
> > > > > +	return ret;
> > > > > +}
> > > > > +EXPORT_SYMBOL_GPL(da9150_register_irq);
> > > >
> > > > Why do they need help?  What problem does adding these layers s=
olve?
> > >
> > > Means I don't have to keep adding print error lines everywhere el=
se if this
> > > function takes care of it. Thought that would be cleaner.
> >=20
> > You only need to request each IRQ once.  It's just more abstraction
> > for the sake of it.  I would prefer if you removed them.
>=20
> Yes, but in the charger driver for example, there are 4 IRQs to reque=
st. If
> I don't use this approach the IRQ requesting becomes bloated, hence w=
hy I went
> for a common function like this. Thought generally the intention was =
to cut
> down on repeated code?

If you're worried about bloat in .probe() it's okay to define a new
function within the charger driver; however, creating a call-back into
the MFD driver like this I think it over-kill for 4 requests.

> > > > > +void da9150_release_irq(struct platform_device *pdev, void *=
dev_id,
> > > > > +		       const char *name)
> > > > > +{
> > > > > +	int irq;
> > > > > +
> > > > > +	irq =3D platform_get_irq_byname(pdev, name);
> > > > > +	if (irq < 0)
> > > > > +		return;
> > > > > +
> > > > > +	devm_free_irq(&pdev->dev, irq, dev_id);
> > > > > +}
> > > > > +EXPORT_SYMBOL_GPL(da9150_release_irq);
> > > >
> > > > Do you ever release the IRQ and not unbind the driver?
> > > >
> > > > Are there ordering issues at play here?
> > > >
> > > > If not, there's no need to conduct a manual free.
> > >
> > > In the charger driver, in the remove function there is a need I b=
elieve to
> > > free the IRQs before other items are cleared up (e.g. power_suppl=
y classes),
> > > so this is why I have added this in here.
> >=20
> > Can you handle this separately in the Charger driver then please?
> >=20
> > [...]
>=20
> If I have to remove the IRQ register function, then yes, otherwise it=
 makes more
> sense to have the pair of functions in the MFD core I would say.

I would prefer you to remove the call-back please.

> > > > > +	if (pdata)
> > > > > +		da9150->irq_base =3D pdata->irq_base;
> > > > > +	else
> > > > > +		da9150->irq_base =3D -1;
> > > >
> > > > pdata ? pdata->irq_base : -1;
> > >
> > > This is left this way as later updates to add additional function=
ality will
> > > require addtional work to be done with the platform data. Seemed =
pointless
> > > changing it here just to change it back later.
> >=20
> > You're not changing anything, as this is the introduction of the co=
de.
> > I can't tell you how many times I've heard "I will change it later"=
,
> > or "doing it this way will support subsequent submissions", then
> > received no more patches.  It's okay to do it nicely now and expand
> > it back out in the new patches.
> >=20
> > [...]
>=20
> It appears that way to you but I have to modify my code for sumbissio=
n as the
> local code I have covers all functionality. Am having to refactor aga=
in and
> again just to suit this initial submission, and then I have to revert=
 it back
> again when submitting the last couple of drivers. Time consuming, and=
 quite
> frustrating when the intention was to make the whole process easier. =
Anyway,
> will update for now and revert in subsequent patches.

I sincerely hope the refactorings won't add too much effort, but it's
difficult to have one rule for the masses and different ones for
others.

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
