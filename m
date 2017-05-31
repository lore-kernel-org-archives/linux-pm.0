From: Paul Kocialkowski <contact@paulk.fr>
Subject: Re: [PATCH 5/5] power: supply: bq27xxx: Correct supply status with
 current draw
Date: Wed, 31 May 2017 18:55:19 +0200
Message-ID: <1496249719.1774.1.camel@paulk.fr>
References: <20170430182727.24412-1-contact@paulk.fr>
         <20170430182727.24412-5-contact@paulk.fr>
         <20170528191619.GA20159@xo-6d-61-c0.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-oY/8n/V4Fd3wwj5PNmMo"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170528191619.GA20159@xo-6d-61-c0.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Pali =?ISO-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>, "Andrew F . Davis" <afd@ti.com>, Sebastian Reichel <sre@kernel.org>, Chris Lapa <chris@lapa.com.au>, Matt Ranostay <mranostay@gmail.com>
List-Id: linux-pm@vger.kernel.org


--=-oY/8n/V4Fd3wwj5PNmMo
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

Le dimanche 28 mai 2017 =C3=A0 21:16 +0200, Pavel Machek a =C3=A9crit :
> Hi!
>=20
> > The status reported directly by the battery controller is not always
> > reliable and should be corrected based on the current draw information.
> >=20
> > This implements such a correction with a dedicated function, called
> > when retrieving the supply status.
> >=20
> > @@ -1182,6 +1196,8 @@ static int bq27xxx_battery_status(struct
> > bq27xxx_device_info *di,
> >  		else
> >  			status =3D POWER_SUPPLY_STATUS_DISCHARGING;
> >  	} else {
> > +		curr =3D (int)((s16)curr) * 1000;
>=20
> Umm.
>=20
> > @@ -1190,6 +1206,18 @@ static int bq27xxx_battery_status(struct
> > bq27xxx_device_info *di,
> >  			status =3D POWER_SUPPLY_STATUS_CHARGING;
> >  	}
> > =20
> > +
> > +	if (curr =3D=3D 0 && status !=3D POWER_SUPPLY_STATUS_NOT_CHARGING)
> > +		status =3D POWER_SUPPLY_STATUS_FULL;
> > +
> > +	if (status =3D=3D POWER_SUPPLY_STATUS_FULL) {
> > +		/* Drawing or providing current when full */
> > +		if (curr > 0)
> > +			status =3D POWER_SUPPLY_STATUS_CHARGING;
> > +		else if (curr < 0)
> > +			status =3D POWER_SUPPLY_STATUS_DISCHARGING;
> > +	}
>=20
> Are you sure this works? On N900, we normally see small currents to/from
> "full" battery.

In my case, this works perfectly and I am quite surprised of what you're
describing. Is it the case when the battery has a PSU connected?

I guess I would consider this a hardware issue (leak currents) and we could
definitely set some range (in device-tree) to distinguish between full + le=
ak
currents and bad reporting from the fuel gauge. That would work well in my =
case
too.

> Should the test be for absolute_value(curr) < something rather than for =
=3D=3D 0?
>=20
> What hw did you test it on?

I tested this on nyan Chromebooks (Acer Chromebook 13 and HP Chromebook 11)=
 as
well as veyron Chromebooks (Chromebook C201PA) that use a bq27xxx fuel gaug=
e.

Cheers!

--=20
Paul Kocialkowski, developer of free digital technology and hardware suppor=
t

Website: https://www.paulk.fr/
Coding blog: https://code.paulk.fr/
Git repositories: https://git.paulk.fr/ https://git.code.paulk.fr/
--=-oY/8n/V4Fd3wwj5PNmMo
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEAbcMXZQMtj1fphLChP3B6o/ulQwFAlku9XgACgkQhP3B6o/u
lQw9aA/+IhuQqBBz/Lh1qxBUCIsjL6THIunIJj/TLyYYZ1Qqd3MBYbAP6F/+R6Nm
0+/zTmSaZlhdrCgwq1QpmQGkdKHuxxhhplejZCRbc3rVDqzdvBWQOGdE7AdxWhWR
pwcmLcmqsxWQR1U+3YzUpWDRA1OxuwD+VcviABpItorI19yOhbIyLuCbgPSBSoiW
D8v+KJ7zvlk91/VxxYALmXQ43pbCViMsy5CdL5WfhxcBZyMCjnFoIu0Ufa2beCmi
Yn/MXzzdl7+iwC9edR1WbxO23ZnpA3W1ukUCt1BMBNvzUIbYqr5ZJsm3XNrj6aqw
fKZEY8G8UM0y+MXxfY/yLXP4MWUGgcgE2NqAS66rb/wlZwZqDbl5jdflV5Y41axG
WPDR2ZXMw8QjklplRw/96JoUZgn6tV9NwYVTXG3iansYb1YB8cI+BMLGNzZ2npyx
R2/XU41aZJRc2HSo3QpkZY+DhTbA+3LS9/QPygR1rbAd5WjJxu+SALG6lwFJiGFA
mNNDx4LQLx7XkrZMhY6m9IkeolxZmG4Ih2cQNwZ6c2naFamQ5kU1NNrZdvY8Shpd
YDgwChVaLJM+2g92KiEJ7uWTUnibZzTr1Mah9kvCgwXEVSoHUUgG//zMPMQ134JN
ykEH1ZJ2hWFwGDeoPOyd/xRyzMUL6U6wzq5RXXIvAjV4tRMM4pw=
=RzJB
-----END PGP SIGNATURE-----

--=-oY/8n/V4Fd3wwj5PNmMo--
