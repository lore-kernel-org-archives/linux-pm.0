From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH] power: twl4030: fix a missing check of return value
Date: Sun, 20 Jan 2019 22:38:53 +0100
Message-ID: <20190120213853.5yh6hiw3ccfgtbmo@earth.universe>
References: <20181220195124.29467-1-kjlu@umn.edu>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="pxnevxnfaejqw6t7"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181220195124.29467-1-kjlu@umn.edu>
Sender: linux-kernel-owner@vger.kernel.org
To: Kangjie Lu <kjlu@umn.edu>
Cc: pakki001@umn.edu, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org


--pxnevxnfaejqw6t7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Dec 20, 2018 at 01:51:24PM -0600, Kangjie Lu wrote:
> If twl4030_bci_read() fails, the read data in "s" is incorrect,
> which is however used in the following execution. The fix checks
> the return value of twl4030_bci_read() and returns an error code
> upstream upon the failure of twl4030_bci_read().
>=20
> Signed-off-by: Kangjie Lu <kjlu@umn.edu>
> ---

Thanks, queued to power-supply-next.

-- Sebastian

>  drivers/power/supply/twl4030_charger.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/power/supply/twl4030_charger.c b/drivers/power/suppl=
y/twl4030_charger.c
> index 0e202d4273fb..4299873a1118 100644
> --- a/drivers/power/supply/twl4030_charger.c
> +++ b/drivers/power/supply/twl4030_charger.c
> @@ -809,7 +809,9 @@ static int twl4030_bci_get_property(struct power_supp=
ly *psy,
>  		is_charging =3D state & TWL4030_MSTATEC_AC;
>  	if (!is_charging) {
>  		u8 s;
> -		twl4030_bci_read(TWL4030_BCIMDEN, &s);
> +		ret =3D twl4030_bci_read(TWL4030_BCIMDEN, &s);
> +		if (ret < 0)
> +			return ret;
>  		if (psy->desc->type =3D=3D POWER_SUPPLY_TYPE_USB)
>  			is_charging =3D s & 1;
>  		else
> --=20
> 2.17.1
>=20

--pxnevxnfaejqw6t7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlxE6m0ACgkQ2O7X88g7
+po4vA//bmq+OXH+sKw1H5E3jTUh60l+43qwHxHu6UGCyTr1SQ4PHcB/nyqxTA3s
5XzRj5AT96xlBEBfT2ItxeFzSO1XWUa1ji/zi4pwmc5gCzICu0J4+Fbs9VsmPMtA
JT+oRXTnD6DXzS03Q3A6SBYBfe07s4VL7k5MH/7jqNJQ/AvfVAsAaxVHxWCnUV1W
8dDlp+CFhuIR+Joi1uCPuL2Kibz+9tufQJvGX/ahdHRlUuLTXzyaSWFTpJn0WV7H
HkrfvaVdaP9OCU3n4D0XQQJ+nMbeAmUgqnxTQXZ3vTOPhk0S//zDUFo9CmwBXyHx
BCZ4mbTbLRwYjHQZH+G/DS+qj0+YxWH6G5VA9Nbemqwvs5xyHeRXxWmjqUbPlSeE
pW9y5TUfGtbUSLnZ6fAskH9727sysIlSp9oaXgvw5QqRXoDykF3ISjRvgMZDTjvx
h3EPsKKaj2CKMUMjJ/p7ipSHaqkoqcWWyG0l8nC3g4hAmNUuWluZYsO5CTmUVXCI
Yo6h7gNv6XYrlagvJTbvDCZyNqzd51dPFs+SQWDY0x4amxr99Vjk6n/ZCd/cYwy9
nqb+NrXT0Bx0k6Qa+TOAecRjuFwDVGmNqZZcb7Xbu13VfUVC/KT01bMYWVUosiAP
GFZOpqv9/W+7nnrVAsDzJJfPlfAz692gIlULduPK9plsbpuNgko=
=Cdng
-----END PGP SIGNATURE-----

--pxnevxnfaejqw6t7--
