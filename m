From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH 1/1] thermal: stm32: simplify getting .driver_data
Date: Wed, 27 Mar 2019 14:00:09 +0100
Message-ID: <62d8b5a6-ed22-b0ec-ff3e-b545840b1210@linaro.org>
References: <20190319163635.30891-1-wsa+renesas@sang-engineering.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190319163635.30891-1-wsa+renesas@sang-engineering.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa+renesas@sang-engineering.com>, linux-kernel@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@st.com>, linux-pm@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

On 19/03/2019 17:36, Wolfram Sang wrote:
> We should get 'driver_data' from 'struct device' directly. Going via
> platform_device is an unneeded step back and forth.
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Reviewed-by: Daniel Lezcano <daniel.lezcano@linaro.org>

> ---
> 
> Build tested only. buildbot is happy.
> 
>  drivers/thermal/st/stm_thermal.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/thermal/st/stm_thermal.c b/drivers/thermal/st/stm_thermal.c
> index bbd73c5a4a4e..cf9ddc52f30e 100644
> --- a/drivers/thermal/st/stm_thermal.c
> +++ b/drivers/thermal/st/stm_thermal.c
> @@ -570,8 +570,7 @@ static int stm_thermal_prepare(struct stm_thermal_sensor *sensor)
>  static int stm_thermal_suspend(struct device *dev)
>  {
>  	int ret;
> -	struct platform_device *pdev = to_platform_device(dev);
> -	struct stm_thermal_sensor *sensor = platform_get_drvdata(pdev);
> +	struct stm_thermal_sensor *sensor = dev_get_drvdata(dev);
>  
>  	ret = stm_thermal_sensor_off(sensor);
>  	if (ret)
> @@ -585,8 +584,7 @@ static int stm_thermal_suspend(struct device *dev)
>  static int stm_thermal_resume(struct device *dev)
>  {
>  	int ret;
> -	struct platform_device *pdev = to_platform_device(dev);
> -	struct stm_thermal_sensor *sensor = platform_get_drvdata(pdev);
> +	struct stm_thermal_sensor *sensor = dev_get_drvdata(dev);
>  
>  	ret = stm_thermal_prepare(sensor);
>  	if (ret)
> 


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
