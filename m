From: Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: Re: [PATCH 14/14] power: supply: axp288: use the BIT() macro
Date: Wed, 5 Dec 2018 18:43:39 +0100
Message-ID: <20181205174339.veqr63rdzdm6afjt@earth.universe>
References: <cover.156212c9c5df493e098556cad9793a07dcab5e32.1543245984.git-series.plaes@plaes.org>
 <c500c452040428a2a5fae32c48c9ba778df9fb17.1543245984.git-series.plaes@plaes.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="fnxsdv5gg3qmvdqi"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <c500c452040428a2a5fae32c48c9ba778df9fb17.1543245984.git-series.plaes@plaes.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Priit Laes <plaes@plaes.org>
Cc: Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Chen-Yu Tsai <wens@csie.org>, Maxime Ripard <maxime.ripard@bootlin.com>, Hans de Goede <hdegoede@redhat.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, Olliver Schinagl <oliver@schinagl.nl>
List-Id: linux-pm@vger.kernel.org


--fnxsdv5gg3qmvdqi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Nov 26, 2018 at 05:27:55PM +0200, Priit Laes wrote:
> From: Olliver Schinagl <oliver@schinagl.nl>
>=20
> Make use of the recommended BIT() macro for bit defines.
>=20
> Signed-off-by: Olliver Schinagl <oliver@schinagl.nl>
> Signed-off-by: Priit Laes <plaes@plaes.org>
> ---

Thanks, queued to power-supply-next.

-- Sebastian

>  drivers/power/supply/axp288_charger.c | 35 ++++++++++++++--------------
>  1 file changed, 18 insertions(+), 17 deletions(-)
>=20
> diff --git a/drivers/power/supply/axp288_charger.c b/drivers/power/supply=
/axp288_charger.c
> index 735658e..f8c6da9 100644
> --- a/drivers/power/supply/axp288_charger.c
> +++ b/drivers/power/supply/axp288_charger.c
> @@ -16,6 +16,7 @@
>   */
> =20
>  #include <linux/acpi.h>
> +#include <linux/bitops.h>
>  #include <linux/module.h>
>  #include <linux/device.h>
>  #include <linux/regmap.h>
> @@ -29,17 +30,17 @@
>  #include <linux/mfd/axp20x.h>
>  #include <linux/extcon.h>
> =20
> -#define PS_STAT_VBUS_TRIGGER		(1 << 0)
> -#define PS_STAT_BAT_CHRG_DIR		(1 << 2)
> -#define PS_STAT_VBAT_ABOVE_VHOLD	(1 << 3)
> -#define PS_STAT_VBUS_VALID		(1 << 4)
> -#define PS_STAT_VBUS_PRESENT		(1 << 5)
> +#define PS_STAT_VBUS_TRIGGER		BIT(0)
> +#define PS_STAT_BAT_CHRG_DIR		BIT(2)
> +#define PS_STAT_VBAT_ABOVE_VHOLD	BIT(3)
> +#define PS_STAT_VBUS_VALID		BIT(4)
> +#define PS_STAT_VBUS_PRESENT		BIT(5)
> =20
> -#define CHRG_STAT_BAT_SAFE_MODE		(1 << 3)
> -#define CHRG_STAT_BAT_VALID		(1 << 4)
> -#define CHRG_STAT_BAT_PRESENT		(1 << 5)
> -#define CHRG_STAT_CHARGING		(1 << 6)
> -#define CHRG_STAT_PMIC_OTP		(1 << 7)
> +#define CHRG_STAT_BAT_SAFE_MODE		BIT(3)
> +#define CHRG_STAT_BAT_VALID		BIT(4)
> +#define CHRG_STAT_BAT_PRESENT		BIT(5)
> +#define CHRG_STAT_CHARGING		BIT(6)
> +#define CHRG_STAT_PMIC_OTP		BIT(7)
> =20
>  #define VBUS_ISPOUT_CUR_LIM_MASK	0x03
>  #define VBUS_ISPOUT_CUR_LIM_BIT_POS	0
> @@ -52,33 +53,33 @@
>  #define VBUS_ISPOUT_VHOLD_SET_OFFSET	4000	/* 4000mV */
>  #define VBUS_ISPOUT_VHOLD_SET_LSB_RES	100	/* 100mV */
>  #define VBUS_ISPOUT_VHOLD_SET_4300MV	0x3	/* 4300mV */
> -#define VBUS_ISPOUT_VBUS_PATH_DIS	(1 << 7)
> +#define VBUS_ISPOUT_VBUS_PATH_DIS	BIT(7)
> =20
>  #define CHRG_CCCV_CC_MASK		0xf		/* 4 bits */
>  #define CHRG_CCCV_CC_BIT_POS		0
>  #define CHRG_CCCV_CC_OFFSET		200		/* 200mA */
>  #define CHRG_CCCV_CC_LSB_RES		200		/* 200mA */
> -#define CHRG_CCCV_ITERM_20P		(1 << 4)	/* 20% of CC */
> +#define CHRG_CCCV_ITERM_20P		BIT(4)		/* 20% of CC */
>  #define CHRG_CCCV_CV_MASK		0x60		/* 2 bits */
>  #define CHRG_CCCV_CV_BIT_POS		5
>  #define CHRG_CCCV_CV_4100MV		0x0		/* 4.10V */
>  #define CHRG_CCCV_CV_4150MV		0x1		/* 4.15V */
>  #define CHRG_CCCV_CV_4200MV		0x2		/* 4.20V */
>  #define CHRG_CCCV_CV_4350MV		0x3		/* 4.35V */
> -#define CHRG_CCCV_CHG_EN		(1 << 7)
> +#define CHRG_CCCV_CHG_EN		BIT(7)
> =20
>  #define CNTL2_CC_TIMEOUT_MASK		0x3	/* 2 bits */
>  #define CNTL2_CC_TIMEOUT_OFFSET		6	/* 6 Hrs */
>  #define CNTL2_CC_TIMEOUT_LSB_RES	2	/* 2 Hrs */
>  #define CNTL2_CC_TIMEOUT_12HRS		0x3	/* 12 Hrs */
> -#define CNTL2_CHGLED_TYPEB		(1 << 4)
> -#define CNTL2_CHG_OUT_TURNON		(1 << 5)
> +#define CNTL2_CHGLED_TYPEB		BIT(4)
> +#define CNTL2_CHG_OUT_TURNON		BIT(5)
>  #define CNTL2_PC_TIMEOUT_MASK		0xC0
>  #define CNTL2_PC_TIMEOUT_OFFSET		40	/* 40 mins */
>  #define CNTL2_PC_TIMEOUT_LSB_RES	10	/* 10 mins */
>  #define CNTL2_PC_TIMEOUT_70MINS		0x3
> =20
> -#define CHRG_ILIM_TEMP_LOOP_EN		(1 << 3)
> +#define CHRG_ILIM_TEMP_LOOP_EN		BIT(3)
>  #define CHRG_VBUS_ILIM_MASK		0xf0
>  #define CHRG_VBUS_ILIM_BIT_POS		4
>  #define CHRG_VBUS_ILIM_100MA		0x0	/* 100mA */
> @@ -94,7 +95,7 @@
>  #define CHRG_VLTFC_0C			0xA5	/* 0 DegC */
>  #define CHRG_VHTFC_45C			0x1F	/* 45 DegC */
> =20
> -#define FG_CNTL_OCV_ADJ_EN		(1 << 3)
> +#define FG_CNTL_OCV_ADJ_EN		BIT(3)
> =20
>  #define CV_4100MV			4100	/* 4100mV */
>  #define CV_4150MV			4150	/* 4150mV */
> --=20
> git-series 0.9.1

--fnxsdv5gg3qmvdqi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlwIDksACgkQ2O7X88g7
+ppOgw/8CPrpspeCER5Q+WfWnTQG6yDH1TqgkbMFikTYq1dBjw/pfjL5Jm0gqcF3
Ud05K4OOtpNwh/+FMRdeX5dbMRWHyUGycB/+99KoN1Wvf75KZoMCEf+U7vePHCNT
6wVlS1OiZ2A0Qz9AbnMSRUIA1cB4snil046epU78Tk5X+aG6KPMdBf3UhwViBhVG
y8bHopdrdmjUzXypBidcEkV8YZE+ABCkVjex3+BaanVXTpB7b5cYUXqxIEGoyImL
sjKB0OfeFRygr3YDMmfFGlRx06fccBkc/Mvq1AK5j3o2O9pFPiWVXLFfbjWwXxG4
MEQOSBP+FOnnIzlFQTpnXpArxtn1xVM91U+tCeTDAo1QpUKLYwxdehKJM6gwrhha
L4yylZbYpjCeOhs8bYYcbuGd6MRw3W1Jjk8r+9hKmQKkyjz+K47l7VK6bvFmLAw5
NsyhQ3EXiH7bHEgyxDYCNy7sJgIszzREBb/y9/aeTVidTiahr0Hcb3aGD26LRJ1V
bYJEgsfyfmmIeXq4hl6yuwspZQi+r79rv+lzLCPWYt8Dh64Yb62qq7FWwk9paF/G
EJaLaDHNIcq4zHtQBO5Z4+aieU4rIgGSPw+sorTQtWWTgcTjiUsPDueZWpRqZvO7
Qt1H7hUj1DHls7ReN2uYd8XphVfmYoQI+47NrMCIf7QWpxrpZew=
=cKtS
-----END PGP SIGNATURE-----

--fnxsdv5gg3qmvdqi--
