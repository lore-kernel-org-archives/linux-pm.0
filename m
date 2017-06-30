From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: Re: [PATCH] devfreq: tegra: fix error code in tegra_devfreq_probe()
Date: Fri, 30 Jun 2017 17:02:18 +0900
Message-ID: <5956058A.3090304@samsung.com>
References: <CGME20170630072216epcas1p34027491553237c57f0270b3f305f0058@epcas1p3.samsung.com>
        <20170630072211.GA21867@embeddedgus>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:36135 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751872AbdF3ICW (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 30 Jun 2017 04:02:22 -0400
In-reply-to: <20170630072211.GA21867@embeddedgus>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Gustavo A. R. Silva" <garsilva@embeddedor.com>, MyungJoo Ham <myungjoo.ham@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>
Cc: linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org

Hi,

On 2017년 06월 30일 16:22, Gustavo A. R. Silva wrote:
> Print and propagate the return value of platform_get_irq on failure.
> 
> Signed-off-by: Gustavo A. R. Silva <garsilva@embeddedor.com>
> ---
>  drivers/devfreq/tegra-devfreq.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/devfreq/tegra-devfreq.c b/drivers/devfreq/tegra-devfreq.c
> index 214fff9..ae71215 100644
> --- a/drivers/devfreq/tegra-devfreq.c
> +++ b/drivers/devfreq/tegra-devfreq.c
> @@ -688,9 +688,9 @@ static int tegra_devfreq_probe(struct platform_device *pdev)
>  	}
>  
>  	irq = platform_get_irq(pdev, 0);
> -	if (irq <= 0) {
> -		dev_err(&pdev->dev, "Failed to get IRQ\n");
> -		return -ENODEV;
> +	if (irq < 0) {
> +		dev_err(&pdev->dev, "Failed to get IRQ: %d\n", irq);
> +		return irq;
>  	}
>  
>  	platform_set_drvdata(pdev, tegra);
> 

Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
