From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: Re: [patch] PM / devfreq: event: testing the wrong variable
Date: Tue, 10 Feb 2015 19:59:40 +0900
Message-ID: <54D9E49C.80105@samsung.com>
References: <20150210103547.GA18481@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:54138 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750766AbbBJK7n (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 10 Feb 2015 05:59:43 -0500
In-reply-to: <20150210103547.GA18481@mwanda>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: MyungJoo Ham <myungjoo.ham@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Kukjin Kim <kgene@kernel.org>, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, kernel-janitors@vger.kernel.org

On 02/10/2015 07:35 PM, Dan Carpenter wrote:
> There is a typo here so we test "edev" but we intended to test
> "edev[i]".
> 
> Fixes: f262f28c1470 ('PM / devfreq: event: Add devfreq_event class')
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> 
> diff --git a/drivers/devfreq/event/exynos-ppmu.c b/drivers/devfreq/event/exynos-ppmu.c
> index 135be0a..ad83473 100644
> --- a/drivers/devfreq/event/exynos-ppmu.c
> +++ b/drivers/devfreq/event/exynos-ppmu.c
> @@ -327,8 +327,8 @@ static int exynos_ppmu_probe(struct platform_device *pdev)
>  
>  	for (i = 0; i < info->num_events; i++) {
>  		edev[i] = devm_devfreq_event_add_edev(&pdev->dev, &desc[i]);
> -		if (IS_ERR(edev)) {
> -			ret = PTR_ERR(edev);
> +		if (IS_ERR(edev[i])) {
> +			ret = PTR_ERR(edev[i]);
>  			dev_err(&pdev->dev,
>  				"failed to add devfreq-event device\n");
>  			goto err;
> 

Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>

But,
This patch has not yet merged to linux.git (http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git).
After releasing Linux 3.20-rc1, this patch will be handled.

Thanks,
Chanwoo Choi



