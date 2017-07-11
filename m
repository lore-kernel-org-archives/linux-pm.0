From: Phil Reid <preid@electromag.com.au>
Subject: Re: [PATCH 4/4] power: supply: sbs-battery: Don't reset mode in
 get_battery_capacity
Date: Tue, 11 Jul 2017 12:57:43 +0800
Message-ID: <f27e0672-fbc5-dd9d-c9dd-1bfbfed8272a@electromag.com.au>
References: <1499667800-69055-1-git-send-email-preid@electromag.com.au>
 <1499667800-69055-5-git-send-email-preid@electromag.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from anchovy1.45ru.net.au ([203.30.46.145]:35020 "EHLO
        anchovy.45ru.net.au" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1754266AbdGKE5r (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 11 Jul 2017 00:57:47 -0400
In-Reply-To: <1499667800-69055-5-git-send-email-preid@electromag.com.au>
Content-Language: en-AU
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: sre@kernel.org, linux-pm@vger.kernel.org, posted@heine.so

On 10/07/2017 14:23, Phil Reid wrote:
> There seems little point in resetting the capacity mode bit when
> reading a capacity register that is affected by this bit. The
> next call to the register read will set the bit if it's not in
> the correct mode.
> 

Thinking about this a bit more and I don't think this is a good idea.
Reading the spec again I'm guessing the runtime till empty calcs will
be different based on this mode bit.

ie:
in uW mode, the spec is making an assumption of constant power, ie Switch Mode regulator load.
in mA mode, the spec is make an assumption of constant current, ie linear regulator load

What it probably needs is a mode selection option and set that at probe or when a battery is detected.

I'm not sure what impact changing the mode has to data calcs that uses averaging.

Please drop this patch for now.



> Signed-off-by: Phil Reid <preid@electromag.com.au>
> ---
>   drivers/power/supply/sbs-battery.c | 31 ++++++++++++-------------------
>   1 file changed, 12 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/power/supply/sbs-battery.c b/drivers/power/supply/sbs-battery.c
> index 3473b45..441a576 100644
> --- a/drivers/power/supply/sbs-battery.c
> +++ b/drivers/power/supply/sbs-battery.c
> @@ -491,22 +491,19 @@ static void  sbs_unit_adjustment(struct i2c_client *client,
>   	}
>   }
>   
> -static enum sbs_battery_mode sbs_set_battery_mode(struct i2c_client *client,
> +static int sbs_set_battery_mode(struct i2c_client *client,
>   	enum sbs_battery_mode mode)
>   {
> -	int ret, original_val;
> +	int ret;
>   
> -	original_val = sbs_read_word_data(client, BATTERY_MODE_OFFSET);
> -	if (original_val < 0)
> -		return original_val;
> +	ret = sbs_read_word_data(client, BATTERY_MODE_OFFSET);
> +	if (ret < 0)
> +		return ret;
>   
> -	if ((original_val & BATTERY_MODE_MASK) == mode)
> -		return mode;
> +	if ((ret & BATTERY_MODE_MASK) == mode)
> +		return 0;
>   
> -	if (mode == BATTERY_MODE_AMPS)
> -		ret = original_val & ~BATTERY_MODE_MASK;
> -	else
> -		ret = original_val | BATTERY_MODE_MASK;
> +	ret = (ret & ~BATTERY_MODE_MASK) | mode;
>   
>   	ret = sbs_write_word_data(client, BATTERY_MODE_OFFSET, ret);
>   	if (ret < 0)
> @@ -514,7 +511,7 @@ static enum sbs_battery_mode sbs_set_battery_mode(struct i2c_client *client,
>   
>   	usleep_range(1000, 2000);
>   
> -	return original_val & BATTERY_MODE_MASK;
> +	return 0;
>   }
>   
>   static int sbs_get_battery_capacity(struct i2c_client *client,
> @@ -527,9 +524,9 @@ static int sbs_get_battery_capacity(struct i2c_client *client,
>   	if (power_supply_is_amp_property(psp))
>   		mode = BATTERY_MODE_AMPS;
>   
> -	mode = sbs_set_battery_mode(client, mode);
> -	if (mode < 0)
> -		return mode;
> +	ret = sbs_set_battery_mode(client, mode);
> +	if (ret < 0)
> +		return ret;
>   
>   	ret = sbs_read_word_data(client, sbs_data[reg_offset].addr);
>   	if (ret < 0)
> @@ -542,10 +539,6 @@ static int sbs_get_battery_capacity(struct i2c_client *client,
>   	} else
>   		val->intval = ret;
>   
> -	ret = sbs_set_battery_mode(client, mode);
> -	if (ret < 0)
> -		return ret;
> -
>   	return 0;
>   }
>   
> 


-- 
Regards
Phil Reid
