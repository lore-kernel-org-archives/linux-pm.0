From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH 2/2] Add driver for MAX17211/MAX17215 fuel gauge
Date: Sun, 30 Apr 2017 22:44:08 +0200
Message-ID: <20170430204407.fmmtdb3yi33dkkks@earth>
References: <20170429143429.5685-1-minimumlaw@rambler.ru>
 <20170429143429.5685-3-minimumlaw@rambler.ru>
 <20170429164053.olynja4kyqpwhfpk@earth>
 <77d557e3-3ff3-de60-826c-b98937360d8c@rambler.ru>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="uwufflh3mzvktlbb"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:33470 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1166029AbdD3UoN (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sun, 30 Apr 2017 16:44:13 -0400
Content-Disposition: inline
In-Reply-To: <77d557e3-3ff3-de60-826c-b98937360d8c@rambler.ru>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: =?utf-8?B?0JzQuNGF0LDQudC70L7QsiDQkNC70LXQutGB0LXQuSDQkNC90LDRgtC+0Ls=?= =?utf-8?B?0YzQtdCy0LjRhw==?= <minimumlaw@rambler.ru>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, zbr@ioremap.net


--uwufflh3mzvktlbb
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sun, Apr 30, 2017 at 08:32:10PM +0300, =D0=9C=D0=B8=D1=85=D0=B0=D0=B9=D0=
=BB=D0=BE=D0=B2 =D0=90=D0=BB=D0=B5=D0=BA=D1=81=D0=B5=D0=B9 =D0=90=D0=BD=D0=
=B0=D1=82=D0=BE=D0=BB=D1=8C=D0=B5=D0=B2=D0=B8=D1=87 wrote:
> > IIRC we already had problems with small THERMAL_NAME_LENGTH before.
> > I suggest to add another patch, that increases THERMAL_NAME_LENGTH
> > (don't forget to Cc/To the thermal subsystem people).
> May be rename "max17211-battery" to "max17211" and remove no_thermal =3D =
true?
> This case thermal zone will work again. In current (mainline) kernel all
> drivers "xxxxxx-battery" (like ds2780-battery or ds2760-battery) compiled,
> but not working (not registered). They can start working again without
> thermal zone by adding no_thermal =3D true or by remove "-battery" from
> platform device name. Alternative limit on THERMAL_NAME_LENGTH may be
> extended.

I think increasing THERMAL_NAME_LENGTH is the right way.

> > > +	info->bat =3D power_supply_register(&pdev->dev, &info->bat_desc,
> > > +						&psy_cfg);
> > > +	if (IS_ERR(info->bat)) {
> > > +		dev_err(info->dev, "failed to register battery\n");
> > > +		return PTR_ERR(info->bat);
> > > +	}
> > Please use devm_power_supply_register() and drop the remove
> > function.
> Khm... probe/remove paired functions. I can use devm_power_supply_register
> in my code. But all other fuel gauge drivers use classic probe/remove pai=
r.
> Which decision will be more correct?

Most drivers are older than devm_power_supply_register. We already
have a few fuel gauge drivers, which use it, though:

$ git grep devm_power_supply_register | grep "battery"=20
88pm860x_battery.c:	info->battery =3D devm_power_supply_register(&pdev->dev,
da9150-fg.c:	fg->battery =3D devm_power_supply_register(dev, &fg_desc, NULL=
);
max17042_battery.c:	chip->battery =3D devm_power_supply_register(&client->d=
ev, max17042_desc,
max8997_charger.c:	charger->battery =3D devm_power_supply_register(&pdev->d=
ev,
max8998_charger.c:	max8998->battery =3D devm_power_supply_register(max8998-=
>dev,
sbs-battery.c:	chip->power_supply =3D devm_power_supply_register(&client->d=
ev, sbs_desc,

-- Sebastian

--uwufflh3mzvktlbb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlkGTJUACgkQ2O7X88g7
+pqenBAAmKnFA42LPnvvqkpph+H0+QsQ+XA1Lg1NImVB88p1DiXp+57qpOJ5GwKO
kRT+c8mSqBfars8l1CBiIqjLiJt3+wJII2gyHDtjY0LwYuetbjse/A6bDXOsqWfu
vZXOnG7jwCooslrp8891HFnwlKcW9V6T0p1bOoTFfy4WA3xXmL6EiryMwrfytrDe
UeSYwAet6c+PmqM3mpkileDy/j8ehVAA6cO8xkZMPek8qPQSTpJzxfdd3WPSRV0l
l2U/A1hh3pBY3pVGw8HwWbxrC3Ng3Jq6PfFPsU+nh7EYlS1L9JaPtitVw/LEz4zC
OtHnQdTELGeOuGUhdTVvOH+Ooyor9uLut28fGfHooeEfQqlf0mpIAr6dw/0SbyG2
hJQJcMGhkGd6GRCRef7Vvs3GlTsVTVgBewFUYsgCw2OI5DEVU8a2tlkVKxrmLLUh
1STyTlWht+Phqjk+gOXVNclP160qfmfJS++dWwd98aXLGQuXV7k15RD5xqml1Q2G
Eg2LSd0dObhuicres/W5h8zXbndsPgAnQ8kzOnn8fCKaukdZekhYSN4w9+3qfYTM
FGGTgARaf9pFbxv1CuxDvaN8/J1bN4ivbzHZa/hmx0PfE0NadumR06pCFcuFJTJq
ySjj2tz9NKiQ9Tk9w/RISFhnfJwDXiFxtuW6d8iiXkTlZiA5/qQ=
=gf8D
-----END PGP SIGNATURE-----

--uwufflh3mzvktlbb--
