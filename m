From: MyungJoo Ham <myungjoo.ham@samsung.com>
Subject: Re: [patch v2] PM / devfreq: exynos-nocp: Remove incorrect IS_ERR() check
Date: Wed, 1 Jun 2016 19:25:14 +0900
Message-ID: <CAJ0PZbR4j+8dRpOsvEtdsu2Z7hoXN1UOD70qoJ5q3oMG4X+yDw@mail.gmail.com>
References: <alpine.DEB.2.10.1605251710500.3644@hadrien> <20160526064541.GA6680@mwanda>
Reply-To: myungjoo.ham@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oi0-f67.google.com ([209.85.218.67]:33194 "EHLO
	mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751433AbcFAKZ3 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 1 Jun 2016 06:25:29 -0400
In-Reply-To: <20160526064541.GA6680@mwanda>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Chanwoo Choi <cw00.choi@samsung.com>, Julia Lawall <julia.lawall@lip6.fr>, Kyungmin Park <kyungmin.park@samsung.com>, Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, Linux PM list <linux-pm@vger.kernel.org>, Linux Samsung SoC <linux-samsung-soc@vger.kernel.org>, kernel-janitors@vger.kernel.org

On Thu, May 26, 2016 at 3:45 PM, Dan Carpenter <dan.carpenter@oracle.com> wrote:
> Smatch complains because platform_get_resource() returns NULL on error
> and not an error pointer so the check is wrong.  Julia Lawall pointed
> out that normally we don't check these, because devm_ioremap_resource()
> has a check for NULL.
>
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

Acked-by: MyungJoo Ham <myungjoo.ham@samsung.com>

Queued in fixes branch to be sent with other fixes for RCx.

> ---
> v2: just remove the check
>
> diff --git a/drivers/devfreq/event/exynos-nocp.c b/drivers/devfreq/event/exynos-nocp.c
> index 6b6a5f3..a584140 100644
> --- a/drivers/devfreq/event/exynos-nocp.c
> +++ b/drivers/devfreq/event/exynos-nocp.c
> @@ -220,9 +220,6 @@ static int exynos_nocp_parse_dt(struct platform_device *pdev,
>
>         /* Maps the memory mapped IO to control nocp register */
>         res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -       if (IS_ERR(res))
> -               return PTR_ERR(res);
> -
>         base = devm_ioremap_resource(dev, res);
>         if (IS_ERR(base))
>                 return PTR_ERR(base);
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pm" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
MyungJoo Ham, Ph.D.
Frontier CS Lab, S/W Center, Samsung Electronics
