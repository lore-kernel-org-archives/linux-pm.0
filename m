From: Rajendra Nayak <rnayak@codeaurora.org>
Subject: Re: [PATCH -next] thermal: qcom: tsens: Fix return value check in
 init_common()
Date: Wed, 10 Aug 2016 10:29:32 +0530
Message-ID: <57AAB4B4.4090907@codeaurora.org>
References: <1469860357-2773-1-git-send-email-weiyj.lk@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:57287 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750724AbcHJE7i (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 10 Aug 2016 00:59:38 -0400
In-Reply-To: <1469860357-2773-1-git-send-email-weiyj.lk@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Wei Yongjun <weiyj.lk@gmail.com>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Lina Iyer <lina.iyer@linaro.org>
Cc: linux-pm@vger.kernel.org


On 07/30/2016 12:02 PM, Wei Yongjun wrote:
> In case of error, the function of_iomap() returns NULL pointer
> not ERR_PTR(). The IS_ERR() test in the return value check
> should be replaced with NULL test.
> And the function devm_regmap_init_mmio() returns ERR_PTR()
> and never returns NULL. The NULL test in the return value
> check should be replaced with IS_ERR().

Thanks for fixing this, I seem to have mixed up the return types
for the two functions

Acked-by: Rajendra Nayak <rnayak@codeaurora.org>

> 
> Signed-off-by: Wei Yongjun <weiyj.lk@gmail.com>
> ---
>  drivers/thermal/qcom/tsens-common.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/thermal/qcom/tsens-common.c b/drivers/thermal/qcom/tsens-common.c
> index 4a1af15..b1449ad 100644
> --- a/drivers/thermal/qcom/tsens-common.c
> +++ b/drivers/thermal/qcom/tsens-common.c
> @@ -128,13 +128,13 @@ int __init init_common(struct tsens_device *tmdev)
>  	void __iomem *base;
>  
>  	base = of_iomap(tmdev->dev->of_node, 0);
> -	if (IS_ERR(base))
> +	if (!base)
>  		return -EINVAL;
>  
>  	tmdev->map = devm_regmap_init_mmio(tmdev->dev, base, &tsens_config);
> -	if (!tmdev->map) {
> +	if (IS_ERR(tmdev->map)) {
>  		iounmap(base);
> -		return -ENODEV;
> +		return PTR_ERR(tmdev->map);
>  	}
>  
>  	return 0;
> 

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
