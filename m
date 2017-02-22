From: Liam Breck <liam-RYWXG+zxWwBdeoIcmNTgJF6hYfS7NtTn@public.gmane.org>
Subject: Re: [PATCH v7 1/9] devicetree: power: Add battery.txt
Date: Wed, 22 Feb 2017 13:39:46 -0800
Message-ID: <CAKvHMgRLGVAUEBqt9HsUsSE8cCJdTRuxt9QDi=L6eaNV=mHZ0g@mail.gmail.com>
References: <20170221213008.30044-1-liam@networkimprov.net>
 <20170221213008.30044-2-liam@networkimprov.net> <bd747560-8780-3294-86dd-f7f7f4de1736@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <bd747560-8780-3294-86dd-f7f7f4de1736-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Andrew F. Davis" <afd-l0cyMroinI0@public.gmane.org>
Cc: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Matt Ranostay <matt-sk+viVC6FLCDq+mSdOJa79kegs52MxvZ@public.gmane.org>, Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Liam Breck <kernel-RYWXG+zxWwBdeoIcmNTgJF6hYfS7NtTn@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

On Wed, Feb 22, 2017 at 12:05 PM, Andrew F. Davis <afd-l0cyMroinI0@public.gmane.org> wrote:
> On 02/21/2017 03:30 PM, Liam Breck wrote:
>> From: Liam Breck <kernel-RYWXG+zxWwBdeoIcmNTgJF6hYfS7NtTn@public.gmane.org>
>>
>> Documentation of static battery characteristics that can be defined
>> for batteries which cannot self-identify. This information is required
>> by fuel-gauge and charger chips for proper handling of the battery.
>>
>> Cc: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
>> Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
>> Signed-off-by: Matt Ranostay <matt-sk+viVC6FLCDq+mSdOJa79kegs52MxvZ@public.gmane.org>
>> Signed-off-by: Liam Breck <kernel-RYWXG+zxWwBdeoIcmNTgJF6hYfS7NtTn@public.gmane.org>
>> ---
>>  .../devicetree/bindings/power/supply/battery.txt   | 42 ++++++++++++++++++++++
>>  1 file changed, 42 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/power/supply/battery.txt
>>
>> diff --git a/Documentation/devicetree/bindings/power/supply/battery.txt b/Documentation/devicetree/bindings/power/supply/battery.txt
>> new file mode 100644
>> index 0000000..3d916bd
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/power/supply/battery.txt
>> @@ -0,0 +1,42 @@
>> +Battery Characteristics
>> +
>> +Required Properties:
>> + - compatible: Must be "fixed-battery"
>> +
>> +Optional Properties:
>> + - voltage-min-design-microvolt: drained battery voltage
>> + - energy-full-design-microwatt-hours: battery design energy
>> + - charge-full-design-microamp-hours: battery design capacity
>> +
>> +Future Properties must be named for the corresponding elements in
>> +enum power_supply_property, defined in include/linux/power_supply.h.
>> +
>> +Batteries must be referenced by chargers and/or fuel-gauges
>> +using a phandle. The phandle's property should be named
>> +"monitored-battery".
>> +
>> +Driver code should call power_supply_get_battery_info() to obtain
>> +battery properties via monitored-battery. For details see:
>> +  drivers/power/supply/power_supply_core.c
>> +  drivers/power/supply/bq27xxx_battery.c
>> +
>> +Example:
>> +
>> +     bat: battery {
>> +             compatible = "fixed-battery";
>> +             voltage-min-design-microvolt = <3200000>;
>> +             energy-full-design-microwatt-hours = <5290000>;
>> +             charge-full-design-microamp-hours = <1430000>;
>> +     };
>> +
>
> Still not sure what a non-fixed-battery would be. I guess it would be a
> battery with an integrated fuel-gauge pre-programmed with this design
> info. So then the charger node would want to point to a fuel-gauge node,
> and the fuel-gauge can optionally point to a fixed-battery if that info
> is not pre-programmable.

Sebastian wondered about a chain from charger thru gauge to battery,
but there are battery characteristics the gauge won't know about, e.g.
pre-charge and post-charge current, which is usually derived from
battery capacity.

> The issues then is for chargers with an integrated fuel-gauge, or
> systems without a fuel-gauge, that may get a bit messy, so I have no
> issues with this current binding.
>
>> +     charger: charger@11 {
>> +             ....
>> +             monitored-battery = <&bat>;
>> +             ...
>> +     };
>> +
>> +     fuel_gauge: fuel-gauge@22 {
>> +             ....
>> +             monitored-battery = <&bat>;
>> +             ...
>> +     };
>>
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
