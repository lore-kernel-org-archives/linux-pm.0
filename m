From: "Andrew F. Davis" <afd-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v6 1/8] devicetree: power: Add battery.txt
Date: Mon, 13 Feb 2017 10:06:36 -0600
Message-ID: <ce69f358-ac3b-993d-0639-844856362c9d@ti.com>
References: <20170211024340.19491-1-liam@networkimprov.net>
 <20170211024340.19491-2-liam@networkimprov.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170211024340.19491-2-liam-RYWXG+zxWwBdeoIcmNTgJF6hYfS7NtTn@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Liam Breck <liam-RYWXG+zxWwBdeoIcmNTgJF6hYfS7NtTn@public.gmane.org>, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Matt Ranostay <matt-sk+viVC6FLCDq+mSdOJa79kegs52MxvZ@public.gmane.org>, Liam Breck <kernel-RYWXG+zxWwBdeoIcmNTgJF6hYfS7NtTn@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

On 02/10/2017 08:43 PM, Liam Breck wrote:
> From: Matt Ranostay <matt-sk+viVC6FLCDq+mSdOJa79kegs52MxvZ@public.gmane.org>
> 
> Documentation of static battery characteristics that can be defined
> for batteries which cannot self-identify. This information is required
> by fuel-gauge and charger chips for proper handling of the battery.


I think some of the confusion about what a "smart-battery" binding would
look like is due to a miss-understanding what it means to
"self-identify". Originally the bq27xxx *was* the chip that lived its
whole life inside a battery (the iphone battery is one such example and
a good way to test the bq27000). This way it could be factory programmed
with the battery's basics and then learn about the individual pack over
time to provide better info on time to empty, discharge rates, etc..

Eventually, people wanted to have the battery become cheap and
replaceable, so fuel-gauges were made that are "system side", and ride
along with the device, not the battery. Now this has one big problem,
how can we learn about a battery when it may be a new battery every time
we boot up? So we added programmable memory to the devices, and
programming this memory looks to be what this series is about.

Only the battery design info is programmed in this series, but much more
battery info can be uploaded, including stuff that is not fixed and
therefor cannot be added to the DT. Even the design parameters may not
be fix if one changes the battery as different manufactures of the same
battery type may have different design capacities.

The ideal use-case in a system with a system side gauge is the OS should
periodically, or just before shutdown, read the battery's learned info
and when the device is powered back up, if the battery serial number
matches from before, re-upload this learned info to the gauge so it
doesn't have to re-learn everything. All of this will need to happen in
user-space, so what we really need is a user-space API for manipulating
these properties.

The properties added in this series are okay, and it's good to have some
sane defaults in DT, but looking forward this may not be enough to get
full use out of these devices.

Andrew

> 
> Cc: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
> Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> Signed-off-by: Matt Ranostay <matt-sk+viVC6FLCDq+mSdOJa79kegs52MxvZ@public.gmane.org>
> Signed-off-by: Liam Breck <kernel-RYWXG+zxWwBdeoIcmNTgJF6hYfS7NtTn@public.gmane.org>
> ---
>  .../devicetree/bindings/power/supply/battery.txt   | 37 ++++++++++++++++++++++
>  1 file changed, 37 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/power/supply/battery.txt
> 
> diff --git a/Documentation/devicetree/bindings/power/supply/battery.txt b/Documentation/devicetree/bindings/power/supply/battery.txt
> new file mode 100644
> index 0000000..d78a4aa
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/power/supply/battery.txt
> @@ -0,0 +1,37 @@
> +Battery Characteristics
> +
> +Required Properties:
> + - compatible: Must be "fixed-battery"
> +
> +Optional Properties:
> + - voltage-min-design-microvolt: drained battery voltage
> + - energy-full-design-microwatt-hours: battery design energy
> + - charge-full-design-microamp-hours: battery design capacity
> +
> +Future Properties must be named for the corresponding elements in
> +enum power_supply_property, defined in include/linux/power_supply.h.
> +
> +Batteries must be referenced by chargers and/or fuel-gauges
> +using a phandle. The phandle's property should be named
> +"monitored-battery".
> +
> +Example:
> +
> +	bat: battery {
> +		compatible = "fixed-battery";
> +		voltage-min-design-microvolt = <3200000>;
> +		energy-full-design-microwatt-hours = <5290000>;
> +		charge-full-design-microamp-hours = <1430000>;
> +	};
> +
> +	charger: charger@11 {
> +		....
> +		monitored-battery = <&bat>;
> +		...
> +	};
> +
> +	fuel_gauge: fuel-gauge@22 {
> +		....
> +		monitored-battery = <&bat>;
> +		...
> +	};
> 
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
