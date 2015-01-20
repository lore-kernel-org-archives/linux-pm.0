From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [RFC PATCHv2 07/19] mfd: ab8500: Use power_supply_*() API for
 accessing function attrs
Date: Tue, 20 Jan 2015 15:51:49 +0000
Message-ID: <20150120155149.GG13701@x1>
References: <1420472882-10463-1-git-send-email-k.kozlowski@samsung.com>
 <1420472882-10463-8-git-send-email-k.kozlowski@samsung.com>
 <20150120133617.GG13701@x1>
 <1421763376.8855.4.camel@AMDC1943>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ig0-f172.google.com ([209.85.213.172]:41530 "EHLO
	mail-ig0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751617AbbATPwB (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 20 Jan 2015 10:52:01 -0500
Received: by mail-ig0-f172.google.com with SMTP id l13so17733500iga.5
        for <linux-pm@vger.kernel.org>; Tue, 20 Jan 2015 07:52:00 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1421763376.8855.4.camel@AMDC1943>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Pavel Machek <pavel@ucw.cz>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org

On Tue, 20 Jan 2015, Krzysztof Kozlowski wrote:

> On wto, 2015-01-20 at 13:36 +0000, Lee Jones wrote:
> > On Mon, 05 Jan 2015, Krzysztof Kozlowski wrote:
> >=20
> > > Replace direct calls to power supply function attributes with wra=
ppers.
> > > Wrappers provide safe access in case of unregistering the power
> > > supply (e.g. by removing the driver). Replace:
> > >  - get_property -> power_supply_get_property
> > >=20
> > > Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> > > Acked-by: Jonghwa Lee <jonghwa3.lee@samusng.com>
> > > Acked-by: Pavel Machek <pavel@ucw.cz>
> > > Acked-by: Lee Jones <lee.jones@linaro.org>
> >=20
> > You've sent this to me already Acked.  I don't see 00/00, so I have=
 no
> > idea what's going on.  Do you want me to take this patch?  Can it b=
e
> > taking on its own?
>=20
> git send-email automatically CC-you because you acked this. The depen=
ds
> on previous patches adding this API so please do not pick it up.=20

You should always send MFD related patches to me (either
automatically, or manually).

> Everything (with respective acks) should go through one power supply
> tree.

That's not how it works.  We need to decide that amongst ourselves
and it needs to culminate in pull-requests being sent out to all of
the effected Maintainers.

> The same applies to patch 18/19.
>=20
> Best regards,
> Krzysztof
>=20
> >=20
> > > ---
> > >  drivers/mfd/ab8500-sysctrl.c | 7 ++++---
> > >  1 file changed, 4 insertions(+), 3 deletions(-)
> > >=20
> > > diff --git a/drivers/mfd/ab8500-sysctrl.c b/drivers/mfd/ab8500-sy=
sctrl.c
> > > index cfff0b643f1b..d4a4b24be7c6 100644
> > > --- a/drivers/mfd/ab8500-sysctrl.c
> > > +++ b/drivers/mfd/ab8500-sysctrl.c
> > > @@ -49,7 +49,8 @@ static void ab8500_power_off(void)
> > >  		if (!psy)
> > >  			continue;
> > > =20
> > > -		ret =3D psy->get_property(psy, POWER_SUPPLY_PROP_ONLINE, &val)=
;
> > > +		ret =3D power_supply_get_property(psy, POWER_SUPPLY_PROP_ONLIN=
E,
> > > +				&val);
> > > =20
> > >  		if (!ret && val.intval) {
> > >  			charger_present =3D true;
> > > @@ -63,8 +64,8 @@ static void ab8500_power_off(void)
> > >  	/* Check if battery is known */
> > >  	psy =3D power_supply_get_by_name("ab8500_btemp");
> > >  	if (psy) {
> > > -		ret =3D psy->get_property(psy, POWER_SUPPLY_PROP_TECHNOLOGY,
> > > -					&val);
> > > +		ret =3D power_supply_get_property(psy,
> > > +				POWER_SUPPLY_PROP_TECHNOLOGY, &val);
> > >  		if (!ret && val.intval !=3D POWER_SUPPLY_TECHNOLOGY_UNKNOWN) {
> > >  			printk(KERN_INFO
> > >  			       "Charger \"%s\" is connected with known battery."
> >=20
>=20

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
