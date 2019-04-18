From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH v2 1/4] iio: inkern: API for reading available iio
 channel attribute values
Date: Thu, 18 Apr 2019 21:47:47 +0200
Message-ID: <20190418194747.dptsqebjsf3rr6cy@earth.universe>
References: <20190323172809.14407-1-contact@artur-rojek.eu>
 <20190324152725.35fed317@archlinux>
 <20190414113454.53087ca6@archlinux>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="wgsxqldkf5o6zf2t"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190414113454.53087ca6@archlinux>
Sender: linux-kernel-owner@vger.kernel.org
To: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
Cc: Artur Rojek <contact@artur-rojek.eu>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, linux-pm@vger.kernel.org, linux-iio@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>
List-Id: linux-pm@vger.kernel.org


--wgsxqldkf5o6zf2t
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sun, Apr 14, 2019 at 11:34:54AM +0100, Jonathan Cameron wrote:
> On Sun, 24 Mar 2019 15:27:25 +0000
> Jonathan Cameron <jic23@kernel.org> wrote:
>=20
> > On Sat, 23 Mar 2019 18:28:06 +0100
> > Artur Rojek <contact@artur-rojek.eu> wrote:
> >=20
> > > Extend the inkern API with a function for reading available
> > > attribute values of iio channels.
> > >=20
> > > Signed-off-by: Artur Rojek <contact@artur-rojek.eu> =20
> > If this goes through a route other than IIO (otherwise
> > I'll just add a signed-off-by...)
> >=20
> > Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>=20
> Applied to the ib-jz47xx-prereq branch of
> git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git
>=20
> I'll merge that into the togreg branch as well shortly.

Thanks, I pulled that branch into power-supply next for the
other two patches.

-- Sebastian

--wgsxqldkf5o6zf2t
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAly41GMACgkQ2O7X88g7
+pq0Dg/+P5WbhV6uttsmFVoHwB+hHc7HmE2h4orwZWWWjceetahyW73XHoORaNvd
AAqGYq2CorKegt3pEYN1FjGLFl5Z1/ifbvr/2XL4145NEe9i2qyf56qlhY0Lou+S
al59XZ+PfiDSLWL1JX643zocJMIIFFxIptU6BYGPdIlANg9sFxVjejci2j+xJXo7
im6oiLmaJ9pY8ug9TFflQoS3YiNBEaVNoBks4tWZuJYGLZ2FH5LohEAk/V85g7hR
m4DTmBDD9bJWC0JQRkjyIal+xYB98f0FJV4dBkD/2G5OUZsCFDM+57MNQTKNF2dG
YSAcGg5sr5U7WDNvZrlPQpeqi5FmSiSAKp6QO0d1Wo1rfLsUfhrhH6G/KNYYMIpK
6TZAIB4qfPRSCOWy3zNILPDa4mdSd4tCyfJKj6iGLN0eioZnlvJU7yspm+0wxhnK
2I+Mj4oWyO4lCbX8CeM3+a+GCCQwxOFM4VQ8muer+tXla2eayznKPkPc0l3K5Jid
3DZK6ob/VqJV8uC7xPCDW9/7VWiRU7qG3h+z21dt2h7UXVvPu5keeTpifbnhUL6F
h0eOXOOLmjItgyXUiDcY2fdzUUypEJt0f6vKRozbBOy/ME0bba9ZYyxpi1aolaNU
dXtj0fd7c+XiZ+fZ0VpIbCF38/OrDoQBl82EzQJg6SdmhiAnfmA=
=wLB6
-----END PGP SIGNATURE-----

--wgsxqldkf5o6zf2t--
