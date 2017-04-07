From: Liam Breck <liam-RYWXG+zxWwBdeoIcmNTgJF6hYfS7NtTn@public.gmane.org>
Subject: Re: [PATCH v11 01/10] devicetree: power: Add battery.txt
Date: Fri, 7 Apr 2017 12:23:29 -0700
Message-ID: <CAKvHMgTxRJXgfpDgqQ_+=ErFEZAh9CodjVn5ZOoCfqPqSZWetA@mail.gmail.com>
References: <20170320094335.19224-1-liam@networkimprov.net> <20170320094335.19224-2-liam@networkimprov.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170320094335.19224-2-liam-RYWXG+zxWwBdeoIcmNTgJF6hYfS7NtTn@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: "Andrew F. Davis" <afd-l0cyMroinI0@public.gmane.org>, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

[+CC Tony Lindgren]

Rob & Sebastian & Tony & Andrew,

With this binding we allow a DT to hard-code battery characteristics.
But mainline dts files for boards & boxes really should NOT include
immutable battery properties unless the battery is inseparable from
the electronics. We want to prevent unpredictable behavior due to
incorrect DT properties after a user changes a battery to a different
type.

It's OK for device vendors to hard-code battery characteristics in DT,
but mainline dts is another matter.

If this is agreed, how should we document it?


On Mon, Mar 20, 2017 at 2:43 AM, Liam Breck <liam-RYWXG+zxWwBdeoIcmNTgJF6hYfS7NtTn@public.gmane.org> wrote:
> From: Liam Breck <kernel-RYWXG+zxWwBdeoIcmNTgJF6hYfS7NtTn@public.gmane.org>
>
> Documentation of static battery characteristics that can be defined
> for batteries which cannot self-identify. This information is required
> by fuel-gauge and charger chips for proper handling of the battery.
>
> Cc: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
> Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> Signed-off-by: Matt Ranostay <matt-sk+viVC6FLCDq+mSdOJa79kegs52MxvZ@public.gmane.org>
> Signed-off-by: Liam Breck <kernel-RYWXG+zxWwBdeoIcmNTgJF6hYfS7NtTn@public.gmane.org>
> ---
>  .../devicetree/bindings/power/supply/battery.txt   | 43 ++++++++++++++++++++++
>  1 file changed, 43 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/power/supply/battery.txt
>
> diff --git a/Documentation/devicetree/bindings/power/supply/battery.txt b/Documentation/devicetree/bindings/power/supply/battery.txt
> new file mode 100644
> index 0000000..53a68c0
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/power/supply/battery.txt
> @@ -0,0 +1,43 @@
> +Battery Characteristics
> +
> +The devicetree battery node provides static battery characteristics.
> +In smart batteries, these are typically stored in non-volatile memory
> +on a fuel gauge chip. The battery node should be used where there is
> +no appropriate non-volatile memory, or it is unprogrammed/incorrect.
> +
> +Required Properties:
> + - compatible: Must be "simple-battery"
> +
> +Optional Properties:
> + - voltage-min-design-microvolt: drained battery voltage
> + - energy-full-design-microwatt-hours: battery design energy
> + - charge-full-design-microamp-hours: battery design capacity
> +
> +Battery properties are named, where possible, for the corresponding
> +elements in enum power_supply_property, defined in
> +https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/include/linux/power_supply.h#n86
> +
> +Batteries must be referenced by chargers and/or fuel-gauges
> +using a phandle. The phandle's property should be named
> +"monitored-battery".
> +
> +Example:
> +
> +       bat: battery {
> +               compatible = "simple-battery";
> +               voltage-min-design-microvolt = <3200000>;
> +               energy-full-design-microwatt-hours = <5290000>;
> +               charge-full-design-microamp-hours = <1430000>;
> +       };
> +
> +       charger: charger@11 {
> +               ....
> +               monitored-battery = <&bat>;
> +               ...
> +       };
> +
> +       fuel_gauge: fuel-gauge@22 {
> +               ....
> +               monitored-battery = <&bat>;
> +               ...
> +       };
> --
> 2.9.3
>
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
