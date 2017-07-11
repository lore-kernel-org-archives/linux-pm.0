From: Michael Heinemann <posted@heine.so>
Subject: Re: [PATCH v2 3/3] power: supply: sbs-battery: Add delay when
 changing capacity mode bit
Date: Tue, 11 Jul 2017 13:31:16 +0200
Message-ID: <79941e55f3f273a1cf796deb945f5e95@heine.so>
References: <1499766223-130934-1-git-send-email-preid@electromag.com.au>
 <1499766223-130934-4-git-send-email-preid@electromag.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.stresser.de ([88.198.198.115]:36846 "EHLO mail.stresser.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752577AbdGKLbU (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 11 Jul 2017 07:31:20 -0400
In-Reply-To: <1499766223-130934-4-git-send-email-preid@electromag.com.au>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Phil Reid <preid@electromag.com.au>, linux-pm@vger.kernel.org
Cc: sre@kernel.org

On 2017-07-11 11:43, Phil Reid wrote:
> At least with the Inspired Energy compatible batteries a delay is 
> required
> after setting the capacity mode bit from amp to watts or the reverse.
> Setting the bit and then immediately pooling the status register 
> results
> in an unknown error being returned in the register. Add the delay 
> results
> in and ok status being return. This was also seen when reading the 
> charge
> and energy registers where the wrong value was returned for the 
> requested
> mode.
> 
> Signed-off-by: Phil Reid <preid@electromag.com.au>

Tested-by: Michael Heinemann <committed@heine.so>

> ---
>  drivers/power/supply/sbs-battery.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/power/supply/sbs-battery.c
> b/drivers/power/supply/sbs-battery.c
> index 4594ed1..3473b45 100644
> --- a/drivers/power/supply/sbs-battery.c
> +++ b/drivers/power/supply/sbs-battery.c
> @@ -14,6 +14,7 @@
>   * more details.
>   */
> 
> +#include <linux/delay.h>
>  #include <linux/err.h>
>  #include <linux/gpio/consumer.h>
>  #include <linux/i2c.h>
> @@ -511,6 +512,8 @@ static enum sbs_battery_mode
> sbs_set_battery_mode(struct i2c_client *client,
>  	if (ret < 0)
>  		return ret;
> 
> +	usleep_range(1000, 2000);
> +
>  	return original_val & BATTERY_MODE_MASK;
>  }
