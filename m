From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: Re: [PATCH v1] PM / devfreq: exynos-nocp : Handle return value of
 clk_prepare_enable
Date: Tue, 23 May 2017 18:43:29 +0900
Message-ID: <59240441.9090208@samsung.com>
References: <CGME20170519105215epcas5p26e75138ae5815f288ac6ca57a64c1087@epcas5p2.samsung.com>
        <1495191035-15882-1-git-send-email-arvind.yadav.cs@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:34314 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932938AbdEWJnc (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 23 May 2017 05:43:32 -0400
In-reply-to: <1495191035-15882-1-git-send-email-arvind.yadav.cs@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Arvind Yadav <arvind.yadav.cs@gmail.com>, myungjoo.ham@samsung.com, kyungmin.park@samsung.com, krzk@kernel.org, kgene@kernel.org, javier@osg.samsung.com
Cc: linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Arvind,

On 2017년 05월 19일 19:50, Arvind Yadav wrote:
> clk_prepare_enable() can fail here and we must check its return value.
> 
> Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
> ---
>  drivers/devfreq/event/exynos-nocp.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/devfreq/event/exynos-nocp.c b/drivers/devfreq/event/exynos-nocp.c
> index 5c3e7b1..f6e7956 100644
> --- a/drivers/devfreq/event/exynos-nocp.c
> +++ b/drivers/devfreq/event/exynos-nocp.c
> @@ -267,7 +267,11 @@ static int exynos_nocp_probe(struct platform_device *pdev)
>  	}
>  	platform_set_drvdata(pdev, nocp);
>  
> -	clk_prepare_enable(nocp->clk);
> +	ret = clk_prepare_enable(nocp->clk);
> +	if (ret) {
> +		dev_err(&pdev->dev, "failed to prepare ppmu clock\n");
> +		return ret;
> +	}

I already replied from the similar patch. Thanks.

>  
>  	pr_info("exynos-nocp: new NoC Probe device registered: %s\n",
>  			dev_name(dev));
> 


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
