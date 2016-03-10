From: Caesar Wang <caesar.upstream@gmail.com>
Subject: Re: [PATCH 10/13] thermal: convert rockchip_thermal to use
 devm_thermal_zone_of_sensor_register
Date: Thu, 10 Mar 2016 10:36:35 +0800
Message-ID: <56E0DDB3.8080405@gmail.com>
References: <1457559336-17652-1-git-send-email-edubezval@gmail.com>
 <1457559336-17652-11-git-send-email-edubezval@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f193.google.com ([209.85.192.193]:34129 "EHLO
	mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753653AbcCJCgl (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 9 Mar 2016 21:36:41 -0500
In-Reply-To: <1457559336-17652-11-git-send-email-edubezval@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>
Cc: Rui Zhang <rui.zhang@intel.com>, Heiko Stuebner <heiko@sntech.de>, Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, lm-sensors@lm-sensors.org, linux-rockchip@lists.infradead.org, linux-arm-kernel@lists.infradead.org



=E5=9C=A8 2016=E5=B9=B403=E6=9C=8810=E6=97=A5 05:35, Eduardo Valentin =E5=
=86=99=E9=81=93:
> This changes the driver to use the devm_ version
> of thermal_zone_of_sensor_register and cleans
> up the  local points and unregister calls.
>
> Cc: Zhang Rui <rui.zhang@intel.com>
> Cc: Heiko Stuebner <heiko@sntech.de>
> Cc: linux-pm@vger.kernel.org
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-rockchip@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Eduardo Valentin <edubezval@gmail.com>

Tested-by: Caesar Wang <wxt@rock-chips.com>
Reviewed-by: Caesar Wang <wxt@rock-chips.com>

I just cherry-pick the devm* patches to test the rockchip thermal.

> ---
>   drivers/thermal/rockchip_thermal.c | 17 ++++-------------
>   1 file changed, 4 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/thermal/rockchip_thermal.c b/drivers/thermal/roc=
kchip_thermal.c
> index b58e3fb..792c5d0 100644
> --- a/drivers/thermal/rockchip_thermal.c
> +++ b/drivers/thermal/rockchip_thermal.c
> @@ -753,8 +753,8 @@ rockchip_thermal_register_sensor(struct platform_=
device *pdev,
>  =20
>   	sensor->thermal =3D thermal;
>   	sensor->id =3D id;
> -	sensor->tzd =3D thermal_zone_of_sensor_register(&pdev->dev, id, sen=
sor,
> -						      &rockchip_of_thermal_ops);
> +	sensor->tzd =3D devm_thermal_zone_of_sensor_register(&pdev->dev, id=
,
> +					sensor, &rockchip_of_thermal_ops);
>   	if (IS_ERR(sensor->tzd)) {
>   		error =3D PTR_ERR(sensor->tzd);
>   		dev_err(&pdev->dev, "failed to register sensor %d: %d\n",
> @@ -782,7 +782,7 @@ static int rockchip_thermal_probe(struct platform=
_device *pdev)
>   	const struct of_device_id *match;
>   	struct resource *res;
>   	int irq;
> -	int i, j;
> +	int i;
>   	int error;
>  =20
>   	match =3D of_match_node(of_rockchip_thermal_match, np);
> @@ -865,9 +865,6 @@ static int rockchip_thermal_probe(struct platform=
_device *pdev)
>   			dev_err(&pdev->dev,
>   				"failed to register sensor[%d] : error =3D %d\n",
>   				i, error);
> -			for (j =3D 0; j < i; j++)
> -				thermal_zone_of_sensor_unregister(&pdev->dev,
> -						thermal->sensors[j].tzd);
>   			goto err_disable_pclk;
>   		}
>   	}
> @@ -879,7 +876,7 @@ static int rockchip_thermal_probe(struct platform=
_device *pdev)
>   	if (error) {
>   		dev_err(&pdev->dev,
>   			"failed to request tsadc irq: %d\n", error);
> -		goto err_unregister_sensor;
> +		goto err_disable_pclk;
>   	}
>  =20
>   	thermal->chip->control(thermal->regs, true);
> @@ -891,11 +888,6 @@ static int rockchip_thermal_probe(struct platfor=
m_device *pdev)
>  =20
>   	return 0;
>  =20
> -err_unregister_sensor:
> -	while (i--)
> -		thermal_zone_of_sensor_unregister(&pdev->dev,
> -						  thermal->sensors[i].tzd);
> -
>   err_disable_pclk:
>   	clk_disable_unprepare(thermal->pclk);
>   err_disable_clk:
> @@ -913,7 +905,6 @@ static int rockchip_thermal_remove(struct platfor=
m_device *pdev)
>   		struct rockchip_thermal_sensor *sensor =3D &thermal->sensors[i];
>  =20
>   		rockchip_thermal_toggle_sensor(sensor, false);
> -		thermal_zone_of_sensor_unregister(&pdev->dev, sensor->tzd);
>   	}
>  =20
>   	thermal->chip->control(thermal->regs, false);


--=20
Thanks,
Caesar

