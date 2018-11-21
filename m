From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH V5 2/2] thermal: imx: save one condition block for normal
 case of nvmem initialization
Date: Wed, 21 Nov 2018 09:30:59 +0100
Message-ID: <b28efba1-e04a-7e33-126b-b92c7aa5e9a9@linaro.org>
References: <1542779052-29536-1-git-send-email-Anson.Huang@nxp.com>
 <1542779052-29536-2-git-send-email-Anson.Huang@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1542779052-29536-2-git-send-email-Anson.Huang@nxp.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Anson Huang <anson.huang@nxp.com>, "rui.zhang@intel.com" <rui.zhang@intel.com>, "edubezval@gmail.com" <edubezval@gmail.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>, "l.stach@pengutronix.de" <l.stach@pengutronix.de>
Cc: dl-linux-imx <linux-imx@nxp.com>
List-Id: linux-pm@vger.kernel.org

On 21/11/2018 06:49, Anson Huang wrote:
> Put return value checks of calling imx_init_from_nvmem_cells()
> into one block to save one condition block for normal case.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>

Reviewed-by: Daniel Lezcano <daniel.lezcano@linaro.org>

> ---
>  drivers/thermal/imx_thermal.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/thermal/imx_thermal.c b/drivers/thermal/imx_thermal.c
> index c924396..bb6754a 100644
> --- a/drivers/thermal/imx_thermal.c
> +++ b/drivers/thermal/imx_thermal.c
> @@ -742,9 +742,10 @@ static int imx_thermal_probe(struct platform_device *pdev)
>  
>  	if (of_find_property(pdev->dev.of_node, "nvmem-cells", NULL)) {
>  		ret = imx_init_from_nvmem_cells(pdev);
> -		if (ret == -EPROBE_DEFER)
> -			return ret;
>  		if (ret) {
> +			if (ret == -EPROBE_DEFER)
> +				return ret;
> +
>  			dev_err(&pdev->dev, "failed to init from nvmem: %d\n",
>  				ret);
>  			return ret;
> 


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
