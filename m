From: Jonathan Cameron <jic23@kernel.org>
Subject: Re: [PATCH 2/7] power: supply: ab8500_charger: convert to IIO ADC
Date: Sat, 14 Jan 2017 14:56:52 +0000
Message-ID: <4ef609e7-8f9a-d780-964a-e59536a80e1f@kernel.org>
References: <20170110234745.29691-1-linus.walleij@linaro.org>
 <20170110234745.29691-3-linus.walleij@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:51912 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750823AbdANO4z (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 14 Jan 2017 09:56:55 -0500
In-Reply-To: <20170110234745.29691-3-linus.walleij@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>, Lee Jones <lee.jones@linaro.org>, linux-iio@vger.kernel.org, Sebastian Reichel <sre@kernel.org>, Guenter Roeck <linux@roeck-us.net>
Cc: Mboumba Cedric Madianga <cedric.madianga@gmail.com>, linux-pm@vger.kernel.org, linux-hwmon@vger.kernel.org

On 10/01/17 23:47, Linus Walleij wrote:
> This switches the AB8500 battery charger driver to using
> the standard IIO ADC channel lookup and conversion routines.
> 
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Other than the fact you have no dependencies on IIO being there
or similar (which the build bots pointed out anyway).

Acked-by: Jonathan Cameron <jic23@kernel.org>

> ---
>  drivers/power/supply/ab8500_charger.c | 78 ++++++++++++++++++++++++++---------
>  1 file changed, 58 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/power/supply/ab8500_charger.c b/drivers/power/supply/ab8500_charger.c
> index 5cee9aa87aa3..c1c4873899e9 100644
> --- a/drivers/power/supply/ab8500_charger.c
> +++ b/drivers/power/supply/ab8500_charger.c
> @@ -29,10 +29,10 @@
>  #include <linux/mfd/abx500/ab8500.h>
>  #include <linux/mfd/abx500.h>
>  #include <linux/mfd/abx500/ab8500-bm.h>
> -#include <linux/mfd/abx500/ab8500-gpadc.h>
>  #include <linux/mfd/abx500/ux500_chargalg.h>
>  #include <linux/usb/otg.h>
>  #include <linux/mutex.h>
> +#include <linux/iio/consumer.h>
>  
>  /* Charger constants */
>  #define NO_PW_CONN			0
> @@ -235,7 +235,10 @@ struct ab8500_charger_max_usb_in_curr {
>   * @current_stepping_sessions:
>   *			Counter for current stepping sessions
>   * @parent:		Pointer to the struct ab8500
> - * @gpadc:		Pointer to the struct gpadc
> + * @adc_main_charger_v	ADC channel for main charger voltage
> + * @adc_main_charger_c	ADC channel for main charger current
> + * @adc_vbus_v		ADC channel for USB charger voltage
> + * @adc_usb_charger_c	ADC channel for USB charger current
>   * @bm:           	Platform specific battery management information
>   * @flags:		Structure for information about events triggered
>   * @usb_state:		Structure for usb stack information
> @@ -285,7 +288,10 @@ struct ab8500_charger {
>  	int is_aca_rid;
>  	atomic_t current_stepping_sessions;
>  	struct ab8500 *parent;
> -	struct ab8500_gpadc *gpadc;
> +	struct iio_channel *adc_main_charger_v;
> +	struct iio_channel *adc_main_charger_c;
> +	struct iio_channel *adc_vbus_v;
> +	struct iio_channel *adc_usb_charger_c;
>  	struct abx500_bm_data *bm;
>  	struct ab8500_charger_event_flags flags;
>  	struct ab8500_charger_usb_state usb_state;
> @@ -461,13 +467,13 @@ static void ab8500_charger_set_usb_connected(struct ab8500_charger *di,
>   */
>  static int ab8500_charger_get_ac_voltage(struct ab8500_charger *di)
>  {
> -	int vch;
> +	int vch, ret;
>  
>  	/* Only measure voltage if the charger is connected */
>  	if (di->ac.charger_connected) {
> -		vch = ab8500_gpadc_convert(di->gpadc, MAIN_CHARGER_V);
> -		if (vch < 0)
> -			dev_err(di->dev, "%s gpadc conv failed,\n", __func__);
> +		ret = iio_read_channel_processed(di->adc_main_charger_v, &vch);
> +		if (ret < 0)
> +			dev_err(di->dev, "%s ADC conv failed,\n", __func__);
>  	} else {
>  		vch = 0;
>  	}
> @@ -512,13 +518,13 @@ static int ab8500_charger_ac_cv(struct ab8500_charger *di)
>   */
>  static int ab8500_charger_get_vbus_voltage(struct ab8500_charger *di)
>  {
> -	int vch;
> +	int vch, ret;
>  
>  	/* Only measure voltage if the charger is connected */
>  	if (di->usb.charger_connected) {
> -		vch = ab8500_gpadc_convert(di->gpadc, VBUS_V);
> -		if (vch < 0)
> -			dev_err(di->dev, "%s gpadc conv failed\n", __func__);
> +		ret = iio_read_channel_processed(di->adc_vbus_v, &vch);
> +		if (ret < 0)
> +			dev_err(di->dev, "%s ADC conv failed,\n", __func__);
>  	} else {
>  		vch = 0;
>  	}
> @@ -534,13 +540,13 @@ static int ab8500_charger_get_vbus_voltage(struct ab8500_charger *di)
>   */
>  static int ab8500_charger_get_usb_current(struct ab8500_charger *di)
>  {
> -	int ich;
> +	int ich, ret;
>  
>  	/* Only measure current if the charger is online */
>  	if (di->usb.charger_online) {
> -		ich = ab8500_gpadc_convert(di->gpadc, USB_CHARGER_C);
> -		if (ich < 0)
> -			dev_err(di->dev, "%s gpadc conv failed\n", __func__);
> +		ret = iio_read_channel_processed(di->adc_usb_charger_c, &ich);
> +		if (ret < 0)
> +			dev_err(di->dev, "%s ADC conv failed,\n", __func__);
>  	} else {
>  		ich = 0;
>  	}
> @@ -556,13 +562,13 @@ static int ab8500_charger_get_usb_current(struct ab8500_charger *di)
>   */
>  static int ab8500_charger_get_ac_current(struct ab8500_charger *di)
>  {
> -	int ich;
> +	int ich, ret;
>  
>  	/* Only measure current if the charger is online */
>  	if (di->ac.charger_online) {
> -		ich = ab8500_gpadc_convert(di->gpadc, MAIN_CHARGER_C);
> -		if (ich < 0)
> -			dev_err(di->dev, "%s gpadc conv failed\n", __func__);
> +		ret = iio_read_channel_processed(di->adc_main_charger_c, &ich);
> +		if (ret < 0)
> +			dev_err(di->dev, "%s ADC conv failed,\n", __func__);
>  	} else {
>  		ich = 0;
>  	}
> @@ -3485,7 +3491,39 @@ static int ab8500_charger_probe(struct platform_device *pdev)
>  	/* get parent data */
>  	di->dev = &pdev->dev;
>  	di->parent = dev_get_drvdata(pdev->dev.parent);
> -	di->gpadc = ab8500_gpadc_get("ab8500-gpadc.0");
> +
> +	/* Get ADC channels */
> +	di->adc_main_charger_v = devm_iio_channel_get(&pdev->dev,
> +						      "main_charger_v");
> +	if (IS_ERR(di->adc_main_charger_v)) {
> +		if (PTR_ERR(di->adc_main_charger_v) == -ENODEV)
> +                        return -EPROBE_DEFER;
> +		dev_err(&pdev->dev, "failed to get ADC main charger voltage\n");
> +		return PTR_ERR(di->adc_main_charger_v);
> +	}
> +	di->adc_main_charger_c = devm_iio_channel_get(&pdev->dev,
> +						      "main_charger_c");
> +	if (IS_ERR(di->adc_main_charger_c)) {
> +		if (PTR_ERR(di->adc_main_charger_c) == -ENODEV)
> +                        return -EPROBE_DEFER;
> +		dev_err(&pdev->dev, "failed to get ADC main charger current\n");
> +		return PTR_ERR(di->adc_main_charger_v);
> +	}
> +	di->adc_vbus_v = devm_iio_channel_get(&pdev->dev, "vbus_v");
> +	if (IS_ERR(di->adc_vbus_v)) {
> +		if (PTR_ERR(di->adc_vbus_v) == -ENODEV)
> +                        return -EPROBE_DEFER;
> +		dev_err(&pdev->dev, "failed to get ADC USB charger voltage\n");
> +		return PTR_ERR(di->adc_vbus_v);
> +	}
> +	di->adc_usb_charger_c = devm_iio_channel_get(&pdev->dev,
> +						     "usb_charger_c");
> +	if (IS_ERR(di->adc_usb_charger_c)) {
> +		if (PTR_ERR(di->adc_usb_charger_c) == -ENODEV)
> +                        return -EPROBE_DEFER;
> +		dev_err(&pdev->dev, "failed to get ADC USB charger current\n");
> +		return PTR_ERR(di->adc_usb_charger_c);
> +	}
>  
>  	/* initialize lock */
>  	spin_lock_init(&di->usb_state.usb_lock);
> 

