From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH] max17042_battery: fix model download bug.
Date: Tue, 9 Aug 2016 20:54:29 +0200
Message-ID: <20160809185429.GB19946@earth>
References: <CAGngYiVv=+RKDcuwqPxyg5GpU6iCBkuR2v7EFmnDM3Xf+w0b_g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="7iMSBzlTiPOCCT2k"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:50610 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932207AbcHISyf (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 9 Aug 2016 14:54:35 -0400
Content-Disposition: inline
In-Reply-To: <CAGngYiVv=+RKDcuwqPxyg5GpU6iCBkuR2v7EFmnDM3Xf+w0b_g@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sven Van Asbroeck <thesven73@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Jonghwa Lee <jonghwa3.lee@samsung.com>, Krzysztof Kozlowski <k.kozlowski@samsung.com>


--7iMSBzlTiPOCCT2k
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

[adding some people to CC]

On Wed, Aug 03, 2016 at 10:03:46AM -0400, Sven Van Asbroeck wrote:
> The device's model download function returns the model data as
> an array of u32s, which is later compared to the reference
> model data. However, since the latter is an array of u16s,
> the comparison does not happen correctly, and model verification
> fails. This in turn breaks the POR initialization sequence.

Patch looks ok, except for missing Fixes. I guess it should be
"Fixes: 39e7213edc4f3". I will wait with queuing it for a few
days giving Samsung people a chance to reply.

-- Sebastian

>  drivers/power/max17042_battery.c | 15 +++++++++------
>  1 file changed, 9 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/power/max17042_battery.c b/drivers/power/max17042_ba=
ttery.c
> index 9c65f13..da7a75f 100644
> --- a/drivers/power/max17042_battery.c
> +++ b/drivers/power/max17042_battery.c
> @@ -457,13 +457,16 @@ static inline void
> max17042_write_model_data(struct max17042_chip *chip,
>  }
>=20
>  static inline void max17042_read_model_data(struct max17042_chip *chip,
> -                    u8 addr, u32 *data, int size)
> +                    u8 addr, u16 *data, int size)
>  {
>      struct regmap *map =3D chip->regmap;
>      int i;
> +    u32 tmp;
>=20
> -    for (i =3D 0; i < size; i++)
> -        regmap_read(map, addr + i, &data[i]);
> +    for (i =3D 0; i < size; i++) {
> +        regmap_read(map, addr + i, &tmp);
> +        data[i] =3D (u16)tmp;
> +    }
>  }
>=20
>  static inline int max17042_model_data_compare(struct max17042_chip *chip,
> @@ -486,7 +489,7 @@ static int max17042_init_model(struct max17042_chip *=
chip)
>  {
>      int ret;
>      int table_size =3D ARRAY_SIZE(chip->pdata->config_data->cell_char_tb=
l);
> -    u32 *temp_data;
> +    u16 *temp_data;
>=20
>      temp_data =3D kcalloc(table_size, sizeof(*temp_data), GFP_KERNEL);
>      if (!temp_data)
> @@ -501,7 +504,7 @@ static int max17042_init_model(struct max17042_chip *=
chip)
>      ret =3D max17042_model_data_compare(
>          chip,
>          chip->pdata->config_data->cell_char_tbl,
> -        (u16 *)temp_data,
> +        temp_data,
>          table_size);
>=20
>      max10742_lock_model(chip);
> @@ -514,7 +517,7 @@ static int max17042_verify_model_lock(struct
> max17042_chip *chip)
>  {
>      int i;
>      int table_size =3D ARRAY_SIZE(chip->pdata->config_data->cell_char_tb=
l);
> -    u32 *temp_data;
> +    u16 *temp_data;
>      int ret =3D 0;
>=20
>      temp_data =3D kcalloc(table_size, sizeof(*temp_data), GFP_KERNEL);
> --=20
> 1.9.1

--7iMSBzlTiPOCCT2k
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJXqibjAAoJENju1/PIO/qai88P/2IWdsxeu2OxhWdvUHacPV0H
ylBh6ByMyHw1hhEz462D3qvVq6pvFlaEWSiLM3VnK8JopqFQ5l/PG9209GECWEvv
HITP/dQyl1pzNqtc2Rh/JPwytUNcNwRBEtWbTUDp83hbtxvveAw/Y/p4+lp5JXyw
oDfx7dg9QK7QnxV7CRSb2Fj2YBFgd9JOHo4hEv9t3DL2d3b+DFOBFEhQXI5Lqd4R
PWH1dVbKo0f3QyRtGuaVotlkCsN4gSupUFzXqiUF2uAuBr364sEuFTjGAePV79w6
Uihum5tFW1lxhUuEHNn3FogI14gfu3jWsEGli+UFc3hDretwC5ZaqQiuY1MEP/f7
C0yjOX8CP9xY/xxpTYWPQbYlgs/ay9FpTudWMabKxMPdMM9YLmDLakwPDqCC+H/H
U79tXXOgZ2yQlVQ6ibk588ppRqhZ2PjRt1YV1R8Ewv1emJ3hzFbLYT1SXcxi4cim
cm8tFDAGnF7aMEGUFXoIaHaGqoSNPmnxO+7dfbMitsMtdoYpKmh18oHQvP7A9d7C
4xwIuROxOrSt2XBOwoqJggaVydMO5EIoz1FanXoI9oVfhrRYoeGdnaqKCGr0srwI
DZ1waa7UF6dlKIVdGTIl48z76R6UQhhXe+yGggFt3GNOoYlE4mIQ/bBX7gnVtMnW
shGIBR+eIt3AndH4jLW1
=7/Ap
-----END PGP SIGNATURE-----

--7iMSBzlTiPOCCT2k--
