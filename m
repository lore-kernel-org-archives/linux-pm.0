From: Andreas Dannenberg <dannenberg@ti.com>
Subject: Re: [PATCH v4 7/7] power: bq27xxx_battery: Add interrupt handling
 support
Date: Tue, 15 Sep 2015 13:47:15 -0500
Message-ID: <20150915184714.GB18055@beast>
References: <1442265973-32261-1-git-send-email-afd@ti.com>
 <1442265973-32261-8-git-send-email-afd@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:48926 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751834AbbIOSrn (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 15 Sep 2015 14:47:43 -0400
Content-Disposition: inline
In-Reply-To: <1442265973-32261-8-git-send-email-afd@ti.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Andrew F. Davis" <afd@ti.com>
Cc: Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Dan Murphy <dmurphy@ti.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

On Mon, Sep 14, 2015 at 04:26:13PM -0500, Andrew F. Davis wrote:
> Some devices have a pin that can generate an interrupt when
> the battery's status changes. Add an interrupt handler to
> read the new battery status.
> 
> Signed-off-by: Andrew F. Davis <afd@ti.com>
> ---
>  drivers/power/bq27xxx_battery.c | 23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
> 
> diff --git a/drivers/power/bq27xxx_battery.c b/drivers/power/bq27xxx_battery.c
> index 10be8a6..29fdcd7 100644
> --- a/drivers/power/bq27xxx_battery.c
> +++ b/drivers/power/bq27xxx_battery.c
> @@ -48,6 +48,7 @@
>  #include <linux/idr.h>
>  #include <linux/i2c.h>
>  #include <linux/slab.h>
> +#include <linux/interrupt.h>
>  #include <asm/unaligned.h>
>  
>  #include <linux/power/bq27xxx_battery.h>
> @@ -732,6 +733,15 @@ static void bq27xxx_battery_update(struct bq27xxx_device_info *di)
>  	di->last_update = jiffies;
>  }
>  
> +static irqreturn_t bq27xxx_battery_irq_handler_thread(int irq, void *data)
> +{
> +	struct bq27xxx_device_info *di = data;
> +
> +	bq27xxx_battery_update(di);
> +
> +	return IRQ_HANDLED;
> +}
> +
>  static void bq27xxx_battery_poll(struct work_struct *work)
>  {
>  	struct bq27xxx_device_info *di =
> @@ -1137,6 +1147,19 @@ static int bq27xxx_battery_i2c_probe(struct i2c_client *client,
>  
>  	i2c_set_clientdata(client, di);
>  
> +	if (client->irq) {
> +		retval = devm_request_threaded_irq(&client->dev, client->irq,
> +				NULL, bq27xxx_battery_irq_handler_thread,
> +				IRQF_ONESHOT,
> +				name, di);

Hi Andrew,
I think it'll be better if you explicitly specify the rising vs. falling
edge interrupt flags according to exactly what the bq27xxx will trigger
on to ensure the corresponding GPIO module is always configured properly.

While we are at it, was the platform-data based initialization in
conjunction with interrupts tested?

Regards,

--
Andreas Dannenberg
Texas Instruments Inc


> +		if (retval) {
> +			dev_err(&client->dev,
> +				"Unable to register IRQ %d error %d\n",
> +				client->irq, retval);
> +			return retval;
> +		}
> +	}
> +
>  	return 0;
>  
>  batt_failed:
> -- 
> 1.9.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pm" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
