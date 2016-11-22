From: Brian Norris <briannorris@chromium.org>
Subject: Re: [PATCH 3/5] thermal: rockchip: fixes invalid temperature case
Date: Tue, 22 Nov 2016 12:57:37 -0800
Message-ID: <20161122205737.GB45366@google.com>
References: <1479818088-6007-1-git-send-email-wxt@rock-chips.com>
 <1479818088-6007-4-git-send-email-wxt@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1479818088-6007-4-git-send-email-wxt@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Caesar Wang <wxt@rock-chips.com>
Cc: edubezval@gmail.com, rui.zhang@intel.com, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-rockchip@lists.infradead.org, heiko@sntech.de, smbarber@chromium.org
List-Id: linux-pm@vger.kernel.org

On Tue, Nov 22, 2016 at 08:34:46PM +0800, Caesar Wang wrote:
> The temp_to_code function will return 0 when we set the trip points value
> or valid temperature.

I'm not quite sure what you mean by "when we set the trip points value
or valid temperature." Do you mean "when we set the trip point's value
to an invalid temperature"?

Assuming that's what you meant...

> This patch will prevent this case happening.

This is good to change, but IMO, it's better to actually pick a close
value, instead of the max. e.g., if you support temperatures at degree
intervals of 80, 85, 90, ..., 125, but someone lists 82 in the device
tree, we should pick either 80 or 85, not 125.

Brian

> Signed-off-by: Caesar Wang <wxt@rock-chips.com>
> ---
> 
>  drivers/thermal/rockchip_thermal.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/thermal/rockchip_thermal.c b/drivers/thermal/rockchip_thermal.c
> index 766486f..535f1fa 100644
> --- a/drivers/thermal/rockchip_thermal.c
> +++ b/drivers/thermal/rockchip_thermal.c
> @@ -401,17 +401,15 @@ static u32 rk_tsadcv2_temp_to_code(const struct chip_tsadc_table *table,
>  				   int temp)
>  {
>  	int high, low, mid;
> -	u32 error = 0;
> +	u32 error = table->data_mask;
>  
>  	low = 0;
>  	high = table->length - 1;
>  	mid = (high + low) / 2;
>  
>  	/* Return mask code data when the temp is over table range */
> -	if (temp < table->id[low].temp || temp > table->id[high].temp) {
> -		error = table->data_mask;
> +	if (temp < table->id[low].temp || temp > table->id[high].temp)
>  		goto exit;
> -	}
>  
>  	while (low <= high) {
>  		if (temp == table->id[mid].temp)
> -- 
> 2.7.4
> 
