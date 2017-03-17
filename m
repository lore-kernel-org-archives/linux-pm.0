From: Liam Breck <liam@networkimprov.net>
Subject: Re: [PATCH v10 1/8] devicetree: power: Add battery.txt
Date: Fri, 17 Mar 2017 14:43:12 -0700
Message-ID: <CAKvHMgS92WFoJa=imfAFiEEc0VyiSsDBbuYi4yzZ=LEa7__yKA@mail.gmail.com>
References: <20170315192653.26799-1-liam@networkimprov.net>
 <20170315192653.26799-2-liam@networkimprov.net> <20170315220425.qeidvmanbsmq4wxk@earth>
 <CAKvHMgSF2rsaAaUqFw1qF+b2NA9CkABYKYOTd2p+imuPAHq9JA@mail.gmail.com>
 <20170315225709.ugjibnoqfukay657@earth> <d548b5e6-af6e-3fa6-e926-b24636a676a8@ti.com>
 <CAKvHMgS4dRm7LfxVFSh9UeeUA=ZFVoArtG8wZOpZyZDjiKkKwQ@mail.gmail.com> <691553d1-cff7-958f-d9d9-6194210b4f87@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-it0-f65.google.com ([209.85.214.65]:33965 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751359AbdCQVnO (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 17 Mar 2017 17:43:14 -0400
In-Reply-To: <691553d1-cff7-958f-d9d9-6194210b4f87@ti.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Andrew F. Davis" <afd@ti.com>
Cc: Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org, Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org, Liam Breck <kernel@networkimprov.net>

On Fri, Mar 17, 2017 at 8:21 AM, Andrew F. Davis <afd@ti.com> wrote:
> On 03/16/2017 05:58 PM, Liam Breck wrote:
>> On Thu, Mar 16, 2017 at 6:21 AM, Andrew F. Davis <afd@ti.com> wrote:
>>> On 03/15/2017 05:57 PM, Sebastian Reichel wrote:
>>>> Hi,
>>>>
>>>> On Wed, Mar 15, 2017 at 03:18:17PM -0700, Liam Breck wrote:
>>>>> Hey Sebastian, welcome back :-)
>>>>>
>>>>> I've taken over work on this patchset from Matt.
>>>>
>>>> Ok.
>>>>
>>>>> On Wed, Mar 15, 2017 at 3:04 PM, Sebastian Reichel <sre@kernel.org> wrote:
>>>>>> Hi Liam & Matt,
>>>>>>
>>>>>> Sorry for my absence in the discussion. I skipped the previous
>>>>>> iterations for now and start with this version.
>>>>>>
>>>>>> On Wed, Mar 15, 2017 at 12:26:46PM -0700, Liam Breck wrote:
>>>>>>> From: Liam Breck <kernel@networkimprov.net>
>>>>>>>
>>>>>>> Documentation of static battery characteristics that can be defined
>>>>>>> for batteries which cannot self-identify. This information is required
>>>>>>> by fuel-gauge and charger chips for proper handling of the battery.
>>>>>>>
>>>>>>> Cc: Rob Herring <robh@kernel.org>
>>>>>>> Cc: devicetree@vger.kernel.org
>>>>>>> Signed-off-by: Matt Ranostay <matt@ranostay.consulting>
>>>>>>> Signed-off-by: Liam Breck <kernel@networkimprov.net>
>>>>>>> ---
>>>>>>>  .../devicetree/bindings/power/supply/battery.txt   | 45 ++++++++++++++++++++++
>>>>>>>  1 file changed, 45 insertions(+)
>>>>>>>  create mode 100644 Documentation/devicetree/bindings/power/supply/battery.txt
>>>>>>>
>>>>>>> diff --git a/Documentation/devicetree/bindings/power/supply/battery.txt b/Documentation/devicetree/bindings/power/supply/battery.txt
>>>>>>> new file mode 100644
>>>>>>> index 0000000..0278617
>>>>>>> --- /dev/null
>>>>>>> +++ b/Documentation/devicetree/bindings/power/supply/battery.txt
>>>>>>> @@ -0,0 +1,45 @@
>>>>>>> +Battery Characteristics
>>>>>>
>>>>>> Maybe add something like
>>>>>>
>>>>>> This device provides static battery information, that is usually
>>>>>> available in the EEPROM of a smart battery. It's supposed to be
>>>>>> used for batteries, which do not have their own EEPROM (or if its
>>>>>> unusable).
>>>>>
>>>>> OK.
>>>>>
>>>>>>> +Required Properties:
>>>>>>> + - compatible: Must be "fixed-battery"
>>>>>
>>>>> Rob questioned the term "fixed". Shall we consider other terms --
>>>>> simple-battery, plain-battery...?
>>>>
>>>> I don't like the term either, but it was the best I came up with.
>>>> They are known as "dumb" batteries, but that term looks too
>>>> colloquial for DT usage. While I think "simple-battery" is not
>>>> perfect either, it's better than "fixed-battery", so please switch
>>>> to that in the next revision.
>>>>
>>>
>>> I rather like "fixed-battery", it matches the regulator and other power
>>> source DTs better. To answer Rob's question on what a non-fixed battery
>>> would look like we can think of a future battery that can change its
>>> physical properties (chemical or physical perhaps) in response to
>>> software. Although I've not seen such a battery I don't think it's too
>>> far-fetched.
>>
>> A "fixed" battery sounds like a non-removable one to me. I'll switch
>> to "simple-battery" in v11 unless a better idea bubbles up first.
>>
>
> Are fixed-regulators non-removable, or do most people understand. Also
> this is for non-removable batteries, if a battery is changeable then
> this DT is not valid as it would be describing the current configuration
> of the device. I guess it could be done with overlays for the current
> battery, not sure, but something to think about.

I know little about regulators, but wikipedia mentions fixed and
variable/adjustable kinds. We're not contemplating an "adjustable
battery" type, so the fixed/adjustable dichotomy isn't a natural fit
here.

>>> All the properties described here are "fixed", if we say "simple" then a
>>> battery with more properties would be a "complex" battery..
>>
>> Simple is not a boolean term; it really doesn't mandate a
>> "complex-battery" type.
>>
>
> Yes, but the spectrum would imply levels of simplicity, what would *you*
> call a "non-simple" battery?

Simple is not an integral term, either :-)

simple-battery, gauged-battery, coin-battery, bare-battery (no
protection circuit)...

>>>>>>> +Optional Properties:
>>>>>>> + - voltage-min-design-microvolt: drained battery voltage
>>>>>>> + - energy-full-design-microwatt-hours: battery design energy
>>>>>>> + - charge-full-design-microamp-hours: battery design capacity
>>>>>>
>>>>>> Looks fine to me.
>>>>>>
>>>>>>> +Because drivers surface properties in sysfs using names derived
>>>>>>> +from enum power_supply_property, e.g.
>>>>>>> +/sys/class/power_supply/<device>/charge_full_design, our
>>>>>>> +battery properties must be named for the corresponding elements in
>>>>>>> +enum power_supply_property, defined in include/linux/power_supply.h.
>>>>>>
>>>>>> This is Linux/implementation specific and does not belong
>>>>>> into a DT binding document.
>>>>>
>>>>> I just wrote on a thread for an earlier version of this patch:
>>>>>
>>>>> "Sebastian proposed DT:battery specifically to be consumed by
>>>>> power_supply_core. Allowing names in DT:battery and
>>>>> power_supply_property to diverge would cause confusion and wasted
>>>>> time, for no particular benefit. As there is no rationale to
>>>>> reconsider the names of these fields for DT:battery, let's write that
>>>>> into the docs."
>>>>
>>>> DT bindings are not "Linux hardware information bindings". Of course
>>>> there is no need to diverge without a good reason, but that kind of
>>>> Documentation just does not belong into the DT bindings.
>>>>
>>>>>>> +Batteries must be referenced by chargers and/or fuel-gauges
>>>>>>> +using a phandle. The phandle's property should be named
>>>>>>> +"monitored-battery".
>>>>>>
>>>>>> This looks fine.
>>>>>>
>>>>>>> +Driver code should call power_supply_get_battery_info() to obtain
>>>>>>> +battery properties via monitored-battery. For details see:
>>>>>>> +  drivers/power/supply/power_supply_core.c
>>>>>>> +  drivers/power/supply/bq27xxx_battery.c
>>>>>>
>>>>>> This is also Linux/implementation specific and should be dropped.
>>>>>
>>>>> We ought to mention how drivers are expected to consume DT:battery.
>>>>
>>>> That kind of documentation does not belong into
>>>> Documentation/devicetree/bindings. We can add something to
>>>> Documentation/power/power_supply_class.txt instead.
>>>>
>>>>>>> +Example:
>>>>>>> +
>>>>>>> +     bat: battery {
>>>>>>> +             compatible = "fixed-battery";
>>>>>>> +             voltage-min-design-microvolt = <3200000>;
>>>>>>> +             energy-full-design-microwatt-hours = <5290000>;
>>>>>>> +             charge-full-design-microamp-hours = <1430000>;
>>>>>>> +     };
>>>>>>> +
>>>>>>> +     charger: charger@11 {
>>>>>>> +             ....
>>>>>>> +             monitored-battery = <&bat>;
>>>>>>> +             ...
>>>>>>> +     };
>>>>>>> +
>>>>>>> +     fuel_gauge: fuel-gauge@22 {
>>>>>>> +             ....
>>>>>>> +             monitored-battery = <&bat>;
>>>>>>> +             ...
>>>>>>> +     };
>>>>>>> --
>>>>>>> 2.9.3
>>>>>>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe devicetree" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
