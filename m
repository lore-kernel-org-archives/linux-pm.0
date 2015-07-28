From: Pali =?utf-8?q?Roh=C3=A1r?= <pali.rohar@gmail.com>
Subject: Re: [PATCH v2 2/6] power: bq27x00_battery: Renaming for consistency
Date: Tue, 28 Jul 2015 22:04:34 +0200
Message-ID: <201507282204.35083@pali>
References: <1438112353-19704-1-git-send-email-afd@ti.com> <1438112353-19704-3-git-send-email-afd@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart6204940.Ug7Ceyz1Zq";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1438112353-19704-3-git-send-email-afd@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Andrew F. Davis" <afd@ti.com>
Cc: Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Dan Murphy <dmurphy@ti.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

--nextPart6204940.Ug7Ceyz1Zq
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Tuesday 28 July 2015 21:39:09 Andrew F. Davis wrote:
> Rename functions that are used by multiple devices. New devices
> have been added and the function names and driver name are no longer
> general enough for the functionality they provide.
>=20
> Signed-off-by: Andrew F. Davis <afd@ti.com>

I see that you did not changed platform (HDQ) parts:

MODULE_ALIAS("platform:bq27000-battery");
=2Ename =3D "bq27000-battery",

But there is just only one kernel file which registers HDQ bq device and=20
it is bq27000 in file drivers/w1/slaves/w1_bq27000.c

So for now alias bq27000-battery is OK for me.

Acked-by: Pali Roh=C3=A1r <pali.rohar@gmail.com>

=2D-=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--nextPart6204940.Ug7Ceyz1Zq
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAlW34FMACgkQi/DJPQPkQ1IG3QCeMwqhFP72qpTEJBikSIYPgx3T
6swAoKIoCsoEO7qZczn4EJyD0Sa9N6eh
=3mZ8
-----END PGP SIGNATURE-----

--nextPart6204940.Ug7Ceyz1Zq--
