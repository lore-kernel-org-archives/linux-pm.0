From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: Re: [PATCH 21/21] thermal: exynos: Make Exynos3250 TMU compatible with
 Exynos4412
Date: Fri, 10 Oct 2014 08:34:22 +0900
Message-ID: <54371B7E.5010600@samsung.com>
References: <1412872737-624-1-git-send-email-l.majewski@samsung.com>
 <1412872737-624-22-git-send-email-l.majewski@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:38829 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750918AbaJIXeZ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 9 Oct 2014 19:34:25 -0400
In-reply-to: <1412872737-624-22-git-send-email-l.majewski@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lukasz Majewski <l.majewski@samsung.com>
Cc: Eduardo Valentin <edubezval@gmail.com>, Zhang Rui <rui.zhang@intel.com>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, linux-arm-kernel@lists.infradead.org, Linux PM list <linux-pm@vger.kernel.org>, Kukjin Kim <kgene.kim@samsung.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Lukasz Majewski <l.majewski@majess.pl>, Amit Daniel Kachhap <amit.daniel@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>

On 10/10/2014 01:38 AM, Lukasz Majewski wrote:
> Since both SoCs have the same TMU IP block embedded on them, it is
> not necessary to maintain separate compatible entry.
> 
> Signed-off-by: Lukasz Majewski <l.majewski@samsung.com>
> ---
>  drivers/thermal/samsung/exynos_tmu.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/drivers/thermal/samsung/exynos_tmu.c b/drivers/thermal/samsung/exynos_tmu.c
> index f1e8c9b..7818e2f 100644
> --- a/drivers/thermal/samsung/exynos_tmu.c
> +++ b/drivers/thermal/samsung/exynos_tmu.c
> @@ -744,9 +744,6 @@ static irqreturn_t exynos_tmu_irq(int irq, void *id)
>  
>  static const struct of_device_id exynos_tmu_match[] = {
>  	{
> -		.compatible = "samsung,exynos3250-tmu",
> -	},
> -	{

If you want to remove compatible string for Exynos3250,
you have to modify it on exynos3250.dtsi.

Thanks,
Chanwoo Choi
