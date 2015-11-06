From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [PATCH v2 4/9] thermal: rockchip: improve the conversion function
Date: Fri, 6 Nov 2015 11:00:08 -0800
Message-ID: <20151106190006.GB8202@localhost.localdomain>
References: <1446700685-18017-1-git-send-email-wxt@rock-chips.com>
 <1446700685-18017-5-git-send-email-wxt@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f47.google.com ([209.85.220.47]:34349 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752679AbbKFTAL (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 6 Nov 2015 14:00:11 -0500
Content-Disposition: inline
In-Reply-To: <1446700685-18017-5-git-send-email-wxt@rock-chips.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Caesar Wang <wxt@rock-chips.com>
Cc: Heiko Stuebner <heiko@sntech.de>, linux-rockchip@lists.infradead.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>, linux-arm-kernel@lists.infradead.org

Hello Caesar,

On Thu, Nov 05, 2015 at 01:18:00PM +0800, Caesar Wang wrote:
> We should make the conversion table in as a parameter since the different
> SoCs have the different conversionion table.
> 
> Signed-off-by: Caesar Wang <wxt@rock-chips.com>
> ---
> 
> Changes in v2:
> - make the conversion table in as a parameter both code_to_temp
>   and temp_to_code function.


Now it looks cleaner. Thanks.

The comments below are probably not directly on this change. You may
want to add a different patch that takes care of the suggestions that
follows.

> Series-changes: 1
> - As Dmitry comment, make the conversion table in as a parameter.
> 
> Changes in v1: None
> 
>  drivers/thermal/rockchip_thermal.c | 82 +++++++++++++++++++++++++-------------
>  1 file changed, 55 insertions(+), 27 deletions(-)
> 
> diff --git a/drivers/thermal/rockchip_thermal.c b/drivers/thermal/rockchip_thermal.c
> index bdf7063..e828f18 100644
> --- a/drivers/thermal/rockchip_thermal.c
> +++ b/drivers/thermal/rockchip_thermal.c
> @@ -58,6 +58,16 @@ enum sensor_id {
>   */
>  #define SOC_MAX_SENSORS	2
>  
> +struct chip_tsadc_table {
> +	const struct tsadc_table *id;
> +
> +	/* the array table size*/
> +	unsigned int length;
> +
> +	/* that analogic mask data */
> +	unsigned long data_mask;

Are you sure this need to be long?

> +};
> +
>  struct rockchip_tsadc_chip {
>  	/* The sensor id of chip correspond to the ADC channel */
>  	int chn_id[SOC_MAX_SENSORS];
> @@ -74,9 +84,14 @@ struct rockchip_tsadc_chip {
>  	void (*control)(void __iomem *reg, bool on);
>  
>  	/* Per-sensor methods */
> -	int (*get_temp)(int chn, void __iomem *reg, int *temp);
> -	void (*set_tshut_temp)(int chn, void __iomem *reg, long temp);
> +	int (*get_temp)(struct chip_tsadc_table table,
> +			int chn, void __iomem *reg, int *temp);
> +	void (*set_tshut_temp)(struct chip_tsadc_table table,
> +			       int chn, void __iomem *reg, long temp);

Temperature is currently represented as int not long in the thermal
framework. You may want to send a different patch that normalize the
temperature representation in your driver (long -> int).

>  	void (*set_tshut_mode)(int chn, void __iomem *reg, enum tshut_mode m);
> +
> +	/* Per-table methods */
> +	struct chip_tsadc_table table;
>  };
>  
>  struct rockchip_thermal_sensor {
> @@ -172,21 +187,22 @@ static const struct tsadc_table v2_code_table[] = {
>  	{3421, 125000},
>  };
>  
> -static u32 rk_tsadcv2_temp_to_code(long temp)
> +static u32 rk_tsadcv2_temp_to_code(struct chip_tsadc_table table,
> +				   long temp)

Same comment here.

>  {
>  	int high, low, mid;
>  
>  	low = 0;
> -	high = ARRAY_SIZE(v2_code_table) - 1;
> +	high = table.length - 1;
>  	mid = (high + low) / 2;
>  
> -	if (temp < v2_code_table[low].temp || temp > v2_code_table[high].temp)
> +	if (temp < table.id[low].temp || temp > table.id[high].temp)
>  		return 0;
>  
>  	while (low <= high) {
> -		if (temp == v2_code_table[mid].temp)
> -			return v2_code_table[mid].code;
> -		else if (temp < v2_code_table[mid].temp)
> +		if (temp == table.id[mid].temp)
> +			return table.id[mid].code;
> +		else if (temp < table.id[mid].temp)
>  			high = mid - 1;
>  		else
>  			low = mid + 1;
> @@ -196,25 +212,26 @@ static u32 rk_tsadcv2_temp_to_code(long temp)
>  	return 0;
>  }
>  
> -static int rk_tsadcv2_code_to_temp(u32 code, int *temp)
> +static int rk_tsadcv2_code_to_temp(struct chip_tsadc_table table, u32 code,
> +				   int *temp)

Here you are ok already.

>  {
>  	unsigned int low = 1;
> -	unsigned int high = ARRAY_SIZE(v2_code_table) - 1;
> +	unsigned int high = table.length - 1;
>  	unsigned int mid = (low + high) / 2;
>  	unsigned int num;
>  	unsigned long denom;
>  
> -	BUILD_BUG_ON(ARRAY_SIZE(v2_code_table) < 2);
> +	WARN_ON(table.length < 2);
>  
> -	code &= TSADCV2_DATA_MASK;
> -	if (code < v2_code_table[high].code)
> +	code &= table.data_mask;
> +	if (code < table.id[high].code)
>  		return -EAGAIN;		/* Incorrect reading */
>  
>  	while (low <= high) {
> -		if (code >= v2_code_table[mid].code &&
> -		    code < v2_code_table[mid - 1].code)
> +		if (code >= table.id[mid].code &&
> +		    code < table.id[mid - 1].code)
>  			break;
> -		else if (code < v2_code_table[mid].code)
> +		else if (code < table.id[mid].code)
>  			low = mid + 1;
>  		else
>  			high = mid - 1;
> @@ -227,10 +244,10 @@ static int rk_tsadcv2_code_to_temp(u32 code, int *temp)
>  	 * temperature between 2 table entries is linear and interpolate
>  	 * to produce less granular result.
>  	 */
> -	num = v2_code_table[mid].temp - v2_code_table[mid - 1].temp;
> -	num *= v2_code_table[mid - 1].code - code;
> -	denom = v2_code_table[mid - 1].code - v2_code_table[mid].code;
> -	*temp = v2_code_table[mid - 1].temp + (num / denom);
> +	num = table.id[mid].temp - v2_code_table[mid - 1].temp;
> +	num *= table.id[mid - 1].code - code;
> +	denom = table.id[mid - 1].code - table.id[mid].code;
> +	*temp = table.id[mid - 1].temp + (num / denom);
>  
>  	return 0;
>  }
> @@ -290,20 +307,22 @@ static void rk_tsadcv2_control(void __iomem *regs, bool enable)
>  	writel_relaxed(val, regs + TSADCV2_AUTO_CON);
>  }
>  
> -static int rk_tsadcv2_get_temp(int chn, void __iomem *regs, int *temp)
> +static int rk_tsadcv2_get_temp(struct chip_tsadc_table table,
> +			       int chn, void __iomem *regs, int *temp)
>  {
>  	u32 val;
>  
>  	val = readl_relaxed(regs + TSADCV2_DATA(chn));
>  
> -	return rk_tsadcv2_code_to_temp(val, temp);
> +	return rk_tsadcv2_code_to_temp(table, val, temp);
>  }
>  
> -static void rk_tsadcv2_tshut_temp(int chn, void __iomem *regs, long temp)
> +static void rk_tsadcv2_tshut_temp(struct chip_tsadc_table table,
> +				  int chn, void __iomem *regs, long temp)

Here needs fixing.


BR,

Eduardo Valentin
