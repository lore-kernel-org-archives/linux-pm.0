From: Steve Barber <smbarber@google.com>
Subject: Re: [RESEND PATCH v4 5/5] thermal: rockchip: add the set_trips function
Date: Thu, 2 Jun 2016 13:31:14 -0700
Message-ID: <CADR9n4_LQxJtnEW79xzJy13U9S19FmFpy4Kq4WZm658z2GPA0g@mail.gmail.com>
References: <1464338208-8105-1-git-send-email-wxt@rock-chips.com> <1464338208-8105-6-git-send-email-wxt@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-vk0-f44.google.com ([209.85.213.44]:33155 "EHLO
	mail-vk0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932233AbcFBUbg (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 2 Jun 2016 16:31:36 -0400
Received: by mail-vk0-f44.google.com with SMTP id r140so87606000vkf.0
        for <linux-pm@vger.kernel.org>; Thu, 02 Jun 2016 13:31:35 -0700 (PDT)
In-Reply-To: <1464338208-8105-6-git-send-email-wxt@rock-chips.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Caesar Wang <wxt@rock-chips.com>
Cc: edubezval@gmail.com, linux-pm@vger.kernel.org, Heiko Stuebner <heiko@sntech.de>, Douglas Anderson <dianders@chromium.org>, Brian Norris <briannorris@google.com>, linux-rockchip@lists.infradead.org, Eddie Cai <cf@rock-chips.com>, Tao Huang <huangtao@rock-chips.com>, dmitry.torokhov@gmail.com, javi.merino@arm.com, peter@piie.net, Zhang Rui <rui.zhang@intel.com>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org

On Fri, May 27, 2016 at 1:36 AM, Caesar Wang <wxt@rock-chips.com> wrote:
> Whenever the current temperature is updated, the trip points immediately
> below and above the current temperature are found. A sensor driver
> callback `set_trips' is then called with the temperatures.
> Lastly, The sensor will trigger the hardware high temperature interrupts
> to increase the sampleing rate and throttle frequency to limit the
> temperature rising When performing passive cooling.
>
> Signed-off-by: Caesar Wang <wxt@rock-chips.com>
> Cc: Zhang Rui <rui.zhang@intel.com>
> Cc: Eduardo Valentin <edubezval@gmail.com>
> Cc: linux-pm@vger.kernel.org
>
> ---
>
> Changes in v4: None
> Changes in v3: None
> Changes in v2: None
>
>  drivers/thermal/rockchip_thermal.c | 39 ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 39 insertions(+)
>
> diff --git a/drivers/thermal/rockchip_thermal.c b/drivers/thermal/rockchip_thermal.c
> index 86a1ab0..39e2eec 100644
> --- a/drivers/thermal/rockchip_thermal.c
> +++ b/drivers/thermal/rockchip_thermal.c
> @@ -96,6 +96,7 @@ struct chip_tsadc_table {
>   * @initialize: SoC special initialize tsadc controller method
>   * @irq_ack: clear the interrupt
>   * @get_temp: get the temperature
> + * @set_alarm_temp: set the high temperature interrupt
>   * @set_tshut_temp: set the hardware-controlled shutdown temperature
>   * @set_tshut_mode: set the hardware-controlled shutdown mode
>   * @table: the chip-specific conversion table
> @@ -119,6 +120,8 @@ struct rockchip_tsadc_chip {
>         /* Per-sensor methods */
>         int (*get_temp)(struct chip_tsadc_table table,
>                         int chn, void __iomem *reg, int *temp);
> +       void (*set_alarm_temp)(struct chip_tsadc_table table,
> +                              int chn, void __iomem *reg, int temp);
>         void (*set_tshut_temp)(struct chip_tsadc_table table,
>                                int chn, void __iomem *reg, int temp);
>         void (*set_tshut_mode)(int chn, void __iomem *reg, enum tshut_mode m);
> @@ -183,6 +186,7 @@ struct rockchip_thermal_data {
>  #define TSADCV2_INT_EN                         0x08
>  #define TSADCV2_INT_PD                         0x0c
>  #define TSADCV2_DATA(chn)                      (0x20 + (chn) * 0x04)
> +#define TSADCV2_COMP_INT(chn)                  (0x30 + (chn) * 0x04)
>  #define TSADCV2_COMP_SHUT(chn)                 (0x40 + (chn) * 0x04)
>  #define TSADCV2_HIGHT_INT_DEBOUNCE             0x60
>  #define TSADCV2_HIGHT_TSHUT_DEBOUNCE           0x64
> @@ -628,6 +632,20 @@ static int rk_tsadcv2_get_temp(struct chip_tsadc_table table,
>         return rk_tsadcv2_code_to_temp(table, val, temp);
>  }
>
> +static void rk_tsadcv2_alarm_temp(struct chip_tsadc_table table,
> +                                 int chn, void __iomem *regs, int temp)
> +{
> +       u32 alarm_value, int_en;
> +
> +       alarm_value = rk_tsadcv2_temp_to_code(table, temp);
> +       writel_relaxed(alarm_value & table.data_mask,
> +                      regs + TSADCV2_COMP_INT(chn));
> +
> +       int_en = readl_relaxed(regs + TSADCV2_INT_EN);
> +       int_en |= TSADCV2_INT_SRC_EN(chn);
> +       writel_relaxed(int_en, regs + TSADCV2_INT_EN);
> +}
> +
>  static void rk_tsadcv2_tshut_temp(struct chip_tsadc_table table,
>                                   int chn, void __iomem *regs, int temp)
>  {
> @@ -670,6 +688,7 @@ static const struct rockchip_tsadc_chip rk3228_tsadc_data = {
>         .irq_ack = rk_tsadcv3_irq_ack,
>         .control = rk_tsadcv3_control,
>         .get_temp = rk_tsadcv2_get_temp,
> +       .set_alarm_temp = rk_tsadcv2_alarm_temp,
>         .set_tshut_temp = rk_tsadcv2_tshut_temp,
>         .set_tshut_mode = rk_tsadcv2_tshut_mode,
>
> @@ -694,6 +713,7 @@ static const struct rockchip_tsadc_chip rk3288_tsadc_data = {
>         .irq_ack = rk_tsadcv2_irq_ack,
>         .control = rk_tsadcv2_control,
>         .get_temp = rk_tsadcv2_get_temp,
> +       .set_alarm_temp = rk_tsadcv2_alarm_temp,
>         .set_tshut_temp = rk_tsadcv2_tshut_temp,
>         .set_tshut_mode = rk_tsadcv2_tshut_mode,
>
> @@ -718,6 +738,7 @@ static const struct rockchip_tsadc_chip rk3366_tsadc_data = {
>         .irq_ack = rk_tsadcv3_irq_ack,
>         .control = rk_tsadcv3_control,
>         .get_temp = rk_tsadcv2_get_temp,
> +       .set_alarm_temp = rk_tsadcv2_alarm_temp,
>         .set_tshut_temp = rk_tsadcv2_tshut_temp,
>         .set_tshut_mode = rk_tsadcv2_tshut_mode,
>
> @@ -742,6 +763,7 @@ static const struct rockchip_tsadc_chip rk3368_tsadc_data = {
>         .irq_ack = rk_tsadcv2_irq_ack,
>         .control = rk_tsadcv2_control,
>         .get_temp = rk_tsadcv2_get_temp,
> +       .set_alarm_temp = rk_tsadcv2_alarm_temp,
>         .set_tshut_temp = rk_tsadcv2_tshut_temp,
>         .set_tshut_mode = rk_tsadcv2_tshut_mode,
>
> @@ -766,6 +788,7 @@ static const struct rockchip_tsadc_chip rk3399_tsadc_data = {
>         .irq_ack = rk_tsadcv3_irq_ack,
>         .control = rk_tsadcv3_control,
>         .get_temp = rk_tsadcv2_get_temp,
> +       .set_alarm_temp = rk_tsadcv2_alarm_temp,
>         .set_tshut_temp = rk_tsadcv2_tshut_temp,
>         .set_tshut_mode = rk_tsadcv2_tshut_mode,
>
> @@ -826,6 +849,21 @@ static irqreturn_t rockchip_thermal_alarm_irq_thread(int irq, void *dev)
>         return IRQ_HANDLED;
>  }
>
> +static int rockchip_thermal_set_trips(void *_sensor, int low, int high)
> +{
> +       struct rockchip_thermal_sensor *sensor = _sensor;
> +       struct rockchip_thermal_data *thermal = sensor->thermal;
> +       const struct rockchip_tsadc_chip *tsadc = thermal->chip;
> +
> +       dev_dbg(&thermal->pdev->dev, "%s: sensor %d: low: %d, high %d\n",
> +               __func__, sensor->id, low, high);
> +
> +       tsadc->set_alarm_temp(tsadc->table,
> +                             sensor->id, thermal->regs, high);
> +
> +       return 0;
> +}
> +
>  static int rockchip_thermal_get_temp(void *_sensor, int *out_temp)
>  {
>         struct rockchip_thermal_sensor *sensor = _sensor;
> @@ -843,6 +881,7 @@ static int rockchip_thermal_get_temp(void *_sensor, int *out_temp)
>
>  static const struct thermal_zone_of_device_ops rockchip_of_thermal_ops = {
>         .get_temp = rockchip_thermal_get_temp,
> +       .set_trips = rockchip_thermal_set_trips,
>  };
>
>  static int rockchip_configure_from_dt(struct device *dev,
> --
> 1.9.1
>

Tested-by: Stephen Barber <smbarber@chromium.org>

Steve
