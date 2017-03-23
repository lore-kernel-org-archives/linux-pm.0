From: Liam Breck <liam@networkimprov.net>
Subject: Re: [PATCH v11 01/10] devicetree: power: Add battery.txt
Date: Thu, 23 Mar 2017 03:30:42 -0700
Message-ID: <CAKvHMgSEDAZregni_hb2e92BXD2d2gZDpmnd02DFjnvTOni0zA@mail.gmail.com>
References: <20170320094335.19224-1-liam@networkimprov.net>
 <20170320094335.19224-2-liam@networkimprov.net> <20170323102006.2ftvsoukgmqh7dtv@earth>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-io0-f195.google.com ([209.85.223.195]:33089 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751660AbdCWKap (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 23 Mar 2017 06:30:45 -0400
In-Reply-To: <20170323102006.2ftvsoukgmqh7dtv@earth>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: Rob Herring <robh@kernel.org>, "Andrew F. Davis" <afd@ti.com>, linux-pm@vger.kernel.org, Matt Ranostay <matt@ranostay.consulting>, devicetree@vger.kernel.org, Liam Breck <kernel@networkimprov.net>

On Thu, Mar 23, 2017 at 3:20 AM, Sebastian Reichel <sre@kernel.org> wrote:
> Hi,
>
> On Mon, Mar 20, 2017 at 02:43:26AM -0700, Liam Breck wrote:
>> From: Liam Breck <kernel@networkimprov.net>
>>
>> Documentation of static battery characteristics that can be defined
>> for batteries which cannot self-identify. This information is required
>> by fuel-gauge and charger chips for proper handling of the battery.
>>
>> Cc: Rob Herring <robh@kernel.org>
>> Cc: devicetree@vger.kernel.org
>> Signed-off-by: Matt Ranostay <matt@ranostay.consulting>
>> Signed-off-by: Liam Breck <kernel@networkimprov.net>
>> ---
>>  .../devicetree/bindings/power/supply/battery.txt   | 43 ++++++++++++++++++++++
>>  1 file changed, 43 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/power/supply/battery.txt
>>
>> diff --git a/Documentation/devicetree/bindings/power/supply/battery.txt b/Documentation/devicetree/bindings/power/supply/battery.txt
>> new file mode 100644
>> index 0000000..53a68c0
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/power/supply/battery.txt
>> @@ -0,0 +1,43 @@
>> +Battery Characteristics
>> +
>> +The devicetree battery node provides static battery characteristics.
>> +In smart batteries, these are typically stored in non-volatile memory
>> +on a fuel gauge chip. The battery node should be used where there is
>> +no appropriate non-volatile memory, or it is unprogrammed/incorrect.
>> +
>> +Required Properties:
>> + - compatible: Must be "simple-battery"
>> +
>> +Optional Properties:
>> + - voltage-min-design-microvolt: drained battery voltage
>> + - energy-full-design-microwatt-hours: battery design energy
>> + - charge-full-design-microamp-hours: battery design capacity
>> +
>> +Battery properties are named, where possible, for the corresponding
>> +elements in enum power_supply_property, defined in
>> +https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/include/linux/power_supply.h#n86
>
> The above paragraph does not belong into DT bindings. Apart
> from that

How then should I indicate that there is a method to the madness of
the above names? More information in the docs is helpful than less!

> Acked-by: Sebastian Reichel <sre@kernel.org>
>
> FYI: I will wait for Acked-by from Rob Herring on this patch.
>
> -- Sebastian
>
>> +Batteries must be referenced by chargers and/or fuel-gauges
>> +using a phandle. The phandle's property should be named
>> +"monitored-battery".
>> +
>> +Example:
>> +
>> +     bat: battery {
>> +             compatible = "simple-battery";
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
