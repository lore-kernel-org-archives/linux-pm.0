From: Priit Laes <plaes-q/aMd4JkU83YtjvyW6yDsg@public.gmane.org>
Subject: Re: [RFT PATCH 7/9] mfd: axp20x: add USB power supply
 mfd cell to AXP813
Date: Thu, 7 Feb 2019 15:13:06 +0000
Message-ID: <20190207151306.lyjcwyllshwm4o6q@plaes.org>
References: <20190207064535.9226-1-wens@csie.org>
 <20190207064535.9226-8-wens@csie.org>
Reply-To: plaes-q/aMd4JkU83YtjvyW6yDsg@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sunxi+bncBDB4J47M7YERBBMW6HRAKGQE7SI6FJQ-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Content-Disposition: inline
In-Reply-To: <20190207064535.9226-8-wens-jdAy2FN1RRM@public.gmane.org>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>
Cc: Maxime Ripard <maxime.ripard-LDxbnhwyfcJBDgjK7y7TUQ@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Quentin Schulz <quentin.schulz-LDxbnhwyfcJBDgjK7y7TUQ@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

On Thu, Feb 07, 2019 at 02:45:33PM +0800, Chen-Yu Tsai wrote:
> From: Quentin Schulz <quentin.schulz-LDxbnhwyfcJBDgjK7y7TUQ@public.gmane.org>
> 
> The AXP813 has a VBUS power input. Now that the axp20x_usb_power driver
> supports this variant, we can add an mfd cell for it to use it.
> 
> Signed-off-by: Quentin Schulz <quentin.schulz-LDxbnhwyfcJBDgjK7y7TUQ@public.gmane.org>
> [wens-jdAy2FN1RRM@public.gmane.org: add commit message]
> Signed-off-by: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>
> ---
>  drivers/mfd/axp20x.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/drivers/mfd/axp20x.c b/drivers/mfd/axp20x.c
> index 3c97f2c0fdfe..17b115845993 100644
> --- a/drivers/mfd/axp20x.c
> +++ b/drivers/mfd/axp20x.c
> @@ -198,6 +198,12 @@ static const struct resource axp22x_usb_power_supply_resources[] = {
>  	DEFINE_RES_IRQ_NAMED(AXP22X_IRQ_VBUS_REMOVAL, "VBUS_REMOVAL"),
>  };
>  
> +/* AXP803 and AXP813/AXP818 share the same interrupts */
> +static struct resource axp803_usb_power_supply_resources[] = {

const, if possible?

> +	DEFINE_RES_IRQ_NAMED(AXP803_IRQ_VBUS_PLUGIN, "VBUS_PLUGIN"),
> +	DEFINE_RES_IRQ_NAMED(AXP803_IRQ_VBUS_REMOVAL, "VBUS_REMOVAL"),
> +};
> +
>  static const struct resource axp22x_pek_resources[] = {
>  	DEFINE_RES_IRQ_NAMED(AXP22X_IRQ_PEK_RIS_EDGE, "PEK_DBR"),
>  	DEFINE_RES_IRQ_NAMED(AXP22X_IRQ_PEK_FAL_EDGE, "PEK_DBF"),
> @@ -793,6 +799,11 @@ static const struct mfd_cell axp813_cells[] = {
>  		.of_compatible	= "x-powers,axp813-ac-power-supply",
>  		.num_resources	= ARRAY_SIZE(axp20x_ac_power_supply_resources),
>  		.resources	= axp20x_ac_power_supply_resources,
> +	}, {
> +		.name		= "axp20x-usb-power-supply",
> +		.num_resources	= ARRAY_SIZE(axp803_usb_power_supply_resources),
> +		.resources	= axp803_usb_power_supply_resources,
> +		.of_compatible	= "x-powers,axp813-usb-power-supply",
>  	},
>  };
>  
> -- 
> 2.20.1
> 
> -- 
> You received this message because you are subscribed to the Google Groups "linux-sunxi" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to linux-sunxi+unsubscribe-/JYPxA39Uh5TLH3MbocFF+G/Ez6ZCGd0@public.gmane.org
> For more options, visit https://groups.google.com/d/optout.
