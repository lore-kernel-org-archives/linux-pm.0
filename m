From: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH v1 1/7] devicetree: power: battery: Add properties for
 pre-charge and end-charge current
Date: Wed, 22 Mar 2017 13:04:26 +0100
Message-ID: <d73af3ca-cfa4-f48b-ba5e-cd07900de058@redhat.com>
References: <20170321220921.5834-1-liam@networkimprov.net>
 <20170321220921.5834-2-liam@networkimprov.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170321220921.5834-2-liam-RYWXG+zxWwBdeoIcmNTgJF6hYfS7NtTn@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Liam Breck <liam-RYWXG+zxWwBdeoIcmNTgJF6hYfS7NtTn@public.gmane.org>, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Liam Breck <kernel-RYWXG+zxWwBdeoIcmNTgJF6hYfS7NtTn@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

Hi,

On 21-03-17 23:09, Liam Breck wrote:
> From: Liam Breck <kernel-RYWXG+zxWwBdeoIcmNTgJF6hYfS7NtTn@public.gmane.org>
>
> precharge-current-microamp and endcharge-current-microamp are used
> by battery chargers at the beginning and end of a charging cycle.
>
> Depends-on: https://patchwork.kernel.org/patch/9633605/
> Cc: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
> Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> Signed-off-by: Liam Breck <kernel-RYWXG+zxWwBdeoIcmNTgJF6hYfS7NtTn@public.gmane.org>

Looks good to me:

Reviewed-by: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>

Regards,

Hans


> ---
>  Documentation/devicetree/bindings/power/supply/battery.txt | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/power/supply/battery.txt b/Documentation/devicetree/bindings/power/supply/battery.txt
> index 53a68c0..494374a 100644
> --- a/Documentation/devicetree/bindings/power/supply/battery.txt
> +++ b/Documentation/devicetree/bindings/power/supply/battery.txt
> @@ -12,6 +12,8 @@ Optional Properties:
>   - voltage-min-design-microvolt: drained battery voltage
>   - energy-full-design-microwatt-hours: battery design energy
>   - charge-full-design-microamp-hours: battery design capacity
> + - precharge-current-microamp: current for pre-charge phase
> + - endcharge-current-microamp: current for charge termination phase
>
>  Battery properties are named, where possible, for the corresponding
>  elements in enum power_supply_property, defined in
> @@ -28,6 +30,8 @@ Example:
>  		voltage-min-design-microvolt = <3200000>;
>  		energy-full-design-microwatt-hours = <5290000>;
>  		charge-full-design-microamp-hours = <1430000>;
> +		precharge-current-microamp = <256000>;
> +		endcharge-current-microamp = <128000>;
>  	};
>
>  	charger: charger@11 {
>
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
