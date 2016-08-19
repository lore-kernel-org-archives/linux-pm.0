From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCH -next] thermal: qcom: tsens: Fix return value check in
 init_common()
Date: Fri, 19 Aug 2016 21:12:58 +0800
Message-ID: <1471612378.2691.74.camel@intel.com>
References: <1469860357-2773-1-git-send-email-weiyj.lk@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:60055 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754931AbcHSNQL (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 19 Aug 2016 09:16:11 -0400
In-Reply-To: <1469860357-2773-1-git-send-email-weiyj.lk@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Wei Yongjun <weiyj.lk@gmail.com>, Eduardo Valentin <edubezval@gmail.com>, Lina Iyer <lina.iyer@linaro.org>, Rajendra Nayak <rnayak@codeaurora.org>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

On 六, 2016-07-30 at 00:32 -0600, Wei Yongjun wrote:
> In case of error, the function of_iomap() returns NULL pointer
> not ERR_PTR(). The IS_ERR() test in the return value check
> should be replaced with NULL test.
> And the function devm_regmap_init_mmio() returns ERR_PTR()
> and never returns NULL. The NULL test in the return value
> check should be replaced with IS_ERR().
> 
> Signed-off-by: Wei Yongjun <weiyj.lk@gmail.com>

Patch applied.

thanks,
rui
> ---
>  drivers/thermal/qcom/tsens-common.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/thermal/qcom/tsens-common.c
> b/drivers/thermal/qcom/tsens-common.c
> index 4a1af15..b1449ad 100644
> --- a/drivers/thermal/qcom/tsens-common.c
> +++ b/drivers/thermal/qcom/tsens-common.c
> @@ -128,13 +128,13 @@ int __init init_common(struct tsens_device
> *tmdev)
>  	void __iomem *base;
>  
>  	base = of_iomap(tmdev->dev->of_node, 0);
> -	if (IS_ERR(base))
> +	if (!base)
>  		return -EINVAL;
>  
>  	tmdev->map = devm_regmap_init_mmio(tmdev->dev, base,
> &tsens_config);
> -	if (!tmdev->map) {
> +	if (IS_ERR(tmdev->map)) {
>  		iounmap(base);
> -		return -ENODEV;
> +		return PTR_ERR(tmdev->map);
>  	}
>  
>  	return 0;
> 
