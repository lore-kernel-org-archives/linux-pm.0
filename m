From: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
Subject: Re: [PATCH 1/1] power: Fix unchecked return value of devm_kzalloc
Date: Tue, 25 Apr 2017 12:50:00 +0200
Message-ID: <20170425105000.GF30553@pali>
References: <1493022128-3918-1-git-send-email-bianpan2016@163.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:33441 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1171065AbdDYKuE (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 25 Apr 2017 06:50:04 -0400
Content-Disposition: inline
In-Reply-To: <1493022128-3918-1-git-send-email-bianpan2016@163.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Pan Bian <bianpan2016@163.com>
Cc: Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

On Monday 24 April 2017 16:22:08 Pan Bian wrote:
> Function devm_kzalloc() will return a NULL pointer. However, in function
> isp1704_charger_probe(), the return value of devm_kzalloc() is directly
> used without validation. This may result in a bad memory access bug.
> 
> Signed-off-by: Pan Bian <bianpan2016@163.com>
> ---
>  drivers/power/supply/isp1704_charger.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/power/supply/isp1704_charger.c b/drivers/power/supply/isp1704_charger.c
> index 4cd6899..95af5f3 100644
> --- a/drivers/power/supply/isp1704_charger.c
> +++ b/drivers/power/supply/isp1704_charger.c
> @@ -418,6 +418,10 @@ static int isp1704_charger_probe(struct platform_device *pdev)
>  
>  		pdata = devm_kzalloc(&pdev->dev,
>  			sizeof(struct isp1704_charger_data), GFP_KERNEL);
> +		if (!pdata) {
> +			ret = -ENOMEM;
> +			goto fail0;
> +		}
>  		pdata->enable_gpio = gpio;
>  
>  		dev_info(&pdev->dev, "init gpio %d\n", pdata->enable_gpio);

Looks good now. Reviewed-by: Pali Rohár <pali.rohar@gmail.com>

-- 
Pali Rohár
pali.rohar@gmail.com
