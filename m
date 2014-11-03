From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 7/7] mfd: ab8500: Decrement the power supply's device
 reference counter
Date: Mon, 3 Nov 2014 18:00:59 +0000
Message-ID: <20141103180059.GW12011@x1>
References: <1413290117-13082-1-git-send-email-k.kozlowski@samsung.com>
 <1413290117-13082-8-git-send-email-k.kozlowski@samsung.com>
 <20141103175945.GV12011@x1>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20141103175945.GV12011@x1>
Sender: linux-kernel-owner@vger.kernel.org
To: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, Linus Walleij <linus.walleij@linaro.org>, Samuel Ortiz <sameo@linux.intel.com>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Lv Zheng <lv.zheng@intel.com>, Bjorn Helgaas <bhelgaas@google.com>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, Anton Vorontsov <anton@enomsg.org>, Pavel Machek <pavel@ucw.cz>, Kyungmin Park <kyungmin.park@samsung.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
List-Id: linux-pm@vger.kernel.org

On Mon, 03 Nov 2014, Lee Jones wrote:

> On Tue, 14 Oct 2014, Krzysztof Kozlowski wrote:
>=20
> > Use power_supply_put() to decrement the power supply's device refer=
ence
> > counter.
> >=20
> > Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> > ---
> >  drivers/mfd/ab8500-sysctrl.c | 2 ++
> >  1 file changed, 2 insertions(+)
>=20
> Applied, thanks.

Whoops, to hasty there -- unapplied.

What's going on with this set?

> > diff --git a/drivers/mfd/ab8500-sysctrl.c b/drivers/mfd/ab8500-sysc=
trl.c
> > index 93b2d2c32ca3..d05a5719cfc4 100644
> > --- a/drivers/mfd/ab8500-sysctrl.c
> > +++ b/drivers/mfd/ab8500-sysctrl.c
> > @@ -51,6 +51,7 @@ static void ab8500_power_off(void)
> > =20
> >  		ret =3D power_supply_get_property(psy, POWER_SUPPLY_PROP_ONLINE,
> >  				&val);
> > +		power_supply_put(psy);
> > =20
> >  		if (!ret && val.intval) {
> >  			charger_present =3D true;
> > @@ -73,6 +74,7 @@ static void ab8500_power_off(void)
> >  			       pss[i]);
> >  			machine_restart("charging");
> >  		}
> > +		power_supply_put(psy);
> >  	}
> > =20
> >  shutdown:
>=20

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
