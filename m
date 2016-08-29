From: Paul Kocialkowski <contact-W9ppeneeCTY@public.gmane.org>
Subject: Re: [PATCH 1/2] power: bq24735-charger: Request status GPIO with
 initial input setup
Date: Mon, 29 Aug 2016 20:13:22 +0200
Message-ID: <1472494402.9437.0.camel@paulk.fr>
References: <20160828173446.32728-1-contact@paulk.fr>
         <20160829003652.hs4tk7qmvu25mqhb@earth>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-ZFxaxzL7tjV8A9m8C1r7"
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20160829003652.hs4tk7qmvu25mqhb@earth>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Dmitry Eremin-Solenikov <dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org


--=-ZFxaxzL7tjV8A9m8C1r7
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le lundi 29 ao=C3=BBt 2016 =C3=A0 02:36 +0200, Sebastian Reichel a =C3=A9cr=
it=C2=A0:
> Hi,
>=20
> On Sun, Aug 28, 2016 at 07:34:45PM +0200, Paul Kocialkowski wrote:
> >=20
> > This requests the status GPIO with initial input setup. it is required
> > to read the GPIO status at probe time and thus correctly avoid sending
> > i2c messages when AC is not plugged.
> >=20
> > When requesting the GPIO without initial input setup, it always reads 0
> > which causes probe to fail as it assumes the charger is connected, send=
s
> > i2c messages and fails.
>=20
> Please convert the driver to devm_gpiod_get instead.

Sure thing, see v2.

Thanks!

--=20
Paul Kocialkowski, developer of low-level free software for embedded device=
s

Website: https://www.paulk.fr/
Coding blog: https://code.paulk.fr/
Git repositories: https://git.paulk.fr/ https://git.code.paulk.fr/
--=-ZFxaxzL7tjV8A9m8C1r7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIcBAABCAAGBQJXxHtEAAoJEIT9weqP7pUMPZAP/1USiUwkbd9qF7KuGJcbjvxZ
pwLtZ7SRnHNPIuO9IL4h5CcsFqh1dXtJFL+lrZn/fMS7LNKn4KHYK9qLuq3zEQ15
QiQv4bAtJwTZjZ/TFd+gWigZLkKo170bzz2Pi/HZyziiin7ZWIOZppM3SkhdBNIP
hSORWchUvw3+DQdL0Ix+MvzWKZTVG37VQRmZnAXRc/Pyr/v0WFLESJH+oksdl+j5
s/PplLITI9EGqo975MKp9Yz2VyNlI+7800avQ5WwzsKZGu45wD8JSJWSyWGi0eTY
e8UwZ95+mcqhUk08oQg1VYZIWddg0JE+AZoB4RBcJJPbThWjtcgM6IS/FFo/iXpS
GE2TYeKnerpYRFPITQRIltrtQQwG+6mj+0hU3pY2Uil3rn+9e5m1onnkkkZi4AWf
J+uiS+QSFDpFsZy6Pu58KbxCKsEmni7LqLhYFa2SBL/6p182ZFtWQiFzuSKCSB7K
J48Wuw3umKQUlLFoteoNumNaFcXFw4v6JwMCNI6QJKjkThszszF6US+rmULRrqCT
iOsO867N5z5YWV4Ft5XXrubG8O2A8p6YqFV6NCYWzG8B/i0Yi6T8UDRDO6ys7Q4f
F/oJecn7DUk+WEt2I1jrILpbCTcCZ4brfjmu3tTFM6KBYzB2cS+9/gqp1B/Dyhtg
NqXEtMZNC4XXruPIKwkA
=H82t
-----END PGP SIGNATURE-----

--=-ZFxaxzL7tjV8A9m8C1r7--
