From: Liam Breck <liam@networkimprov.net>
Subject: Re: [PATCH v4 01/18] dt-bindings: power: battery: add
 constant-charge-current property
Date: Thu, 30 Mar 2017 00:30:32 -0700
Message-ID: <CAKvHMgRo2f71okiQU6r0-QxkhQ97iuYtiDZuhLd2qV8FLZUtoA@mail.gmail.com>
References: <20170315105537.22349-1-quentin.schulz@free-electrons.com>
 <20170315105537.22349-2-quentin.schulz@free-electrons.com>
 <CAKvHMgSnyPPMEZ1o70Ed2oBHGcMho=-jjFhfXGn4t+2bdALEew@mail.gmail.com>
 <ce6f2ddb-f875-0370-ca45-293397d97495@free-electrons.com> <CAKvHMgR58sDnB-nn386Bd-H0Duevkeoc8eEfz=otLAumc8FD+w@mail.gmail.com>
 <765fc3be-23db-0997-85b1-b6c85b3aceef@free-electrons.com> <CAKvHMgRKroPFDdNMb=F=bA4bTwg9bYMAR-5Z4DKLzHJtCYz3_Q@mail.gmail.com>
 <CAKvHMgRtEnNbokYReu2vEs9UKH6qZnncdyQD=1JMDTZeN+aYCA@mail.gmail.com>
 <659fb6a3-d49d-5429-8770-88917e4fd0b3@free-electrons.com> <CAKvHMgSFNBmr3fU-biHDo5tzCDV7QaCpFnbChgn4wgSN_1FBig@mail.gmail.com>
 <8853ebb9-9c4f-d9bf-8c82-daad4650c4f8@free-electrons.com> <CAKvHMgQf=Zod-F9SMPDDj5Eq3v=JHGh7uns-T_=ynQM0dMtEvw@mail.gmail.com>
 <614aa4ef-6900-0c56-a364-0ef4e8af2f97@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-it0-f67.google.com ([209.85.214.67]:36546 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752733AbdC3Hae (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 30 Mar 2017 03:30:34 -0400
In-Reply-To: <614aa4ef-6900-0c56-a364-0ef4e8af2f97@free-electrons.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Quentin Schulz <quentin.schulz@free-electrons.com>
Cc: Sebastian Reichel <sre@kernel.org>, robh+dt@kernel.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org

On Wed, Mar 29, 2017 at 11:41 PM, Quentin Schulz
<quentin.schulz@free-electrons.com> wrote:
> Hi,
>
> On 29/03/2017 11:26, Liam Breck wrote:
>> On Wed, Mar 29, 2017 at 12:54 AM, Quentin Schulz
>> <quentin.schulz@free-electrons.com> wrote:
>>> Hi,
>>>
>>> On 29/03/2017 09:39, Liam Breck wrote:
>>>> On Wed, Mar 29, 2017 at 12:09 AM, Quentin Schulz
>>>> <quentin.schulz@free-electrons.com> wrote:
>>>>> Hi Liam,
>>>>>
>>>>> On 29/03/2017 08:55, Liam Breck wrote:
>>>>>> Hi Quentin,
>>>>>>
>>>>>> On Thu, Mar 16, 2017 at 12:42 AM, Liam Breck <liam@networkimprov.net> wrote:
>>>>>>> On Thu, Mar 16, 2017 at 12:03 AM, Quentin Schulz
>>>>>>> <quentin.schulz@free-electrons.com> wrote:
>>>>>>>> Hi Liam,
>>>>>>>>
>>>>>>>> On 16/03/2017 07:27, Liam Breck wrote:
>>>>>>>>> Hi Rob,
>>>>>>>>>
>>>>>>>>> On Wed, Mar 15, 2017 at 6:10 AM, Quentin Schulz
>>>>>>>>> <quentin.schulz@free-electrons.com> wrote:
>>>>>>>>>> Hi Liam,
>>>>>>>>>>
>>>>>>>>>> On 15/03/2017 13:08, Liam Breck wrote:
>>>>>>>>>>> I dropped most of the CCs, pls re-add anyone essential. Use Cc lines
>>>>>>>>>>> in patch description to direct a patch to interested parties and
>>>>>>>>>>> relevant lists. I don't want to see all 19 patches in this series.
>>>>>>>>>>>
>>>>>>>>>>> On Wed, Mar 15, 2017 at 3:55 AM, Quentin Schulz
>>>>>>>>>>> <quentin.schulz@free-electrons.com> wrote:
>>>>>>>>>>>> This adds the constant-charge-current property to the list of optional
>>>>>>>>>>>> properties of the battery.
>>>>>>>>>>>>
>>>>>>>>>>>> The constant charge current is critical for batteries as they can't
>>>>>>>>>>>> handle all charge currents.
>>>>>>>>>>>>
>>>>>>>>>>>> Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
>>>>>>>>>>>> Acked-by: Rob Herring <robh@kernel.org>
>>>>>>>>>>>> ---
>>>>>>>>>>>>
>>>>>>>>>>>> v4:
>>>>>>>>>>>>  - switch from constant-charge-current-microamp to constant-charge-microamp,
>>>>>>>>>
>>>>>>>>> Sebastian is on record supporting name alignment between DT:battery
>>>>>>>>> properties and enum power_supply_property.
>>>>>>>>>
>>>>>>>>> Could you OK a change back to constant-charge-current-microamp in this patch?
>>>>>>>>>
>>>>>>>>> Note that the following could appear in DT:battery in future:
>>>>>>>>>
>>>>>>>>> constant-charge-current-microamp
>>>>>>>>> constant-charge-current-max-microamp
>>>>>>>>
>>>>>>>> OK. I am actually setting max constant charge current and constant
>>>>>>>> current charge with the same DT property so I might need to adapt my
>>>>>>>> patches.
>>>>>>>
>>>>>>> I suspect you should set battery:*-current-max with DT, as -current is
>>>>>>> "programmed by charger" so seems to be a stat, not a fixed
>>>>>>> characteristic.
>>>>>>
>>>>>> Did you resolve this issue?
>>>>>>
>>>>>
>>>>> Sorry, completely missed your first mail.
>>>>>
>>>>> Constant charge current is actually what I set in the PMIC. The maximum
>>>>> constant charge current is completely PMIC-agnostic in my driver as it
>>>>> is used to tell the user that (s)he shouldn't really have a constant
>>>>> charge current over the maximum limit as the battery might not be able
>>>>> to handle such high current.
>>>>>
>>>>> What I suggest is to have both properties in DT. I'll set the maximum as
>>>>> I do today and we can give the user the ability to set a "default"
>>>>> constant charge current (below maximum constant charge current) in the
>>>>> DT. Maybe we do not want to recharge your battery with the maximum value
>>>>> by default?
>>>>
>>>> The scope here is just static battery characteristics. For the battery
>>>> node, I think constant-charge-current-max-microamp is the relevant
>>>> term.
>>>
>>> If it's only for static battery characteristics, I agree.
>>>
>>>
>>>> If we added both properties, one would be an alias for the
>>>> other, which doesn't seem useful.
>>
>> Meaning if both properties describe static characteristics of the
>> battery, they wouldn't have different meaning.
>>
>>> Hum. Not really an alias. In my driver, I have a maximum which avoids to
>>> set a constant charge current higher than what the battery is supposed
>>> to be able to handle. The maximum can be increased via sysfs if ever the
>>> user decides to go wild (or if (s)he changes the battery for example).
>>> The maximum is never input in any of PMIC registers, it is not dealing
>>> with the PMIC at all.
>>
>> Using the battery's -max as the default for your user-adjustable max
>> sounds sensible. However the user-adjustable max should perhaps appear
>> in a custom sysfs attribute, not
>> /sys/class.../constant_charge_current_max (see comment re regulator).
>>
>
> Why?

Because charger's ccc_max should refer to its electrical
characteristics, not a user-adjustable setting. Maybe
/sys/class.../constant_charge_current_max_local or similar.

>> If the battery changes, the DT battery node should also change, esp if
>> its -max drops. I realize that's not nec trivial.
>>
>
> Disagree. That's definitely not user friendly.

There are ways to field-upgrade the dtb, tho that might not be
workable in all cases :-)

>>> If I have only the max constant charge current in the DT, I'll set the
>>> max and constant charge current with the same DT entry. That's perfectly
>>> fine.
>>
>> I assume the pmic ccc setting is adjustable via
>> /sys/class.../constant_charge_current?
>>
>
> Yes, it is then limited by a user-modifiable constant_charge_current_max.
>
>>> However, what I was thinking is to have a "default" value taken from DT
>>> for constant charge current (which will be below maximum ccc) if ever
>>> someone wants to set a maximum but use a lower ccc value. Anyway, I
>>> guess it's more a "fancy" feature than a requirement (unlike max-ccc).
>>
>> Maybe a lower default ccc than battery's -max could be provided via a
>> % value in the pmic DT node? Then multiply battery -max by that to set
>> ccc.
>>
>
> That's battery-specific, why would you want to put it in the PMIC node?

A % modifier is not too battery-specific. If you want a specific
alternate default ccc, you could certainly put it in the battery node,
and read it from your driver the way power_supply_get_battery_info()
does. But if you are expecting battery changes which alter
characteristics, the less you hard-wire into DT, the better.

>>>> The pmic can report both independently of the battery characteristic,
>>>> and take a driver-specific DT property for
>>>> constant-charge-current-microamp which it applies if less than the
>>>> battery's -max setting.
>>>
>>> Indeed.
>>>
>>>> Or you could set that in userspace via
>>>> /sys/class.../constant_charge_current.
>>>
>>> The goal is to have both. The DT for default values (given by the
>>> vendor/upstream) and sysfs for custom values (interesting if you don't
>>> want to/can't recompile a DT.
>>>
>>>> The charger's -max value would
>>>> be a characteristic of its regulator.
>>>>
>>>
>>> I don't really understand what you mean by that.
>>
>> I believe the pmic's -max value is a characteristic of its electrical
>> design, the max current it can deliver. The power_supply_class docs
>> are not very clear - "maximum charge current supported by the power
>> supply object".
>>
>
> This PMIC can deliver a maximum of 1.8A or 2.5A depending on the variant
> for constant charge current but you do not want to easily allow your
> user to put such a high value as the battery is most likely not able to
> handle such a high current.

Right, and /sys/class.../constant_charge_current_max should probably
report exactly that. Hence the suggestion for ccc_max_local for the
adjustable ccc_max.

We really shouldn't be wondering what do do here, but alas, the kernel
power-supply framework is a bit under-developed :-p

Anyway I plan to add constant-charge-current-max-microamp in the
forthcoming patchset.

>>>> Or am I missing something...?
>>>>
>>>>>> Rob & Sebastian want me to merge all items for
>>>>>> bindings/power/supply/battery.txt. If I do that I'll also roll up
>>>>>> their counterparts in power_supply_core.c and submit a patchset for
>>>>>> those two files.
>>>>>>
>>>>>
>>>>> I guess that adding the two properties make sense, don't you think?
>>>>>
>>>>> Also, could you Cc me on your next version of your patches? So I know
>>>>> when to rebase and slightly rework my patches once your patch series is
>>>>> merged.
>>>>
>>>> Surely.
>>>>
>>>>> Thanks,
>>>>> Quentin
>>>>>
>>>>>>> You may program your charger's -current with the battery's
>>>>>>> -current-max, of course.
>>>>>>>
>>>>>>> Note that your charger also has a -current-max characteristic, likely
>>>>>>> different than your battery. You may not need that in DT tho.
>>>>>>>
>>>>>>>>> constant-charge-voltage-microvolt
>>>>>>>>> constant-charge-voltage-max-microvolt
>>>>>>>>>
>>>>>>>>> Thanks!
>>>>>>>>>
>>>>>>>>>>> Must be constant-charge-current-microamp for the reasons discussed in
>>>>>>>>>>> battery.txt - consistency with sysfs names.
>>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> Hum. Just nitpicking, but I disagree with the use of 'must'. IIRC there
>>>>>>>>>> is nothing in the code that would require the property to be named after
>>>>>>>>>> a property from the enum power_supply_property.
>>>>>>>>>>
>>>>>>>>>> I would say that you _want_ it to be named like that because it
>>>>>>>>>> underlines the relation between the DT property and the actual impacted
>>>>>>>>>> property in the power supply subsystem. I'm fine with this reason but in
>>>>>>>>>> the end, the maintainer's opinion prevails (if (s)he does not want it,
>>>>>>>>>> (s)he will not take it). So, basically, I actually don't mind either
>>>>>>>>>> option and I see arguments on each side.
>>>>>>>>>>
>>>>>>>>>> So, just waiting for maintainer's opinion to make the final version of
>>>>>>>>>> this patch.
>>>>>>>>>>
>>>>>>>>>> Thanks,
>>>>>>>>>> Quentin
>>>>>>>>>>
>>>>>>>>>>> Also applies to power_supply_core.c patch.
>>>>>>>>>>>
>>>>>>>>>>> Rob: enum power_supply_property also lists constant-charge-voltage,
>>>>>>>>>>> hence the -current
>>>>>>>>>>>
>>>>>>>>>>>
>>>>>>>>>>>> added in v3
>>>>>>>>>>>>
>>>>>>>>>>>>  Documentation/devicetree/bindings/power/supply/battery.txt | 2 ++
>>>>>>>>>>>>  1 file changed, 2 insertions(+)
>>>>>>>>>>>>
>>>>>>>>>>>> diff --git a/Documentation/devicetree/bindings/power/supply/battery.txt b/Documentation/devicetree/bindings/power/supply/battery.txt
>>>>>>>>>>>> index 0278617..9594e1e 100644
>>>>>>>>>>>> --- a/Documentation/devicetree/bindings/power/supply/battery.txt
>>>>>>>>>>>> +++ b/Documentation/devicetree/bindings/power/supply/battery.txt
>>>>>>>>>>>> @@ -7,6 +7,7 @@ Optional Properties:
>>>>>>>>>>>>   - voltage-min-design-microvolt: drained battery voltage
>>>>>>>>>>>>   - energy-full-design-microwatt-hours: battery design energy
>>>>>>>>>>>>   - charge-full-design-microamp-hours: battery design capacity
>>>>>>>>>>>> + - constant-charge-microamp: battery constant charge current
>>>>>>>>>>>>
>>>>>>>>>>>>  Because drivers surface properties in sysfs using names derived
>>>>>>>>>>>>  from enum power_supply_property, e.g.
>>>>>>>>>>>> @@ -30,6 +31,7 @@ Example:
>>>>>>>>>>>>                 voltage-min-design-microvolt = <3200000>;
>>>>>>>>>>>>                 energy-full-design-microwatt-hours = <5290000>;
>>>>>>>>>>>>                 charge-full-design-microamp-hours = <1430000>;
>>>>>>>>>>>> +               constant-charge-microamp = <300000>;
>>>>>>>>>>>>         };
>>>>>>>>>>>>
>>>>>>>>>>>>         charger: charger@11 {
>>>>>>>>>>>> --
>>>>>>>>>>>> 2.9.3
>>>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> --
>>>>>>>>>> Quentin Schulz, Free Electrons
>>>>>>>>>> Embedded Linux and Kernel engineering
>>>>>>>>>> http://free-electrons.com
>>>>>>>>
>>>>>>>> --
>>>>>>>> Quentin Schulz, Free Electrons
>>>>>>>> Embedded Linux and Kernel engineering
>>>>>>>> http://free-electrons.com
>>>>>
>>>>> --
>>>>> Quentin Schulz, Free Electrons
>>>>> Embedded Linux and Kernel engineering
>>>>> http://free-electrons.com
>>>
>>> --
>>> Quentin Schulz, Free Electrons
>>> Embedded Linux and Kernel engineering
>>> http://free-electrons.com
>
> --
> Quentin Schulz, Free Electrons
> Embedded Linux and Kernel engineering
> http://free-electrons.com
