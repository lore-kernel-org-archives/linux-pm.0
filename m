From: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2 1/7] mfd: Add support for DA9150 combined charger &
 fuel-gauge device
Date: Tue, 16 Sep 2014 15:07:40 -0700
Message-ID: <20140916220740.GQ25162@lee--X1>
References: <cover.1409145187.git.Adam.Thomson.Opensource@diasemi.com>
 <d6c7de200c9447dbafa74ee76739da943a0b73b2.1409145187.git.Adam.Thomson.Opensource@diasemi.com>
 <20140828163608.GY24579@lee--X1>
 <2E89032DDAA8B9408CB92943514A0337AB5144CE@SW-EX-MBX01.diasemi.com>
 <20140910094951.GN30307@lee--X1>
 <2E89032DDAA8B9408CB92943514A0337AB514846@SW-EX-MBX01.diasemi.com>
 <20140915223924.GC25162@lee--X1>
 <2E89032DDAA8B9408CB92943514A0337AB514E7C@SW-EX-MBX01.diasemi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <2E89032DDAA8B9408CB92943514A0337AB514E7C-68WUHU125fLLPO1uwJ3ImwLouzNaz+3S@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Opensource [Adam Thomson]" <Adam.Thomson.Opensource-WBD+wuPFNBhBDgjK7y7TUQ@public.gmane.org>
Cc: Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Dmitry Eremin-Solenikov <dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, "linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, Joe Perches <joe-6d6DIl74uiNBDgjK7y7TUQ@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Support Opensource <Support.Opensource-WBD+wuPFNBhBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

On Tue, 16 Sep 2014, Opensource [Adam Thomson] wrote:

> On September 15, 2014 23:39, Lee Jones wrote:
>=20
> > On Wed, 10 Sep 2014, Opensource [Adam Thomson] wrote:
> > > On September 10, 2014 10:50, Lee Jones wrote:
> > > > On Tue, 09 Sep 2014, Opensource [Adam Thomson] wrote:
> > > >
> > > > > On August 28, 2014 17:36, Lee Jones wrote:
> > > > >
> > > > > Thanks for the feedback. As a general comment a couple of the=
 items you've
> > > > > identified relate to future updates (additional functionality=
 being added).
> > > > > I already have code in place for this but have stripped out a=
 couple of the
> > > > > drivers just to reduce the churn and size of patch submission=
=2E These will be
> > > > > added once these patches have been accepted.
> > > > >
> > > > > Where this is the case, I have added notes in-line against th=
e relevant
> > > > > comments you made.
> > > > >
> > > > > > On Thu, 28 Aug 2014, Adam Thomson wrote:
> > > > > >
> > > > > > > DA9150 is a combined Charger and Fuel-Gauge IC, with addi=
tional
> > > > > > > GPIO and GPADC functionality.
> > > > > > >
> > > > > > > Signed-off-by: Adam Thomson
> > <Adam.Thomson.Opensource-WBD+wuPFNBhBDgjK7y7TUQ@public.gmane.org>
> > > > > > > ---
> > > > > > >  drivers/mfd/Kconfig                  |   12 +
> > > > > > >  drivers/mfd/Makefile                 |    2 +
> > > > > > >  drivers/mfd/da9150-core.c            |  332 ++++++++++
> > > > > > >  drivers/mfd/da9150-i2c.c             |  176 ++++++
> >=20
> > [...]
> >=20
> > > > > > > +/* Helper functions for sub-devices to request/free IRQs=
 */
> > > > > > > +int da9150_register_irq(struct platform_device *pdev, vo=
id *dev_id,
> > > > > > > +			irq_handler_t handler, const char *name)
> > > > > > > +{
> > > > > > > +	int irq, ret;
> > > > > > > +
> > > > > > > +	irq =3D platform_get_irq_byname(pdev, name);
> > > > > > > +	if (irq < 0)
> > > > > > > +		return irq;
> > > > > > > +
> > > > > > > +	ret =3D devm_request_threaded_irq(&pdev->dev, irq, NULL=
, handler,
> > > > > > > +					IRQF_ONESHOT, name, dev_id);
> > > > > > > +	if (ret)
> > > > > > > +		dev_err(&pdev->dev, "Failed to request IRQ %d: %d\n", =
irq,
> > ret);
> > > > > > > +
> > > > > > > +	return ret;
> > > > > > > +}
> > > > > > > +EXPORT_SYMBOL_GPL(da9150_register_irq);
> > > > > >
> > > > > > Why do they need help?  What problem does adding these laye=
rs solve?
> > > > >
> > > > > Means I don't have to keep adding print error lines everywher=
e else if this
> > > > > function takes care of it. Thought that would be cleaner.
> > > >
> > > > You only need to request each IRQ once.  It's just more abstrac=
tion
> > > > for the sake of it.  I would prefer if you removed them.
> > >
> > > Yes, but in the charger driver for example, there are 4 IRQs to r=
equest. If
> > > I don't use this approach the IRQ requesting becomes bloated, hen=
ce why I went
> > > for a common function like this. Thought generally the intention =
was to cut
> > > down on repeated code?
> >=20
> > If you're worried about bloat in .probe() it's okay to define a new
> > function within the charger driver; however, creating a call-back i=
nto
> > the MFD driver like this I think it over-kill for 4 requests.
>=20
> I could do something just in the charger, but why not have something =
which can
> be used for all sub-devices? There is also an IRQ used in the IIO ADC=
 driver and
> there will be another in the later fuel-gauge driver too. Doesn't mak=
e sense to
> me not to do in the MFD code when that will provide a simple common c=
all for all
> sub-devices. What is your concern with adding something like this, ju=
st so I'm
> clear?

I guess my last response wasn't as descriptive as it could have been.
I don't think that any helper function is required at all.  No need to
abstract/obfuscate how the IRQ is obtained and registered.  What I
meant by 'do it in the charger driver' was, copy and paste all of the
platform_get_irq_byname() and devm_request_threaded_irq() calls from
=2Eprobe() into a separate function, but only if you are worried about =
a
bloated .probe().  Personally I'd just leave them in there.

Bottom line is; I don't feel there is a necessity for any helper
function here.  I think it adds unnecessary complexity for the sake of
saving a few lines of code.

If you still think there is a requirement for it, perhaps a more
system-wide devm_request_threaded_irq_byname() is in order instead?

> > > > > > > +void da9150_release_irq(struct platform_device *pdev, vo=
id *dev_id,
> > > > > > > +		       const char *name)
> > > > > > > +{
> > > > > > > +	int irq;
> > > > > > > +
> > > > > > > +	irq =3D platform_get_irq_byname(pdev, name);
> > > > > > > +	if (irq < 0)
> > > > > > > +		return;
> > > > > > > +
> > > > > > > +	devm_free_irq(&pdev->dev, irq, dev_id);
> > > > > > > +}
> > > > > > > +EXPORT_SYMBOL_GPL(da9150_release_irq);
> > > > > >
> > > > > > Do you ever release the IRQ and not unbind the driver?
> > > > > >
> > > > > > Are there ordering issues at play here?
> > > > > >
> > > > > > If not, there's no need to conduct a manual free.
> > > > >
> > > > > In the charger driver, in the remove function there is a need=
 I believe to
> > > > > free the IRQs before other items are cleared up (e.g. power_s=
upply classes),
> > > > > so this is why I have added this in here.
> > > >
> > > > Can you handle this separately in the Charger driver then pleas=
e?
> > > >
> > > > [...]
> > >
> > > If I have to remove the IRQ register function, then yes, otherwis=
e it makes more
> > > sense to have the pair of functions in the MFD core I would say.
> >=20
> > I would prefer you to remove the call-back please.
>=20
> Right.
>=20
> >=20
> > > > > > > +	if (pdata)
> > > > > > > +		da9150->irq_base =3D pdata->irq_base;
> > > > > > > +	else
> > > > > > > +		da9150->irq_base =3D -1;
> > > > > >
> > > > > > pdata ? pdata->irq_base : -1;
> > > > >
> > > > > This is left this way as later updates to add additional func=
tionality will
> > > > > require addtional work to be done with the platform data. See=
med pointless
> > > > > changing it here just to change it back later.
> > > >
> > > > You're not changing anything, as this is the introduction of th=
e code.
> > > > I can't tell you how many times I've heard "I will change it la=
ter",
> > > > or "doing it this way will support subsequent submissions", the=
n
> > > > received no more patches.  It's okay to do it nicely now and ex=
pand
> > > > it back out in the new patches.
> > > >
> > > > [...]
> > >
> > > It appears that way to you but I have to modify my code for sumbi=
ssion as the
> > > local code I have covers all functionality. Am having to refactor=
 again and
> > > again just to suit this initial submission, and then I have to re=
vert it back
> > > again when submitting the last couple of drivers. Time consuming,=
 and quite
> > > frustrating when the intention was to make the whole process easi=
er. Anyway,
> > > will update for now and revert in subsequent patches.
> >=20
> > I sincerely hope the refactorings won't add too much effort, but it=
's
> > difficult to have one rule for the masses and different ones for
> > others.
>=20
> I do understand that, and that's fair enough. Is just frustrating whe=
n you're
> trying to do a proper job. Anyway, am sure I'll live. :)

I know how you feel, as I've been on the receiving end of such rules
more than once, but you could have probably re-factored twice in the
time it's taken us to have this conversation. :)

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
--
To unsubscribe from this list: send the line "unsubscribe devicetree" i=
n
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
