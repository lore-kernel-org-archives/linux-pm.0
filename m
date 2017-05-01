From: Sebastian Reichel <sebastian.reichel-ZGY8ohtN/8pPYcu2f3hruQ@public.gmane.org>
Subject: Re: [PATCH 2/2] power: supply: sbs-battery: Correct supply status
 with current draw
Date: Mon, 1 May 2017 13:33:58 +0200
Message-ID: <20170501113358.qo5xzojemjh46e3w@earth>
References: <20170425150905.4185-1-contact@paulk.fr>
 <20170425150905.4185-2-contact@paulk.fr>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="bhfoqsnd35u4mqcr"
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20170425150905.4185-2-contact-W9ppeneeCTY@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Paul Kocialkowski <contact-W9ppeneeCTY@public.gmane.org>
Cc: linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org


--bhfoqsnd35u4mqcr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Apr 25, 2017 at 05:09:05PM +0200, Paul Kocialkowski wrote:
> The status reported directly by the battery controller is not always
> reliable and should be corrected based on the current draw information.
>=20
> This implements such a correction with a dedicated function, called
> where the supply status is retrieved.
>=20
> Signed-off-by: Paul Kocialkowski <contact-W9ppeneeCTY@public.gmane.org>

Thanks, queued.

-- Sebastian

--bhfoqsnd35u4mqcr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlkHHSYACgkQ2O7X88g7
+ppVnRAAkn5ZCSQ/EJtK0Z+mqz8flVlk2X4rxcbvTBSmAuu0hCO1kvdMgiDYNacu
0onLqDlcgFVDL/wEAfBFYTfGhrUx+P0WrRMMzhE3y17LeQcWyeofUQaqETklM61U
QD246ESS0ftJcXJ5uZIL6JDfXn0LcactuVOc+ihTcYwMP/4jORRe4YLLXk/Kq1XC
HgRDxX0sEhfvDrT5eF1Zj8OiXCVkTS6Sogq5xs+puQ5o85hSQFyg4BhH+qnyx5Zg
LhEoBnb7RJq87pCTZhnZ+0WTjQ5ySScIcV6BedWg2W+gAXDZIJGUGxwh5+kWfhys
b4AdYO3nN86lt8O4q+VuFhuIwyVwPxxw9kImIik4bSVyOhMPVEgJhhkI1Wd5b+BQ
tqJZTJtaDGlwKZOoXXVWAlNZ+rpYX+9ACrh7Q24ZdxJ3cpKsg6lNBsutDsvJ6ALU
hj6BsHsFpcH9qtqA/J99uYGJSozUvKzAWeFBmH5OxBpceYOaS8sQanIWAlMzpkQ+
2Bv/sUrV+Je7r7n79ozlO/oyp76flekVOeTreCHk51M0pvfecV3vbmQaAMYzhWiU
oWujOL+xRvVHL01/QZn1JRx9yf0gF8YlK2CySxlfRv+4MNhKGHxn0uACY9Pn/Tg2
ZuwRb+4nrBpsO6ctAQCQDonv2VYz6vHVNGQkugGYaRJP5rVyuH0=
=F9Vy
-----END PGP SIGNATURE-----

--bhfoqsnd35u4mqcr--
