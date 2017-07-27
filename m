From: Matthias Brugger <matthias.bgg@gmail.com>
Subject: Re: [PATCH v1 4/4] thermal: mediatek: minor mtk_thermal.c cleanups
Date: Thu, 27 Jul 2017 17:49:33 +0200
Message-ID: <c8585136-d7a8-3a47-1af2-512c6485eca0@gmail.com>
References: <1501134417-3505-1-git-send-email-louis.yu@mediatek.com>
 <1501134417-3505-5-git-send-email-louis.yu@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:33915 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751113AbdG0Pth (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 27 Jul 2017 11:49:37 -0400
Received: by mail-wm0-f65.google.com with SMTP id c184so11715718wmd.1
        for <linux-pm@vger.kernel.org>; Thu, 27 Jul 2017 08:49:37 -0700 (PDT)
In-Reply-To: <1501134417-3505-5-git-send-email-louis.yu@mediatek.com>
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: louis.yu@mediatek.com, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, dawei.chien@mediatek.com, fan.chen@mediatek.com, eddie.huang@mediatek.com, linux-pm@vger.kernel.org, linux-mediatek@lists.infradead.org, srv_heupstream@mediatek.com



On 07/27/2017 07:46 AM, louis.yu@mediatek.com wrote:
> From: Louis Yu <louis.yu@mediatek.com>
> 
> Move thermal module reset in the beginning and revise clock error
> handle flow to pair the clock control.
> 
> Signed-off-by: Louis Yu <louis.yu@mediatek.com>
> ---
>   drivers/thermal/mtk_thermal.c | 12 ++++++------
>   1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/thermal/mtk_thermal.c b/drivers/thermal/mtk_thermal.c
> index f2a7155..5dffdb4 100644
> --- a/drivers/thermal/mtk_thermal.c
> +++ b/drivers/thermal/mtk_thermal.c
> @@ -712,20 +712,20 @@ static int mtk_thermal_probe(struct platform_device *pdev)
>   		return -EINVAL;
>   	}
>   
> +	ret = device_reset(&pdev->dev);
> +	if (ret)
> +		return ret;
> +
>   	ret = clk_prepare_enable(mt->clk_auxadc);
>   	if (ret) {
>   		dev_err(&pdev->dev, "Can't enable auxadc clk: %d\n", ret);
> -		return ret;
> -	}
> -
> -	ret = device_reset(&pdev->dev);
> -	if (ret)
>   		goto err_disable_clk_auxadc;
> +	}
>   
>   	ret = clk_prepare_enable(mt->clk_peri_therm);
>   	if (ret) {
>   		dev_err(&pdev->dev, "Can't enable peri clk: %d\n", ret);
> -		goto err_disable_clk_auxadc;
> +		goto err_disable_clk_peri_therm;

If you can't enable the clock, there is no use in disable it in the error path.

Regards,
Matthias

>   	}
>   
>   	for (i = 0; i < mt->conf->num_banks; i++)
> 
