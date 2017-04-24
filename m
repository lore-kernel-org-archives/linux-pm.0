From: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
Subject: Re: [PATCH 1/1] power: Fix unchecked return value of devm_kzalloc
Date: Mon, 24 Apr 2017 09:16:24 +0200
Message-ID: <20170424071624.GA30553@pali>
References: <1492994048-15733-1-git-send-email-bianpan2016@163.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:34122 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1165926AbdDXHQb (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 24 Apr 2017 03:16:31 -0400
Content-Disposition: inline
In-Reply-To: <1492994048-15733-1-git-send-email-bianpan2016@163.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Pan Bian <bianpan2016@163.com>
Cc: Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

On Monday 24 April 2017 08:34:08 Pan Bian wrote:
> Function devm_kzalloc() will return a NULL pointer. However, in function
> isp1704_charger_probe(), the return value of devm_kzalloc() is directly
> used without validation. This may result in a bad memory access bug.
> 
> Signed-off-by: Pan Bian <bianpan2016@163.com>
> ---
>  drivers/power/supply/isp1704_charger.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/power/supply/isp1704_charger.c b/drivers/power/supply/isp1704_charger.c
> index 4cd6899..2f02463 100644
> --- a/drivers/power/supply/isp1704_charger.c
> +++ b/drivers/power/supply/isp1704_charger.c
> @@ -418,6 +418,8 @@ static int isp1704_charger_probe(struct platform_device *pdev)
>  
>  		pdata = devm_kzalloc(&pdev->dev,
>  			sizeof(struct isp1704_charger_data), GFP_KERNEL);
> +		if (pdata)
> +			goto fail0;
>  		pdata->enable_gpio = gpio;
>  
>  		dev_info(&pdev->dev, "init gpio %d\n", pdata->enable_gpio);

fail0 returns ret value value which is initialized to -ENODEV. It could
be fragile if somebody change default initialization ret value to
something else (wort to 0). In your case before goto fail0 it is needed
to explicitly set ret to -ENOMEM so prevent future problems.

-- 
Pali Rohár
pali.rohar@gmail.com
