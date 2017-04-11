From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH 3/4] power: supply: axp288_fuel_gauge: Unregister
 duplicate ACPI battery supply
Date: Tue, 11 Apr 2017 11:18:33 +0200
Message-ID: <2796ccd7-333c-848c-1409-2a76fb498d94@redhat.com>
References: <20170316161601.32267-1-hdegoede@redhat.com>
 <20170316161601.32267-4-hdegoede@redhat.com>
 <6382698.NuYXpb6L7h@aspire.rjw.lan>
 <0ed23626-b6b2-a42e-2a1d-762c8c833f7b@redhat.com>
 <CAJZ5v0h466y6hBy_-12AEgcpAUXEA7cZkNwXZwvsHnjWtoqFeg@mail.gmail.com>
 <eb52c4b4-fc3c-b11b-edef-a35c6bb0d82d@redhat.com>
 <CAJZ5v0i7TN+iJLR_SeaCrpKJ13g1_bQ-G54cugAF9Dm4=pifAg@mail.gmail.com>
 <0c1cc4fc-d127-54d1-334b-9a569354d2a3@redhat.com>
 <c62e0707-7415-9473-98cb-3741c4f258ff@redhat.com>
 <cb6ff75e-3ee8-fa34-82c2-ff1338c0048e@redhat.com>
 <c937143c-f112-7d49-dc11-1577d987b309@redhat.com>
 <CAJZ5v0i0pZwBvd1WFYxGh9grbDyRkYWoLY7VSn3+mbLZdmQnxw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <CAJZ5v0i0pZwBvd1WFYxGh9grbDyRkYWoLY7VSn3+mbLZdmQnxw@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Sebastian Reichel <sre@kernel.org>, Chen-Yu Tsai <wens@csie.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi,

On 10-04-17 22:01, Rafael J. Wysocki wrote:
> On Mon, Apr 10, 2017 at 8:13 PM, Hans de Goede <hdegoede@redhat.com> wrote:

<snip>

>>>>>> OK
>>>>>>
>>>>>> Anyway, I'd prefer blacklists in the battery and ac drivers to be
>>>>>> honest.
>>>>>
>>>>>
>>>>> As I explained in my reply to the discussion around the first patch that
>>>>> is somewhat hard to do and requires encoding knowledge in those drivers
>>>>> which really does not belong there:
>>>>>
>>>>> "The problem is that Intel re-uses HIDs between generations and
>>>>> for the Whiskey Cove PMIC we want to not use the ACPI battery
>>>>> and ac drivers on Cherry Trail (where they are known to be
>>>>> broken) but things are different on Apollo Lake. Yet both
>>>>> use the same HID for their companion Whiskey Cove PMIC even
>>>>> though they are 2 completely different revisions of the PMIC
>>>>> (e.g. one uses i2c the other does not).
>>>>>
>>>>> The 2 native drivers have code to detect which revision they
>>>>> are dealing with and exit with -ENODEV if it is not the
>>>>> revision they were written for, but this means that simple
>>>>> HID blacklisting will not work. So IMHO the decision to
>>>>> unregister the  ACPI battery / ac interface really belongs
>>>>> in the native driver as that has all the nitty gritty detail
>>>>> needed to make that decision."
>>>>
>>>>
>>>> So thinking more about this, esp. after receiving a bug report
>>>> from a user getting ACPI errors because of Linux not implementing
>>>> the proprietary undocumented BMOP opregion before the ACPI battery
>>>> driver gets unregistered by the native one, I thing we do indeed
>>>> need to go with a blacklist.
>>>>
>>>> This means also being able to match by _HRV, as Some HIDs are
>>>> re-used for different hardware between Bay Trail / Cherry Trail /
>>>> Broxton with just a bump of _HRV.
>>>>
>>>> I'm currently working on respinning my
>>>> "acpi: utils: Add new acpi_dev_present helper" to address the
>>>> review comments on it. I'm going to give it an optional hrv
>>>> function argument for this use, so as to not having to implement
>>>> hrv checking code in both ac.c and battery.c .
>>>
>>>
>>> So a quick copy paste from another thread, the black-list approach
>>> causes regressions even before hitting -next and seeing any
>>> substantial testing, so we're back to adding unregister functions
>>> and calling those from native PMIC power_supply drivers when the
>>> native power_supply has been successfully registered.
>>>
>>> Some Bay Trail / Cherry Trail users are running kernels build
>>> from my personal tree to get early access to various fixes
>>> in there and I got a regression report on the DELL 5855, where
>>> the blacklisting of the ACPI battery driver if INT33F4 is
>>> present caused the battery monitoring to stop working, that
>>> devices has an INT33F4 node with _STA returning 15 yet it
>>> is not using an axp288 PMIC at all, I'm still gathering more
>>> info, but I believe atm that Dell simply disabled the i2c
>>> controller to which the axp288 would be connected if present
>>> and left the other bits of the DTSD unmodified.
>>>
>>> One option which comes to mind would be to only count devices
>>> as present if all their deps are met, but that will only
>>> work if the blacklist check is done after all other drivers
>>> have loaded which is not how things work.
>>>
>>> So I believe that my earlier attempts at fixing the double
>>> power_supply registration by unregistering the ACPI one when
>>> the native one has successfully loaded is better. That guarantees
>>> regressions like this one will not happen, because the ACPI
>>> power_supply does not get unregistered until the native one
>>> has loaded.
>>
>>
>> Ok scrap that, I've some more info and the INT33F4 node on
>> the Dell 5855 is returning 0 from _STA and the blacklist is
>> causing problems on that machine for other reason, it could
>> be the user was using an older version with the uninitialized
>> .cls match info problem, I've asked the user to test the latest
>> version.
>>
>> So assuming that does work, we are good to go with the blacklist
>> approach (which seems to be the solution everyone prefers),
>> sorry about the noise.
>
> OK, but there's one more possibility to consider.
>
> Instead of unregistering the ACPI battery (or AC) driver from the
> platform device driver superseding it, you could clear the
> match_driver flag for the ACPI companion device and call
> device_release_driver() on it, like acpi_bus_trim().  Then (because
> the match_driver flag is unset) the driver core will not try to attach
> the driver to the thing again - until the next invocation of
> acpi_bus_attach() on it, which I think is a bug, because there seems
> to be a flags.visited check missing in there (I need to go back and
> recall why it is not there).
>
> Arguably, that would be a more lightweight way of getting what you
> want without using a blacklist.

The reason I changed my mind on the blacklist approach and went
from unregistering on native-power-supply register to the blacklist
is because some users where seeing a ton of ACPI errors from the
ACPI battery driver trying to use the broken ACPI battery dev in
the DTSD before the native PMIC driver loaded and unregistered
the battery dev. So I really believe the blacklist is the right
approach.

I just got confirmation from the user that the regression on the
Dell 5855 was indeed a false positive.

So from my pov we are good to go with v5 of patch 1 of this
set and v2 (also send as v3 and v4 but unchanged) of patches
2-4 of this set.

Regards,

Hans
