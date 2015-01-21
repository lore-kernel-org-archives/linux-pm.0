From: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v6 0/7] Add initial support for DA9150 Charger &
 Fuel-Gauge IC
Date: Wed, 21 Jan 2015 17:52:50 +0100
Message-ID: <20150121165250.GG13715@earth.universe>
References: <cover.1421854282.git.Adam.Thomson.Opensource@diasemi.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="PyMzGVE0NRonI6bs"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <cover.1421854282.git.Adam.Thomson.Opensource-WBD+wuPFNBhBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Adam Thomson <Adam.Thomson.Opensource-WBD+wuPFNBhBDgjK7y7TUQ@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Hartmut Knaack <knaack.h-Mmb7MZpHnFY@public.gmane.org>, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Dmitry Eremin-Solenikov <dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, Joe Perches <joe-6d6DIl74uiNBDgjK7y7TUQ@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, support.opensource-WBD+wuPFNBhBDgjK7y7TUQ@public.gmane.org
List-Id: linux-pm@vger.kernel.org


--PyMzGVE0NRonI6bs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Jan 21, 2015 at 03:46:25PM +0000, Adam Thomson wrote:
> This patch set adds initial support for the Dialog DA9150 Integrated Char=
ger &
> Fuel-Gauge IC. The device also provides GPIO and GPADC functionality.
>=20
> In this patch set the following is provided:
>  - MFD Core support and DT bindings documentation.
>  - IIO GPADC support and DT bindings documentation.
>  - Power Supply Charger support and DT bindings documentation.
>  - Update to MAINTAINERS file to add DA9150 files to Dialog support list.
>=20
> To keep patch submission from being too large, support for GPIO and Fuel-=
Gauge
> will come after initial support patches are accepted.
>=20
> This patch set is baselined against the v3.19-rc5 kernel version.
>=20
> Changes in v6:
> - For GPADC driver, Use lower case extended names for IIO GPADC channels,=
 and
>   remove extended names for GPIO related channels.
> - For charger driver, revert to no devm IRQ request/free functions as ord=
ering
>   is important, and probe failure scenario was not being correctly covere=
d. A
>   helper function for free IRQs has been added to make code cleaner.

Probably a devm_ variant of power_supply_register should be created,
but for now this is ok for me.

Jonathan, Lee: I assume you are ok with the whole patchset going
through the power supply subsystem?

-- Sebastian

--PyMzGVE0NRonI6bs
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJUv9lcAAoJENju1/PIO/qaIKIP/14eqxi1ase5m88E13nRORfJ
3OB3fQIYR0V5yEJCUCAWYAxhYdfiSuVVsZBAyYCPnz2Njae6DPoMNJgcyca1U2S+
8PqyIlp2PSYOixTHECTXWC/XwS4Y7sk3tc1WVqgoy1x8tCCuAw0shGMyCN87P7U9
ouNBTgNtF0k/V577HrDjwkgKaC78tdh+h5IeomPpYzQjE7l4MyA1TgNk8UT+v9CB
jLkzDs8VLThcCnB5GKmRfFOYZMbTs1mtv3D1IoLRJ65M0QEn8kU9Id4YHdwhmNqk
g7cJe1s+ep7VExJ+qCoVyKnGfZmycDK7KzZ3A4rGUz3KPaxsqI5EAS9/cKiugMCM
PfI9XhIF31Sw6/erXxfNhTJmueKiSo7yf3tx1ZA3Geg7aR8bSU3SaEbYXOHfiKRj
A6RjfmAFhBx3N2cJxhylxU0ZiRkZUtVr+KIGDlezYap8md2W94dKFZlegCYN+Y5Q
/VgKwHVGzXuG2t14k+oek4p0GTYIy8IbnSC4zGZr9qCUOfT6yKzSx/mC81MVPsfD
9jobcopwL9lghFx44mYwrwgbautZOxmNFrC0j1EMXHlXqcDH1cNvHh1jevdi0LzJ
srJvcNVz4xDewvrY4Qhhup31Jj6FTX5bqmqF7Z/JNj5tYu2nJajW2cmS1I93kx4R
/80/ZvrMX6/NDajDv4gy
=G8aH
-----END PGP SIGNATURE-----

--PyMzGVE0NRonI6bs--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
