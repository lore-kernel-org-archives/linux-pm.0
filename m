From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH] thermal: imx: fix for dependency on cpu-freq
Date: Tue, 20 Nov 2018 09:44:32 +0100
Message-ID: <28d501b1-8016-cc1a-3f7c-ac485ab81aa2@linaro.org>
References: <1540362909-32481-1-git-send-email-Anson.Huang@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1540362909-32481-1-git-send-email-Anson.Huang@nxp.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Anson Huang <anson.huang@nxp.com>, "rui.zhang@intel.com" <rui.zhang@intel.com>, "edubezval@gmail.com" <edubezval@gmail.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: dl-linux-imx <linux-imx@nxp.com>
List-Id: linux-pm@vger.kernel.org

On 24/10/2018 08:39, Anson Huang wrote:
> The thermal driver is a standalone driver for monitoring SoC temperature
> by enabling thermal sensor, so it can be enabled even when CONFIG_CPU_FREQ
> is NOT set. So remove the dependency with CPU_THERMAL.
> 
> Add CONFIG_CPU_FREQ check for cpu-freq related operation in thermal
> driver to make thermal driver probe successfully when CONFIG_CPU_FREQ
> is NOT set.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---

Why not simply kill this legacy code ?



>  drivers/thermal/Kconfig       | 2 +-
>  drivers/thermal/imx_thermal.c | 4 ++++
>  2 files changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
> index 1775d44..c8a6352 100644
> --- a/drivers/thermal/Kconfig
> +++ b/drivers/thermal/Kconfig
> @@ -212,7 +212,7 @@ config HISI_THERMAL
>  
>  config IMX_THERMAL
>  	tristate "Temperature sensor driver for Freescale i.MX SoCs"
> -	depends on (ARCH_MXC && CPU_THERMAL) || COMPILE_TEST
> +	depends on ARCH_MXC || COMPILE_TEST
>  	depends on NVMEM || !NVMEM
>  	depends on MFD_SYSCON
>  	depends on OF
> diff --git a/drivers/thermal/imx_thermal.c b/drivers/thermal/imx_thermal.c
> index 1566154..87386d1 100644
> --- a/drivers/thermal/imx_thermal.c
> +++ b/drivers/thermal/imx_thermal.c
> @@ -648,6 +648,7 @@ static const struct of_device_id of_imx_thermal_match[] = {
>  };
>  MODULE_DEVICE_TABLE(of, of_imx_thermal_match);
>  
> +#ifdef CONFIG_CPU_FREQ
>  /*
>   * Create cooling device in case no #cooling-cells property is available in
>   * CPU node
> @@ -668,6 +669,7 @@ static int imx_thermal_register_legacy_cooling(struct imx_thermal_data *data)
>  
>  	return 0;
>  }
> +#endif
>  
>  static int imx_thermal_probe(struct platform_device *pdev)
>  {
> @@ -743,6 +745,7 @@ static int imx_thermal_probe(struct platform_device *pdev)
>  	regmap_write(map, data->socdata->sensor_ctrl + REG_SET,
>  		     data->socdata->power_down_mask);
>  
> +#ifdef CONFIG_CPU_FREQ
>  	data->policy = cpufreq_cpu_get(0);
>  	if (!data->policy) {
>  		pr_debug("%s: CPUFreq policy not found\n", __func__);
> @@ -755,6 +758,7 @@ static int imx_thermal_probe(struct platform_device *pdev)
>  			"failed to register cpufreq cooling device: %d\n", ret);
>  		return ret;
>  	}
> +#endif
>  
>  	data->thermal_clk = devm_clk_get(&pdev->dev, NULL);
>  	if (IS_ERR(data->thermal_clk)) {
> 


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
