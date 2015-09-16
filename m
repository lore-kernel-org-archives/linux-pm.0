From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: Re: [PATCH v4 05/10] power: bq24257: Add SW-based approach for Power
 Good determination
Date: Wed, 16 Sep 2015 14:41:13 +0900
Message-ID: <55F900F9.90306@samsung.com>
References: <1442339914-25843-1-git-send-email-dannenberg@ti.com>
 <1442339914-25843-6-git-send-email-dannenberg@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout2.w1.samsung.com ([210.118.77.12]:9500 "EHLO
	mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750989AbbIPFlR (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 16 Sep 2015 01:41:17 -0400
In-reply-to: <1442339914-25843-6-git-send-email-dannenberg@ti.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Andreas Dannenberg <dannenberg@ti.com>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Laurentiu Palcu <laurentiu.palcu@intel.com>
Cc: Ramakrishna Pallala <ramakrishna.pallala@intel.com>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org

On 16.09.2015 02:58, Andreas Dannenberg wrote:
> A software-based approach for determining the charger's input voltage
> "Power Good" state is introduced for devices like the bq24250 which
> don't have a dedicated hardware pin for that purpose. This SW-based
> approach is also used for other devices (with dedicated PG pin) as a
> fall back solution if that pin is not configured to be used through
> "pg-gpios".
> 
> Signed-off-by: Andreas Dannenberg <dannenberg@ti.com>
> ---
>  drivers/power/bq24257_charger.c | 49 ++++++++++++++++++++++++++++++++++++-----
>  1 file changed, 43 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/power/bq24257_charger.c b/drivers/power/bq24257_charger.c
> index 55e4ee4..d7488cf 100644
> --- a/drivers/power/bq24257_charger.c
> +++ b/drivers/power/bq24257_charger.c
> @@ -103,6 +103,7 @@ struct bq24257_device {
>  	struct mutex lock; /* protect state data */
>  
>  	bool in_ilimit_autoset_disable;
> +	bool pg_gpio_disable;
>  };
>  
>  static bool bq24257_is_volatile_reg(struct device *dev, unsigned int reg)
> @@ -356,7 +357,26 @@ static int bq24257_get_chip_state(struct bq24257_device *bq,
>  
>  	state->fault = ret;
>  
> -	state->power_good = !gpiod_get_value_cansleep(bq->pg);
> +	if (bq->pg_gpio_disable)
> +		/*
> +		 * If we have a chip without a dedicated power-good GPIO or
> +		 * some other explicit bit that would provide this information
> +		 * assume the power is good if there is no supply related
> +		 * fault - and not good otherwise. There is a possibility for
> +		 * other errors to mask that power in fact is not good but this
> +		 * is probably the best we can do here.
> +		 */
> +		switch (state->fault) {
> +		case FAULT_INPUT_OVP:
> +		case FAULT_INPUT_UVLO:
> +		case FAULT_INPUT_LDO_LOW:
> +			state->power_good = false;
> +			break;
> +		default:
> +			state->power_good = true;
> +		}
> +	else
> +		state->power_good = !gpiod_get_value_cansleep(bq->pg);
>  
>  	return 0;
>  }
> @@ -676,7 +696,7 @@ static int bq24257_pg_gpio_probe(struct bq24257_device *bq)
>  {
>  	bq->pg = devm_gpiod_get_index(bq->dev, BQ24257_PG_GPIO, 0, GPIOD_IN);
>  	if (IS_ERR(bq->pg)) {
> -		dev_err(bq->dev, "could not probe PG pin\n");
> +		dev_info(bq->dev, "could not probe PG pin\n");

I think if pg-gpio is provided (e.g. by DTS) but it is invalid (return
value != ENOENT) then it is an error you could print. The driver will
fallback to the software method but still user/developer may want to
notice the error (e.g. error in DTS).

Anyway it is up to you, rest looks good:

Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

Best regards,
Krzysztof

