From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v1] power: supply: bq25890: Use gpiod_get()
Date: Tue, 28 Feb 2017 17:13:20 +0200
Message-ID: <1488294800.20145.63.camel@linux.intel.com>
References: <20170220171223.40799-1-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:51571 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751709AbdB1POL (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 28 Feb 2017 10:14:11 -0500
In-Reply-To: <20170220171223.40799-1-andriy.shevchenko@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org

On Mon, 2017-02-20 at 19:12 +0200, Andy Shevchenko wrote:
> Since index is always 0, replace gpiod_get_index() by gpiod_get().
> 

Any comments on this?

I would reduce as much as possible use of gpiod_get_index*() to sort out
things later.

> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/power/supply/bq25890_charger.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/power/supply/bq25890_charger.c
> b/drivers/power/supply/bq25890_charger.c
> index f993a55cde20..8e2c41ded171 100644
> --- a/drivers/power/supply/bq25890_charger.c
> +++ b/drivers/power/supply/bq25890_charger.c
> @@ -723,7 +723,7 @@ static int bq25890_irq_probe(struct bq25890_device
> *bq)
>  {
>  	struct gpio_desc *irq;
>  
> -	irq = devm_gpiod_get_index(bq->dev, BQ25890_IRQ_PIN, 0,
> GPIOD_IN);
> +	irq = devm_gpiod_get(bq->dev, BQ25890_IRQ_PIN, GPIOD_IN);
>  	if (IS_ERR(irq)) {
>  		dev_err(bq->dev, "Could not probe irq pin.\n");
>  		return PTR_ERR(irq);

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
