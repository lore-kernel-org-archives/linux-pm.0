From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH -next] power: supply: ltc3651-charger: Fix wrong pointer
 passed to PTR_ERR()
Date: Thu, 18 May 2017 17:59:48 -0700
Message-ID: <20170519005948.GA34310@dtor-ws>
References: <20170517121132.7052-1-weiyj.lk@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f193.google.com ([209.85.192.193]:34137 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752741AbdESA7v (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 18 May 2017 20:59:51 -0400
Received: by mail-pf0-f193.google.com with SMTP id w69so7536360pfk.1
        for <linux-pm@vger.kernel.org>; Thu, 18 May 2017 17:59:51 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20170517121132.7052-1-weiyj.lk@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Wei Yongjun <weiyj.lk@gmail.com>
Cc: Sebastian Reichel <sre@kernel.org>, Wei Yongjun <weiyongjun1@huawei.com>, linux-pm@vger.kernel.org

On Wed, May 17, 2017 at 12:11:32PM +0000, Wei Yongjun wrote:
> From: Wei Yongjun <weiyongjun1@huawei.com>
> 
> PTR_ERR should access the value just tested by IS_ERR, otherwise
> the wrong error code will be returned.
> 
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>

This does fix the issue, but maybe we want to use PTR_ERR_OR_ZERO()?

	ltc3651_charger->acpr_gpio = devm_gpiod_get(&pdev->dev,
					"lltc,acpr", GPIOD_IN);
	ret = PTR_ERR_OR_ZERO(ltc3651_charger->acpr_gpio);
	if (ret)
		...

Or even

	err = PTR_ERR_OR_ZERO((ltc3651_charger->acpr_gpio =
		devm_gpiod_get(&pdev->dev, "lltc,acpr", GPIOD_IN)));
	if (err)
		...

To make sure we never mix up pointer. Maybe we need ERR_OR_ASSIGN(ptr1,
ptr2) to avoid the ugly assignment in argument above...

Thanks.

> ---
>  drivers/power/supply/ltc3651-charger.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/power/supply/ltc3651-charger.c b/drivers/power/supply/ltc3651-charger.c
> index 5f8d5c0..eea63ff 100644
> --- a/drivers/power/supply/ltc3651-charger.c
> +++ b/drivers/power/supply/ltc3651-charger.c
> @@ -110,21 +110,21 @@ static int ltc3651_charger_probe(struct platform_device *pdev)
>  	ltc3651_charger->acpr_gpio = devm_gpiod_get(&pdev->dev,
>  					"lltc,acpr", GPIOD_IN);
>  	if (IS_ERR(ltc3651_charger->acpr_gpio)) {
> -		ret = PTR_ERR(ltc3651_charger->charger);
> +		ret = PTR_ERR(ltc3651_charger->acpr_gpio);
>  		dev_err(&pdev->dev, "Failed to acquire acpr GPIO: %d\n", ret);
>  		return ret;
>  	}
>  	ltc3651_charger->fault_gpio = devm_gpiod_get_optional(&pdev->dev,
>  					"lltc,fault", GPIOD_IN);
>  	if (IS_ERR(ltc3651_charger->fault_gpio)) {
> -		ret = PTR_ERR(ltc3651_charger->charger);
> +		ret = PTR_ERR(ltc3651_charger->fault_gpio);
>  		dev_err(&pdev->dev, "Failed to acquire fault GPIO: %d\n", ret);
>  		return ret;
>  	}
>  	ltc3651_charger->chrg_gpio = devm_gpiod_get_optional(&pdev->dev,
>  					"lltc,chrg", GPIOD_IN);
>  	if (IS_ERR(ltc3651_charger->chrg_gpio)) {
> -		ret = PTR_ERR(ltc3651_charger->charger);
> +		ret = PTR_ERR(ltc3651_charger->chrg_gpio);
>  		dev_err(&pdev->dev, "Failed to acquire chrg GPIO: %d\n", ret);
>  		return ret;
>  	}
> 

-- 
Dmitry
