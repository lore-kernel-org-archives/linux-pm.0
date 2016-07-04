From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: Re: [PATCH v2 1/1] devfreq: exynos-bus: add missing of_node_put after
 calling of_parse_phandle
Date: Mon, 04 Jul 2016 12:31:29 +0900
Message-ID: <5779D891.30405@samsung.com>
References: <CGME20160704025548epcas1p2869c5b59279f7a997b0dc0425d6a9d88@epcas1p2.samsung.com>
 <1467600466-13667-1-git-send-email-peter.chen@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:37830 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932386AbcGDDbc (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 3 Jul 2016 23:31:32 -0400
In-reply-to: <1467600466-13667-1-git-send-email-peter.chen@nxp.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Peter Chen <peter.chen@nxp.com>, myungjoo.ham@samsung.com, kyungmin.park@samsung.com
Cc: linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <k.kozlowski@samsung.com>

On 2016=EB=85=84 07=EC=9B=94 04=EC=9D=BC 11:47, Peter Chen wrote:
> of_node_put needs to be called when the device node which is got
> from of_parse_phandle has finished using.
>=20
> Cc: Chanwoo Choi <cw00.choi@samsung.com>
> Cc: MyungJoo Ham <myungjoo.ham@samsung.com>
> Cc: Kyungmin Park <kyungmin.park@samsung.com>
> Cc: Kukjin Kim <kgene@kernel.org>
> Cc: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> Signed-off-by: Peter Chen <peter.chen@nxp.com>
> ---
>=20
> Changes at v2:
> - It should define node as pointer, kbuild test robot reports it
>=20
>=20
>  drivers/devfreq/exynos-bus.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/devfreq/exynos-bus.c b/drivers/devfreq/exynos-bu=
s.c
> index 2363d0a..4b4c63c 100644
> --- a/drivers/devfreq/exynos-bus.c
> +++ b/drivers/devfreq/exynos-bus.c
> @@ -383,7 +383,7 @@ err_clk:
>  static int exynos_bus_probe(struct platform_device *pdev)
>  {
>  	struct device *dev =3D &pdev->dev;
> -	struct device_node *np =3D dev->of_node;
> +	struct device_node *node, *np =3D dev->of_node;
>  	struct devfreq_dev_profile *profile;
>  	struct devfreq_simple_ondemand_data *ondemand_data;
>  	struct devfreq_passive_data *passive_data;
> @@ -415,10 +415,13 @@ static int exynos_bus_probe(struct platform_dev=
ice *pdev)
>  		goto err;
>  	}
> =20
> -	if (of_parse_phandle(dev->of_node, "devfreq", 0))
> +	node =3D of_parse_phandle(dev->of_node, "devfreq", 0);
> +	if (node) {
> +		of_node_put(node);
>  		goto passive;
> -	else
> +	} else {
>  		ret =3D exynos_bus_parent_parse_of(np, bus);
> +	}
> =20
>  	if (ret < 0)
>  		goto err;
>=20

Acked-by: Chanwoo Choi <cw00.choi@samsung.com>

Thanks,
Chanwoo Choi
