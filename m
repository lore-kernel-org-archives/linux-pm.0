From: Laurentiu Palcu <laurentiu.palcu@intel.com>
Subject: Re: [PATCH v2 11/13] power: bq24257: Add platform data based
 initialization
Date: Thu, 10 Sep 2015 17:40:53 +0300
Message-ID: <20150910144053.GM21512@lpalcu-desk>
References: <1441757557-7266-1-git-send-email-dannenberg@ti.com>
 <1441757557-7266-12-git-send-email-dannenberg@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:7833 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753028AbbIJOlM (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 10 Sep 2015 10:41:12 -0400
Content-Disposition: inline
In-Reply-To: <1441757557-7266-12-git-send-email-dannenberg@ti.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Andreas Dannenberg <dannenberg@ti.com>
Cc: Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org

On Tue, Sep 08, 2015 at 07:12:35PM -0500, Andreas Dannenberg wrote:
> The patch adds a way to setup and initialize the device through the use
> of platform data with configuration options equivalent to when using
> device firmware (DT or ACPI) for systems where this is not available.
> 
> Signed-off-by: Andreas Dannenberg <dannenberg@ti.com>
> ---
>  drivers/power/bq24257_charger.c       | 95 +++++++++++++++++++++++++++++++++--
>  include/linux/power/bq24257_charger.h | 30 +++++++++++
>  2 files changed, 120 insertions(+), 5 deletions(-)
>  create mode 100644 include/linux/power/bq24257_charger.h
> 
> diff --git a/drivers/power/bq24257_charger.c b/drivers/power/bq24257_charger.c
> index 9a4a7a0..b5e82ed 100644
> --- a/drivers/power/bq24257_charger.c
> +++ b/drivers/power/bq24257_charger.c
> @@ -27,10 +27,13 @@
>  #include <linux/gpio/consumer.h>
>  #include <linux/interrupt.h>
>  #include <linux/delay.h>
> +#include <linux/gpio.h>
>  
>  #include <linux/acpi.h>
>  #include <linux/of.h>
>  
> +#include <linux/power/bq24257_charger.h>
> +
>  #define BQ24257_REG_1			0x00
>  #define BQ24257_REG_2			0x01
>  #define BQ24257_REG_3			0x02
> @@ -958,28 +961,102 @@ static int bq24257_power_supply_init(struct bq24257_device *bq)
>  
>  static int bq24257_irq_probe(struct bq24257_device *bq)
>  {
> +	struct bq24257_platform_data *pdata = bq->client->dev.platform_data;
>  	struct gpio_desc *stat_irq;
> +	int ret;
> +
> +	if (!pdata)
> +		stat_irq = devm_gpiod_get_index(bq->dev, BQ24257_STAT_IRQ, 0,
> +				GPIOD_IN);
> +	else {
> +		if (!gpio_is_valid(pdata->stat_gpio)) {
> +			dev_err(bq->dev, "invalid stat_irq pin\n");
> +			return -EINVAL;
> +		}
> +
> +		ret = devm_gpio_request_one(bq->dev, pdata->stat_gpio,
> +				GPIOD_IN, BQ24257_STAT_IRQ);
> +		if (ret) {
> +			dev_err(bq->dev, "stat_irq pin request failed\n");
> +			return ret;
> +		}
> +
> +		stat_irq = gpio_to_desc(pdata->stat_gpio);
> +	}
>  
> -	stat_irq = devm_gpiod_get_index(bq->dev, BQ24257_STAT_IRQ, 0, GPIOD_IN);
>  	if (IS_ERR(stat_irq)) {
gpio_to_desc() can return NULL. In this case, IS_ERR() will be false. I
think this is not what you want...

The rest seems fine.

laurentiu
