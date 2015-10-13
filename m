From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v7 6/6] mfd: da9150: Use DEFINE_RES_IRQ_NAMED() help
 macro for IRQ resource
Date: Tue, 13 Oct 2015 10:26:52 +0100
Message-ID: <20151013092652.GX32409@x1>
References: <cover.1444225050.git.Adam.Thomson.Opensource@diasemi.com>
 <d5715f971e87517c30dd07a9907fd8c223dd7650.1444225050.git.Adam.Thomson.Opensource@diasemi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <d5715f971e87517c30dd07a9907fd8c223dd7650.1444225050.git.Adam.Thomson.Opensource@diasemi.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Cc: Samuel Ortiz <sameo@linux.intel.com>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Support Opensource <support.opensource@diasemi.com>
List-Id: linux-pm@vger.kernel.org

On Wed, 07 Oct 2015, Adam Thomson wrote:

> Signed-off-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
> Suggested-by: Lee Jones <lee.jones@linaro.org>
> Acked-by: Lee Jones <lee.jones@linaro.org>
> ---
>=20
> Changes in v6:
>  - Rebase to v4.3-rc4
>=20
> Changes in v5:
>  - Rebase to v4.2
>=20
> Changes in v3:
>  - Initial version.
>=20
>  drivers/mfd/da9150-core.c | 35 +++++------------------------------
>  1 file changed, 5 insertions(+), 30 deletions(-)

Applied, thanks.

> diff --git a/drivers/mfd/da9150-core.c b/drivers/mfd/da9150-core.c
> index 85ca4b5..195fdcf 100644
> --- a/drivers/mfd/da9150-core.c
> +++ b/drivers/mfd/da9150-core.c
> @@ -355,39 +355,14 @@ static const struct regmap_irq_chip da9150_regm=
ap_irq_chip =3D {
>  };
>=20
>  static struct resource da9150_gpadc_resources[] =3D {
> -	{
> -		.name =3D "GPADC",
> -		.start =3D DA9150_IRQ_GPADC,
> -		.end =3D DA9150_IRQ_GPADC,
> -		.flags =3D IORESOURCE_IRQ,
> -	},
> +	DEFINE_RES_IRQ_NAMED(DA9150_IRQ_GPADC, "GPADC"),
>  };
>=20
>  static struct resource da9150_charger_resources[] =3D {
> -	{
> -		.name =3D "CHG_STATUS",
> -		.start =3D DA9150_IRQ_CHG,
> -		.end =3D DA9150_IRQ_CHG,
> -		.flags =3D IORESOURCE_IRQ,
> -	},
> -	{
> -		.name =3D "CHG_TJUNC",
> -		.start =3D DA9150_IRQ_TJUNC,
> -		.end =3D DA9150_IRQ_TJUNC,
> -		.flags =3D IORESOURCE_IRQ,
> -	},
> -	{
> -		.name =3D "CHG_VFAULT",
> -		.start =3D DA9150_IRQ_VFAULT,
> -		.end =3D DA9150_IRQ_VFAULT,
> -		.flags =3D IORESOURCE_IRQ,
> -	},
> -	{
> -		.name =3D "CHG_VBUS",
> -		.start =3D DA9150_IRQ_VBUS,
> -		.end =3D DA9150_IRQ_VBUS,
> -		.flags =3D IORESOURCE_IRQ,
> -	},
> +	DEFINE_RES_IRQ_NAMED(DA9150_IRQ_CHG, "CHG_STATUS"),
> +	DEFINE_RES_IRQ_NAMED(DA9150_IRQ_TJUNC, "CHG_TJUNC"),
> +	DEFINE_RES_IRQ_NAMED(DA9150_IRQ_VFAULT, "CHG_VFAULT"),
> +	DEFINE_RES_IRQ_NAMED(DA9150_IRQ_VBUS, "CHG_VBUS"),
>  };
>=20
>  static struct resource da9150_fg_resources[] =3D {

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
