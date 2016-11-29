From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [PATCH v3 4/5] thermal: rockchip: optimize the conversion table
Date: Mon, 28 Nov 2016 17:48:14 -0800
Message-ID: <20161129014814.GB3097@localhost.localdomain>
References: <1480331524-18741-1-git-send-email-wxt@rock-chips.com>
 <1480331524-18741-5-git-send-email-wxt@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f67.google.com ([74.125.83.67]:33013 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752046AbcK2BsR (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 28 Nov 2016 20:48:17 -0500
Content-Disposition: inline
In-Reply-To: <1480331524-18741-5-git-send-email-wxt@rock-chips.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Caesar Wang <wxt@rock-chips.com>
Cc: rui.zhang@intel.com, heiko@sntech.de, smbarber@chromium.org, briannorris@chromium.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-rockchip@lists.infradead.org

On Mon, Nov 28, 2016 at 07:12:03PM +0800, Caesar Wang wrote:
> In order to support the valid temperature can conver to analog value.
> The rockchip thermal driver has not supported the all valid temperature
> to convert the analog value. (e.g.: 61C, 62C, 63C....)
> 
> For example:
> In some cases, we need adjust the trip point.
> $cd /sys/class/thermal/thermal_zone*
> $echo 68000 > trip_point_0_temp
> That will return the max analogic value indicates the invalid before
> posting this patch.
> 
> So, this patch will optimize the conversion table to support the other
> cases.
> 
> Signed-off-by: Caesar Wang <wxt@rock-chips.com>
> Reviewed-by: Brian Norris <briannorris@chromium.org>
> ---
> 
> Changes in v3: None
> Changes in v2:
> - improve the commit as Brian commnets on https://patchwork.kernel.org/patch/9440985
> 
> Changes in v1: None
> 
>  drivers/thermal/rockchip_thermal.c | 23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
> 
> diff --git a/drivers/thermal/rockchip_thermal.c b/drivers/thermal/rockchip_thermal.c
> index ca1730e..660ed3b 100644
> --- a/drivers/thermal/rockchip_thermal.c
> +++ b/drivers/thermal/rockchip_thermal.c
> @@ -401,6 +401,8 @@ static u32 rk_tsadcv2_temp_to_code(const struct chip_tsadc_table *table,
>  				   int temp)
>  {
>  	int high, low, mid;
> +	unsigned long num;
> +	unsigned int denom;
>  	u32 error = table->data_mask;
>  
>  	low = 0;
> @@ -421,6 +423,27 @@ static u32 rk_tsadcv2_temp_to_code(const struct chip_tsadc_table *table,
>  		mid = (low + high) / 2;
>  	}
>  
> +	/*
> +	 * The conversion code granularity provided by the table. Let's
> +	 * assume that the relationship between temperature and
> +	 * analog value between 2 table entries is linear and interpolate
> +	 * to produce less granular result.
> +	 */
> +	num = abs(table->id[mid].code - table->id[mid + 1].code);
> +	num *= temp - table->id[mid].temp;
> +	denom = table->id[mid + 1].temp - table->id[mid].temp;
> +
> +	switch (table->mode) {
> +	case ADC_DECREMENT:
> +		return table->id[mid].code - (num / denom);
> +	case ADC_INCREMENT:
> +		return table->id[mid].code + (num / denom);
> +	default:
> +		pr_err("%s: invalid conversion table, mode=%d\n",

Is this really an invalid conversion table, or an invalid conversion mode?

> +		       __func__, table->mode);
> +		return error;
> +	}
> +
>  exit:
>  	pr_err("%s: invalid temperature, temp=%d error=%d\n",
>  	       __func__, temp, error);
> -- 
> 2.7.4
> 
