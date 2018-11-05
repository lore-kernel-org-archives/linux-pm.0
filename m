From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH 2/5] thermal: rockchip_thermal: simplify getting
 .driver_data
Date: Mon, 5 Nov 2018 16:05:16 +0100
Message-ID: <e022320e-3a85-070c-4f9e-700457ae4386@linaro.org>
References: <20181021200053.2194-1-wsa+renesas@sang-engineering.com>
 <20181021200053.2194-3-wsa+renesas@sang-engineering.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181021200053.2194-3-wsa+renesas@sang-engineering.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa+renesas@sang-engineering.com>, linux-kernel@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Heiko Stuebner <heiko@sntech.de>, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

On 21/10/2018 22:00, Wolfram Sang wrote:
> We should get 'driver_data' from 'struct device' directly. Going via
> platform_device is an unneeded step back and forth.
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Reviewed-by: Daniel Lezcano <daniel.lezcano@linaro.org>

> ---
> 
> Build tested only. buildbot is happy.
> 
>  drivers/thermal/rockchip_thermal.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/thermal/rockchip_thermal.c b/drivers/thermal/rockchip_thermal.c
> index f36375d5a16c..9c7643d62ed7 100644
> --- a/drivers/thermal/rockchip_thermal.c
> +++ b/drivers/thermal/rockchip_thermal.c
> @@ -1327,8 +1327,7 @@ static int rockchip_thermal_remove(struct platform_device *pdev)
>  
>  static int __maybe_unused rockchip_thermal_suspend(struct device *dev)
>  {
> -	struct platform_device *pdev = to_platform_device(dev);
> -	struct rockchip_thermal_data *thermal = platform_get_drvdata(pdev);
> +	struct rockchip_thermal_data *thermal = dev_get_drvdata(dev);
>  	int i;
>  
>  	for (i = 0; i < thermal->chip->chn_num; i++)
> @@ -1346,8 +1345,7 @@ static int __maybe_unused rockchip_thermal_suspend(struct device *dev)
>  
>  static int __maybe_unused rockchip_thermal_resume(struct device *dev)
>  {
> -	struct platform_device *pdev = to_platform_device(dev);
> -	struct rockchip_thermal_data *thermal = platform_get_drvdata(pdev);
> +	struct rockchip_thermal_data *thermal = dev_get_drvdata(dev);
>  	int i;
>  	int error;
>  
> @@ -1376,7 +1374,7 @@ static int __maybe_unused rockchip_thermal_resume(struct device *dev)
>  					      id, thermal->regs,
>  					      thermal->tshut_temp);
>  		if (error)
> -			dev_err(&pdev->dev, "%s: invalid tshut=%d, error=%d\n",
> +			dev_err(dev, "%s: invalid tshut=%d, error=%d\n",
>  				__func__, thermal->tshut_temp, error);
>  	}
>  
> 


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
