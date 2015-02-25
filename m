From: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v7 0/7] Add initial support for DA9150 Charger &
 Fuel-Gauge IC
Date: Wed, 25 Feb 2015 21:33:08 +0100
Message-ID: <20150225203307.GC13695@earth>
References: <cover.1424267009.git.Adam.Thomson.Opensource@diasemi.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="+xNpyl7Qekk2NvDX"
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <cover.1424267009.git.Adam.Thomson.Opensource-WBD+wuPFNBhBDgjK7y7TUQ@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Adam Thomson <Adam.Thomson.Opensource-WBD+wuPFNBhBDgjK7y7TUQ@public.gmane.org>
Cc: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Hartmut Knaack <knaack.h-Mmb7MZpHnFY@public.gmane.org>, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Dmitry Eremin-Solenikov <dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, Joe Perches <joe-6d6DIl74uiNBDgjK7y7TUQ@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, support.opensource-WBD+wuPFNBhBDgjK7y7TUQ@public.gmane.org
List-Id: linux-pm@vger.kernel.org


--+xNpyl7Qekk2NvDX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Feb 18, 2015 at 02:08:19PM +0000, Adam Thomson wrote:
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
> This patch set is baselined against the v3.19 kernel version.

I pulled in patches 3-7 into battery-2.6.git (patch 1 was already
applied by Lee in 4.0-rc1 and patch 2 can simply be pulled in by
Lee).

Jonathan: I have prepared an immutable branch "da9150-charger-fuelgauge"
based on 4.0-rc1, which contains the IIO bits, so that you can pull them
in, too:

git://git.infradead.org/battery-2.6.git da9150-charger-fuelgauge

--Sebastian

--+xNpyl7Qekk2NvDX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJU7jF+AAoJENju1/PIO/qaTUkQAJJW69C+VlZ7+o98gR3Sb6rA
q45Nk3n7BSiPU3lqLql9JL+IKGOAd+cjRJ0QpIyPUAaqiLrdBpUQZS0TQnHRMERp
7nFJpX/oC+eHSe6l9PeeBzS9tSWK2eYQk8+rnI6XgwvfPj59kMclh3XIWIowI/ZK
Ve8vJ3Ebk6cRImCGfyvihzxwe+YS15D/8+GCifiipy3wQoWLiSuvYe9xn23SyDGw
QpJr9i6LKcwe8hGiRRLLb4PzXWSBDr0H3pf8FRYAQEHJbjMjqu24SzgFfDSCWBAz
YzQ0qNyM/ERZcqGAj7y9FA+hGeROLxKxWj95bLEMjwWcCZylWJJvAreUpQt7rUWL
zb33xO6NnH96X4NXSl2K65+ZFgfvfyP6ydBR6nuhS9zbUhe6+61vjB6uI+T49oER
PlozkGk9t74y0Uyu7Kgl1JLxGptzkWw3sO6x2jXMOm7Uw4bl3AUQRMOVv6sPqUbw
c45kk73pawQioD9oAhLRCDtFDRujkncwn3ZxgN4kCToiN6WHZrSR4RkNgWbLZDah
e3uaXv3xJxE9FiGsHcFCePPsiYEE2bMzEe434/aMR5scgFOPj30V0hqL89O4nWoF
3vlW8ADFrBt8uHlZpP0lRjzJi1okZGW2e3buXh/HoLvpJM85gvWcsNurxSNvcmd7
q72QB6MUKYDZLjyUyx7O
=NHbg
-----END PGP SIGNATURE-----

--+xNpyl7Qekk2NvDX--
