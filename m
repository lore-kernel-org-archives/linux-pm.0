From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 09/22] mfd: axp20x: add AC power supply cells for AXP22X
 PMICs
Date: Wed, 4 Jan 2017 11:57:01 +0000
Message-ID: <20170104115701.GD24058@dell>
References: <20170102163723.7939-1-quentin.schulz@free-electrons.com>
 <20170102163723.7939-10-quentin.schulz@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170102163723.7939-10-quentin.schulz@free-electrons.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Quentin Schulz <quentin.schulz@free-electrons.com>
Cc: jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net, robh+dt@kernel.org, mark.rutland@arm.com, wens@csie.org, sre@kernel.org, linux@armlinux.org.uk, maxime.ripard@free-electrons.com, linux-iio@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, thomas.petazzoni@free-electrons.com, icenowy@aosc.xyz, bonbons@linux-vserver.org
List-Id: linux-pm@vger.kernel.org

On Mon, 02 Jan 2017, Quentin Schulz wrote:

> The X-Powers AXP20X and AXP22X PMICs expose the status of AC power
> supply.
> 
> This adds the AC power supply driver to the MFD cells of the AXP22X
> PMICs.
> 
> Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
> ---
>  drivers/mfd/axp20x.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)

For my own reference:
  Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
  
> diff --git a/drivers/mfd/axp20x.c b/drivers/mfd/axp20x.c
> index 31a84d81..65c57d0 100644
> --- a/drivers/mfd/axp20x.c
> +++ b/drivers/mfd/axp20x.c
> @@ -608,6 +608,11 @@ static struct mfd_cell axp221_cells[] = {
>  		.name		= "axp20x-adc",
>  		.of_compatible	= "x-powers,axp221-adc"
>  	}, {
> +		.name		= "axp20x-ac-power-supply",
> +		.of_compatible	= "x-powers,axp221-ac-power-supply",
> +		.num_resources	= ARRAY_SIZE(axp20x_ac_power_supply_resources),
> +		.resources	= axp20x_ac_power_supply_resources,
> +	}, {
>  		.name		= "axp20x-usb-power-supply",
>  		.of_compatible	= "x-powers,axp221-usb-power-supply",
>  		.num_resources	= ARRAY_SIZE(axp22x_usb_power_supply_resources),
> @@ -626,6 +631,11 @@ static struct mfd_cell axp223_cells[] = {
>  	}, {
>  		.name			= "axp20x-regulator",
>  	}, {
> +		.name		= "axp20x-ac-power-supply",
> +		.of_compatible	= "x-powers,axp221-ac-power-supply",
> +		.num_resources	= ARRAY_SIZE(axp20x_ac_power_supply_resources),
> +		.resources	= axp20x_ac_power_supply_resources,
> +	}, {
>  		.name		= "axp20x-usb-power-supply",
>  		.of_compatible	= "x-powers,axp223-usb-power-supply",
>  		.num_resources	= ARRAY_SIZE(axp22x_usb_power_supply_resources),

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
