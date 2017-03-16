From: Liam Breck <liam-RYWXG+zxWwBdeoIcmNTgJF6hYfS7NtTn@public.gmane.org>
Subject: Re: [PATCH v4 01/18] dt-bindings: power: battery: add
 constant-charge-current property
Date: Wed, 15 Mar 2017 23:27:27 -0700
Message-ID: <CAKvHMgR58sDnB-nn386Bd-H0Duevkeoc8eEfz=otLAumc8FD+w@mail.gmail.com>
References: <20170315105537.22349-1-quentin.schulz@free-electrons.com>
 <20170315105537.22349-2-quentin.schulz@free-electrons.com>
 <CAKvHMgSnyPPMEZ1o70Ed2oBHGcMho=-jjFhfXGn4t+2bdALEew@mail.gmail.com> <ce6f2ddb-f875-0370-ca45-293397d97495@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <ce6f2ddb-f875-0370-ca45-293397d97495-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Quentin Schulz <quentin.schulz-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Cc: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org

Hi Rob,

On Wed, Mar 15, 2017 at 6:10 AM, Quentin Schulz
<quentin.schulz-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org> wrote:
> Hi Liam,
>
> On 15/03/2017 13:08, Liam Breck wrote:
>> I dropped most of the CCs, pls re-add anyone essential. Use Cc lines
>> in patch description to direct a patch to interested parties and
>> relevant lists. I don't want to see all 19 patches in this series.
>>
>> On Wed, Mar 15, 2017 at 3:55 AM, Quentin Schulz
>> <quentin.schulz-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org> wrote:
>>> This adds the constant-charge-current property to the list of optional
>>> properties of the battery.
>>>
>>> The constant charge current is critical for batteries as they can't
>>> handle all charge currents.
>>>
>>> Signed-off-by: Quentin Schulz <quentin.schulz-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
>>> Acked-by: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
>>> ---
>>>
>>> v4:
>>>  - switch from constant-charge-current-microamp to constant-charge-microamp,

Sebastian is on record supporting name alignment between DT:battery
properties and enum power_supply_property.

Could you OK a change back to constant-charge-current-microamp in this patch?

Note that the following could appear in DT:battery in future:

constant-charge-current-microamp
constant-charge-current-max-microamp
constant-charge-voltage-microvolt
constant-charge-voltage-max-microvolt

Thanks!

>> Must be constant-charge-current-microamp for the reasons discussed in
>> battery.txt - consistency with sysfs names.
>>
>
> Hum. Just nitpicking, but I disagree with the use of 'must'. IIRC there
> is nothing in the code that would require the property to be named after
> a property from the enum power_supply_property.
>
> I would say that you _want_ it to be named like that because it
> underlines the relation between the DT property and the actual impacted
> property in the power supply subsystem. I'm fine with this reason but in
> the end, the maintainer's opinion prevails (if (s)he does not want it,
> (s)he will not take it). So, basically, I actually don't mind either
> option and I see arguments on each side.
>
> So, just waiting for maintainer's opinion to make the final version of
> this patch.
>
> Thanks,
> Quentin
>
>> Also applies to power_supply_core.c patch.
>>
>> Rob: enum power_supply_property also lists constant-charge-voltage,
>> hence the -current
>>
>>
>>> added in v3
>>>
>>>  Documentation/devicetree/bindings/power/supply/battery.txt | 2 ++
>>>  1 file changed, 2 insertions(+)
>>>
>>> diff --git a/Documentation/devicetree/bindings/power/supply/battery.txt b/Documentation/devicetree/bindings/power/supply/battery.txt
>>> index 0278617..9594e1e 100644
>>> --- a/Documentation/devicetree/bindings/power/supply/battery.txt
>>> +++ b/Documentation/devicetree/bindings/power/supply/battery.txt
>>> @@ -7,6 +7,7 @@ Optional Properties:
>>>   - voltage-min-design-microvolt: drained battery voltage
>>>   - energy-full-design-microwatt-hours: battery design energy
>>>   - charge-full-design-microamp-hours: battery design capacity
>>> + - constant-charge-microamp: battery constant charge current
>>>
>>>  Because drivers surface properties in sysfs using names derived
>>>  from enum power_supply_property, e.g.
>>> @@ -30,6 +31,7 @@ Example:
>>>                 voltage-min-design-microvolt = <3200000>;
>>>                 energy-full-design-microwatt-hours = <5290000>;
>>>                 charge-full-design-microamp-hours = <1430000>;
>>> +               constant-charge-microamp = <300000>;
>>>         };
>>>
>>>         charger: charger@11 {
>>> --
>>> 2.9.3
>>>
>
> --
> Quentin Schulz, Free Electrons
> Embedded Linux and Kernel engineering
> http://free-electrons.com
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
