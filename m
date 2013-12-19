From: Eduardo Valentin <eduardo.valentin@ti.com>
Subject: Re: [PATCH V3 2/2] thermal: imx: add necessary clk operation
Date: Thu, 19 Dec 2013 09:12:57 -0400
Message-ID: <52B2F0D9.2020704@ti.com>
References: <1387487791-3259-1-git-send-email-b20788@freescale.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="rUBDlWxtxjpE5tkeKGR6TbLdxaEgTrPI1"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:45759 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757630Ab3LSNNq (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 19 Dec 2013 08:13:46 -0500
In-Reply-To: <1387487791-3259-1-git-send-email-b20788@freescale.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Anson Huang <b20788@freescale.com>
Cc: shawn.guo@linaro.org, kernel@pengutronix.de, rui.zhang@intel.com, eduardo.valentin@ti.com, devicetree@vger.kernel.org, linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org

--rUBDlWxtxjpE5tkeKGR6TbLdxaEgTrPI1
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 19-12-2013 17:16, Anson Huang wrote:
> Thermal sensor needs pll3_usb_otg when measuring temperature,
> otherwise the temperature read will be incorrect, so need to
> enable this clk before sensor working, for alarm function,
> as hardware will take measurement periodically, so we should
> keep this clk always on once alarm function is enabled.
>=20
> Signed-off-by: Anson Huang <b20788@freescale.com>
> ---
>  .../devicetree/bindings/thermal/imx-thermal.txt    |    4 ++++
>  drivers/thermal/imx_thermal.c                      |   18 ++++++++++++=
++++++
>  2 files changed, 22 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/thermal/imx-thermal.txt =
b/Documentation/devicetree/bindings/thermal/imx-thermal.txt
> index 541c25e..1f0f672 100644
> --- a/Documentation/devicetree/bindings/thermal/imx-thermal.txt
> +++ b/Documentation/devicetree/bindings/thermal/imx-thermal.txt
> @@ -8,10 +8,14 @@ Required properties:
>    calibration data, e.g. OCOTP on imx6q.  The details about calibratio=
n data
>    can be found in SoC Reference Manual.
> =20
> +Optional properties:
> +- clocks : thermal sensor's clock source.
> +
>  Example:
> =20
>  tempmon {
>  	compatible =3D "fsl,imx6q-tempmon";
>  	fsl,tempmon =3D <&anatop>;
>  	fsl,tempmon-data =3D <&ocotp>;
> +	clocks =3D <&clks 172>;
>  };
> diff --git a/drivers/thermal/imx_thermal.c b/drivers/thermal/imx_therma=
l.c
> index 1d6c801..c2b8173 100644
> --- a/drivers/thermal/imx_thermal.c
> +++ b/drivers/thermal/imx_thermal.c
> @@ -7,6 +7,7 @@
>   *
>   */
> =20
> +#include <linux/clk.h>
>  #include <linux/cpu_cooling.h>
>  #include <linux/cpufreq.h>
>  #include <linux/delay.h>
> @@ -73,6 +74,7 @@ struct imx_thermal_data {
>  	unsigned long last_temp;
>  	bool irq_enabled;
>  	int irq;
> +	struct clk *thermal_clk;
>  };
> =20
>  static void imx_set_alarm_temp(struct imx_thermal_data *data,
> @@ -457,6 +459,22 @@ static int imx_thermal_probe(struct platform_devic=
e *pdev)
>  		return ret;
>  	}
> =20

There are several reg writes before this point. Are you sure you won't
need this clock for performing those operations?

> +	data->thermal_clk =3D devm_clk_get(&pdev->dev, NULL);
> +	if (IS_ERR(data->thermal_clk)) {
> +		dev_warn(&pdev->dev, "failed to get thermal clk!\n");
> +	} else {
> +		/*
> +		 * Thermal sensor needs clk on to get correct value, normally
> +		 * we should enable its clk before taking measurement and disable
> +		 * clk after measurement is done, but if alarm function is enabled,
> +		 * hardware will auto measure the temperature periodically, so we
> +		 * need to keep the clk always on for alarm function.
> +		 */
> +		ret =3D clk_prepare_enable(data->thermal_clk);
> +		if (ret)
> +			dev_warn(&pdev->dev, "failed to enable thermal clk: %d\n", ret);
> +	}
> +
>  	/* Enable measurements at ~ 10 Hz */
>  	regmap_write(map, TEMPSENSE1 + REG_CLR, TEMPSENSE1_MEASURE_FREQ);
>  	measure_freq =3D DIV_ROUND_UP(32768, 10); /* 10 Hz */
>=20

Don't you need to release the clock when .remove is called either on
driver or device removal?

What about suspend / resume path? Do you want to keep this clock on when
suspending? Is it gonna work or prevent your system to enter low power
states?



--=20
You have got to be excited about what you are doing. (L. Lamport)

Eduardo Valentin


--rUBDlWxtxjpE5tkeKGR6TbLdxaEgTrPI1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iF4EAREIAAYFAlKy8OEACgkQCXcVR3XQvP1xigEAscjspMIy9C/zo+Qu1Im/CSM9
uGzPb55dirz4C55QOd8A/RYZV4E2i5YT3i2fFmQ0h2kMk+uPl/aMdfZeZ1COdcy7
=TTly
-----END PGP SIGNATURE-----

--rUBDlWxtxjpE5tkeKGR6TbLdxaEgTrPI1--
