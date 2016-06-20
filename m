From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: Re: [PATCH -next] PM / devfreq: event: Fix return value check in
 exynos_nocp_parse_dt()
Date: Mon, 20 Jun 2016 09:54:02 +0900
Message-ID: <57673EAA.2020506@samsung.com>
References: <CGME20160617181052epcas1p34d888fccc7f58186cd2b0e2b1fed3e39@epcas1p3.samsung.com>
 <1466187003-19823-1-git-send-email-weiyj_lk@163.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:42601 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751679AbcFTAy3 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 19 Jun 2016 20:54:29 -0400
In-reply-to: <1466187003-19823-1-git-send-email-weiyj_lk@163.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: weiyj_lk@163.com, MyungJoo Ham <myungjoo.ham@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <k.kozlowski@samsung.com>
Cc: Wei Yongjun <yongjun_wei@trendmicro.com.cn>, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org

Hi Wei,

On 2016=EB=85=84 06=EC=9B=94 18=EC=9D=BC 03:10, weiyj_lk@163.com wrote:
> From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
>=20
> In case of error, the function platform_get_resource() returns NULL
> pointer not ERR_PTR(). Remove unneeded error handling on the result
> of a call to platform_get_resource() since the value is passed to
> devm_ioremap_resource().

This same patch was already merged to devfreq git[1].

[1] https://git.kernel.org/cgit/linux/kernel/git/mzx/devfreq.git/commit=
/?h=3Dfixes&id=3D482c27865b9784831dad45b31c2b0a5c42376802

Thanks,
Chanwoo Choi

>=20
> Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
> ---
>  drivers/devfreq/event/exynos-nocp.c | 3 ---
>  1 file changed, 3 deletions(-)
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
>=20
>=20
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pm" i=
n
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20
>=20
>=20

