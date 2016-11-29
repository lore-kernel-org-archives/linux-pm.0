From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [PATCH v3 3/5] thermal: rockchip: fixes invalid temperature case
Date: Mon, 28 Nov 2016 17:45:54 -0800
Message-ID: <20161129014553.GA3097@localhost.localdomain>
References: <1480331524-18741-1-git-send-email-wxt@rock-chips.com>
 <1480331524-18741-4-git-send-email-wxt@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f68.google.com ([74.125.83.68]:35575 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750754AbcK2Bp6 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 28 Nov 2016 20:45:58 -0500
Content-Disposition: inline
In-Reply-To: <1480331524-18741-4-git-send-email-wxt@rock-chips.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Caesar Wang <wxt@rock-chips.com>
Cc: rui.zhang@intel.com, heiko@sntech.de, smbarber@chromium.org, briannorris@chromium.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-rockchip@lists.infradead.org

Hey Caesar, Brian,

On Mon, Nov 28, 2016 at 07:12:02PM +0800, Caesar Wang wrote:
> The temp_to_code function will return 0 when we set the temperature to a
> invalid value (e.g. 61C, 62C, 63C....), that's unpractical. This patch
> will prevent this case happening. That will return the max analog value to
> indicate the temperature is invalid or over table temperature range.

<cut>

>  
>  	/* Make sure the value is valid */
>  	alarm_value = rk_tsadcv2_temp_to_code(table, temp);

dummy question here, looking at your tables, if I did not miss
something, looks like we have an accuracy of 5C steps. Not only, that,
we also support only multiples of 5C temperatures. If that observation
is correct, would it make more sense to simply check for this property,
and min and max temperature check, instead of going through the binary
search to check for valid temperature? 

>  	if (alarm_value == table->data_mask)
> -		return;
> +		return -ERANGE;
>  
>  	writel_relaxed(alarm_value & table->data_mask,
>  		       regs + TSADCV2_COMP_INT(chn));
> @@ -667,23 +665,27 @@ static void rk_tsadcv2_alarm_temp(const struct chip_tsadc_table *table,
>  	int_en = readl_relaxed(regs + TSADCV2_INT_EN);
>  	int_en |= TSADCV2_INT_SRC_EN(chn);
>  	writel_relaxed(int_en, regs + TSADCV2_INT_EN);
> +
> +	return 0;
>  }
>  
> -static void rk_tsadcv2_tshut_temp(const struct chip_tsadc_table *table,
> -				  int chn, void __iomem *regs, int temp)
> +static int rk_tsadcv2_tshut_temp(const struct chip_tsadc_table *table,
> +				 int chn, void __iomem *regs, int temp)
>  {
>  	u32 tshut_value, val;
>  
>  	/* Make sure the value is valid */
>  	tshut_value = rk_tsadcv2_temp_to_code(table, temp);
>  	if (tshut_value == table->data_mask)
> -		return;
> +		return -ERANGE;
>  
>  	writel_relaxed(tshut_value, regs + TSADCV2_COMP_SHUT(chn));
>  
>  	/* TSHUT will be valid */
>  	val = readl_relaxed(regs + TSADCV2_AUTO_CON);
>  	writel_relaxed(val | TSADCV2_AUTO_SRC_EN(chn), regs + TSADCV2_AUTO_CON);
> +
> +	return 0;
>  }
>  
>  static void rk_tsadcv2_tshut_mode(int chn, void __iomem *regs,
> @@ -886,10 +888,8 @@ static int rockchip_thermal_set_trips(void *_sensor, int low, int high)
>  	dev_dbg(&thermal->pdev->dev, "%s: sensor %d: low: %d, high %d\n",
>  		__func__, sensor->id, low, high);
>  
> -	tsadc->set_alarm_temp(&tsadc->table,
> -			      sensor->id, thermal->regs, high);
> -
> -	return 0;
> +	return tsadc->set_alarm_temp(&tsadc->table,
> +				     sensor->id, thermal->regs, high);
>  }
>  
>  static int rockchip_thermal_get_temp(void *_sensor, int *out_temp)
> @@ -985,8 +985,12 @@ rockchip_thermal_register_sensor(struct platform_device *pdev,
>  	int error;
>  
>  	tsadc->set_tshut_mode(id, thermal->regs, thermal->tshut_mode);
> -	tsadc->set_tshut_temp(&tsadc->table, id, thermal->regs,
> +
> +	error = tsadc->set_tshut_temp(&tsadc->table, id, thermal->regs,
>  			      thermal->tshut_temp);
> +	if (error)
> +		dev_err(&pdev->dev, "%s: invalid tshut=%d, error=%d\n",
> +			__func__, thermal->tshut_temp, error);
>  
>  	sensor->thermal = thermal;
>  	sensor->id = id;
> @@ -1199,9 +1203,13 @@ static int __maybe_unused rockchip_thermal_resume(struct device *dev)
>  
>  		thermal->chip->set_tshut_mode(id, thermal->regs,
>  					      thermal->tshut_mode);
> -		thermal->chip->set_tshut_temp(&thermal->chip->table,
> +
> +		error = thermal->chip->set_tshut_temp(&thermal->chip->table,
>  					      id, thermal->regs,
>  					      thermal->tshut_temp);
> +		if (error)
> +			dev_err(&pdev->dev, "%s: invalid tshut=%d, error=%d\n",
> +				__func__, thermal->tshut_temp, error);
>  	}
>  
>  	thermal->chip->control(thermal->regs, true);
> -- 
> 2.7.4
> 
