From: "Andrew F. Davis" <afd@ti.com>
Subject: Re: [PATCH v6 1/8] devicetree: power: Add battery.txt
Date: Fri, 17 Feb 2017 14:12:32 -0600
Message-ID: <a77bd310-9b7a-3108-0b17-5cb9fe3d5d63@ti.com>
References: <20170211024340.19491-1-liam@networkimprov.net>
 <20170211024340.19491-2-liam@networkimprov.net>
 <ce69f358-ac3b-993d-0639-844856362c9d@ti.com>
 <CAKvHMgSSpbkX1NMwaDmuJwBcgu6Avy65izAaBGTYongqL51kWQ@mail.gmail.com>
 <f38dc321-b32d-1053-75e4-ac9bf3438bb4@ti.com>
 <CAKvHMgTB8D+9mjpm16mAKZtHeTWZhyv0iEAvxw04fm-7GM1wqA@mail.gmail.com>
 <646198ab-b079-59c4-506f-34e446bcd67d@ti.com>
 <CAKvHMgSwi2XZx-evXQ8fB2nbrsZhHWEc0feO+XbKk2syB6Cskg@mail.gmail.com>
 <28a76212-ed8d-e8a2-b761-78437ebfdac1@ti.com>
 <CAKvHMgSgTAFH02GgbeZY4t=BaKHrB-yABwbQkRxOTsM=cU==eA@mail.gmail.com>
 <0969110c-9780-960b-bf5a-b82732787852@ti.com>
 <CAKvHMgSv+84yCeDKq1D-V-BybozJccJpzubzv1JmJkxmgye2wQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from fllnx209.ext.ti.com ([198.47.19.16]:59839 "EHLO
        fllnx209.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932655AbdBQUWp (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 17 Feb 2017 15:22:45 -0500
In-Reply-To: <CAKvHMgSv+84yCeDKq1D-V-BybozJccJpzubzv1JmJkxmgye2wQ@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Liam Breck <liam@networkimprov.net>
Cc: Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org, Matt Ranostay <matt@ranostay.consulting>

On 02/15/2017 06:56 PM, Liam Breck wrote:
> On Wed, Feb 15, 2017 at 3:21 PM, Andrew F. Davis <afd@ti.com> wrote:
>> On 02/15/2017 02:05 PM, Liam Breck wrote:
>>> On Wed, Feb 15, 2017 at 7:54 AM, Andrew F. Davis <afd@ti.com> wrote:
>>>> On 02/14/2017 04:38 PM, Liam Breck wrote:
>>>>> On Tue, Feb 14, 2017 at 12:22 PM, Andrew F. Davis <afd@ti.com> wrote:
>>>>>> On 02/13/2017 03:31 PM, Liam Breck wrote:
>>>>>>> [Dropped devicetree from CC]
>>>>>>>
>>>>>>> On Mon, Feb 13, 2017 at 1:12 PM, Andrew F. Davis <afd@ti.com> wrote:
>>>>>>>> On 02/13/2017 02:58 PM, Liam Breck wrote:
>>>>>>>>> Hi Andrew, thanks for the drill-down on BQ27* chips.
>>>>>>>>>
>>>>>>>>> On Mon, Feb 13, 2017 at 8:06 AM, Andrew F. Davis <afd@ti.com> wrote:
>>>>>>>>>> On 02/10/2017 08:43 PM, Liam Breck wrote:
>>>>>>>>>>> From: Matt Ranostay <matt@ranostay.consulting>
>>>>>>>>>>>
>>>>>>>>>>> Documentation of static battery characteristics that can be defined
>>>>>>>>>>> for batteries which cannot self-identify. This information is required
>>>>>>>>>>> by fuel-gauge and charger chips for proper handling of the battery.
>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> I think some of the confusion about what a "smart-battery" binding would
>>>>>>>>>> look like is due to a miss-understanding what it means to
>>>>>>>>>> "self-identify". Originally the bq27xxx *was* the chip that lived its
>>>>>>>>>> whole life inside a battery (the iphone battery is one such example and
>>>>>>>>>> a good way to test the bq27000). This way it could be factory programmed
>>>>>>>>>> with the battery's basics and then learn about the individual pack over
>>>>>>>>>> time to provide better info on time to empty, discharge rates, etc..
>>>>>>>>>>
>>>>>>>>>> Eventually, people wanted to have the battery become cheap and
>>>>>>>>>> replaceable, so fuel-gauges were made that are "system side", and ride
>>>>>>>>>> along with the device, not the battery. Now this has one big problem,
>>>>>>>>>> how can we learn about a battery when it may be a new battery every time
>>>>>>>>>> we boot up? So we added programmable memory to the devices, and
>>>>>>>>>> programming this memory looks to be what this series is about.
>>>>>>>>>>
>>>>>>>>>> Only the battery design info is programmed in this series, but much more
>>>>>>>>>> battery info can be uploaded, including stuff that is not fixed and
>>>>>>>>>> therefor cannot be added to the DT. Even the design parameters may not
>>>>>>>>>> be fix if one changes the battery as different manufactures of the same
>>>>>>>>>> battery type may have different design capacities.
>>>>>>>>>>
>>>>>>>>>> The ideal use-case in a system with a system side gauge is the OS should
>>>>>>>>>> periodically, or just before shutdown, read the battery's learned info
>>>>>>>>>> and when the device is powered back up, if the battery serial number
>>>>>>>>>> matches from before, re-upload this learned info to the gauge so it
>>>>>>>>>> doesn't have to re-learn everything. All of this will need to happen in
>>>>>>>>>> user-space, so what we really need is a user-space API for manipulating
>>>>>>>>>> these properties.
>>>>>>>>>
>>>>>>>>> We would need a feature in the driver to get/set the blob of pack- or
>>>>>>>>> cell-unique data. The userspace api is one sysfs file.
>>>>>>>>>
>>>>>>>>> However the DT fixed-battery node could indicate when/how-often the
>>>>>>>>> object is stored, and where, e.g. filename. If the latter is given,
>>>>>>>>> the driver should write/read the file itself.
>>>>>>>>>
>>>>>>>>> Is there some documentation about what registers should go in this blob?
>>>>>>>>>
>>>>>>>>
>>>>>>>> This should all be available in the parts' technical reference (looks
>>>>>>>> like page 24 for your device), but the blob isn't meant to be modified,
>>>>>>>> the information/format is mostly internal to the part, all we should do
>>>>>>>> is save blob / restore blob as needed.
>>>>>>>
>>>>>>> Page 24 has "8.5.5 Data Block Summary" That?
>>>>>>>
>>>>>>> Subclass IDs for NVM are 82, 88,104, 105. Do all those go in the blob?
>>>>>>>
>>>>>>
>>>>>> Some devices (bq27421) do not contain an NVM, and so rely on the host to
>>>>>> restore its "learned data" across power cycles with the same battery.
> 
> From your above statement, I inferred that NVM retains pack-unique
> stats on poweroff. Below you state that NVM only retains factory
> defaults. Could you clarify?
> 

This is a simple device, all that it knows is that it should move NVM
stats to RAM when it powers up, and then it uses and updates RAM stats
as it learns.

You can program the NVM values to the updated stats from RAM before
power-off manually if you would like, so that on the next power-on it
will move those updated values over to RAM. You should only do this if
you know you will have the same battery after a power-cycle.

Out of the box, the stats in NVM are the factory defaults, so if you
don't program NVM, and you power-cycle, you will get those factory
defaults in RAM. You are free to overwrite both the NVM and RAM with
updated values if you would like.

>>>>> Ah, so my concept for DT battery:nvm-storage: "filename" would apply
>>>>> to these RAM-only chips.
>>>>>
>>>>
>>>> I think so, I was going to do something similar, but let userspace take
>>>> care of the filename, or have it a fixed/module param like firmware. DT
>>>> is not really the right spot for filenames.
>>>>
>>>> If you can find a kernel-friendly way to do this then I'm all for it!
>>>
>>> Hm, you have a point about filenames in DT. Maybe an inode number? (kidding :-)
>>>
>>
>> :)
>>
>>> We could hand the driver a filename via sysfs file or module param.
>>> Perhaps use a filename in DT as a fallback.
>>>
>>
>> If you can convince Rob, then I'd say go for it.
> 
> OK, I restate the proposal below.
> 
>>>>>> When using devices with NVM this "learned data" can be saved to the NVM
>>>>>> and it will automatically be copied over to the run-time RAM sections on
>>>>>> powerup. So we should only ever need to save the RAM section.
>>>>>
>>>>> For the NVM chips, we'd want a userspace-accessible reset_nvm function
>>>>> in driver which returns the pack-unique data to factory defaults. That
>>>>> can be provided via a sysfs file to which you write a key (safer than
>>>>> "echo 1 > /sys/class.../reset_nvm") to trigger the reset.
>>>>>
>>>>
>>>> Still not sure why one would need this, the only time you would want to
>>>> reset the gauge is when changing the battery, and that will already
>>>> cause it to power cycle (unless you have some kind of back-up battery,
>>>> but that doesn't make sense to me).
>>>
>>> This is for gauges with NVM, where power-cycle does not clear the
>>> pack-specific stats. Or do those gauges recognize that the pack has
>>> changed?
>>>
>>
>> The NVM *is* the factory default, RAM tracks the  pack-specific stats,
>> when the device power-cycles NVM values are automatically moved over
>> into working RAM, so that is always cleared across all devices. There is
>> really no good way to recognize that a pack has changed, so simply
>> forgetting the pack-specific stats and re-loading the defaults is the
>> safest option after a power-cycle. If we want to keep this info in RAM
>> and re-use it, then it is up to the manufacturer to implement a solution
>> for this detection (as only they can know what kind of device they are
>> making and whether that detection makes sense or not for it).
>>
>>>
>>>>>> Another thing to consider is that we (TI) have GUI tools to allow
>>>>>> manufacturers to input battery info and have it generate a blob that can
>>>>>> be deployed to these devices. The blob format is meant to be handled and
>>>>>> uploaded by custom user-space tools as it only really needs to be done
>>>>>> once (power-down events should only happen when changing batteries, in
>>>>>> which case you want to let the device forget what it has learned about
>>>>>> the old battery).
>>>>>>
>>>>>> All of the details of this programming are probably not the job of the
>>>>>> kernel, in end-user hands the kernel only needs to know how to read from
>>>>>> the device, not program it.
>>>>>
>>>>> Were there an independently maintained battery manager app with wide
>>>>> support for battery ICs, it would be a natural venue for BQ27*
>>>>> reset/save/restore_nvm functions. But there is none that I know of,
>>>>> and these features can be implemented in the driver with little new
>>>>> code beyond the read/write_dm_block functions added by this patchset.
>>>>>
>>>>> It's fine to ask hardware makers to rely on IC vendor tools in the
>>>>> factory, but I don't think such tools belong in the end-user's stack.
>>>>>
>>>>
>>>> If they don't belong in the end-user's user-space tool-set then they
>>>> definitely don't belong in kernel-space. The other option is to define a
>>>> whole new API for interfacing with all these device specific parameters
>>>> and internal info tables. It's that or we accept that these are factory
>>>> settings and we don't need all too much kernel infrastructure for
>>>> handling them.
>>>
>>> My point is that an IC vendor *codebase* does not belong in the
>>> end-user's stack; it's a production tool. The functionality we're
>>> discussing clearly belongs in both the device driver and the
>>> production tool.
>>>
>>
>> What functionality?, specifying your battery's design capacity, sure,
>> reprogramming the gauge's internal "Impedance Track™" algorithm data,
>> not so much. It's not up to me to draw the line in what goes into the
>> kernel driver vs user-space tools, at this point I think we can wait for
>> Sebastian to weigh in on this.
> 
> The functionality of save/restore pack-unique data!
> 
> Restating the pack-unique data (PUD) storage proposal:
> - Allow driver to archive/install PUD from/to chip RAM
> - Provide userspace api to above features via sysfs file
> - If driver has a PUD storage policy, it writes/reads a blob/csv on disk
> - PUD storage policy fields: bool poweroff, int period, char* filename
> - PUD storage policy may be set via sysfs file or module param
> - DT may give PUD storage policy as a fallback
> 

I have no issue with any of this, but these are a bit out of the scope
of this patchset, right? Does anything in this set prevent the future
addition of those features?

Andrew

> 
>>>>>> Take everything I say with a grain of salt though, I'm not on the team
>>>>>> that makes these. I don't have much additional info not in the public
>>>>>> data-sheets.
>>>>>>
>>>>>> Andrew
>>>>>>
>>>>>>>
>>>>>>>>> That concept is beyond the scope of this patchset (and doesn't
>>>>>>>>> supersede it), but is something I'd like to implement for our chip,
>>>>>>>>> the *425.
>>>>>>>>>
>>>>>>>>>
>>>>>>>>>> The properties added in this series are okay, and it's good to have some
>>>>>>>>>> sane defaults in DT, but looking forward this may not be enough to get
>>>>>>>>>> full use out of these devices.
>>>>>>>>>
>>>>>>>>> I'm relieved you're not opposed to our patch :-) Now I just need that
>>>>>>>>> guidance I mentioned re the chip family...
>>>>>>>>>
>>>>>>>>
>>>>>>>> Still looking into it, I think for now would be easiest to add the
>>>>>>>> register info to each chip family struct. The un-seal sequence should be
>>>>>>>> generic enough already.
>>>>>>>
>>>>>>> I'll wait for your full reply on that thread.
>>>>>>>
>>>>>>>
>>>>>>>>>>> Cc: Rob Herring <robh@kernel.org>
>>>>>>>>>>> Cc: devicetree@vger.kernel.org
>>>>>>>>>>> Signed-off-by: Matt Ranostay <matt@ranostay.consulting>
>>>>>>>>>>> Signed-off-by: Liam Breck <kernel@networkimprov.net>
>>>>>>>>>>> ---
>>>>>>>>>>>  .../devicetree/bindings/power/supply/battery.txt   | 37 ++++++++++++++++++++++
>>>>>>>>>>>  1 file changed, 37 insertions(+)
>>>>>>>>>>>  create mode 100644 Documentation/devicetree/bindings/power/supply/battery.txt
>>>>>>>>>>>
>>>>>>>>>>> diff --git a/Documentation/devicetree/bindings/power/supply/battery.txt b/Documentation/devicetree/bindings/power/supply/battery.txt
>>>>>>>>>>> new file mode 100644
>>>>>>>>>>> index 0000000..d78a4aa
>>>>>>>>>>> --- /dev/null
>>>>>>>>>>> +++ b/Documentation/devicetree/bindings/power/supply/battery.txt
>>>>>>>>>>> @@ -0,0 +1,37 @@
>>>>>>>>>>> +Battery Characteristics
>>>>>>>>>>> +
>>>>>>>>>>> +Required Properties:
>>>>>>>>>>> + - compatible: Must be "fixed-battery"
>>>>>>>>>>> +
>>>>>>>>>>> +Optional Properties:
>>>>>>>>>>> + - voltage-min-design-microvolt: drained battery voltage
>>>>>>>>>>> + - energy-full-design-microwatt-hours: battery design energy
>>>>>>>>>>> + - charge-full-design-microamp-hours: battery design capacity
>>>>>>>>>>> +
>>>>>>>>>>> +Future Properties must be named for the corresponding elements in
>>>>>>>>>>> +enum power_supply_property, defined in include/linux/power_supply.h.
>>>>>>>>>>> +
>>>>>>>>>>> +Batteries must be referenced by chargers and/or fuel-gauges
>>>>>>>>>>> +using a phandle. The phandle's property should be named
>>>>>>>>>>> +"monitored-battery".
>>>>>>>>>>> +
>>>>>>>>>>> +Example:
>>>>>>>>>>> +
>>>>>>>>>>> +     bat: battery {
>>>>>>>>>>> +             compatible = "fixed-battery";
>>>>>>>>>>> +             voltage-min-design-microvolt = <3200000>;
>>>>>>>>>>> +             energy-full-design-microwatt-hours = <5290000>;
>>>>>>>>>>> +             charge-full-design-microamp-hours = <1430000>;
>>>>>>>>>>> +     };
>>>>>>>>>>> +
>>>>>>>>>>> +     charger: charger@11 {
>>>>>>>>>>> +             ....
>>>>>>>>>>> +             monitored-battery = <&bat>;
>>>>>>>>>>> +             ...
>>>>>>>>>>> +     };
>>>>>>>>>>> +
>>>>>>>>>>> +     fuel_gauge: fuel-gauge@22 {
>>>>>>>>>>> +             ....
>>>>>>>>>>> +             monitored-battery = <&bat>;
>>>>>>>>>>> +             ...
>>>>>>>>>>> +     };
>>>>>>>>>>>
>>>>>>>>> --
>>>>>>>>> To unsubscribe from this list: send the line "unsubscribe devicetree" in
>>>>>>>>> the body of a message to majordomo@vger.kernel.org
>>>>>>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>>>>>>>
