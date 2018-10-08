From: Quentin Schulz <quentin.schulz@bootlin.com>
Subject: Re: [PATCH v2 5/6] mfd: axp20x: add support AXP803 AC and battery
 power supplies
Date: Mon, 8 Oct 2018 09:33:12 +0200
Message-ID: <20181008073312.otdz25ttvew6fzk2@qschulz>
References: <20181004193410.7265-1-oskari@lemmela.net>
 <20181006211836.28253-1-oskari@lemmela.net>
 <20181006211836.28253-6-oskari@lemmela.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ac4srxfaa53qexuc"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181006211836.28253-6-oskari@lemmela.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Oskari Lemmela <oskari@lemmela.net>
Cc: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Chen-Yu Tsai <wens@csie.org>, Maxime Ripard <maxime.ripard@bootlin.com>, Lee Jones <lee.jones@linaro.org>, Quentin Schulz <quentin.schulz@free-electrons.com>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org


--ac4srxfaa53qexuc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Oskari,

On Sun, Oct 07, 2018 at 12:18:35AM +0300, Oskari Lemmela wrote:
> AXP803 is compatible with AXP813.
> Adding needed cells for AC and battery power supplies.
>=20
> AXP813 AC power supply cell added.
>=20
> Signed-off-by: Oskari Lemmela <oskari@lemmela.net>
> ---
>  drivers/mfd/axp20x.c       | 22 +++++++++++++++++++++-
>  include/linux/mfd/axp20x.h |  1 +
>  2 files changed, 22 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/mfd/axp20x.c b/drivers/mfd/axp20x.c
> index 0be511dd93d0..215f0b009728 100644
> --- a/drivers/mfd/axp20x.c
> +++ b/drivers/mfd/axp20x.c
> @@ -731,8 +731,23 @@ static const struct mfd_cell axp803_cells[] =3D {
>  		.name			=3D "axp221-pek",
>  		.num_resources		=3D ARRAY_SIZE(axp803_pek_resources),
>  		.resources		=3D axp803_pek_resources,
> +	}, {
> +		.name			=3D "axp20x-regulator"
> +	}, {
> +		.name			=3D "axp20x-gpio",
> +		.of_compatible		=3D "x-powers,axp813-gpio",
> +	}, {
> +		.name			=3D "axp813-adc",
> +		.of_compatible		=3D "x-powers,axp813-adc",
> +	}, {
> +		.name		=3D "axp20x-battery-power-supply",
> +		.of_compatible	=3D "x-powers,axp813-battery-power-supply",
> +	}, {
> +		.name           =3D "axp20x-ac-power-supply",
> +		.of_compatible  =3D "x-powers,axp813-ac-power-supply",
> +		.num_resources  =3D ARRAY_SIZE(axp20x_ac_power_supply_resources),
> +		.resources      =3D axp20x_ac_power_supply_resources,
>  	},
> -	{	.name			=3D "axp20x-regulator" },
>  };
> =20
>  static const struct mfd_cell axp806_self_working_cells[] =3D {
> @@ -778,6 +793,11 @@ static const struct mfd_cell axp813_cells[] =3D {
>  	}, {
>  		.name		=3D "axp20x-battery-power-supply",
>  		.of_compatible	=3D "x-powers,axp813-battery-power-supply",
> +	}, {
> +		.name           =3D "axp20x-ac-power-supply",
> +		.of_compatible  =3D "x-powers,axp813-ac-power-supply",
> +		.num_resources  =3D ARRAY_SIZE(axp20x_ac_power_supply_resources),
> +		.resources      =3D axp20x_ac_power_supply_resources,

I'll let Maxime or Chen-Yu tell you what they want but I think we could
have two different commits, one for AXP803 and one for AXP813. I don't
think we care about having one commit per added resource for the axp803
though.

>  	},
>  };
> =20
> diff --git a/include/linux/mfd/axp20x.h b/include/linux/mfd/axp20x.h
> index 517e60eecbcb..2302b620d238 100644
> --- a/include/linux/mfd/axp20x.h
> +++ b/include/linux/mfd/axp20x.h
> @@ -266,6 +266,7 @@ enum axp20x_variants {
>  #define AXP288_RT_BATT_V_H		0xa0
>  #define AXP288_RT_BATT_V_L		0xa1
> =20
> +#define AXP813_ACIN_PATH_CTRL		0x3a

You're not using it in this patch, please keep this change in the commit
where its use is introduced.

Thanks,
Quentin

--ac4srxfaa53qexuc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEXeEYjDsJh38OoyMzhLiadT7g8aMFAlu7CDgACgkQhLiadT7g
8aONSBAAi2HPN7CMO899PLLTO6W9d7cyN+OY8PIJwaX+tDqUMDRupJJi84cblIVX
aVfOh1Hl6ZtpKxicWr+jXlpXQEhM9XfvaVkrEM5H95eudhawYoac3xr0Z8wtG9Sa
KzvrLG4j0uTflgo3CRcHJQUNkkWeC5pV3mHQxw3EUllDW3kbYjtjgVLGKyN7DvLJ
eZippTGKvBovwGBRqz+rx86YiUZ9A5kAz87QBJARvGKEE0a3rXkfj/UTvgVZF9M9
IZ56Nl+Gvtrend5MsM502byvAAx2u+WNpFruMXvjv7EnQAOuCIRFk7b5JLnARBfz
OCJBncAKQe199Q3pK2CI6ZqAHqZb7EJ/8ceVhbkFHEg2FIXVnZaKTQyaKuflwXnL
lK2MENvXmaL7Dd71rCCi5XIlvCYuA8MR+gDD6SpzxQSTaoqpJ4l68RpDZt/YUCTP
WYk0ia/Koj/DdYT2ZtVx6J1w8eDUJNVyRa08amxEogt8Ud2LwyPEVWdszV0spio0
OI9gkTNNukq8jkqfm00Se4YXkNaEVSTC1k76VcqVFDCGvvTI1Cito22b4B6bni9e
XoRjD8wvS14L/+ug2lJhaEjkH1FmeHnLODDX6/i3eje3D2EJStevTIRPkhR+WMho
vRul+8J36mw/QijgEpU0aakVWdWEsKWPOUaUQSvpoFDVP0BBwCY=
=Ay4+
-----END PGP SIGNATURE-----

--ac4srxfaa53qexuc--
