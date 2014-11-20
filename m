From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [PATCH 1/2] thermal: armada: Remove support for A375-Z1 SoC
Date: Thu, 20 Nov 2014 15:38:06 -0400
Message-ID: <20141120193804.GA7252@developer>
References: <1415116839-4323-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1415116839-4323-2-git-send-email-ezequiel.garcia@free-electrons.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="EVF5PPMfhYS0aIcm"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qc0-f182.google.com ([209.85.216.182]:51343 "EHLO
	mail-qc0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757268AbaKTTiJ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 20 Nov 2014 14:38:09 -0500
Received: by mail-qc0-f182.google.com with SMTP id r5so2715451qcx.27
        for <linux-pm@vger.kernel.org>; Thu, 20 Nov 2014 11:38:08 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1415116839-4323-2-git-send-email-ezequiel.garcia@free-electrons.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Cc: Zhang Rui <rui.zhang@intel.com>, Jason Cooper <jason@lakedaemon.net>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Gregory Clement <gregory.clement@free-electrons.com>, linux-pm@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, linux-arm-kernel@lists.infradead.org


--EVF5PPMfhYS0aIcm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Ezequiel and Jason,

On Sat, Nov 08, 2014 at 10:16:46PM -0500, Jason Cooper wrote:
> On Tue, Nov 04, 2014 at 01:00:38PM -0300, Ezequiel Garcia wrote:
> > The Armada 375 Z1 SoC revision is no longer supported. This commit
> > removes the quirk needed for the thermal sensor.
> >=20
> > Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
> > ---
> >  .../devicetree/bindings/thermal/armada-thermal.txt   |  8 --------
> >  drivers/thermal/armada_thermal.c                     | 20 ------------=
--------
> >  2 files changed, 28 deletions(-)
>=20
> As Thomas and Ezequiel rightfully mentioned, the compatible string below
> has never been in a dts file.  Our arch code detected the Z1, and
> changed the compatible on the fly.  As a result, there shouldn't be any
> dtbs in the wild with this compatible string.  If there are, it will be
> held by the few developers (Marvell, partners) that know what they are
> doing.

First of, I would like to mention that best thing to avoid such
situation is to be careful when documenting dt entries that represent hw
that no one has access to (except internal people).

>=20
> Acked-by: Jason Cooper <jason@lakedaemon.net>
>=20

OK Jason. I saw you picked patch 2. Does it mean I can queue this one?=20

BR,=20

Eduardo Valentin

> thx,
>=20
> Jason.
>=20
> > diff --git a/Documentation/devicetree/bindings/thermal/armada-thermal.t=
xt b/Documentation/devicetree/bindings/thermal/armada-thermal.txt
> > index 4cf0249..4698e0e 100644
> > --- a/Documentation/devicetree/bindings/thermal/armada-thermal.txt
> > +++ b/Documentation/devicetree/bindings/thermal/armada-thermal.txt
> > @@ -5,17 +5,9 @@ Required properties:
> >  - compatible:	Should be set to one of the following:
> >  		marvell,armada370-thermal
> >  		marvell,armada375-thermal
> > -		marvell,armada375-z1-thermal
> >  		marvell,armada380-thermal
> >  		marvell,armadaxp-thermal
> > =20
> > -		Note: As the name suggests, "marvell,armada375-z1-thermal"
> > -		applies for the SoC Z1 stepping only. On such stepping
> > -		some quirks need to be done and the register offset differs
> > -		from the one in the A0 stepping.
> > -		The operating system may auto-detect the SoC stepping and
> > -		update the compatible and register offsets at runtime.
> > -
> >  - reg:		Device's register space.
> >  		Two entries are expected, see the examples below.
> >  		The first one is required for the sensor register;
> > diff --git a/drivers/thermal/armada_thermal.c b/drivers/thermal/armada_=
thermal.c
> > index 9d1420a..9c8e783 100644
> > --- a/drivers/thermal/armada_thermal.c
> > +++ b/drivers/thermal/armada_thermal.c
> > @@ -35,10 +35,6 @@
> >  #define PMU_TDC0_OTF_CAL_MASK		(0x1 << 30)
> >  #define PMU_TDC0_START_CAL_MASK		(0x1 << 25)
> > =20
> > -#define A375_Z1_CAL_RESET_LSB		0x8011e214
> > -#define A375_Z1_CAL_RESET_MSB		0x30a88019
> > -#define A375_Z1_WORKAROUND_BIT		BIT(9)
> > -
> >  #define A375_UNIT_CONTROL_SHIFT		27
> >  #define A375_UNIT_CONTROL_MASK		0x7
> >  #define A375_READOUT_INVERT		BIT(15)
> > @@ -124,24 +120,12 @@ static void armada375_init_sensor(struct platform=
_device *pdev,
> >  				  struct armada_thermal_priv *priv)
> >  {
> >  	unsigned long reg;
> > -	bool quirk_needed =3D
> > -		!!of_device_is_compatible(pdev->dev.of_node,
> > -					  "marvell,armada375-z1-thermal");
> > -
> > -	if (quirk_needed) {
> > -		/* Ensure these registers have the default (reset) values */
> > -		writel(A375_Z1_CAL_RESET_LSB, priv->control);
> > -		writel(A375_Z1_CAL_RESET_MSB, priv->control + 0x4);
> > -	}
> > =20
> >  	reg =3D readl(priv->control + 4);
> >  	reg &=3D ~(A375_UNIT_CONTROL_MASK << A375_UNIT_CONTROL_SHIFT);
> >  	reg &=3D ~A375_READOUT_INVERT;
> >  	reg &=3D ~A375_HW_RESETn;
> > =20
> > -	if (quirk_needed)
> > -		reg |=3D A375_Z1_WORKAROUND_BIT;
> > -
> >  	writel(reg, priv->control + 4);
> >  	mdelay(20);
> > =20
> > @@ -260,10 +244,6 @@ static const struct of_device_id armada_thermal_id=
_table[] =3D {
> >  		.data       =3D &armada375_data,
> >  	},
> >  	{
> > -		.compatible =3D "marvell,armada375-z1-thermal",
> > -		.data       =3D &armada375_data,
> > -	},
> > -	{
> >  		.compatible =3D "marvell,armada380-thermal",
> >  		.data       =3D &armada380_data,
> >  	},
> > --=20
> > 2.1.0
> >=20
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pm" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--EVF5PPMfhYS0aIcm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUbkMcAAoJEMLUO4d9pOJWTyUH/AkYI54Y+i+R5GaI1dQp8kS3
4gnu7AAjSpNyQEQLaLWQ5fv/pg4YZfwShxrBjxSCnENXPWiLHEG6wDmBP877D6e8
74Pl3THzcApP1L6A+jd+VGvaHqkRsQQc4q+Bt8ATPxKLrYaVC5li+4GI53AFlHzn
hAr9HwLEuzh9C+gX101JVHZo0UvxZA/9YKEpJSLVnNG7TlvIIZEtIlI/De/WOO7C
uTVoofcTT4FJ+tWWSY/OPilD47FMB8MGdY1tgtbQcea5WGo1gs1DDZ4X6lKExVjB
GCpUQB2TRWf0op+8whvrsFHR+KVOCbJNnBbOZpy7SdmoGjGNluSTMjUWIOzy88w=
=StX+
-----END PGP SIGNATURE-----

--EVF5PPMfhYS0aIcm--
