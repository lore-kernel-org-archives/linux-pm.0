From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v2 7/7] mfd: ab8500: Decrement the power supply's device
 reference counter
Date: Fri, 17 Oct 2014 09:50:08 +0200
Message-ID: <20141017075008.GC22725@lee--X1>
References: <1413445327-24862-1-git-send-email-k.kozlowski@samsung.com>
 <1413445327-24862-8-git-send-email-k.kozlowski@samsung.com>
 <20141016122901.GA22725@lee--X1>
 <1413463274.18828.1.camel@AMDC1943>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f176.google.com ([209.85.212.176]:44619 "EHLO
	mail-wi0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753385AbaJQHuO (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 17 Oct 2014 03:50:14 -0400
Received: by mail-wi0-f176.google.com with SMTP id hi2so1318598wib.9
        for <linux-pm@vger.kernel.org>; Fri, 17 Oct 2014 00:50:13 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1413463274.18828.1.camel@AMDC1943>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, Linus Walleij <linus.walleij@linaro.org>, Samuel Ortiz <sameo@linux.intel.com>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Lv Zheng <lv.zheng@intel.com>, Bjorn Helgaas <bhelgaas@google.com>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, Anton Vorontsov <anton@enomsg.org>, Pavel Machek <pavel@ucw.cz>, Kyungmin Park <kyungmin.park@samsung.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

On Thu, 16 Oct 2014, Krzysztof Kozlowski wrote:

> On czw, 2014-10-16 at 14:29 +0200, Lee Jones wrote:
> > On Thu, 16 Oct 2014, Krzysztof Kozlowski wrote:
> >=20
> > > Use power_supply_put() to decrement the power supply's device ref=
erence
> > > counter.
> > >=20
> > > Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> > > Acked-by: Pavel Machek <pavel@ucw.cz>
> >=20
> > I already Acked this.
>=20
> I think you acked mfd change in my first patchset
> (power_supply_get_property()):
> 	[PATCH 5/8] mfd: ab8500: Use power_supply_*() API for accessing
> function attrs
>=20
> ... and this is my second patchset with other API (power_supply_put).

Maybe my reply wasn't sent properly (the WiFi at this conference has
been pretty shakey at points).

Anyway ... Acked-by: Lee Jones <lee.jones@linaro.org>

> > > ---
> > >  drivers/mfd/ab8500-sysctrl.c | 2 ++
> > >  1 file changed, 2 insertions(+)
> > >=20
> > > diff --git a/drivers/mfd/ab8500-sysctrl.c b/drivers/mfd/ab8500-sy=
sctrl.c
> > > index 93b2d2c32ca3..d05a5719cfc4 100644
> > > --- a/drivers/mfd/ab8500-sysctrl.c
> > > +++ b/drivers/mfd/ab8500-sysctrl.c
> > > @@ -51,6 +51,7 @@ static void ab8500_power_off(void)
> > > =20
> > >  		ret =3D power_supply_get_property(psy, POWER_SUPPLY_PROP_ONLIN=
E,
> > >  				&val);
> > > +		power_supply_put(psy);
> > > =20
> > >  		if (!ret && val.intval) {
> > >  			charger_present =3D true;
> > > @@ -73,6 +74,7 @@ static void ab8500_power_off(void)
> > >  			       pss[i]);
> > >  			machine_restart("charging");
> > >  		}
> > > +		power_supply_put(psy);
> > >  	}
> > > =20
> > >  shutdown:
> >=20
>=20

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
