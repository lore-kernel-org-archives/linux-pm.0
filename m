From: Quentin Schulz <quentin.schulz-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [RFC PATCH 4/7] power: supply: axp20x-battery:
 support AXP803
Date: Mon, 25 Sep 2017 10:58:46 +0200
Message-ID: <9b72b982-85b2-22e0-076a-15c066619006@free-electrons.com>
References: <20170920151814.22461-1-icenowy@aosc.io>
 <20170920151814.22461-5-icenowy@aosc.io>
Reply-To: quentin.schulz-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sunxi+bncBCLZXSNY5IDBBUMKUPHAKGQEWRTLP4A-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
In-Reply-To: <20170920151814.22461-5-icenowy-h8G6r0blFSE@public.gmane.org>
Content-Language: en-US
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: Icenowy Zheng <icenowy-h8G6r0blFSE@public.gmane.org>, Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Id: linux-pm@vger.kernel.org

Hi Icenowy,

On 20/09/2017 17:18, Icenowy Zheng wrote:
> The AXP803 PMIC has battery support like other AXP PMICs, but with
> different definition of max target charging voltage and constant
> charging current.
> 
> Add support for AXP803 battery in axp20x-battery driver.
> 
> Signed-off-by: Icenowy Zheng <icenowy-h8G6r0blFSE@public.gmane.org>
> ---
>  drivers/power/supply/axp20x_battery.c | 88 +++++++++++++++++++++++++++++++----
>  1 file changed, 78 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/power/supply/axp20x_battery.c b/drivers/power/supply/axp20x_battery.c
> index 7494f0f0eadb..c9a9fb320c92 100644
> --- a/drivers/power/supply/axp20x_battery.c
> +++ b/drivers/power/supply/axp20x_battery.c
> @@ -49,6 +49,8 @@
[...]
>  static void constant_charge_current_to_raw(struct axp20x_batt_ps *axp, int *val)
>  {
> -	if (axp->axp_id == AXP209_ID)
> +	switch (axp->axp_id) {
> +	case AXP209_ID:
>  		*val = (*val - 300000) / 100000;
> -	else
> +		break;
> +	case AXP221_ID:
>  		*val = (*val - 300000) / 150000;
> +		break;
> +	case AXP803_ID:
> +		*val = (*val - 200000) / 200000;
> +		/*
> +		 * The maximum charge current on AXP803 is 2.8A, and the
> +		 * datasheet says "1110-1111 reserved" in this part.
> +		 * So we return an invalid value -1 in this situation,
> +		 * which will be dealed by the caller of this function,
> +		 */

Good, we could do that for the two others compatible as well. They are
not explicitly marked as reserved but it stops at 1100 for AXP223/AXP221
for example.

> +		if (*val > 13)
> +			*val = -1;
> +		break;
> +	}
>  }
>  
>  static int axp20x_get_constant_charge_current(struct axp20x_batt_ps *axp,
> @@ -269,9 +322,13 @@ static int axp20x_battery_get_prop(struct power_supply *psy,
>  		if (ret)
>  			return ret;
>  
> -		if (axp20x_batt->axp_id == AXP221_ID &&
> -		    !(reg & AXP22X_FG_VALID))
> -			return -EINVAL;
> +		switch (axp20x_batt->axp_id) {
> +		case AXP221_ID:
> +		case AXP803_ID:
> +			if (!(reg & AXP22X_FG_VALID))
> +				return -EINVAL;
> +			break;
> +		};

Looks weird to me.

if (axp20x_batt->axp_id != AXP209_ID && !(reg & AXP22X_FG_VALID))

would be a better match?
[...]

Thanks,
Quentin

-- 
Quentin Schulz, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
