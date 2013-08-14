From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 8/29] drivers/cpuidle/cpuidle-kirkwood.c: simplify use of devm_ioremap_resource
Date: Wed, 14 Aug 2013 15:09:29 +0200
Message-ID: <10943702.UYfHQJBDot@vostro.rjw.lan>
References: <1376471493-22215-1-git-send-email-Julia.Lawall@lip6.fr> <1376471493-22215-9-git-send-email-Julia.Lawall@lip6.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from hydra.sisk.pl ([212.160.235.94]:42430 "EHLO hydra.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932369Ab3HNM7H (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 14 Aug 2013 08:59:07 -0400
In-Reply-To: <1376471493-22215-9-git-send-email-Julia.Lawall@lip6.fr>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Julia Lawall <Julia.Lawall@lip6.fr>
Cc: kernel-janitors@vger.kernel.org, Daniel Lezcano <daniel.lezcano@linaro.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

On Wednesday, August 14, 2013 11:11:12 AM Julia Lawall wrote:
> From: Julia Lawall <Julia.Lawall@lip6.fr>
> 
> Remove unneeded error handling on the result of a call to
> platform_get_resource when the value is passed to devm_ioremap_resource.
> 
> A simplified version of the semantic patch that makes this change is as
> follows: (http://coccinelle.lip6.fr/)
> 
> // <smpl>
> @@
> expression pdev,res,n,e,e1;
> expression ret != 0;
> identifier l;
> @@
> 
> - res = platform_get_resource(pdev, IORESOURCE_MEM, n);
>   ... when != res
> - if (res == NULL) { ... \(goto l;\|return ret;\) }
>   ... when != res
> + res = platform_get_resource(pdev, IORESOURCE_MEM, n);
>   e = devm_ioremap_resource(e1, res);
> // </smpl>
> 
> Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

Queued up for 3.12.

Thanks,
Rafael


> ---
>  drivers/cpuidle/cpuidle-kirkwood.c |    3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/drivers/cpuidle/cpuidle-kirkwood.c b/drivers/cpuidle/cpuidle-kirkwood.c
> index 521b0a7..2237135 100644
> --- a/drivers/cpuidle/cpuidle-kirkwood.c
> +++ b/drivers/cpuidle/cpuidle-kirkwood.c
> @@ -60,9 +60,6 @@ static int kirkwood_cpuidle_probe(struct platform_device *pdev)
>  	struct resource *res;
>  
>  	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -	if (res == NULL)
> -		return -EINVAL;
> -
>  	ddr_operation_base = devm_ioremap_resource(&pdev->dev, res);
>  	if (IS_ERR(ddr_operation_base))
>  		return PTR_ERR(ddr_operation_base);
> 
-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
