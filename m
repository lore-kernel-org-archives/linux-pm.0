From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [PATCH v4 2/2] thermal: exynos: Add TMU support for Exynos7 SoC
Date: Sat, 31 Jan 2015 15:24:21 -0400
Message-ID: <20150131192419.GC17425@developer.hsd1.ca.comcast.net>
References: <1422337703-11289-1-git-send-email-a.kesavan@samsung.com>
 <1422337703-11289-2-git-send-email-a.kesavan@samsung.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="w7PDEPdKQumQfZlR"
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1422337703-11289-2-git-send-email-a.kesavan@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Abhilash Kesavan <a.kesavan@samsung.com>
Cc: rui.zhang@intel.com, kgene.kim@samsung.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, b.zolnierkie@samsung.com, l.majewski@samsung.com, amit.daniel@samsung.com, kesavan.abhilash@gmail.com, linux-samsung-soc@vger.kernel.org
List-Id: linux-pm@vger.kernel.org


--w7PDEPdKQumQfZlR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 27, 2015 at 11:18:22AM +0530, Abhilash Kesavan wrote:
> Add registers, bit fields and compatible strings for Exynos7 TMU
> (Thermal Management Unit). Following are a few of the differences
> in the Exynos7 TMU from earlier SoCs:
>         - 8 trigger levels
>         - Different bit offsets and more registers for the rising
>         and falling thresholds.
>         - New power down detection bit in the TMU_CONTROL register
>         which does not update the CURRENT_TEMP0 when tmu power down
>         is detected.
>         - Change in bit offset for the NEXT_DATA field of EMUL_CON
>         register. EMUL_CON register address has also changed.
>         - INTSTAT and INTCLEAR registers present in earlier SoCs
>         have been combined into one INTPEND register. The register
>         address for INTCLEAR and INTPEND is also different.
>         - Since there are 8 rising/falling interrupts as against
>         at most 4 in earlier SoCs the INTEN bit offsets are different.
>         - Multiple probe support which is handled by a TMU_CONTROL1
>         register (No support for this in the current patch).
>=20
> This patch adds special clock support required only for Exynos7. It
> also updates the "code_to_temp" prototype as Exynos7 has 9 bit
> code-temp mapping.
>=20
> Signed-off-by: Abhilash Kesavan <a.kesavan@samsung.com>

Applied to my -fixes branch. However, I had to amend it myself to make
checkpatch.pl --strict silent. In this version, it still outputs:
CHECK: Alignment should match open parenthesis
#209: FILE: drivers/thermal/samsung/exynos_tmu.c:558:
+       if (!data->temp_error1 ||
+          (pdata->min_efuse_value > data->temp_error1) ||

CHECK: multiple assignments should be avoided
#366: FILE: drivers/thermal/samsung/exynos_tmu.c:882:
+               tmu_intstat =3D tmu_intclear =3D EXYNOS7_TMU_REG_INTPEND;

total: 0 errors, 0 warnings, 2 checks, 314 lines checked

next, make sure you run checkpatch.pl --strict before sending patches.


> ---
> This patch set has been tested on linux next-20150123 with Eduardo's
> thermal-next branch merged along with the arch-side exynos7 related
> dts changes applied.
>=20
> Changes since v3:
> Addressed comments from Lukasz Majewski:
> 	- Added more comments in the code setting the thresholds.
> 	- Split the documentation out into another patch.
> Changes since v2:
> 	- Rebased on top of Lukasz' latest exynos tmu series (v4).
> 	- Added new exynos7 soc_type.
> Changes since v1:
> 	- Rebased on top of Lukasz' latest exynos tmu series (v2).
> 	- Added sclk support to patch adding Exynos7 tmu support.
> 	Previously, it was a separate patch.
> 	- Used the SOC type to decide if sclk is present.
>=20
>  drivers/thermal/samsung/exynos_tmu.c |  204 ++++++++++++++++++++++++++++=
++++--
>  drivers/thermal/samsung/exynos_tmu.h |    1 +
>  2 files changed, 197 insertions(+), 8 deletions(-)
>=20
> diff --git a/drivers/thermal/samsung/exynos_tmu.c b/drivers/thermal/samsu=
ng/exynos_tmu.c
> index 852e622..660ff69 100644
> --- a/drivers/thermal/samsung/exynos_tmu.c
> +++ b/drivers/thermal/samsung/exynos_tmu.c
> @@ -119,6 +119,26 @@
>  #define EXYNOS5440_TMU_TH_RISE4_SHIFT		24
>  #define EXYNOS5440_EFUSE_SWAP_OFFSET		8
> =20
> +/* Exynos7 specific registers */
> +#define EXYNOS7_THD_TEMP_RISE7_6		0x50
> +#define EXYNOS7_THD_TEMP_FALL7_6		0x60
> +#define EXYNOS7_TMU_REG_INTEN			0x110
> +#define EXYNOS7_TMU_REG_INTPEND			0x118
> +#define EXYNOS7_TMU_REG_EMUL_CON		0x160
> +
> +#define EXYNOS7_TMU_TEMP_MASK			0x1ff
> +#define EXYNOS7_PD_DET_EN_SHIFT			23
> +#define EXYNOS7_TMU_INTEN_RISE0_SHIFT		0
> +#define EXYNOS7_TMU_INTEN_RISE1_SHIFT		1
> +#define EXYNOS7_TMU_INTEN_RISE2_SHIFT		2
> +#define EXYNOS7_TMU_INTEN_RISE3_SHIFT		3
> +#define EXYNOS7_TMU_INTEN_RISE4_SHIFT		4
> +#define EXYNOS7_TMU_INTEN_RISE5_SHIFT		5
> +#define EXYNOS7_TMU_INTEN_RISE6_SHIFT		6
> +#define EXYNOS7_TMU_INTEN_RISE7_SHIFT		7
> +#define EXYNOS7_EMUL_DATA_SHIFT			7
> +#define EXYNOS7_EMUL_DATA_MASK			0x1ff
> +
>  #define MCELSIUS	1000
>  /**
>   * struct exynos_tmu_data : A structure to hold the private data of the =
TMU
> @@ -133,6 +153,7 @@
>   * @lock: lock to implement synchronization.
>   * @clk: pointer to the clock structure.
>   * @clk_sec: pointer to the clock structure for accessing the base_secon=
d.
> + * @sclk: pointer to the clock structure for accessing the tmu special c=
lk.
>   * @temp_error1: fused value of the first point trim.
>   * @temp_error2: fused value of the second point trim.
>   * @regulator: pointer to the TMU regulator structure.
> @@ -152,8 +173,8 @@ struct exynos_tmu_data {
>  	enum soc_type soc;
>  	struct work_struct irq_work;
>  	struct mutex lock;
> -	struct clk *clk, *clk_sec;
> -	u8 temp_error1, temp_error2;
> +	struct clk *clk, *clk_sec, *sclk;
> +	u16 temp_error1, temp_error2;
>  	struct regulator *regulator;
>  	struct thermal_zone_device *tzd;
> =20
> @@ -223,7 +244,7 @@ static int temp_to_code(struct exynos_tmu_data *data,=
 u8 temp)
>   * Calculate a temperature value from a temperature code.
>   * The unit of the temperature is degree Celsius.
>   */
> -static int code_to_temp(struct exynos_tmu_data *data, u8 temp_code)
> +static int code_to_temp(struct exynos_tmu_data *data, u16 temp_code)
>  {
>  	struct exynos_tmu_platform_data *pdata =3D data->pdata;
>  	int temp;
> @@ -513,6 +534,84 @@ static int exynos5440_tmu_initialize(struct platform=
_device *pdev)
>  	return ret;
>  }
> =20
> +static int exynos7_tmu_initialize(struct platform_device *pdev)
> +{
> +	struct exynos_tmu_data *data =3D platform_get_drvdata(pdev);
> +	struct thermal_zone_device *tz =3D data->tzd;
> +	struct exynos_tmu_platform_data *pdata =3D data->pdata;
> +	unsigned int status, trim_info;
> +	unsigned int rising_threshold =3D 0, falling_threshold =3D 0;
> +	int ret =3D 0, threshold_code, i;
> +	unsigned long temp, temp_hist;
> +	unsigned int reg_off, bit_off;
> +
> +	status =3D readb(data->base + EXYNOS_TMU_REG_STATUS);
> +	if (!status) {
> +		ret =3D -EBUSY;
> +		goto out;
> +	}
> +
> +	trim_info =3D readl(data->base + EXYNOS_TMU_REG_TRIMINFO);
> +
> +	data->temp_error1 =3D trim_info & EXYNOS7_TMU_TEMP_MASK;
> +	if (!data->temp_error1 ||
> +	   (pdata->min_efuse_value > data->temp_error1) ||
> +	   (data->temp_error1 > pdata->max_efuse_value))
> +		data->temp_error1 =3D pdata->efuse_value & EXYNOS_TMU_TEMP_MASK;
> +
> +	/* Write temperature code for rising and falling threshold */
> +	for (i =3D (of_thermal_get_ntrips(tz) - 1); i >=3D 0; i--) {
> +		/*
> +		 * On exynos7 there are 4 rising and 4 falling threshold
> +		 * registers (0x50-0x5c and 0x60-0x6c respectively). Each
> +		 * register holds the value of two threshold levels (at bit
> +		 * offsets 0 and 16). Based on the fact that there are atmost
> +		 * eight possible trigger levels, calculate the register and
> +		 * bit offsets where the threshold levels are to be written.
> +		 *
> +		 * e.g. EXYNOS7_THD_TEMP_RISE7_6 (0x50)
> +		 * [24:16] - Threshold level 7
> +		 * [8:0] - Threshold level 6
> +		 * e.g. EXYNOS7_THD_TEMP_RISE5_4 (0x54)
> +		 * [24:16] - Threshold level 5
> +		 * [8:0] - Threshold level 4
> +		 *
> +		 * and similarly for falling thresholds.
> +		 *
> +		 * Based on the above, calculate the register and bit offsets
> +		 * for rising/falling threshold levels and populate them.
> +		 */
> +		reg_off =3D ((7 - i) / 2) * 4;
> +		bit_off =3D ((8 - i) % 2);
> +
> +		tz->ops->get_trip_temp(tz, i, &temp);
> +		temp /=3D MCELSIUS;
> +
> +		tz->ops->get_trip_hyst(tz, i, &temp_hist);
> +		temp_hist =3D temp - (temp_hist / MCELSIUS);
> +
> +		/* Set 9-bit temperature code for rising threshold levels */
> +		threshold_code =3D temp_to_code(data, temp);
> +		rising_threshold =3D readl(data->base +
> +			EXYNOS7_THD_TEMP_RISE7_6 + reg_off);
> +		rising_threshold &=3D ~(EXYNOS7_TMU_TEMP_MASK << (16 * bit_off));
> +		rising_threshold |=3D threshold_code << (16 * bit_off);
> +		writel(rising_threshold,
> +		       data->base + EXYNOS7_THD_TEMP_RISE7_6 + reg_off);
> +
> +		/* Set 9-bit temperature code for falling threshold levels */
> +		threshold_code =3D temp_to_code(data, temp_hist);
> +		falling_threshold &=3D ~(EXYNOS7_TMU_TEMP_MASK << (16 * bit_off));
> +		falling_threshold |=3D threshold_code << (16 * bit_off);
> +		writel(falling_threshold,
> +		       data->base + EXYNOS7_THD_TEMP_FALL7_6 + reg_off);
> +	}
> +
> +	data->tmu_clear_irqs(data);
> +out:
> +	return ret;
> +}
> +
>  static void exynos4210_tmu_control(struct platform_device *pdev, bool on)
>  {
>  	struct exynos_tmu_data *data =3D platform_get_drvdata(pdev);
> @@ -573,6 +672,46 @@ static void exynos5440_tmu_control(struct platform_d=
evice *pdev, bool on)
>  	writel(con, data->base + EXYNOS5440_TMU_S0_7_CTRL);
>  }
> =20
> +static void exynos7_tmu_control(struct platform_device *pdev, bool on)
> +{
> +	struct exynos_tmu_data *data =3D platform_get_drvdata(pdev);
> +	struct thermal_zone_device *tz =3D data->tzd;
> +	unsigned int con, interrupt_en;
> +
> +	con =3D get_con_reg(data, readl(data->base + EXYNOS_TMU_REG_CONTROL));
> +
> +	if (on) {
> +		con |=3D (1 << EXYNOS_TMU_CORE_EN_SHIFT);
> +		interrupt_en =3D
> +			(of_thermal_is_trip_valid(tz, 7)
> +			<< EXYNOS7_TMU_INTEN_RISE7_SHIFT) |
> +			(of_thermal_is_trip_valid(tz, 6)
> +			<< EXYNOS7_TMU_INTEN_RISE6_SHIFT) |
> +			(of_thermal_is_trip_valid(tz, 5)
> +			<< EXYNOS7_TMU_INTEN_RISE5_SHIFT) |
> +			(of_thermal_is_trip_valid(tz, 4)
> +			<< EXYNOS7_TMU_INTEN_RISE4_SHIFT) |
> +			(of_thermal_is_trip_valid(tz, 3)
> +			<< EXYNOS7_TMU_INTEN_RISE3_SHIFT) |
> +			(of_thermal_is_trip_valid(tz, 2)
> +			<< EXYNOS7_TMU_INTEN_RISE2_SHIFT) |
> +			(of_thermal_is_trip_valid(tz, 1)
> +			<< EXYNOS7_TMU_INTEN_RISE1_SHIFT) |
> +			(of_thermal_is_trip_valid(tz, 0)
> +			<< EXYNOS7_TMU_INTEN_RISE0_SHIFT);
> +
> +		interrupt_en |=3D
> +			interrupt_en << EXYNOS_TMU_INTEN_FALL0_SHIFT;
> +	} else {
> +		con &=3D ~(1 << EXYNOS_TMU_CORE_EN_SHIFT);
> +		interrupt_en =3D 0; /* Disable all interrupts */
> +	}
> +	con |=3D 1 << EXYNOS7_PD_DET_EN_SHIFT;
> +
> +	writel(interrupt_en, data->base + EXYNOS7_TMU_REG_INTEN);
> +	writel(con, data->base + EXYNOS_TMU_REG_CONTROL);
> +}
> +
>  static int exynos_get_temp(void *p, long *temp)
>  {
>  	struct exynos_tmu_data *data =3D p;
> @@ -602,9 +741,19 @@ static u32 get_emul_con_reg(struct exynos_tmu_data *=
data, unsigned int val,
>  			val &=3D ~(EXYNOS_EMUL_TIME_MASK << EXYNOS_EMUL_TIME_SHIFT);
>  			val |=3D (EXYNOS_EMUL_TIME << EXYNOS_EMUL_TIME_SHIFT);
>  		}
> -		val &=3D ~(EXYNOS_EMUL_DATA_MASK << EXYNOS_EMUL_DATA_SHIFT);
> -		val |=3D (temp_to_code(data, temp) << EXYNOS_EMUL_DATA_SHIFT) |
> -			EXYNOS_EMUL_ENABLE;
> +		if (data->soc =3D=3D SOC_ARCH_EXYNOS7) {
> +			val &=3D ~(EXYNOS7_EMUL_DATA_MASK <<
> +				EXYNOS7_EMUL_DATA_SHIFT);
> +			val |=3D (temp_to_code(data, temp) <<
> +				EXYNOS7_EMUL_DATA_SHIFT) |
> +				EXYNOS_EMUL_ENABLE;
> +		} else {
> +			val &=3D ~(EXYNOS_EMUL_DATA_MASK <<
> +				EXYNOS_EMUL_DATA_SHIFT);
> +			val |=3D (temp_to_code(data, temp) <<
> +				EXYNOS_EMUL_DATA_SHIFT) |
> +				EXYNOS_EMUL_ENABLE;
> +		}
>  	} else {
>  		val &=3D ~EXYNOS_EMUL_ENABLE;
>  	}
> @@ -620,6 +769,8 @@ static void exynos4412_tmu_set_emulation(struct exyno=
s_tmu_data *data,
> =20
>  	if (data->soc =3D=3D SOC_ARCH_EXYNOS5260)
>  		emul_con =3D EXYNOS5260_EMUL_CON;
> +	else if (data->soc =3D=3D SOC_ARCH_EXYNOS7)
> +		emul_con =3D EXYNOS7_TMU_REG_EMUL_CON;
>  	else
>  		emul_con =3D EXYNOS_EMUL_CON;
> =20
> @@ -683,6 +834,12 @@ static int exynos5440_tmu_read(struct exynos_tmu_dat=
a *data)
>  	return readb(data->base + EXYNOS5440_TMU_S0_7_TEMP);
>  }
> =20
> +static int exynos7_tmu_read(struct exynos_tmu_data *data)
> +{
> +	return readw(data->base + EXYNOS_TMU_REG_CURRENT_TEMP) &
> +		EXYNOS7_TMU_TEMP_MASK;
> +}
> +
>  static void exynos_tmu_work(struct work_struct *work)
>  {
>  	struct exynos_tmu_data *data =3D container_of(work,
> @@ -721,6 +878,8 @@ static void exynos4210_tmu_clear_irqs(struct exynos_t=
mu_data *data)
>  	if (data->soc =3D=3D SOC_ARCH_EXYNOS5260) {
>  		tmu_intstat =3D EXYNOS5260_TMU_REG_INTSTAT;
>  		tmu_intclear =3D EXYNOS5260_TMU_REG_INTCLEAR;
> +	} else if (data->soc =3D=3D SOC_ARCH_EXYNOS7) {
> +		tmu_intstat =3D tmu_intclear =3D EXYNOS7_TMU_REG_INTPEND;
>  	} else {
>  		tmu_intstat =3D EXYNOS_TMU_REG_INTSTAT;
>  		tmu_intclear =3D EXYNOS_TMU_REG_INTCLEAR;
> @@ -782,6 +941,9 @@ static const struct of_device_id exynos_tmu_match[] =
=3D {
>  	{
>  		.compatible =3D "samsung,exynos5440-tmu",
>  	},
> +	{
> +		.compatible =3D "samsung,exynos7-tmu",
> +	},
>  	{},
>  };
>  MODULE_DEVICE_TABLE(of, exynos_tmu_match);
> @@ -805,6 +967,8 @@ static int exynos_of_get_soc_type(struct device_node =
*np)
>  		return SOC_ARCH_EXYNOS5420_TRIMINFO;
>  	else if (of_device_is_compatible(np, "samsung,exynos5440-tmu"))
>  		return SOC_ARCH_EXYNOS5440;
> +	else if (of_device_is_compatible(np, "samsung,exynos7-tmu"))
> +		return SOC_ARCH_EXYNOS7;
> =20
>  	return -EINVAL;
>  }
> @@ -928,6 +1092,13 @@ static int exynos_map_dt_data(struct platform_devic=
e *pdev)
>  		data->tmu_set_emulation =3D exynos5440_tmu_set_emulation;
>  		data->tmu_clear_irqs =3D exynos5440_tmu_clear_irqs;
>  		break;
> +	case SOC_ARCH_EXYNOS7:
> +		data->tmu_initialize =3D exynos7_tmu_initialize;
> +		data->tmu_control =3D exynos7_tmu_control;
> +		data->tmu_read =3D exynos7_tmu_read;
> +		data->tmu_set_emulation =3D exynos4412_tmu_set_emulation;
> +		data->tmu_clear_irqs =3D exynos4210_tmu_clear_irqs;
> +		break;
>  	default:
>  		dev_err(&pdev->dev, "Platform not supported\n");
>  		return -EINVAL;
> @@ -1018,21 +1189,37 @@ static int exynos_tmu_probe(struct platform_devic=
e *pdev)
>  		goto err_clk_sec;
>  	}
> =20
> +	if (data->soc =3D=3D SOC_ARCH_EXYNOS7) {
> +		data->sclk =3D devm_clk_get(&pdev->dev, "tmu_sclk");
> +		if (IS_ERR(data->sclk)) {
> +			dev_err(&pdev->dev, "Failed to get sclk\n");
> +			goto err_clk;
> +		} else {
> +			ret =3D clk_prepare_enable(data->sclk);
> +			if (ret) {
> +				dev_err(&pdev->dev, "Failed to enable sclk\n");
> +				goto err_clk;
> +			}
> +		}
> +	}
> +
>  	ret =3D exynos_tmu_initialize(pdev);
>  	if (ret) {
>  		dev_err(&pdev->dev, "Failed to initialize TMU\n");
> -		goto err_clk;
> +		goto err_sclk;
>  	}
> =20
>  	ret =3D devm_request_irq(&pdev->dev, data->irq, exynos_tmu_irq,
>  		IRQF_TRIGGER_RISING | IRQF_SHARED, dev_name(&pdev->dev), data);
>  	if (ret) {
>  		dev_err(&pdev->dev, "Failed to request irq: %d\n", data->irq);
> -		goto err_clk;
> +		goto err_sclk;
>  	}
> =20
>  	exynos_tmu_control(pdev, true);
>  	return 0;
> +err_sclk:
> +	clk_disable_unprepare(data->sclk);
>  err_clk:
>  	clk_unprepare(data->clk);
>  err_clk_sec:
> @@ -1052,6 +1239,7 @@ static int exynos_tmu_remove(struct platform_device=
 *pdev)
>  	thermal_zone_of_sensor_unregister(&pdev->dev, tzd);
>  	exynos_tmu_control(pdev, false);
> =20
> +	clk_disable_unprepare(data->sclk);
>  	clk_unprepare(data->clk);
>  	if (!IS_ERR(data->clk_sec))
>  		clk_unprepare(data->clk_sec);
> diff --git a/drivers/thermal/samsung/exynos_tmu.h b/drivers/thermal/samsu=
ng/exynos_tmu.h
> index 9f9b1b8..4d71ec6 100644
> --- a/drivers/thermal/samsung/exynos_tmu.h
> +++ b/drivers/thermal/samsung/exynos_tmu.h
> @@ -34,6 +34,7 @@ enum soc_type {
>  	SOC_ARCH_EXYNOS5420,
>  	SOC_ARCH_EXYNOS5420_TRIMINFO,
>  	SOC_ARCH_EXYNOS5440,
> +	SOC_ARCH_EXYNOS7,
>  };
> =20
>  /**
> --=20
> 1.7.9.5
>=20

--w7PDEPdKQumQfZlR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUzSvbAAoJEMLUO4d9pOJWqq0H/3gOvqWToSxg6eBM9wbA1WrO
WNH+1zRZf1vl6HDFUxIjvjcTBkmWB0O5sa/fR3B5cKRUXBxvWTJGoWMmSInOGwgF
4HuaQbrpBJ1aN0GRIvE7+p9FYjsIDfLeXNTRZAARoznjVkUWW9eheNn9CQi8rCbz
1oMj+M+f8MMrT0GXZfuXjbmXusRBA9R9g41JySkPkSZMTBylkP+9xEFC9nZaocek
tWJGLrKTT1+CcCgyNvLvgwQJ9FqDgQVxoAM/+womUHC5TB3/7oQV5m3DG7iw7K5u
eTUk1nCRu59yIBc4Z+GxeP1KWQTuynoaDfM0DBMK4CQgF1W0Rfk+rYfrzmtJP9Q=
=SXGq
-----END PGP SIGNATURE-----

--w7PDEPdKQumQfZlR--
