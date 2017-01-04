From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v2 06/11] mfd: axp20x: add separate MFD cell for AXP223
Date: Wed, 4 Jan 2017 09:45:37 +0000
Message-ID: <20170104094537.GS27589@dell>
References: <20161209110419.28981-1-quentin.schulz@free-electrons.com>
 <20161209110419.28981-7-quentin.schulz@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20161209110419.28981-7-quentin.schulz@free-electrons.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Quentin Schulz <quentin.schulz@free-electrons.com>
Cc: sre@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com, wens@csie.org, linux@armlinux.org.uk, maxime.ripard@free-electrons.com, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, thomas.petazzoni@free-electrons.com
List-Id: linux-pm@vger.kernel.org

On Fri, 09 Dec 2016, Quentin Schulz wrote:

> The AXP223 shares most of its logic with the AXP221 but has some
> differences for the VBUS power supply driver. Thus, to probe the driver
> with the correct compatible, the AXP221 and the AXP223 now have separate
> MFD cells.
> 
> AXP221 MFD cells are renamed from axp22x_cells to axp221_cells to avoid
> confusion.
> 
> Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
> Acked-by: Chen-Yu Tsai <wens@csie.org>
> ---
> 
> v2:
>  - correct indentation,
>  - renaming axp22x_cells to axp221_cells to avoid confusion between axp22x,
> axp221 and axp223
> 
>  drivers/mfd/axp20x.c | 28 ++++++++++++++++++++++++----
>  1 file changed, 24 insertions(+), 4 deletions(-)

Applied, thanks.

> diff --git a/drivers/mfd/axp20x.c b/drivers/mfd/axp20x.c
> index 6ee2cc6..b31f123 100644
> --- a/drivers/mfd/axp20x.c
> +++ b/drivers/mfd/axp20x.c
> @@ -591,7 +591,22 @@ static struct mfd_cell axp20x_cells[] = {
>  	},
>  };
>  
> -static struct mfd_cell axp22x_cells[] = {
> +static struct mfd_cell axp221_cells[] = {
> +	{
> +		.name		= "axp20x-pek",
> +		.num_resources	= ARRAY_SIZE(axp22x_pek_resources),
> +		.resources	= axp22x_pek_resources,
> +	}, {
> +		.name		= "axp20x-regulator",
> +	}, {
> +		.name		= "axp20x-usb-power-supply",
> +		.of_compatible	= "x-powers,axp221-usb-power-supply",
> +		.num_resources	= ARRAY_SIZE(axp22x_usb_power_supply_resources),
> +		.resources	= axp22x_usb_power_supply_resources,
> +	},
> +};
> +
> +static struct mfd_cell axp223_cells[] = {
>  	{
>  		.name			= "axp20x-pek",
>  		.num_resources		= ARRAY_SIZE(axp22x_pek_resources),
> @@ -600,7 +615,7 @@ static struct mfd_cell axp22x_cells[] = {
>  		.name			= "axp20x-regulator",
>  	}, {
>  		.name		= "axp20x-usb-power-supply",
> -		.of_compatible	= "x-powers,axp221-usb-power-supply",
> +		.of_compatible	= "x-powers,axp223-usb-power-supply",
>  		.num_resources	= ARRAY_SIZE(axp22x_usb_power_supply_resources),
>  		.resources	= axp22x_usb_power_supply_resources,
>  	},
> @@ -793,9 +808,14 @@ int axp20x_match_device(struct axp20x_dev *axp20x)
>  		axp20x->regmap_irq_chip = &axp20x_regmap_irq_chip;
>  		break;
>  	case AXP221_ID:
> +		axp20x->nr_cells = ARRAY_SIZE(axp221_cells);
> +		axp20x->cells = axp221_cells;
> +		axp20x->regmap_cfg = &axp22x_regmap_config;
> +		axp20x->regmap_irq_chip = &axp22x_regmap_irq_chip;
> +		break;
>  	case AXP223_ID:
> -		axp20x->nr_cells = ARRAY_SIZE(axp22x_cells);
> -		axp20x->cells = axp22x_cells;
> +		axp20x->nr_cells = ARRAY_SIZE(axp223_cells);
> +		axp20x->cells = axp223_cells;
>  		axp20x->regmap_cfg = &axp22x_regmap_config;
>  		axp20x->regmap_irq_chip = &axp22x_regmap_irq_chip;
>  		break;

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
