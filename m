From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH] thermal: armada: fix incorrect check for drvdata
 allocation failure
Date: Mon, 30 Jul 2018 16:14:53 +0200
Message-ID: <cad2f4c3-77c1-c233-975d-ed72fd640163@linaro.org>
References: <20180730122716.6267-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180730122716.6267-1-colin.king@canonical.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Colin King <colin.king@canonical.com>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, linux-pm@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org


Hi Colin,

On 30/07/2018 14:27, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> Currently the drvdata allocation failure is being incorrectly checked by
> checking priv and not drvdata.  Fix this and also free priv to fix a
> memory leak.
> 
> Detected by Coverity Scan, CID#1472102 ("Logically dead code")
> 
> Fixes: c9899c183921 ("thermal: armada: use the resource managed registration helper alternative")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/thermal/armada_thermal.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/thermal/armada_thermal.c b/drivers/thermal/armada_thermal.c
> index 4164a5a4e480..b164fd9f21ac 100644
> --- a/drivers/thermal/armada_thermal.c
> +++ b/drivers/thermal/armada_thermal.c
> @@ -611,8 +611,10 @@ static int armada_thermal_probe(struct platform_device *pdev)
>  		return -ENOMEM;
>  
>  	drvdata = devm_kzalloc(&pdev->dev, sizeof(*drvdata), GFP_KERNEL);
> -	if (!priv)
> +	if (!drvdata) {
> +		devm_kfree(&pdev->dev, priv);

This is not necessary, resources will be free when the driver is
destroyed after the probe fails.

>  		return -ENOMEM;
> +	}
>  
>  	priv->dev = &pdev->dev;
>  	priv->data = (struct armada_thermal_data *)match->data;

Thanks for sending this fix. However, another fix was already submitted
for this.

  -- Daniel




-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
