From: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 1/2] power: supply: add sbs-charger driver
Date: Wed, 23 Nov 2016 14:36:16 +0100
Message-ID: <20161123133615.js74ap6dnplg55ks@earth>
References: <1479900044-19270-1-git-send-email-nicolas.saenz@prodys.net>
 <1479900044-19270-2-git-send-email-nicolas.saenz@prodys.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="dgrhprfdjavuzl6j"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1479900044-19270-2-git-send-email-nicolas.saenz-gbiq2sxWoaasTnJN9+BGXg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Nicolas Saenz Julienne <nicolas.saenz-gbiq2sxWoaasTnJN9+BGXg@public.gmane.org>
Cc: robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org


--dgrhprfdjavuzl6j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Nov 23, 2016 at 12:20:43PM +0100, Nicolas Saenz Julienne wrote:
> This adds support for sbs-charger compilant chips as defined here:
> http://sbs-forum.org/specs/sbc110.pdf
>=20
> This was tested on a arm board connected to an LTC41000 battery charger
> chip.
>=20
> Signed-off-by: Nicolas Saenz Julienne <nicolas.saenz-gbiq2sxWoaasTnJN9+BGXg@public.gmane.org>
> ---
>  v1 -> v2:
>  - add spec link in header
>  - use proper gpio/interrupt interface
>  - update regmap configuration (max register & endianness)
>  - dropped oldschool .supplied_to assignments
>  - use devm_* APIs

Thanks. Looks almost fine now.

>  drivers/power/supply/Kconfig       |   6 +
>  drivers/power/supply/Makefile      |   1 +
>  drivers/power/supply/sbs-charger.c | 264 +++++++++++++++++++++++++++++++=
++++++
>  3 files changed, 271 insertions(+)
>  create mode 100644 drivers/power/supply/sbs-charger.c
>=20
> [...]
>
> +static const struct regmap_config sbs_regmap =3D {
> +	.reg_bits	=3D 8,
> +	.val_bits	=3D 16,
> +	.max_register	=3D SBS_CHARGER_REG_ALARM_WARNING,
> +	.volatile_reg	=3D sbs_volatile_reg,
> +	.val_format_endian =3D REGMAP_ENDIAN_LITTLE, /* since based on SMBus */
> +};

Please provide at least a readable_reg marking the
range from 0x00-0x10 unreadable. You can check this
with

cat /sys/kernel/debug/regmap/sbs-charger/registers

> [...]

-- Sebastian

--dgrhprfdjavuzl6j
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlg1m0wACgkQ2O7X88g7
+ppGAw/9EjzrqNZZ2HRftmitzLnbLzXHBbqMRFCEAeq5rqmWJCoh5nKwQHGTIOxl
u94soXqLFJgsmn7mBuVST/A0nRmtVB6i7mHHKfLgegQ8eGuTfYJmCvSVb4puClPJ
iHS8Ywj/LaqC0MtPiJrabB+XTgc+9lA0H8zAIWeiqKWv3PdTJ5ihYv3OtRufNRfq
XoAeaxunGqh+5jQa7JJNTqAOTn6rVycZNOsbk0nn4rP1yAI960m0ktHhYhbeWk5q
CJpEM6eHBjN8hvbXS+ZsfRM38OHKNgo8yciNV6KdYnHosy853LoiENBl4TFmYfCb
lSiXuVqbNxgnz4fPH1irSMlY3v0MtFtHts4C6cy3aVgQ13oP8u33hljAksIuk2Bc
5mWvl3VEUouEkwYl2XloLj6EJ8MTOths08d0mgJdf5gduuHmAuBrqFLSzZqUSrb5
TItqjakPIjD/jgoXDgqNvrBLXcnmsyikeNz22vMUf/mjYLIIZGYLuW0YGWjgKi/U
aMsukeIazlH6MCkUdaJHrJMLrkgoq0auBz6sWO0qQhYmolYsQPzXE2JI7a4/mAZ4
iPnbqpWE1u3G9iEYoDGsYSt1jP76IZbDrqoexkFKNmYmTn8y3sX+gitoR5AjhImz
8VfHKwavQa/AaeqSfk2hUwo6kpwTCIAkdUGvt/uXjf4xHIMJQjQ=
=8+CL
-----END PGP SIGNATURE-----

--dgrhprfdjavuzl6j--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
