From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: Re: [patch] PM / devfreq: exynos-nocp: Checking for IS_ERR instead of
 NULL
Date: Wed, 25 May 2016 21:34:28 +0900
Message-ID: <57459BD4.1030201@samsung.com>
References: <20160518103707.GA9436@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:35013 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750733AbcEYMec (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 25 May 2016 08:34:32 -0400
In-reply-to: <20160518103707.GA9436@mwanda>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: MyungJoo Ham <myungjoo.ham@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org, kernel-janitors@vger.kernel.org

On 2016=EB=85=84 05=EC=9B=94 18=EC=9D=BC 19:37, Dan Carpenter wrote:
> The platform_get_resource() function returns NULL on error, it never
> returns error pointers.
>=20
> Fixes: 0179a913875a ('PM / devfreq: event: Add new Exynos NoC probe d=
river')
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
>=20
> diff --git a/drivers/devfreq/event/exynos-nocp.c b/drivers/devfreq/ev=
ent/exynos-nocp.c
> index 6b6a5f3..03b35d5 100644
> --- a/drivers/devfreq/event/exynos-nocp.c
> +++ b/drivers/devfreq/event/exynos-nocp.c
> @@ -220,8 +220,8 @@ static int exynos_nocp_parse_dt(struct platform_d=
evice *pdev,
> =20
>  	/* Maps the memory mapped IO to control nocp register */
>  	res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -	if (IS_ERR(res))
> -		return PTR_ERR(res);
> +	if (!res)
> +		return -ENXIO;
> =20
>  	base =3D devm_ioremap_resource(dev, res);
>  	if (IS_ERR(base))

Looks good to me.

Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>

Thanks,
Chanwoo Choi

