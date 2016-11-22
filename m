From: Brian Norris <briannorris@chromium.org>
Subject: Re: [PATCH 4/5] thermal: rockchip: optimize the conversion table
Date: Tue, 22 Nov 2016 13:47:40 -0800
Message-ID: <20161122214739.GA46981@google.com>
References: <1479818088-6007-1-git-send-email-wxt@rock-chips.com>
 <1479818088-6007-5-git-send-email-wxt@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1479818088-6007-5-git-send-email-wxt@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Caesar Wang <wxt@rock-chips.com>
Cc: edubezval@gmail.com, rui.zhang@intel.com, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-rockchip@lists.infradead.org, heiko@sntech.de, smbarber@chromium.org
List-Id: linux-pm@vger.kernel.org

On Tue, Nov 22, 2016 at 08:34:47PM +0800, Caesar Wang wrote:
> In order to support the valid temperature can conver to analog value.
> The rockchip thermal has not supported the all valid temperature.
> 
> For example:
> In some cases, we need adjust the trip point.
> $cd /sys/class/thermal/thermal_zone*
> echo 68000 > trip_point_0_temp
> That will report the error message before posting this patch.

Notably, this only printed an error in the kernel log. It didn't return
an error to the actual API, and instead it just programmed a 0 trip
point (or MASK, as of your previous patch). So you were lying to the
thermal core, which would still tell you that you programmed 68000 to
the trip point when you check:

  cat trip_point_0_temp

It's important to describe what you're fixing, so please reword the
commit log a bit.

> Signed-off-by: Caesar Wang <wxt@rock-chips.com>
> ---
> 
>  drivers/thermal/rockchip_thermal.c | 23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
> 
> diff --git a/drivers/thermal/rockchip_thermal.c b/drivers/thermal/rockchip_thermal.c
> index 535f1fa..f4d4be9 100644
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

If you manage to exit the above loop, you're assuming that:

	table->id[mid].temp < temp

I believe that's the case due to the round-down nature of the

  mid = (low + high) / 2
  
computation, but it's still a bit hard to reason about your binary
search loop.

Anyway, I think this is correct, so if you improve the commit message:

Reviewed-by: Brian Norris <briannorris@chromium.org>

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
