From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v2 8/8] mfd: Add support for Intel Sunrisepoint LPSS
 devices
Date: Fri, 29 May 2015 13:03:15 +0300
Message-ID: <1432893795.26331.21.camel@linux.intel.com>
References: <1432570172-86963-1-git-send-email-andriy.shevchenko@linux.intel.com>
	 <1432570172-86963-9-git-send-email-andriy.shevchenko@linux.intel.com>
	 <20150527102241.GC11677@x1> <1432811843.26331.18.camel@linux.intel.com>
	 <20150528131051.GR11677@x1>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <20150528131051.GR11677@x1>
Sender: linux-acpi-owner@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Vinod Koul <vinod.koul@intel.com>, Andrew Morton <akpm@linux-foundation.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, Heikki Krogerus <heikki.krogerus@linux.intel.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>
List-Id: linux-pm@vger.kernel.org

On Thu, 2015-05-28 at 14:10 +0100, Lee Jones wrote:
> On Thu, 28 May 2015, Andy Shevchenko wrote:
> > On Wed, 2015-05-27 at 11:22 +0100, Lee Jones wrote:
> > > On Mon, 25 May 2015, Andy Shevchenko wrote:

[]

> > > > +	intel_lpss_ltr_expose(lpss);
> > > > +
> > > > +	ret =3D intel_lpss_debugfs_add(lpss);
> > > > +	if (ret)
> > > > +		dev_warn(lpss->dev, "Failed to create debugfs entries\n");
> > > > +
> > > > +	if (intel_lpss_has_idma(lpss)) {
> > > > +		/*
> > > > +		 * Ensure the DMA driver is loaded before the host
> > > > +		 * controller device appears, so that the host controller
> > > > +		 * driver can request its DMA channels as early as
> > > > +		 * possible.
> > > > +		 *
> > > > +		 * If the DMA module is not there that's OK as well.
> > > > +		 */
> > > > +		intel_lpss_request_dma_module(LPSS_IDMA_DRIVER_NAME);
> > > > +
> > > > +		ret =3D mfd_add_devices(dev, lpss->devid, lpss->devs, 2,
> > > > +				      info->mem, info->irq, NULL);
> > > > +	} else {
> > > > +		ret =3D mfd_add_devices(dev, lpss->devid, lpss->devs + 1, 1,
> > > > +				      info->mem, info->irq, NULL);
> > > > +	}
> > >=20
> > > I'm still not happy with the mfd_cells being manipulated in this =
way,
> > > or with the duplication you have within them.  Why don't you plac=
e the
> > > IDMA device it its own mfd_cell, then:
> > >=20
> > > > +	if (intel_lpss_has_idma(lpss)) {
> > > > +		intel_lpss_request_dma_module(LPSS_IDMA_DRIVER_NAME);
> > > > +
> > > > +		ret =3D mfd_add_devices(dev, TBC, idma_dev, ARRAY_SIZE(idma_=
dev),
> > > > +				      info->mem, info->irq, NULL);
> > > > +             /* Error check */
> > > > +	}
> > > > +
> > > > +	ret =3D mfd_add_devices(dev, TBC, proto_dev, ARRAY_SIZE(proto=
_dev),
> > > > +				      info->mem, info->irq, NULL);
> >=20
> > Would be nicer to export mfd_add_device() in that case?
>=20
> What do you mean by export?  What's wrong with using this code
> segment?

I took a closer look into this, indeed, we can call mfd_add_devices() a=
s
many time as we want to add a new child device.

Will refactor this piece of code.

> > > > +#ifdef CONFIG_PM_SLEEP
> > > > +#define INTEL_LPSS_SLEEP_PM_OPS			\
> > > > +	.prepare =3D intel_lpss_prepare,		\
> > > > +	.suspend =3D intel_lpss_suspend,		\
> > > > +	.resume =3D intel_lpss_resume,		\
> > > > +	.freeze =3D intel_lpss_suspend,		\
> > > > +	.thaw =3D intel_lpss_resume,		\
> > > > +	.poweroff =3D intel_lpss_suspend,		\
> > > > +	.restore =3D intel_lpss_resume,
> > > > +#endif
> > > > +
> > > > +#define INTEL_LPSS_RUNTIME_PM_OPS		\
> > > > +	.runtime_suspend =3D intel_lpss_suspend,	\
> > > > +	.runtime_resume =3D intel_lpss_resume,
> > > > +
> > > > +#else /* !CONFIG_PM */
> > > > +#define INTEL_LPSS_SLEEP_PM_OPS
> > > > +#define INTEL_LPSS_RUNTIME_PM_OPS
> > > > +#endif /* CONFIG_PM */
> > > > +
> > > > +#define INTEL_LPSS_PM_OPS(name)			\
> > > > +const struct dev_pm_ops name =3D {		\
> > > > +	INTEL_LPSS_SLEEP_PM_OPS			\
> > > > +	INTEL_LPSS_RUNTIME_PM_OPS		\
> >=20
> > > If you _really_ need .prepare, then it's likely that some other
> > > platform might too.  It will be the same amount of code to just m=
ake
> > > this generic, so do that instead please.
> >=20
> > In 'linux/pm.h' ->prepare() is excluded since it's quite exotic to =
be=20
> > in device drivers. That is my understanding why it makes not much s=
ense
> > to provide a generic definition for that.
> >=20
> > $ git grep -n '\.prepare[ \t]*=3D.*pm' drivers/ | wc -l
> > 33
> > $ git grep -n SET_SYSTEM_SLEEP_PM_OPS drivers/ | wc -l
> > 114
> > $ git grep -n UNIVERSAL_DEV_PM_OPS drivers/ | wc -l
> > 9
> > =E2=80=A6and there are a lot of drivers (hundreds+) that do
> > not use mentioned macros, and has no ->prepare() callback defined.
> >=20
> > I can try to summon up Rafael to clarify this.
>=20
> Yes, let's do that, as I'd like a second opinion on this, thanks.

Rafael, it would be nice to have your input here.

--=20
Andy Shevchenko <andriy.shevchenko@intel.com>
Intel Finland Oy

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
