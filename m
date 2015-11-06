From: Andy Shevchenko <andy.shevchenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v2 6/9] thermal: rockchip: Support the RK3368 SoCs in
 thermal drivers
Date: Fri, 6 Nov 2015 21:39:29 +0200
Message-ID: <CAHp75Vd+UnqOigOV9aDrpdczFD2R+gm1iFhUe-C6vc5U-x3e1g@mail.gmail.com>
References: <1446700685-18017-1-git-send-email-wxt@rock-chips.com>
 <1446700685-18017-7-git-send-email-wxt@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <1446700685-18017-7-git-send-email-wxt-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-rockchip/>
List-Post: <mailto:linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "Linux-rockchip" <linux-rockchip-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Caesar Wang <wxt-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Cc: Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, "linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Eduardo Valentin <edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Zhang Rui <rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, linux-arm Mailing List <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

On Thu, Nov 5, 2015 at 7:18 AM, Caesar Wang <wxt-TNX95d0MmH7DzftRWevZcw@public.gmane.org> wrote:
> The RK3368 SoCs support to 2 channel TS-ADC, the temperature criteria
> of each channel can be configurable.
>
> The system has two Temperature Sensors, channel 0 is for CPU,
> and channel 1 is for GPU.
>
> Signed-off-by: Caesar Wang <wxt-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
> ---
>
> Changes in v2:
> - remove some unused, completed on other patchs.
>
> Changes in v1: None
>
>  drivers/thermal/rockchip_thermal.c | 72 ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 72 insertions(+)
>
> diff --git a/drivers/thermal/rockchip_thermal.c b/drivers/thermal/rockchip_thermal.c
> index 9df027f..47a8873 100644
> --- a/drivers/thermal/rockchip_thermal.c
> +++ b/drivers/thermal/rockchip_thermal.c
> @@ -1,6 +1,9 @@
>  /*
>   * Copyright (c) 2014, Fuzhou Rockchip Electronics Co., Ltd
>   *
> + * Copyright (c) 2015, Fuzhou Rockchip Electronics Co., Ltd
> + * Caesar Wang <wxt-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
> + *
>   * This program is free software; you can redistribute it and/or modify it
>   * under the terms and conditions of the GNU General Public License,
>   * version 2, as published by the Free Software Foundation.
> @@ -152,6 +155,8 @@ struct rockchip_thermal_data {
>  #define TSADCV2_INT_PD_CLEAR_MASK              ~BIT(8)
>
>  #define TSADCV2_DATA_MASK                      0xfff
> +#define TSADCV3_DATA_MASK                      0x3ff
> +
>  #define TSADCV2_HIGHT_INT_DEBOUNCE_COUNT       4
>  #define TSADCV2_HIGHT_TSHUT_DEBOUNCE_COUNT     4
>  #define TSADCV2_AUTO_PERIOD_TIME               250 /* msec */
> @@ -200,6 +205,45 @@ static const struct tsadc_table v2_code_table[] = {
>         {3421, 125000},
>  };
>
> +static const struct tsadc_table v3_code_table[] = {
> +       {0, -40000},
> +       {106, -40000},
> +       {108, -35000},
> +       {110, -30000},
> +       {112, -25000},
> +       {114, -20000},
> +       {116, -15000},
> +       {118, -10000},
> +       {120, -5000},
> +       {122, 0},
> +       {124, 5000},
> +       {126, 10000},
> +       {128, 15000},
> +       {130, 20000},
> +       {132, 25000},
> +       {134, 30000},
> +       {136, 35000},
> +       {138, 40000},
> +       {140, 45000},
> +       {142, 50000},
> +       {144, 55000},
> +       {146, 60000},
> +       {148, 65000},
> +       {150, 70000},
> +       {152, 75000},
> +       {154, 80000},
> +       {156, 85000},
> +       {158, 90000},
> +       {160, 95000},
> +       {162, 100000},
> +       {163, 105000},
> +       {165, 110000},
> +       {167, 115000},
> +       {169, 120000},
> +       {171, 125000},
> +       {TSADCV3_DATA_MASK, 125000},

Why not function which returns one value based on the other?

x < 106:   -40000
161 >= x >= 106: -40000 + 5000 * (x - 106) / 2
171 >= x >= 162: 100000 + 5000 * (x - 162)
x > 171 = 125000

> +};
> +
>  static u32 rk_tsadcv2_temp_to_code(struct chip_tsadc_table table,
>                                    long temp)
>  {
> @@ -408,11 +452,39 @@ static const struct rockchip_tsadc_chip rk3288_tsadc_data = {
>         },
>  };
>
> +static const struct rockchip_tsadc_chip rk3368_tsadc_data = {
> +       .chn_id[SENSOR_CPU] = 0, /* cpu sensor is channel 0 */
> +       .chn_id[SENSOR_GPU] = 1, /* gpu sensor is channel 1 */
> +       .chn_num = 2, /* two channels for tsadc */
> +
> +       .tshut_mode = TSHUT_MODE_GPIO, /* default TSHUT via GPIO give PMIC */
> +       .tshut_polarity = TSHUT_LOW_ACTIVE, /* default TSHUT LOW ACTIVE */
> +       .tshut_temp = 95000,
> +
> +       .initialize = rk_tsadcv2_initialize,
> +       .irq_ack = rk_tsadcv2_irq_ack,
> +       .control = rk_tsadcv2_control,
> +       .get_temp = rk_tsadcv2_get_temp,
> +       .set_tshut_temp = rk_tsadcv2_tshut_temp,
> +       .set_tshut_mode = rk_tsadcv2_tshut_mode,
> +
> +       .table = {
> +               .id = v3_code_table,
> +               .length = ARRAY_SIZE(v3_code_table),
> +               .data_mask = TSADCV3_DATA_MASK,
> +               .flag = ADC_DECREMENT,
> +       },
> +};
> +
>  static const struct of_device_id of_rockchip_thermal_match[] = {
>         {
>                 .compatible = "rockchip,rk3288-tsadc",
>                 .data = (void *)&rk3288_tsadc_data,
>         },
> +       {
> +               .compatible = "rockchip,rk3368-tsadc",
> +               .data = (void *)&rk3368_tsadc_data,
> +       },
>         { /* end */ },
>  };
>  MODULE_DEVICE_TABLE(of, of_rockchip_thermal_match);
> --
> 1.9.1
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/



-- 
With Best Regards,
Andy Shevchenko
