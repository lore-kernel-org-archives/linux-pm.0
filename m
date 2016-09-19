From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: Re: [PATCH] PM / devfreq: rk3399_dmc: Remove explictly regulator_put
 call in .remove
Date: Mon, 19 Sep 2016 09:16:03 +0900
Message-ID: <57DF2E43.4090801@samsung.com>
References: <CGME20160918024126epcas1p16b581f05e978e0e2014bb20a47e82aec@epcas1p1.samsung.com>
 <1474166465-18736-1-git-send-email-axel.lin@ingics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:59872 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932506AbcISAQG (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 18 Sep 2016 20:16:06 -0400
Received: from epcpsbgr1.samsung.com
 (u141.gpu120.samsung.co.kr [203.254.230.141])
 by mailout4.samsung.com (Oracle Communications Messaging Server 7.0.5.31.0
 64bit (built May  5 2014))
 with ESMTP id <0ODQ00TJ362RZM40@mailout4.samsung.com> for
 linux-pm@vger.kernel.org; Mon, 19 Sep 2016 09:16:03 +0900 (KST)
In-reply-to: <1474166465-18736-1-git-send-email-axel.lin@ingics.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Axel Lin <axel.lin@ingics.com>, MyungJoo Ham <myungjoo.ham@samsung.com>
Cc: Kyungmin Park <kyungmin.park@samsung.com>, Lin Huang <hl@rock-chips.com>, linux-pm@vger.kernel.org

Hi,

Looks good to me.

Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>

Best Regards,
Chanwoo Choi

On 2016년 09월 18일 11:41, Axel Lin wrote:
> Current code uses devm_regulator_get() in .probe so a regulator_put() will
> be automatically called when unload the module. Remove the explictly
> regulator_put() call and then we can also remove rk3399_dmcfreq_remove().
> 
> Signed-off-by: Axel Lin <axel.lin@ingics.com>
> ---
>  drivers/devfreq/rk3399_dmc.c | 10 ----------
>  1 file changed, 10 deletions(-)
> 
> diff --git a/drivers/devfreq/rk3399_dmc.c b/drivers/devfreq/rk3399_dmc.c
> index 54d65f2..e24b73d 100644
> --- a/drivers/devfreq/rk3399_dmc.c
> +++ b/drivers/devfreq/rk3399_dmc.c
> @@ -450,15 +450,6 @@ static int rk3399_dmcfreq_probe(struct platform_device *pdev)
>  	return 0;
>  }
>  
> -static int rk3399_dmcfreq_remove(struct platform_device *pdev)
> -{
> -	struct rk3399_dmcfreq *dmcfreq = platform_get_drvdata(pdev);
> -
> -	regulator_put(dmcfreq->vdd_center);
> -
> -	return 0;
> -}
> -
>  static const struct of_device_id rk3399dmc_devfreq_of_match[] = {
>  	{ .compatible = "rockchip,rk3399-dmc" },
>  	{ },
> @@ -466,7 +457,6 @@ static const struct of_device_id rk3399dmc_devfreq_of_match[] = {
>  
>  static struct platform_driver rk3399_dmcfreq_driver = {
>  	.probe	= rk3399_dmcfreq_probe,
> -	.remove	= rk3399_dmcfreq_remove,
>  	.driver = {
>  		.name	= "rk3399-dmc-freq",
>  		.pm	= &rk3399_dmcfreq_pm,
> 
