From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 2/5] thermal: rockchip: Support the RK3368 SoCs in
 thermal driver
Date: Mon, 21 Sep 2015 10:08:51 -0700
Message-ID: <20150921170851.GH17389@dtor-ws>
References: <1442808971-2619-1-git-send-email-wxt@rock-chips.com>
 <1442808971-2619-3-git-send-email-wxt@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f54.google.com ([209.85.220.54]:35626 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932504AbbIURIz (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 21 Sep 2015 13:08:55 -0400
Content-Disposition: inline
In-Reply-To: <1442808971-2619-3-git-send-email-wxt@rock-chips.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Caesar Wang <wxt@rock-chips.com>
Cc: heiko@sntech.de, edubezval@gmail.com, rui.zhang@intel.com, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, will.deacon@arm.com, robh+dt@kernel.org, inux-kernel@vger.kernel.org, galak@codeaurora.org, linux-rockchip@lists.infradead.org, mark.rutland@arm.com, olof@lixom.net, linux-arm-kernel@lists.infradead.org, catalin.marinas@arm.com, ijc+devicetree@hellion.org.uk

Hi Caesar,

On Mon, Sep 21, 2015 at 12:16:08PM +0800, Caesar Wang wrote:
> The RK3368 SoCs support to 2 channel TS-ADC, the temperature criteria
> of each channel can be configurable.
> 
> The system has two Temperature Sensors, channel 0 is for CPU,
> and channel 1 is for GPU.
> 
> Signed-off-by: Caesar Wang <wxt@rock-chips.com>
> ---
> 
>  drivers/thermal/rockchip_thermal.c | 201 ++++++++++++++++++++++++++++++++-----
>  1 file changed, 176 insertions(+), 25 deletions(-)
> 
> diff --git a/drivers/thermal/rockchip_thermal.c b/drivers/thermal/rockchip_thermal.c
> index 4d5b7d4..16d2476 100644
> --- a/drivers/thermal/rockchip_thermal.c
> +++ b/drivers/thermal/rockchip_thermal.c
> @@ -1,6 +1,9 @@
>  /*
>   * Copyright (c) 2014, Fuzhou Rockchip Electronics Co., Ltd
>   *
> + * Copyright (c) 2015, Fuzhou Rockchip Electronics Co., Ltd
> + * Caesar Wang <wxt@rock-chips.com>
> + *
>   * This program is free software; you can redistribute it and/or modify it
>   * under the terms and conditions of the GNU General Public License,
>   * version 2, as published by the Free Software Foundation.
> @@ -43,16 +46,11 @@ enum tshut_polarity {
>  	TSHUT_HIGH_ACTIVE,
>  };
>  
> -/**
> - * The system has three Temperature Sensors.  channel 0 is reserved,
> - * channel 1 is for CPU, and channel 2 is for GPU.
> - */
> -enum sensor_id {
> -	SENSOR_CPU = 1,
> -	SENSOR_GPU,
> -};
> -
>  struct rockchip_tsadc_chip {
> +	/* The sensor id of chip correspond to the ADC channel */
> +	int cpu_id;
> +	int gpu_id;
> +
>  	/* The hardware-controlled tshut property */
>  	long tshut_temp;
>  	enum tshut_mode tshut_mode;
> @@ -72,10 +70,11 @@ struct rockchip_tsadc_chip {
>  struct rockchip_thermal_sensor {
>  	struct rockchip_thermal_data *thermal;
>  	struct thermal_zone_device *tzd;
> -	enum sensor_id id;
> +	int id;
>  };
>  
> -#define NUM_SENSORS	2 /* Ignore unused sensor 0 */
> +/* Two sensors: CPU and GPU */
> +#define NUM_SENSORS	2
>  
>  struct rockchip_thermal_data {
>  	const struct rockchip_tsadc_chip *chip;
> @@ -94,7 +93,7 @@ struct rockchip_thermal_data {
>  	enum tshut_polarity tshut_polarity;
>  };
>  
> -/* TSADC V2 Sensor info define: */
> +/* TSADC Sensor info define: */
>  #define TSADCV2_AUTO_CON			0x04
>  #define TSADCV2_INT_EN				0x08
>  #define TSADCV2_INT_PD				0x0c
> @@ -116,6 +115,8 @@ struct rockchip_thermal_data {
>  #define TSADCV2_INT_PD_CLEAR_MASK		~BIT(8)
>  
>  #define TSADCV2_DATA_MASK			0xfff
> +#define TSADCV3_DATA_MASK			0x3ff
> +
>  #define TSADCV2_HIGHT_INT_DEBOUNCE_COUNT	4
>  #define TSADCV2_HIGHT_TSHUT_DEBOUNCE_COUNT	4
>  #define TSADCV2_AUTO_PERIOD_TIME		250 /* msec */
> @@ -164,6 +165,45 @@ static const struct tsadc_table v2_code_table[] = {
>  	{3421, 125000},
>  };
>  
> +static const struct tsadc_table v3_code_table[] = {
> +	{0, -40000},
> +	{106, -40000},
> +	{108, -35000},
> +	{110, -30000},
> +	{112, -25000},
> +	{114, -20000},
> +	{116, -15000},
> +	{118, -10000},
> +	{120, -5000},
> +	{122, 0},
> +	{124, 5000},
> +	{126, 10000},
> +	{128, 15000},
> +	{130, 20000},
> +	{132, 25000},
> +	{134, 30000},
> +	{136, 35000},
> +	{138, 40000},
> +	{140, 45000},
> +	{142, 50000},
> +	{144, 55000},
> +	{146, 60000},
> +	{148, 65000},
> +	{150, 70000},
> +	{152, 75000},
> +	{154, 80000},
> +	{156, 85000},
> +	{158, 90000},
> +	{160, 95000},
> +	{162, 100000},
> +	{163, 105000},
> +	{165, 110000},
> +	{167, 115000},
> +	{169, 120000},
> +	{171, 125000},
> +	{TSADCV3_DATA_MASK, 125000},
> +};
> +
>  static u32 rk_tsadcv2_temp_to_code(long temp)
>  {
>  	int high, low, mid;
> @@ -227,16 +267,83 @@ static int rk_tsadcv2_code_to_temp(u32 code, int *temp)
>  	return 0;
>  }
>  
> +static u32 rk_tsadcv3_temp_to_code(long temp)
> +{
> +	int high, low, mid;
> +
> +	low = 0;
> +	high = ARRAY_SIZE(v3_code_table) - 1;
> +	mid = (high + low) / 2;
> +
> +	if (temp < v3_code_table[low].temp || temp > v3_code_table[high].temp)
> +		return 0;

How is this different from v2 conversion except for the table being
used? I think you should be able to reuse the conversion routines if you
pass the conversion table in as a parameter.

Thanks.

-- 
Dmitry
