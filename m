From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: Re: [PATCH v1] PM / devfreq: exynos-ppmu : Handle return value of
 clk_prepare_enable
Date: Tue, 23 May 2017 18:41:59 +0900
Message-ID: <592403E7.8060906@samsung.com>
References: <CGME20170519105745epcas5p29a5cbb259cd15138d7220f34e130e00a@epcas5p2.samsung.com>
        <1495191364-16015-1-git-send-email-arvind.yadav.cs@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:41741 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932938AbdEWJmL (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 23 May 2017 05:42:11 -0400
In-reply-to: <1495191364-16015-1-git-send-email-arvind.yadav.cs@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Arvind Yadav <arvind.yadav.cs@gmail.com>, myungjoo.ham@samsung.com, kyungmin.park@samsung.com, krzk@kernel.org, kgene@kernel.org, javier@osg.samsung.com
Cc: linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org

On 2017년 05월 19일 19:56, Arvind Yadav wrote:
> clk_prepare_enable() can fail here and we must check its return value.
> 
> Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
> ---
>  drivers/devfreq/event/exynos-ppmu.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/devfreq/event/exynos-ppmu.c b/drivers/devfreq/event/exynos-ppmu.c
> index 9b73509..8f6537a 100644
> --- a/drivers/devfreq/event/exynos-ppmu.c
> +++ b/drivers/devfreq/event/exynos-ppmu.c
> @@ -648,7 +648,11 @@ static int exynos_ppmu_probe(struct platform_device *pdev)
>  			dev_name(&pdev->dev), desc[i].name);
>  	}
>  
> -	clk_prepare_enable(info->ppmu.clk);
> +	ret = clk_prepare_enable(info->ppmu.clk);
> +	if (ret) {
> +		dev_err(&pdev->dev, "failed to prepare ppmu clock\n");
> +		return ret;
> +	}

You're right. But, actually, some ppmu device-tree node doesn't include
the clock information because exynos clk driver don't support the
clock for some ppmu devices. Until now, the clock of ppmu devices
are default on state.

Before applying this patch, exynos clock driver have to support
the ppmu's clock and then add the clock information to the device tree
of ppmu devices.

>  
>  	return 0;
>  }
> 


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
