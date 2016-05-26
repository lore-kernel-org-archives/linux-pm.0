From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: Re: [patch v2] PM / devfreq: exynos-nocp: Remove incorrect IS_ERR()
 check
Date: Thu, 26 May 2016 17:12:19 +0900
Message-ID: <5746AFE3.6030606@samsung.com>
References: <CGME20160526064612epcas1p4cb0d45fa11deafea51fa84974132afed@epcas1p4.samsung.com>
 <20160526064541.GA6680@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <20160526064541.GA6680@mwanda>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Dan Carpenter <dan.carpenter@oracle.com>, Julia Lawall <julia.lawall@lip6.fr>
Cc: MyungJoo Ham <myungjoo.ham@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org, kernel-janitors@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hi Dan,

On 2016=EB=85=84 05=EC=9B=94 26=EC=9D=BC 15:45, Dan Carpenter wrote:
> Smatch complains because platform_get_resource() returns NULL on erro=
r
> and not an error pointer so the check is wrong.  Julia Lawall pointed
> out that normally we don't check these, because devm_ioremap_resource=
()
> has a check for NULL.
>=20
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
> v2: just remove the check
>=20
> diff --git a/drivers/devfreq/event/exynos-nocp.c b/drivers/devfreq/ev=
ent/exynos-nocp.c
> index 6b6a5f3..a584140 100644
> --- a/drivers/devfreq/event/exynos-nocp.c
> +++ b/drivers/devfreq/event/exynos-nocp.c
> @@ -220,9 +220,6 @@ static int exynos_nocp_parse_dt(struct platform_d=
evice *pdev,
> =20
>  	/* Maps the memory mapped IO to control nocp register */
>  	res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -	if (IS_ERR(res))
> -		return PTR_ERR(res);
> -
>  	base =3D devm_ioremap_resource(dev, res);
>  	if (IS_ERR(base))
>  		return PTR_ERR(base);


I don't recommend that you mention the name of engineer on patch descri=
ption
directly. Except for this comment, looks good to me.

Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>

Thanks,
Chanwoo Choi
