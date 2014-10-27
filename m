From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH v2 2/2] power: bq2415x_charger: Fix memory leak on DTS
 parsing error
Date: Mon, 27 Oct 2014 18:44:07 +0100
Message-ID: <20141027174406.GB10897@earth.universe>
References: <1413383110-20310-1-git-send-email-k.kozlowski@samsung.com>
 <1413383110-20310-2-git-send-email-k.kozlowski@samsung.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="KFztAG8eRSV9hGtP"
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1413383110-20310-2-git-send-email-k.kozlowski@samsung.com>
Sender: stable-owner@vger.kernel.org
To: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Cc: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
List-Id: linux-pm@vger.kernel.org


--KFztAG8eRSV9hGtP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Oct 15, 2014 at 04:25:10PM +0200, Krzysztof Kozlowski wrote:
> Memory allocated for 'name' was leaking if required binding properties
> were not present.
>=20
> The memory for 'name' was allocated early at probe with kasprintf(). It
> was freed in error paths executed before and after parsing DTS but not
> in that error path.
>=20
> Fix the error path for parsing device tree properties.
>=20
> Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> Fixes: faffd234cf85 ("bq2415x_charger: Add DT support")
> Cc: <stable@vger.kernel.org>

Applied to next.

-- Sebastian

--KFztAG8eRSV9hGtP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJUToRmAAoJENju1/PIO/qaa10P/RHzYulySf1d3tH5nWjA8fIq
JgaA5copIntFb9cc1gyW9fRoavJbHrbEgH7nb1IUuO3yhoTh5gvIWj3Va88Zz3Fe
xn7YaRlOPMOvjuSLpBv1eXSHrH10LN1axLD+o0vm4yhYnTs7vJLY3t4MEyUPRjJn
kgoBl4H2oiFd50G1PU5OOqwOBrBeQiB0u8q3IPmwFwbUK6vRCRe+0Zk+OQVxau3Y
tWyj26ECeO102pM6xlwPtSx35Gk+0nQOAypabTNAFNQLfZJq8IrgkrYlTy7c8LE1
nGYuL6zU5GMbyJC8DAMvF7u7olorgsfoPpfK/YnD233VWYVfw1KsVOM2QpsxdEgs
bo/XaeUDR+yxNpeyR5DzFjotcoy+LhAQnyOPSVwdUdfnnS9fw7Ezb39FKAn7k51A
DtbiYuff1TcC86pkOlBRftGYkbJDR8FMbc9HidQ6sTgs5OFbs7mVADzcZsEmdR4L
UwBlmFxDfxkR5HP0QULetRMKKD4svpF3wsqKqn1iHCsW731L0Iu3N273J6eUKRl1
9Y8W0OfnLu6G6zNpS4w3+5TcVprSOgeZ+v0Wl4IDLYGP3npzoi4OIbyUkxdP5o4I
1fnkbxKTdG5T5T/oDn6qN4qeYy+ESGmxyIBquWHDqQyAy91SUvl62MBWE/5EFIxD
LNpwNq7WS5F+hJeXzv/u
=oBPr
-----END PGP SIGNATURE-----

--KFztAG8eRSV9hGtP--
