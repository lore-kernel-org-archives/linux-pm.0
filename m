From: Paul Kocialkowski <contact@paulk.fr>
Subject: Re: [PATCH v4] power: bq24735-charger: Request status GPIO with
 initial input setup
Date: Mon, 05 Sep 2016 14:22:48 +0200
Message-ID: <1473078168.1041.2.camel@paulk.fr>
References: <20160902220953.28995-1-contact@paulk.fr>
         <20160905110846.5ersy47jbozzgldj@earth>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-n8EkLXe6TGehPdGxKH+Q"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from gagarine.paulk.fr ([109.190.93.129]:58853 "EHLO
        gagarine.paulk.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753671AbcIEMXJ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 5 Sep 2016 08:23:09 -0400
In-Reply-To: <20160905110846.5ersy47jbozzgldj@earth>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>


--=-n8EkLXe6TGehPdGxKH+Q
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

Le lundi 05 septembre 2016 =C3=A0 13:08 +0200, Sebastian Reichel a =C3=A9cr=
it=C2=A0:
> Hi Paul,
>=20
> On Sat, Sep 03, 2016 at 12:09:53AM +0200, Paul Kocialkowski wrote:
> >=20
> > This requests the status GPIO with initial input setup. it is required
> > to read the GPIO status at probe time and thus correctly avoid sending
> > i2c messages when AC is not plugged.
> >=20
> > When requesting the GPIO without initial input setup, it always reads 0
> > which causes probe to fail as it assumes the charger is connected, send=
s
> > i2c messages and fails.
> >=20
> > While at it, this switches the driver over to gpio consumer.
> >=20
> > Signed-off-by: Paul Kocialkowski <contact@paulk.fr>
> > ---
> > =C2=A0drivers/power/supply/bq24735-charger.c | 44 +++++++++++++--------=
--------
> > -----
> > =C2=A0include/linux/power/bq24735-charger.h=C2=A0=C2=A0|=C2=A0=C2=A04 -=
---
> > =C2=A02 files changed, 16 insertions(+), 32 deletions(-)
> >=20
> > diff --git a/drivers/power/supply/bq24735-charger.c
> > b/drivers/power/supply/bq24735-charger.c
>=20
> [...]
>=20
> >=20
> > -	if (IS_ENABLED(CONFIG_OF) && !charger->pdata && client-
> > >dev.of_node)
> > +	if (IS_ENABLED(CONFIG_OF) && !charger->pdata && client-
> > >dev.of_node) {
> > =C2=A0		charger->pdata =3D bq24735_parse_dt_data(client);
> > +		if (IS_ERR(charger->pdata))
> > +			return PTR_ERR(charger->pdata);
> > +	}
>=20
> I queued your patch into power-supply's for-next branch, but dropped
> this change, which is from an earlier revision of this patch and no
> longer needed. Thanks for your patch.

Damn, I forgot to clean that up. Good spotting, thanks!

--=20
Paul Kocialkowski, developer of low-level free software for embedded device=
s

Website: https://www.paulk.fr/
Coding blog: https://code.paulk.fr/
Git repositories: https://git.paulk.fr/ https://git.code.paulk.fr/
--=-n8EkLXe6TGehPdGxKH+Q
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIcBAABCAAGBQJXzWOZAAoJEIT9weqP7pUMUs4P/RTP+2CYmTlTONSiJ1049KTD
dvJ369Fej1FXbBUob4124ZgfLZAybhjfEMi+186Sw5xQksUFuGw647HA4lG/CWiP
CX2cXxpoQg9pYeGXq+N7ymC+PVO+z+SL1QGCCxlTsDodH7CwZohsdRDoLtH6oLaw
88uZuPQwf4r5QyXTzOVcnAMLp0OQWhDNhoJ+6BUEC+nps1qyBl5hlBld1dMOnSVN
X2MMUYAW+fXQ7kWlZdkz/GXrnydPmoN7GpYiixPp9/wuH9ehmAkvhD5sy4wKOo3D
DhOuwkzpp5OrKRieea8gMBtI8dKnZvZzG9BVRyHXBY+T64T9R6E45oOaXOfPJioc
PdQpHmEIfzwmNyK72WH59WaPtv/x6ZaQJmYqIOylXTL5tS3tTAYhofLJlFsteaXQ
qd0NPXWGtl77tIeDTfbAd52Exu85KM3xv0LenwzZuD4StN9Xam7cc5i/fFmpmrw7
mvsh0LaSra32/bBTF3BaRIrC97mY4+9PMYVkYjQckQRd5HFCBGxGDG9r4Aq7VLor
XLGGsokobGyWYZBiF0sC1960MiaFjbfOM67Oo4g1U/u2PcNQ9cPWqmPS9R55TjKd
UEYYzUvo+mZDDEq38ozLB3JixOczzgK2I2fNP7/fKJEAEZKvzreCmOHMWa4MpNWi
BaZfhaj+yKKOraT1x43m
=BVOj
-----END PGP SIGNATURE-----

--=-n8EkLXe6TGehPdGxKH+Q--

