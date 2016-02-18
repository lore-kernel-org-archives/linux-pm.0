From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: Re: [PATCH 3/3] thermal: exynos: Print a message about exceeded number
 of supported trip-points
Date: Thu, 18 Feb 2016 14:31:59 +0900
Message-ID: <56C5574F.7090900@samsung.com>
References: <1455772460-20684-1-git-send-email-k.kozlowski@samsung.com>
 <1455772460-20684-3-git-send-email-k.kozlowski@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <1455772460-20684-3-git-send-email-k.kozlowski@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Krzysztof Kozlowski <k.kozlowski@samsung.com>, Kukjin Kim <kgene@kernel.org>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org, Lukasz Majewski <l.majewski@samsung.com>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, linux-pm@vger.kernel.org
Cc: Viresh Kumar <viresh.kumar@linaro.org>
List-Id: linux-pm@vger.kernel.org

On 2016=EB=85=84 02=EC=9B=94 18=EC=9D=BC 14:14, Krzysztof Kozlowski wro=
te:
> When DeviveTree contains more trip-points than SoC can configure
> (usually more than four) and polling mode is not enabled, then the
> remaining trip-points will be silently ignored. No interrupts will be
> generated for them.
>=20
> This might be quite dangerous when one provides DTB with a
> non-configurable critical trip-point, like (assuming four supported
> thresholds in TMU):
>  - alert @50 C (type: active),
>  - alert @60 C (type: active),
>  - alert @70 C (type: active),
>  - alert @80 C (type: active),
>  - critical @120 C (type: critical) <- no interrupts generated.
>=20
> This is a mistake in DTB so print a message in such case.
>=20
> Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> ---
>  drivers/thermal/samsung/exynos_tmu.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
>=20
> diff --git a/drivers/thermal/samsung/exynos_tmu.c b/drivers/thermal/s=
amsung/exynos_tmu.c
> index fa61eff88496..6c6f59ba7423 100644
> --- a/drivers/thermal/samsung/exynos_tmu.c
> +++ b/drivers/thermal/samsung/exynos_tmu.c
> @@ -184,6 +184,7 @@
>   * @temp_error2: fused value of the second point trim.
>   * @regulator: pointer to the TMU regulator structure.
>   * @reg_conf: pointer to structure to register with core thermal.
> + * @ntrip: number of supported trip points.
>   * @tmu_initialize: SoC specific TMU initialization method
>   * @tmu_control: SoC specific TMU control method
>   * @tmu_read: SoC specific TMU temperature read method
> @@ -203,6 +204,7 @@ struct exynos_tmu_data {
>  	u16 temp_error1, temp_error2;
>  	struct regulator *regulator;
>  	struct thermal_zone_device *tzd;
> +	unsigned int ntrip;
> =20
>  	int (*tmu_initialize)(struct platform_device *pdev);
>  	void (*tmu_control)(struct platform_device *pdev, bool on);
> @@ -346,6 +348,14 @@ static int exynos_tmu_initialize(struct platform=
_device *pdev)
>  	struct exynos_tmu_data *data =3D platform_get_drvdata(pdev);
>  	int ret;
> =20
> +	if (of_thermal_get_ntrips(data->tzd) > data->ntrip) {
> +		dev_info(&pdev->dev,
> +			 "More trip points than supported by this TMU.\n");
> +		dev_info(&pdev->dev,
> +			 "%d trip points should be configured in polling mode.\n",
> +			 (of_thermal_get_ntrips(data->tzd) - data->ntrip));
> +	}
> +
>  	mutex_lock(&data->lock);
>  	clk_enable(data->clk);
>  	if (!IS_ERR(data->clk_sec))
> @@ -1210,6 +1220,7 @@ static int exynos_map_dt_data(struct platform_d=
evice *pdev)
>  		data->tmu_control =3D exynos4210_tmu_control;
>  		data->tmu_read =3D exynos4210_tmu_read;
>  		data->tmu_clear_irqs =3D exynos4210_tmu_clear_irqs;
> +		data->ntrip =3D 4;
>  		break;
>  	case SOC_ARCH_EXYNOS3250:
>  	case SOC_ARCH_EXYNOS4412:
> @@ -1222,6 +1233,7 @@ static int exynos_map_dt_data(struct platform_d=
evice *pdev)
>  		data->tmu_read =3D exynos4412_tmu_read;
>  		data->tmu_set_emulation =3D exynos4412_tmu_set_emulation;
>  		data->tmu_clear_irqs =3D exynos4210_tmu_clear_irqs;
> +		data->ntrip =3D 4;
>  		break;
>  	case SOC_ARCH_EXYNOS5433:
>  		data->tmu_initialize =3D exynos5433_tmu_initialize;
> @@ -1229,6 +1241,7 @@ static int exynos_map_dt_data(struct platform_d=
evice *pdev)
>  		data->tmu_read =3D exynos4412_tmu_read;
>  		data->tmu_set_emulation =3D exynos4412_tmu_set_emulation;
>  		data->tmu_clear_irqs =3D exynos4210_tmu_clear_irqs;
> +		data->ntrip =3D 8;
>  		break;
>  	case SOC_ARCH_EXYNOS5440:
>  		data->tmu_initialize =3D exynos5440_tmu_initialize;
> @@ -1236,6 +1249,7 @@ static int exynos_map_dt_data(struct platform_d=
evice *pdev)
>  		data->tmu_read =3D exynos5440_tmu_read;
>  		data->tmu_set_emulation =3D exynos5440_tmu_set_emulation;
>  		data->tmu_clear_irqs =3D exynos5440_tmu_clear_irqs;
> +		data->ntrip =3D 4;
>  		break;
>  	case SOC_ARCH_EXYNOS7:
>  		data->tmu_initialize =3D exynos7_tmu_initialize;
> @@ -1243,6 +1257,7 @@ static int exynos_map_dt_data(struct platform_d=
evice *pdev)
>  		data->tmu_read =3D exynos7_tmu_read;
>  		data->tmu_set_emulation =3D exynos4412_tmu_set_emulation;
>  		data->tmu_clear_irqs =3D exynos4210_tmu_clear_irqs;
> +		data->ntrip =3D 8;
>  		break;
>  	default:
>  		dev_err(&pdev->dev, "Platform not supported\n");
>=20

Exynos5433 and Exynos7 have the 8 interrupt.

Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>

Best Regards,
Chanwoo Choi
