From: Liam Breck <liam-RYWXG+zxWwBdeoIcmNTgJF6hYfS7NtTn@public.gmane.org>
Subject: Re: [PATCH v1 1/7] devicetree: power: battery: Add properties for
 pre-charge and end-charge current
Date: Tue, 28 Mar 2017 18:42:42 -0700
Message-ID: <CAKvHMgRWP6HAYOPCDaLfHUeTfQTYTb5ORg9bt19MDYQ7ubniMg@mail.gmail.com>
References: <20170321220921.5834-1-liam@networkimprov.net> <20170321220921.5834-2-liam@networkimprov.net>
 <20170329003946.3eyqmsozj2sxrtiw@rob-hp-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170329003946.3eyqmsozj2sxrtiw@rob-hp-laptop>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Quentin Schulz <quentin.schulz-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

Hi Rob,

On Tue, Mar 28, 2017 at 5:39 PM, Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
> On Tue, Mar 21, 2017 at 03:09:15PM -0700, Liam Breck wrote:
>> From: Liam Breck <kernel-RYWXG+zxWwBdeoIcmNTgJF6hYfS7NtTn@public.gmane.org>
>>
>> precharge-current-microamp and endcharge-current-microamp are used
>> by battery chargers at the beginning and end of a charging cycle.
>>
>> Depends-on: https://patchwork.kernel.org/patch/9633605/
>> Cc: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
>> Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
>> Signed-off-by: Liam Breck <kernel-RYWXG+zxWwBdeoIcmNTgJF6hYfS7NtTn@public.gmane.org>
>> ---
>>  Documentation/devicetree/bindings/power/supply/battery.txt | 4 ++++
>>  1 file changed, 4 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/power/supply/battery.txt b/Documentation/devicetree/bindings/power/supply/battery.txt
>> index 53a68c0..494374a 100644
>> --- a/Documentation/devicetree/bindings/power/supply/battery.txt
>> +++ b/Documentation/devicetree/bindings/power/supply/battery.txt
>> @@ -12,6 +12,8 @@ Optional Properties:
>>   - voltage-min-design-microvolt: drained battery voltage
>>   - energy-full-design-microwatt-hours: battery design energy
>>   - charge-full-design-microamp-hours: battery design capacity
>> + - precharge-current-microamp: current for pre-charge phase
>> + - endcharge-current-microamp: current for charge termination phase
>
> current is implied by microamp, so perhaps just pre-charge-microamp and
> end-charge-microamp.

Ah, this is why I want to document the naming scheme for battery node
properties in battery.txt, by referring to a linux header file :-)

The names mirror enum power_supply_property elements wherever
possible. Shortening them as you suggest makes dts code a little more
terse, but obscures their relationship with power_supply sysfs
attributes. I prefer brevity myself, but there is no strong case to
reword the names for DT use.

> I know little about batteries, but don't you also need to know when each
> phase starts/ends?

Meaning at what voltage levels? We don't need it for this
battery/charger pair; no idea about others...

> I mainly ask because we just added the previous properties and now we're
> adding 2 more. While fine to add features to a driver one by one, we
> really shouldn't for bindings. The h/w is not evolving (in a month).

And a third patchset from Quentin Schulz adds another :-)

I think you may need to accept piecemeal assembly in this case... No
one has made a study of all properties that should be in the battery
node. (precharge_current wasn't even in power_supply_property until
this patchset.) Sebastian requested we create this binding in the
process of adding DT support to a fuel gauge, so we coded what that
called for.

I hope that helps...
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
