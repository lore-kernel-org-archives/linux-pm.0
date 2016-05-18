From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: Re: [patch] PM / devfreq: exynos-nocp: Checking for IS_ERR instead of
 NULL
Date: Wed, 18 May 2016 19:57:28 +0900
Message-ID: <573C4A98.9060500@samsung.com>
References: <20160518103707.GA9436@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <kernel-janitors-owner@vger.kernel.org>
In-reply-to: <20160518103707.GA9436@mwanda>
Sender: kernel-janitors-owner@vger.kernel.org
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: MyungJoo Ham <myungjoo.ham@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org, kernel-janitors@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hi Dan,

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

Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>

Thanks,
Chanwoo Choi


--
To unsubscribe from this list: send the line "unsubscribe kernel-janito=
rs" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
