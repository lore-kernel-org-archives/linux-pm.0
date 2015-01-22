From: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v3 1/2] power: rt5033_charger: Add RT5033 charger device
 driver
Date: Thu, 22 Jan 2015 04:12:41 +0100
Message-ID: <20150122031240.GA17627@earth.universe>
References: <1421887092-4070-1-git-send-email-beomho.seo@samsung.com>
 <1421887092-4070-2-git-send-email-beomho.seo@samsung.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="9jxsPFA5p3P2qPhR"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1421887092-4070-2-git-send-email-beomho.seo-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Beomho Seo <beomho.seo-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, lee.jone-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, cw00.choi-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, inki.dae-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, sw0312.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
List-Id: linux-pm@vger.kernel.org


--9jxsPFA5p3P2qPhR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Jan 22, 2015 at 09:38:11AM +0900, Beomho Seo wrote:
> This patch add device driver of Richtek RT5033 PMIC. The driver
> support switching charger. rt5033 charger provide three charging
> mode.  Three charging mode are pre charge mode, fast cahrge mode
> and constant voltage mode. They are have vary charge rate, charge
> parameters. The charge parameters can be controlled by i2c
> interface.
>=20
> [...]
>
> +	charger->psy.name =3D "rt5033-charger",
> +	charger->psy.type =3D POWER_SUPPLY_TYPE_BATTERY,
>
> [...]

POWER_SUPPLY_TYPE_MAINS?

-- Sebastian

--9jxsPFA5p3P2qPhR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJUwGqlAAoJENju1/PIO/qax6sP/RbyQOsulqXxSGySrQNligz0
2XrCaD08g2BanAfkzksx/p5+RFB0oMUeHOTgrkZeDHAHcAJg71bskV7zAyX1bWGc
1n2j+RqqLSv0oOs6UVTq7Xsl+0mw59aG1AT2oukJq96qUsP+3ecT/EQA3cqbOQ36
UblMzo/SefpnD98icCttaAewDrjxVPebJS21eWiRSgrIvDmc5NHDFIdthz9KeuBI
L1f6f0q6Y1QBP6liCGQFyoRSCNVSCp9t5H8Yyehkaofcs3b1yVVTKOQbgYn5PJnp
Mrn6BBe2IxNP6MXOi1G24ENrrDaIIRMuQgieieR13EU/wTpT3BngKQeBfEpk9H0D
ZH+SLVpng+pLJhM6WzY/VgirhsI9rAee5x63aFFACJjvw7oCO3Hh5WEbt1rDx360
s7ctnsrVSGdVFNOMpz7e8MFQecB5NOatAVXMQkC6HMhHiTRoGKoZQ01qaOsz1ouH
DUoS72g8nEbOHN6lB9OFT2bjw668cGTPGqQ5ueFnLZ/UeQRkVw2kB/iR+qmOUGr9
QqmjFeKqwnAL85yjaxCpiWdEu7E5Ip5OBOMyf2H6Yfcl8owmskj4/r+3MHslWgXU
hBwc9PPGJOZVgJSaQ6Px8QjWtNmvpa0tPtOK7CQPXTV68sYKY7ZE+0ElAk5XzGjT
jmkc2dgP3jY/wH30akdw
=t/3w
-----END PGP SIGNATURE-----

--9jxsPFA5p3P2qPhR--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
