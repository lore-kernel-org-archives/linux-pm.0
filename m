From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCH -next] thermal: qoriq: Remove unnecessary
 platform_set_drvdata()
Date: Wed, 24 Aug 2016 14:41:01 +0800
Message-ID: <1472020861.2682.2.camel@intel.com>
References: <1471964488-28313-1-git-send-email-weiyj.lk@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:10406 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752805AbcHXGlC (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 24 Aug 2016 02:41:02 -0400
In-Reply-To: <1471964488-28313-1-git-send-email-weiyj.lk@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Wei Yongjun <weiyj.lk@gmail.com>, Eduardo Valentin <edubezval@gmail.com>
Cc: Wei Yongjun <weiyongjun1@huawei.com>, linux-pm@vger.kernel.org, hongtao.jia@nxp.com

On 二, 2016-08-23 at 15:01 +0000, Wei Yongjun wrote:
> From: Wei Yongjun <weiyongjun1@huawei.com>
> 
> The driver core clears the driver data to NULL after device_release
> or on probe failure. Thus, it is not needed to manually clear the
> device driver data to NULL.
> 
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>

Patch applied.

thanks,
rui
> ---
>  drivers/thermal/qoriq_thermal.c | 10 ++--------
>  1 file changed, 2 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/thermal/qoriq_thermal.c
> b/drivers/thermal/qoriq_thermal.c
> index 644ba52..d01eca0 100644
> --- a/drivers/thermal/qoriq_thermal.c
> +++ b/drivers/thermal/qoriq_thermal.c
> @@ -217,15 +217,13 @@ static int qoriq_tmu_probe(struct
> platform_device *pdev)
>  	data->sensor_id = qoriq_tmu_get_sensor_id();
>  	if (data->sensor_id < 0) {
>  		dev_err(&pdev->dev, "Failed to get sensor id\n");
> -		ret = -ENODEV;
> -		goto err_iomap;
> +		return -ENODEV;
>  	}
>  
>  	data->regs = of_iomap(np, 0);
>  	if (!data->regs) {
>  		dev_err(&pdev->dev, "Failed to get memory
> region\n");
> -		ret = -ENODEV;
> -		goto err_iomap;
> +		return -ENODEV;
>  	}
>  
>  	qoriq_tmu_init_device(data);	/* TMU initialization */
> @@ -254,9 +252,6 @@ static int qoriq_tmu_probe(struct platform_device
> *pdev)
>  err_tmu:
>  	iounmap(data->regs);
>  
> -err_iomap:
> -	platform_set_drvdata(pdev, NULL);
> -
>  	return ret;
>  }
>  
> @@ -270,7 +265,6 @@ static int qoriq_tmu_remove(struct
> platform_device *pdev)
>  	tmu_write(data, TMR_DISABLE, &data->regs->tmr);
>  
>  	iounmap(data->regs);
> -	platform_set_drvdata(pdev, NULL);
>  
>  	return 0;
>  }
> 
> 
> 
