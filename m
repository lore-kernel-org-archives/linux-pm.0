From: Liam Breck <liam-RYWXG+zxWwBdeoIcmNTgJF6hYfS7NtTn@public.gmane.org>
Subject: Re: [PATCH v10 1/8] devicetree: power: Add battery.txt
Date: Wed, 15 Mar 2017 15:18:17 -0700
Message-ID: <CAKvHMgSF2rsaAaUqFw1qF+b2NA9CkABYKYOTd2p+imuPAHq9JA@mail.gmail.com>
References: <20170315192653.26799-1-liam@networkimprov.net>
 <20170315192653.26799-2-liam@networkimprov.net> <20170315220425.qeidvmanbsmq4wxk@earth>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170315220425.qeidvmanbsmq4wxk@earth>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: "Andrew F. Davis" <afd-l0cyMroinI0@public.gmane.org>, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Liam Breck <kernel-RYWXG+zxWwBdeoIcmNTgJF6hYfS7NtTn@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

Hey Sebastian, welcome back :-)

I've taken over work on this patchset from Matt.

On Wed, Mar 15, 2017 at 3:04 PM, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
> Hi Liam & Matt,
>
> Sorry for my absence in the discussion. I skipped the previous
> iterations for now and start with this version.
>
> On Wed, Mar 15, 2017 at 12:26:46PM -0700, Liam Breck wrote:
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
>>  .../devicetree/bindings/power/supply/battery.txt   | 45 ++++++++++++++++++++++
>>  1 file changed, 45 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/power/supply/battery.txt
>>
>> diff --git a/Documentation/devicetree/bindings/power/supply/battery.txt b/Documentation/devicetree/bindings/power/supply/battery.txt
>> new file mode 100644
>> index 0000000..0278617
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/power/supply/battery.txt
>> @@ -0,0 +1,45 @@
>> +Battery Characteristics
>
> Maybe add something like
>
> This device provides static battery information, that is usually
> available in the EEPROM of a smart battery. It's supposed to be
> used for batteries, which do not have their own EEPROM (or if its
> unusable).

OK.

>> +Required Properties:
>> + - compatible: Must be "fixed-battery"

Rob questioned the term "fixed". Shall we consider other terms --
simple-battery, plain-battery...?

>> +Optional Properties:
>> + - voltage-min-design-microvolt: drained battery voltage
>> + - energy-full-design-microwatt-hours: battery design energy
>> + - charge-full-design-microamp-hours: battery design capacity
>
> Looks fine to me.
>
>> +Because drivers surface properties in sysfs using names derived
>> +from enum power_supply_property, e.g.
>> +/sys/class/power_supply/<device>/charge_full_design, our
>> +battery properties must be named for the corresponding elements in
>> +enum power_supply_property, defined in include/linux/power_supply.h.
>
> This is Linux/implementation specific and does not belong
> into a DT binding document.

I just wrote on a thread for an earlier version of this patch:

"Sebastian proposed DT:battery specifically to be consumed by
power_supply_core. Allowing names in DT:battery and
power_supply_property to diverge would cause confusion and wasted
time, for no particular benefit. As there is no rationale to
reconsider the names of these fields for DT:battery, let's write that
into the docs."

>> +Batteries must be referenced by chargers and/or fuel-gauges
>> +using a phandle. The phandle's property should be named
>> +"monitored-battery".
>
> This looks fine.
>
>> +Driver code should call power_supply_get_battery_info() to obtain
>> +battery properties via monitored-battery. For details see:
>> +  drivers/power/supply/power_supply_core.c
>> +  drivers/power/supply/bq27xxx_battery.c
>
> This is also Linux/implementation specific and should be dropped.

We ought to mention how drivers are expected to consume DT:battery.

>> +Example:
>> +
>> +     bat: battery {
>> +             compatible = "fixed-battery";
>> +             voltage-min-design-microvolt = <3200000>;
>> +             energy-full-design-microwatt-hours = <5290000>;
>> +             charge-full-design-microamp-hours = <1430000>;
>> +     };
>> +
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
>> --
>> 2.9.3
>>
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
