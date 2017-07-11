From: Michael Heinemann <posted@heine.so>
Subject: Re: [PATCH 2/4] power: supply: sbs-battery: sort includes
Date: Tue, 11 Jul 2017 10:37:16 +0200
Message-ID: <d4bd4cfbbbb4e26b62bc78f3f4c40ad1@heine.so>
References: <1499667800-69055-1-git-send-email-preid@electromag.com.au>
 <1499667800-69055-3-git-send-email-preid@electromag.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.stresser.de ([88.198.198.115]:34040 "EHLO mail.stresser.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755274AbdGKIhT (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 11 Jul 2017 04:37:19 -0400
In-Reply-To: <1499667800-69055-3-git-send-email-preid@electromag.com.au>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Phil Reid <preid@electromag.com.au>
Cc: sre@kernel.org, linux-pm@vger.kernel.org

On 2017-07-10 08:23, Phil Reid wrote:
> Sort the header includes prior to adding to the list.
> 
> Signed-off-by: Phil Reid <preid@electromag.com.au>
> ---
>  drivers/power/supply/sbs-battery.c | 17 ++++++++---------
>  1 file changed, 8 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/power/supply/sbs-battery.c
> b/drivers/power/supply/sbs-battery.c
> index 15873df..4594ed1 100644
> --- a/drivers/power/supply/sbs-battery.c
> +++ b/drivers/power/supply/sbs-battery.c
> @@ -14,19 +14,18 @@
>   * more details.
>   */
> 
> -#include <linux/init.h>
> -#include <linux/module.h>
> -#include <linux/kernel.h>
>  #include <linux/err.h>
> -#include <linux/power_supply.h>
> +#include <linux/gpio/consumer.h>
>  #include <linux/i2c.h>
> -#include <linux/slab.h>
> +#include <linux/init.h>
>  #include <linux/interrupt.h>
> -#include <linux/gpio/consumer.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
>  #include <linux/of.h>
> -#include <linux/stat.h>
> -
>  #include <linux/power/sbs-battery.h>
> +#include <linux/power_supply.h>
> +#include <linux/slab.h>
> +#include <linux/stat.h>
> 
>  enum {
>  	REG_MANUFACTURER_DATA,
> @@ -57,7 +56,7 @@ enum {
>  #define BATTERY_MODE_MASK		0x8000
>  enum sbs_battery_mode {
>  	BATTERY_MODE_AMPS = 0,
> -	BATTERY_MODE_WATTS = 0x800
> +	BATTERY_MODE_WATTS = 0x8000
>  };

I guess the second chunk is in there by accident.

> 
>  /* manufacturer access defines */
