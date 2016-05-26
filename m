From: Julia Lawall <julia.lawall@lip6.fr>
Subject: Re: [patch v2] PM / devfreq: exynos-nocp: Remove incorrect IS_ERR()
 check
Date: Thu, 26 May 2016 13:13:00 +0200 (CEST)
Message-ID: <alpine.DEB.2.10.1605261312400.3786@hadrien>
References: <20160526064541.GA6680@mwanda>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <20160526064541.GA6680@mwanda>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Chanwoo Choi <cw00.choi@samsung.com>, Julia Lawall <julia.lawall@lip6.fr>, MyungJoo Ham <myungjoo.ham@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org, kernel-janitors@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Reviewed-by: Julia Lawall <julia.lawall@lip6.fr>

On Thu, 26 May 2016, Dan Carpenter wrote:

> Smatch complains because platform_get_resource() returns NULL on error
> and not an error pointer so the check is wrong.  Julia Lawall pointed
> out that normally we don't check these, because devm_ioremap_resource()
> has a check for NULL.
>
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
> v2: just remove the check
>
> diff --git a/drivers/devfreq/event/exynos-nocp.c b/drivers/devfreq/event/exynos-nocp.c
> index 6b6a5f3..a584140 100644
> --- a/drivers/devfreq/event/exynos-nocp.c
> +++ b/drivers/devfreq/event/exynos-nocp.c
> @@ -220,9 +220,6 @@ static int exynos_nocp_parse_dt(struct platform_device *pdev,
>
>  	/* Maps the memory mapped IO to control nocp register */
>  	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -	if (IS_ERR(res))
> -		return PTR_ERR(res);
> -
>  	base = devm_ioremap_resource(dev, res);
>  	if (IS_ERR(base))
>  		return PTR_ERR(base);
> --
> To unsubscribe from this list: send the line "unsubscribe kernel-janitors" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
