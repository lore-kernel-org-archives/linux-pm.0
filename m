From: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH 2/3] thermal: add support for the thermal sensor on
 Allwinner new SoCs
Date: Tue, 28 Feb 2017 07:44:26 +0100
Message-ID: <20170228064426.jsukm53ybaatpgyx@lukather>
References: <20170227194054.51951-1-icenowy@aosc.xyz>
 <20170227194054.51951-2-icenowy@aosc.xyz>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="fvwkzhfjr6hh4ime"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20170227194054.51951-2-icenowy-ymACFijhrKM@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Icenowy Zheng <icenowy-ymACFijhrKM@public.gmane.org>
Cc: Zhang Rui <rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Eduardo Valentin <edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, Ondrej Jirman <megous-5qf/QAjKc83QT0dZR+AlfA@public.gmane.org>, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org


--fvwkzhfjr6hh4ime
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 28, 2017 at 03:40:53AM +0800, Icenowy Zheng wrote:
> From: Ondrej Jirman <megous-5qf/QAjKc83QT0dZR+AlfA@public.gmane.org>
>=20
> Allwinner SoCs from H3 (including H5, A64, etc) have a new version of
> thermal sensor, and needs a new driver for it.
>=20
> Add such a driver.
>=20
> Currently only H3 is supported, but other SoCs are easily to be
> supported by adding new formula and set the sensor number.
>=20
> Signed-off-by: Ond=C5=99ej Jirman <megous-5qf/QAjKc83QT0dZR+AlfA@public.gmane.org>
> [Icenowy: extend to support further multiple-sensor SoCs, change commit
>  message]
> Signed-off-by: Icenowy Zheng <icenowy-ymACFijhrKM@public.gmane.org>

There's no need to create a new driver for that. This can be handled
by the GPADC driver we already have.

Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com

--fvwkzhfjr6hh4ime
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJYtRxKAAoJEBx+YmzsjxAgrRsP/1DiBK75OK0ShuS+tKpvj7LW
HtLLeRUrNjUIWGJ1MLskeRPerZhRL6+6/HgNdltDFXuy/JWpfl+cuBluHvJzv2eQ
oib+6/ieJ+2uWkdf+42irBpxQP/uAbBPr08MLtKzONf1ohnDdS+Cbs6YFcaJQJc6
stX3OWyo6b3Ua/NnhOfguNU4JptQEK0WaKcYommrm1VcVo5HA3fYlrvGK+mjeTSj
R0M3zubGlU0jQLY0nCwZ88vRhvKTi1DxrRklMLr2QoOdv2xSDahcWQbfkTBbqaXY
HqrTElvkSYXRqhPxNpH1M5hqJB1e3yp66SiAJ/jxK4F3ahK0EdStwa3FDAXD0jZC
aS8oNrb6VvhJmOR+KDTN15ASycm/fDo6S2GgPieqBAC38VgZ7GTVSfqy2RkcUeLX
cC8ZyLsg8z1eMxeUzm8suYxgWxLZlLbsJkcFetw0Ok/9eBdllojtblH/+5W0I2OT
1zSaoxzaBDaQ1t9WUjeDP/6Q5lAYdl7iomGV62a71zm1jYQX9ulaF2cibX9GtOCD
HLt91tbrKyXp1RDTkFe3p/HS7nB7Z/1K0D49KPiGtaf2MfvDc+QBjZsmu7ZqDQ2Z
lWbf0E6OVYuCuQInoc+IpegGOw4uxk/n8Q4L+gwg02SdJ1cqlHNQ4q7ceFzgO1Jq
FkI/jZXII9K4aL/n7sHc
=H9/X
-----END PGP SIGNATURE-----

--fvwkzhfjr6hh4ime--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
