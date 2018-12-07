From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v6 8/8] mfd: axp20x: Add supported cells for AXP803
Date: Fri, 7 Dec 2018 16:40:11 +0000
Message-ID: <20181207164011.GI26661@dell>
References: <20181120175211.3913-1-oskari@lemmela.net>
 <20181120175211.3913-9-oskari@lemmela.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181120175211.3913-9-oskari@lemmela.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Oskari Lemmela <oskari@lemmela.net>
Cc: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Chen-Yu Tsai <wens@csie.org>, Maxime Ripard <maxime.ripard@bootlin.com>, Quentin Schulz <quentin.schulz@bootlin.com>, Vasily Khoruzhick <anarsoul@gmail.com>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

On Tue, 20 Nov 2018, Oskari Lemmela wrote:

> Parts of the AXP803 are compatible with their counterparts on the AXP813.
> These include the GPIO, ADC, AC and battery power supplies.
> 
> Signed-off-by: Oskari Lemmela <oskari@lemmela.net>
> Reviewed-by: Chen-Yu Tsai <wens@csie.org>
> Tested-by: Vasily Khoruzhick <anarsoul@gmail.com>
> ---
>  drivers/mfd/axp20x.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/drivers/mfd/axp20x.c b/drivers/mfd/axp20x.c
> index dfc3cff1d08b..e415b967d38c 100644
> --- a/drivers/mfd/axp20x.c
> +++ b/drivers/mfd/axp20x.c
> @@ -728,11 +728,26 @@ static const struct mfd_cell axp288_cells[] = {
>  
>  static const struct mfd_cell axp803_cells[] = {
>  	{
> +		.name		= "axp20x-gpio",
> +		.of_compatible	= "x-powers,axp813-gpio",
> +	}, {
>  		.name			= "axp221-pek",
>  		.num_resources		= ARRAY_SIZE(axp803_pek_resources),
>  		.resources		= axp803_pek_resources,
>  	},
>  	{	.name			= "axp20x-regulator" },
> +	{
> +		.name		= "axp813-adc",
> +		.of_compatible	= "x-powers,axp813-adc",
> +	}, {
> +		.name		= "axp20x-battery-power-supply",
> +		.of_compatible	= "x-powers,axp813-battery-power-supply",
> +	}, {
> +		.name		= "axp20x-ac-power-supply",
> +		.of_compatible	= "x-powers,axp813-ac-power-supply",
> +		.num_resources	= ARRAY_SIZE(axp20x_ac_power_supply_resources),
> +		.resources	= axp20x_ac_power_supply_resources,
> +	},
>  };

My OCD-dar is going crazy.

Why haven't you used the same alignment as is already there?

If it starts to run over 80-chars then bring the others back.

Also why is there a single liner shoved in the middle of the
multi-line entries?  Please move the singles to the top or the
bottom.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
