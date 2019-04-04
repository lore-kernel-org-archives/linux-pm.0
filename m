From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH v1 3/3] thermal: rockchip: Support the PX30 SoC in thermal
 driver
Date: Thu, 4 Apr 2019 05:08:27 +0200
Message-ID: <b00bffe4-8aad-ad86-bac8-d196b22b304d@linaro.org>
References: <1554100985-11385-1-git-send-email-zhangqing@rock-chips.com>
 <1554100985-11385-4-git-send-email-zhangqing@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1554100985-11385-4-git-send-email-zhangqing@rock-chips.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Elaine Zhang <zhangqing@rock-chips.com>, heiko@sntech.de
Cc: rui.zhang@intel.com, edubezval@gmail.com, robh+dt@kernel.org, mark.rutland@arm.com, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, xxx@rock-chips.com, xf@rock-chips.com, huangtao@rock-chips.com
List-Id: linux-pm@vger.kernel.org

On 01/04/2019 08:43, Elaine Zhang wrote:
> PX30 SOC has two Temperature Sensors for CPU and GPU.
> 
> Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>
> ---
>  drivers/thermal/rockchip_thermal.c | 39 ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 39 insertions(+)
> 
> diff --git a/drivers/thermal/rockchip_thermal.c b/drivers/thermal/rockchip_thermal.c
> index faa6c7792155..d5c161e63361 100644
> --- a/drivers/thermal/rockchip_thermal.c
> +++ b/drivers/thermal/rockchip_thermal.c
> @@ -225,11 +225,15 @@ struct rockchip_thermal_data {
>  #define GRF_TSADC_TESTBIT_L			0x0e648
>  #define GRF_TSADC_TESTBIT_H			0x0e64c
>  
> +#define PX30_GRF_SOC_CON2			0x0408
> +
>  #define GRF_SARADC_TESTBIT_ON			(0x10001 << 2)
>  #define GRF_TSADC_TESTBIT_H_ON			(0x10001 << 2)
>  #define GRF_TSADC_VCM_EN_L			(0x10001 << 7)
>  #define GRF_TSADC_VCM_EN_H			(0x10001 << 7)
>  
> +#define GRF_CON_TSADC_CH_INV			(0x10001 << 1)
> +
>  /**
>   * struct tsadc_table - code to temperature conversion table
>   * @code: the value of adc channel
> @@ -692,6 +696,14 @@ static void rk_tsadcv3_initialize(struct regmap *grf, void __iomem *regs,
>  			       regs + TSADCV2_AUTO_CON);
>  }
>  
> +static void rk_tsadcv4_initialize(struct regmap *grf, void __iomem *regs,
> +				  enum tshut_polarity tshut_polarity)
> +{
> +	rk_tsadcv2_initialize(grf, regs, tshut_polarity);
> +	if (!IS_ERR(grf))

Why this test ? grf is not modified by the 'rk_tsadcv2_initialize' function.

> +		regmap_write(grf, PX30_GRF_SOC_CON2, GRF_CON_TSADC_CH_INV);
> +}
> +
>  static void rk_tsadcv2_irq_ack(void __iomem *regs)
>  {
>  	u32 val;
> @@ -821,6 +833,30 @@ static void rk_tsadcv2_tshut_mode(int chn, void __iomem *regs,
>  	writel_relaxed(val, regs + TSADCV2_INT_EN);
>  }
>  
> +static const struct rockchip_tsadc_chip px30_tsadc_data = {
> +	.chn_id[SENSOR_CPU] = 0, /* cpu sensor is channel 0 */
> +	.chn_id[SENSOR_GPU] = 1, /* gpu sensor is channel 1 */
> +	.chn_num = 2, /* 2 channels for tsadc */
> +
> +	.tshut_mode = TSHUT_MODE_CRU, /* default TSHUT via CRU */
> +	.tshut_temp = 95000,
> +
> +	.initialize = rk_tsadcv4_initialize,
> +	.irq_ack = rk_tsadcv3_irq_ack,
> +	.control = rk_tsadcv3_control,
> +	.get_temp = rk_tsadcv2_get_temp,
> +	.set_alarm_temp = rk_tsadcv2_alarm_temp,
> +	.set_tshut_temp = rk_tsadcv2_tshut_temp,
> +	.set_tshut_mode = rk_tsadcv2_tshut_mode,
> +
> +	.table = {
> +		.id = rk3328_code_table,
> +		.length = ARRAY_SIZE(rk3328_code_table),
> +		.data_mask = TSADCV2_DATA_MASK,
> +		.mode = ADC_INCREMENT,
> +	},
> +};
> +
>  static const struct rockchip_tsadc_chip rv1108_tsadc_data = {
>  	.chn_id[SENSOR_CPU] = 0, /* cpu sensor is channel 0 */
>  	.chn_num = 1, /* one channel for tsadc */
> @@ -993,6 +1029,9 @@ static void rk_tsadcv2_tshut_mode(int chn, void __iomem *regs,
>  };
>  
>  static const struct of_device_id of_rockchip_thermal_match[] = {
> +	{	.compatible = "rockchip,px30-tsadc",
> +		.data = (void *)&px30_tsadc_data,
> +	},
>  	{
>  		.compatible = "rockchip,rv1108-tsadc",
>  		.data = (void *)&rv1108_tsadc_data,
> 


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
