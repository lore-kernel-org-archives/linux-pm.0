From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: Re: [PATCH RFC v2 02/16] PM / Domains: Remove dev->driver check for
 runtime PM
Date: Mon, 29 Jun 2015 09:40:12 +0900
Message-ID: <559093EC.8050002@samsung.com>
References: <1435374156-19214-1-git-send-email-lina.iyer@linaro.org>
 <1435374156-19214-3-git-send-email-lina.iyer@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout3.w1.samsung.com ([210.118.77.13]:31815 "EHLO
	mailout3.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752996AbbF2AkS (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 28 Jun 2015 20:40:18 -0400
Received: from eucpsbgm2.samsung.com (unknown [203.254.199.245])
 by mailout3.w1.samsung.com
 (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5 2014))
 with ESMTP id <0NQO00189KJ4VR20@mailout3.w1.samsung.com> for
 linux-pm@vger.kernel.org; Mon, 29 Jun 2015 01:40:16 +0100 (BST)
In-reply-to: <1435374156-19214-3-git-send-email-lina.iyer@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lina Iyer <lina.iyer@linaro.org>, rjw@rjwysocki.net, ulf.hansson@linaro.org, khilman@linaro.org
Cc: geert@linux-m68k.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, msivasub@codeaurora.org, agross@codeaurora.org

On 27.06.2015 12:02, Lina Iyer wrote:
> Remove check for driver of a device, for runtime PM. Device may be
> suspended without an explicit driver. This check seems to be vestigial
> and incorrect in the current context.
> 
> Signed-off-by: Kevin Hilman <khilman@linaro.org>
> Signed-off-by: Lina Iyer <lina.iyer@linaro.org>
> ---
>  drivers/base/power/domain.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)


Makes sense,
Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>


Best regards,
Krzysztof

> 
> diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
> index 44af889..e9b7cfb 100644
> --- a/drivers/base/power/domain.c
> +++ b/drivers/base/power/domain.c
> @@ -391,8 +391,7 @@ static int pm_genpd_poweroff(struct generic_pm_domain *genpd)
>  		if (stat > PM_QOS_FLAGS_NONE)
>  			return -EBUSY;
>  
> -		if (pdd->dev->driver && (!pm_runtime_suspended(pdd->dev)
> -		    || pdd->dev->power.irq_safe))
> +		if (!pm_runtime_suspended(pdd->dev) || pdd->dev->power.irq_safe)
>  			not_suspended++;
>  	}
>  
> 

