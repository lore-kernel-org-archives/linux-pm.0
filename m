From: Eduardo Valentin <eduardo.valentin@ti.com>
Subject: Re: [PATCH V3 10/21] thermal: exynos: Fix to clear only the generated
 interrupts
Date: Thu, 9 May 2013 10:33:59 -0400
Message-ID: <518BB3D7.3010205@ti.com>
References: <1367931671-3906-1-git-send-email-amit.daniel@samsung.com> <1367931671-3906-11-git-send-email-amit.daniel@samsung.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="----enig2BRCKLKSBSBFKIRPVUSWS"
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <1367931671-3906-11-git-send-email-amit.daniel@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Amit Daniel Kachhap <amit.daniel@samsung.com>
Cc: linux-pm@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>, linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org, amit.kachhap@gmail.com, Kukjin Kim <kgene.kim@samsung.com>, Eduardo Valentin <eduardo.valentin@ti.com>
List-Id: linux-pm@vger.kernel.org

------enig2BRCKLKSBSBFKIRPVUSWS
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 07-05-2013 09:01, Amit Daniel Kachhap wrote:
> This patch uses the TMU status register to know the generated interrupt=
s
> and only clear them in the interrupt handler.
>=20
> Acked-by: Kukjin Kim <kgene.kim@samsung.com>
> Signed-off-by: Amit Daniel Kachhap <amit.daniel@samsung.com>
> ---
>  drivers/thermal/samsung/exynos_tmu.c      |   10 ++++------
>  drivers/thermal/samsung/exynos_tmu_data.c |    2 ++
>  2 files changed, 6 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/thermal/samsung/exynos_tmu.c b/drivers/thermal/sam=
sung/exynos_tmu.c
> index 97b87aa..082d5a2 100644
> --- a/drivers/thermal/samsung/exynos_tmu.c
> +++ b/drivers/thermal/samsung/exynos_tmu.c
> @@ -325,17 +325,15 @@ static void exynos_tmu_work(struct work_struct *w=
ork)
>  			struct exynos_tmu_data, irq_work);
>  	struct exynos_tmu_platform_data *pdata =3D data->pdata;
>  	struct exynos_tmu_registers *reg =3D pdata->registers;
> +	unsigned int val_irq;
> =20
>  	exynos_report_trigger();
>  	mutex_lock(&data->lock);
>  	clk_enable(data->clk);
> =20
> -	if (data->soc =3D=3D SOC_ARCH_EXYNOS)
> -		writel((reg->inten_rise_mask << reg->inten_rise_shift) |
> -			(reg->inten_fall_mask << reg->inten_fall_shift),
> -				data->base + reg->tmu_intclear);
> -	else
> -		writel(reg->inten_rise_mask, data->base + reg->tmu_intclear);
> +	val_irq =3D readl(data->base + reg->tmu_intstat);
> +	/* clear the interrupts */
> +	writel(val_irq, data->base + reg->tmu_intclear);
> =20

hmmm.. Don t you need to act accordingly depending on what is in your
int status?

>  	clk_disable(data->clk);
>  	mutex_unlock(&data->lock);
> diff --git a/drivers/thermal/samsung/exynos_tmu_data.c b/drivers/therma=
l/samsung/exynos_tmu_data.c
> index 3a1ded1..7322597 100644
> --- a/drivers/thermal/samsung/exynos_tmu_data.c
> +++ b/drivers/thermal/samsung/exynos_tmu_data.c
> @@ -45,6 +45,7 @@ static struct exynos_tmu_registers exynos4210_tmu_reg=
isters =3D {
>  	.inten_rise1_shift =3D EXYNOS_TMU_INTEN_RISE1_SHIFT,
>  	.inten_rise2_shift =3D EXYNOS_TMU_INTEN_RISE2_SHIFT,
>  	.inten_rise3_shift =3D EXYNOS_TMU_INTEN_RISE3_SHIFT,
> +	.tmu_intstat =3D EXYNOS_TMU_REG_INTSTAT,
>  	.tmu_intclear =3D EXYNOS_TMU_REG_INTCLEAR,
>  };
>  struct exynos_tmu_platform_data const exynos4210_default_tmu_data =3D =
{
> @@ -111,6 +112,7 @@ static struct exynos_tmu_registers exynos5250_tmu_r=
egisters =3D {
>  	.inten_rise2_shift =3D EXYNOS_TMU_INTEN_RISE2_SHIFT,
>  	.inten_rise3_shift =3D EXYNOS_TMU_INTEN_RISE3_SHIFT,
>  	.inten_fall0_shift =3D EXYNOS_TMU_INTEN_FALL0_SHIFT,
> +	.tmu_intstat =3D EXYNOS_TMU_REG_INTSTAT,
>  	.tmu_intclear =3D EXYNOS_TMU_REG_INTCLEAR,
>  	.emul_con =3D EXYNOS_EMUL_CON,
>  	.emul_temp_shift =3D EXYNOS_EMUL_DATA_SHIFT,
>=20



------enig2BRCKLKSBSBFKIRPVUSWS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iF4EAREIAAYFAlGLs9cACgkQCXcVR3XQvP2MVgD/RJdxxs+P25ePJ5UFje6aV4oB
460DQqwP3w1nj2SXH9IBAP4GgY9f+VOQpKSgaonWttsWPn0aKS4bshbW6PfMp8pm
=BDKx
-----END PGP SIGNATURE-----

------enig2BRCKLKSBSBFKIRPVUSWS--
