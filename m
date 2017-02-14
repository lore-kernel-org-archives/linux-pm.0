From: "Andrew F. Davis" <afd@ti.com>
Subject: Re: [PATCH v6 1/8] devicetree: power: Add battery.txt
Date: Tue, 14 Feb 2017 14:22:01 -0600
Message-ID: <646198ab-b079-59c4-506f-34e446bcd67d@ti.com>
References: <20170211024340.19491-1-liam@networkimprov.net>
 <20170211024340.19491-2-liam@networkimprov.net>
 <ce69f358-ac3b-993d-0639-844856362c9d@ti.com>
 <CAKvHMgSSpbkX1NMwaDmuJwBcgu6Avy65izAaBGTYongqL51kWQ@mail.gmail.com>
 <f38dc321-b32d-1053-75e4-ac9bf3438bb4@ti.com>
 <CAKvHMgTB8D+9mjpm16mAKZtHeTWZhyv0iEAvxw04fm-7GM1wqA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from fllnx209.ext.ti.com ([198.47.19.16]:9006 "EHLO
        fllnx209.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754941AbdBNUWx (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 14 Feb 2017 15:22:53 -0500
In-Reply-To: <CAKvHMgTB8D+9mjpm16mAKZtHeTWZhyv0iEAvxw04fm-7GM1wqA@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Liam Breck <liam@networkimprov.net>
Cc: Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org, Matt Ranostay <matt@ranostay.consulting>

On 02/13/2017 03:31 PM, Liam Breck wrote:
> [Dropped devicetree from CC]
> 
> On Mon, Feb 13, 2017 at 1:12 PM, Andrew F. Davis <afd@ti.com> wrote:
>> On 02/13/2017 02:58 PM, Liam Breck wrote:
>>> Hi Andrew, thanks for the drill-down on BQ27* chips.
>>>
>>> On Mon, Feb 13, 2017 at 8:06 AM, Andrew F. Davis <afd@ti.com> wrote:
>>>> On 02/10/2017 08:43 PM, Liam Breck wrote:
>>>>> From: Matt Ranostay <matt@ranostay.consulting>
>>>>>
>>>>> Documentation of static battery characteristics that can be defined
>>>>> for batteries which cannot self-identify. This information is required
>>>>> by fuel-gauge and charger chips for proper handling of the battery.
>>>>
>>>>
>>>> I think some of the confusion about what a "smart-battery" binding would
>>>> look like is due to a miss-understanding what it means to
>>>> "self-identify". Originally the bq27xxx *was* the chip that lived its
>>>> whole life inside a battery (the iphone battery is one such example and
>>>> a good way to test the bq27000). This way it could be factory programmed
>>>> with the battery's basics and then learn about the individual pack over
>>>> time to provide better info on time to empty, discharge rates, etc..
>>>>
>>>> Eventually, people wanted to have the battery become cheap and
>>>> replaceable, so fuel-gauges were made that are "system side", and ride
>>>> along with the device, not the battery. Now this has one big problem,
>>>> how can we learn about a battery when it may be a new battery every time
>>>> we boot up? So we added programmable memory to the devices, and
>>>> programming this memory looks to be what this series is about.
>>>>
>>>> Only the battery design info is programmed in this series, but much more
>>>> battery info can be uploaded, including stuff that is not fixed and
>>>> therefor cannot be added to the DT. Even the design parameters may not
>>>> be fix if one changes the battery as different manufactures of the same
>>>> battery type may have different design capacities.
>>>>
>>>> The ideal use-case in a system with a system side gauge is the OS should
>>>> periodically, or just before shutdown, read the battery's learned info
>>>> and when the device is powered back up, if the battery serial number
>>>> matches from before, re-upload this learned info to the gauge so it
>>>> doesn't have to re-learn everything. All of this will need to happen in
>>>> user-space, so what we really need is a user-space API for manipulating
>>>> these properties.
>>>
>>> We would need a feature in the driver to get/set the blob of pack- or
>>> cell-unique data. The userspace api is one sysfs file.
>>>
>>> However the DT fixed-battery node could indicate when/how-often the
>>> object is stored, and where, e.g. filename. If the latter is given,
>>> the driver should write/read the file itself.
>>>
>>> Is there some documentation about what registers should go in this blob?
>>>
>>
>> This should all be available in the parts' technical reference (looks
>> like page 24 for your device), but the blob isn't meant to be modified,
>> the information/format is mostly internal to the part, all we should do
>> is save blob / restore blob as needed.
> 
> Page 24 has "8.5.5 Data Block Summary" That?
> 
> Subclass IDs for NVM are 82, 88,104, 105. Do all those go in the blob?
> 

Some devices (bq27421) do not contain an NVM, and so rely on the host to
restore its "learned data" across power cycles with the same battery.

When using devices with NVM this "learned data" can be saved to the NVM
and it will automatically be copied over to the run-time RAM sections on
powerup.

So we should only ever need to save the RAM section.

Another thing to consider is that we (TI) have GUI tools to allow
manufacturers to input battery info and have it generate a blob that can
be deployed to these devices. The blob format is meant to be handled and
uploaded by custom user-space tools as it only really needs to be done
once (power-down events should only happen when changing batteries, in
which case you want to let the device forget what it has learned about
the old battery).

All of the details of this programming are probably not the job of the
kernel, in end-user hands the kernel only needs to know how to read from
the device, not program it.

Take everything I say with a grain of salt though, I'm not on the team
that makes these. I don't have much additional info not in the public
data-sheets.

Andrew

> 
>>> That concept is beyond the scope of this patchset (and doesn't
>>> supersede it), but is something I'd like to implement for our chip,
>>> the *425.
>>>
>>>
>>>> The properties added in this series are okay, and it's good to have some
>>>> sane defaults in DT, but looking forward this may not be enough to get
>>>> full use out of these devices.
>>>
>>> I'm relieved you're not opposed to our patch :-) Now I just need that
>>> guidance I mentioned re the chip family...
>>>
>>
>> Still looking into it, I think for now would be easiest to add the
>> register info to each chip family struct. The un-seal sequence should be
>> generic enough already.
> 
> I'll wait for your full reply on that thread.
> 
> 
>>>>> Cc: Rob Herring <robh@kernel.org>
>>>>> Cc: devicetree@vger.kernel.org
>>>>> Signed-off-by: Matt Ranostay <matt@ranostay.consulting>
>>>>> Signed-off-by: Liam Breck <kernel@networkimprov.net>
>>>>> ---
>>>>>  .../devicetree/bindings/power/supply/battery.txt   | 37 ++++++++++++++++++++++
>>>>>  1 file changed, 37 insertions(+)
>>>>>  create mode 100644 Documentation/devicetree/bindings/power/supply/battery.txt
>>>>>
>>>>> diff --git a/Documentation/devicetree/bindings/power/supply/battery.txt b/Documentation/devicetree/bindings/power/supply/battery.txt
>>>>> new file mode 100644
>>>>> index 0000000..d78a4aa
>>>>> --- /dev/null
>>>>> +++ b/Documentation/devicetree/bindings/power/supply/battery.txt
>>>>> @@ -0,0 +1,37 @@
>>>>> +Battery Characteristics
>>>>> +
>>>>> +Required Properties:
>>>>> + - compatible: Must be "fixed-battery"
>>>>> +
>>>>> +Optional Properties:
>>>>> + - voltage-min-design-microvolt: drained battery voltage
>>>>> + - energy-full-design-microwatt-hours: battery design energy
>>>>> + - charge-full-design-microamp-hours: battery design capacity
>>>>> +
>>>>> +Future Properties must be named for the corresponding elements in
>>>>> +enum power_supply_property, defined in include/linux/power_supply.h.
>>>>> +
>>>>> +Batteries must be referenced by chargers and/or fuel-gauges
>>>>> +using a phandle. The phandle's property should be named
>>>>> +"monitored-battery".
>>>>> +
>>>>> +Example:
>>>>> +
>>>>> +     bat: battery {
>>>>> +             compatible = "fixed-battery";
>>>>> +             voltage-min-design-microvolt = <3200000>;
>>>>> +             energy-full-design-microwatt-hours = <5290000>;
>>>>> +             charge-full-design-microamp-hours = <1430000>;
>>>>> +     };
>>>>> +
>>>>> +     charger: charger@11 {
>>>>> +             ....
>>>>> +             monitored-battery = <&bat>;
>>>>> +             ...
>>>>> +     };
>>>>> +
>>>>> +     fuel_gauge: fuel-gauge@22 {
>>>>> +             ....
>>>>> +             monitored-battery = <&bat>;
>>>>> +             ...
>>>>> +     };
>>>>>
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe devicetree" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>
