From: Liam Breck <liam-RYWXG+zxWwBdeoIcmNTgJF6hYfS7NtTn@public.gmane.org>
Subject: Re: [PATCH v1 1/7] devicetree: power: battery: Add properties for
 pre-charge and end-charge current
Date: Fri, 24 Mar 2017 17:34:26 -0700
Message-ID: <CAKvHMgQt=C1tmfPz3pp_vwhc3b9DHKau2t=jwp3Rv2b2U6hsaQ@mail.gmail.com>
References: <20170321220921.5834-1-liam@networkimprov.net> <20170321220921.5834-2-liam@networkimprov.net>
 <20170324090158.tl55neisjws66naf@earth>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170324090158.tl55neisjws66naf@earth>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Liam Breck <kernel-RYWXG+zxWwBdeoIcmNTgJF6hYfS7NtTn@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

On Fri, Mar 24, 2017 at 2:01 AM, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
> Hi,
>
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
>
> Acked-by: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
>
> I think it makes sense to merge this into the patch adding
> simple-battery.

It would make sense, but it means a new _prop_precharge/endcharge
patch in that patchset, and I am trying to constrain it at this stage.

So if it's OK, I'd like to keep all that in this patchset.

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
>>
>>  Battery properties are named, where possible, for the corresponding
>>  elements in enum power_supply_property, defined in
>> @@ -28,6 +30,8 @@ Example:
>>               voltage-min-design-microvolt = <3200000>;
>>               energy-full-design-microwatt-hours = <5290000>;
>>               charge-full-design-microamp-hours = <1430000>;
>> +             precharge-current-microamp = <256000>;
>> +             endcharge-current-microamp = <128000>;
>>       };
>>
>>       charger: charger@11 {
>> --
>> 2.9.3
>>
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
