From: Quentin Schulz <quentin.schulz@free-electrons.com>
Subject: Re: [RFC PATCH 2/7] iio: adc: axp20x-adc: allow to skip ADC rate
 setup now
Date: Mon, 25 Sep 2017 09:20:02 +0200
Message-ID: <300803eb-4526-52c4-e74b-92625602a6da@free-electrons.com>
References: <20170920151814.22461-1-icenowy@aosc.io>
 <20170920151814.22461-3-icenowy@aosc.io>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:59792 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932385AbdIYHUO (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 25 Sep 2017 03:20:14 -0400
In-Reply-To: <20170920151814.22461-3-icenowy@aosc.io>
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Icenowy Zheng <icenowy@aosc.io>, Chen-Yu Tsai <wens@csie.org>, Maxime Ripard <maxime.ripard@free-electrons.com>, Jonathan Cameron <jic23@kernel.org>, Lee Jones <lee.jones@linaro.org>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-iio@vger.kernel.org, linux-sunxi@googlegroups.com

Hi Icenowy,

On 20/09/2017 17:18, Icenowy Zheng wrote:
> The ADC rate setup on AXP803 is more complex than AXP20x/22x.
> 

Can you elaborate?

I can see two rate settings in register 0x85.

Bits 7-6 => TS/GPIO ADC speed setting (25, 50, 100, 200 Hz) ((ilog2(x) /
25) << 6, same as AXP20X).
Bits 5-4 => Vol/Cur ADC speed setting (100, 200, 400, 800 Hz) ((ilog2(x)
/ 100) << 4, same as AXP22X except the bit shift).

Just set both to 100 or 200 by default (common rate). If someone wants
to add a more specific rate setting, he could do it in the future.

Setting a default is safer as we don't know if anything before the
kernel does anything to this register.

Thanks,
Quentin

> As it's not a necessary setup, allow it to be skipped, to allow simpler
> AXP803 support now.
> 
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> ---
>  drivers/iio/adc/axp20x_adc.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/adc/axp20x_adc.c b/drivers/iio/adc/axp20x_adc.c
> index 11e177180ea0..93dd6b80059e 100644
> --- a/drivers/iio/adc/axp20x_adc.c
> +++ b/drivers/iio/adc/axp20x_adc.c
> @@ -556,8 +556,10 @@ static int axp20x_probe(struct platform_device *pdev)
>  				   AXP20X_ADC_EN2_MASK, AXP20X_ADC_EN2_MASK);
>  
>  	/* Configure ADCs rate */
> -	regmap_update_bits(info->regmap, AXP20X_ADC_RATE, AXP20X_ADC_RATE_MASK,
> -			   info->data->adc_rate(100));
> +	if (info->data->adc_rate)
> +		regmap_update_bits(info->regmap, AXP20X_ADC_RATE,
> +				   AXP20X_ADC_RATE_MASK,
> +				   info->data->adc_rate(100));
>  
>  	ret = iio_map_array_register(indio_dev, info->data->maps);
>  	if (ret < 0) {
> 

-- 
Quentin Schulz, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
