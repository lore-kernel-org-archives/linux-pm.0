From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH 3/4] power: supply: axp288_fuel_gauge: Unregister
 duplicate ACPI battery supply
Date: Mon, 10 Apr 2017 09:31:32 +0200
Message-ID: <cb6ff75e-3ee8-fa34-82c2-ff1338c0048e@redhat.com>
References: <20170316161601.32267-1-hdegoede@redhat.com>
 <20170316161601.32267-4-hdegoede@redhat.com>
 <6382698.NuYXpb6L7h@aspire.rjw.lan>
 <0ed23626-b6b2-a42e-2a1d-762c8c833f7b@redhat.com>
 <CAJZ5v0h466y6hBy_-12AEgcpAUXEA7cZkNwXZwvsHnjWtoqFeg@mail.gmail.com>
 <eb52c4b4-fc3c-b11b-edef-a35c6bb0d82d@redhat.com>
 <CAJZ5v0i7TN+iJLR_SeaCrpKJ13g1_bQ-G54cugAF9Dm4=pifAg@mail.gmail.com>
 <0c1cc4fc-d127-54d1-334b-9a569354d2a3@redhat.com>
 <c62e0707-7415-9473-98cb-3741c4f258ff@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <c62e0707-7415-9473-98cb-3741c4f258ff@redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Sebastian Reichel <sre@kernel.org>, Chen-Yu Tsai <wens@csie.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi,

On 07-04-17 09:18, Hans de Goede wrote:
> Hi,
>
> On 31-03-17 11:57, Hans de Goede wrote:
>> Hi,
>>
>> On 31-03-17 11:11, Rafael J. Wysocki wrote:
>>> On Fri, Mar 31, 2017 at 11:08 AM, Hans de Goede <hdegoede@redhat.com> wrote:
>>>> Hi,
>>>>
>>>> On 31-03-17 11:05, Rafael J. Wysocki wrote:
>>>>>
>>>>> On Fri, Mar 31, 2017 at 11:01 AM, Hans de Goede <hdegoede@redhat.com>
>>>>> wrote:
>>>>>
>>>>> [cut]
>>>>>
>>>>>>>> --- a/drivers/power/supply/axp288_fuel_gauge.c
>>>>>>>> +++ b/drivers/power/supply/axp288_fuel_gauge.c
>>>>>>>> @@ -26,6 +26,7 @@
>>>>>>>>  #include <linux/mfd/axp20x.h>
>>>>>>>>  #include <linux/platform_device.h>
>>>>>>>>  #include <linux/power_supply.h>
>>>>>>>> +#include <linux/power/acpi.h>
>>>>>>>>  #include <linux/iio/consumer.h>
>>>>>>>>  #include <linux/debugfs.h>
>>>>>>>>  #include <linux/seq_file.h>
>>>>>>>> @@ -754,6 +755,8 @@ static int axp288_fuel_gauge_probe(struct
>>>>>>>> platform_device *pdev)
>>>>>>>>                 return ret;
>>>>>>>>         }
>>>>>>>>
>>>>>>>> +       acpi_battery_unregister();
>>>>>>>> +
>>>>>>>
>>>>>>>
>>>>>>>
>>>>>>> What if the ACPI battery driver is loaded after this has been called
>>>>>>> already?
>>>>>>
>>>>>>
>>>>>>
>>>>>> The module exports that symbol so it must be loaded already.
>>>>>
>>>>>
>>>>> But then it may be unloaded manually and loaded again, may it not?
>>>>
>>>>
>>>> Only if you first unload axp288_fuel_gauge.ko otherwise it will
>>>> have a refcount > 0.
>>>
>>> OK
>>>
>>> Anyway, I'd prefer blacklists in the battery and ac drivers to be honest.
>>
>> As I explained in my reply to the discussion around the first patch that
>> is somewhat hard to do and requires encoding knowledge in those drivers
>> which really does not belong there:
>>
>> "The problem is that Intel re-uses HIDs between generations and
>> for the Whiskey Cove PMIC we want to not use the ACPI battery
>> and ac drivers on Cherry Trail (where they are known to be
>> broken) but things are different on Apollo Lake. Yet both
>> use the same HID for their companion Whiskey Cove PMIC even
>> though they are 2 completely different revisions of the PMIC
>> (e.g. one uses i2c the other does not).
>>
>> The 2 native drivers have code to detect which revision they
>> are dealing with and exit with -ENODEV if it is not the
>> revision they were written for, but this means that simple
>> HID blacklisting will not work. So IMHO the decision to
>> unregister the  ACPI battery / ac interface really belongs
>> in the native driver as that has all the nitty gritty detail
>> needed to make that decision."
>
> So thinking more about this, esp. after receiving a bug report
> from a user getting ACPI errors because of Linux not implementing
> the proprietary undocumented BMOP opregion before the ACPI battery
> driver gets unregistered by the native one, I thing we do indeed
> need to go with a blacklist.
>
> This means also being able to match by _HRV, as Some HIDs are
> re-used for different hardware between Bay Trail / Cherry Trail /
> Broxton with just a bump of _HRV.
>
> I'm currently working on respinning my
> "acpi: utils: Add new acpi_dev_present helper" to address the
> review comments on it. I'm going to give it an optional hrv
> function argument for this use, so as to not having to implement
> hrv checking code in both ac.c and battery.c .

So a quick copy paste from another thread, the black-list approach
causes regressions even before hitting -next and seeing any
substantial testing, so we're back to adding unregister functions
and calling those from native PMIC power_supply drivers when the
native power_supply has been successfully registered.

Some Bay Trail / Cherry Trail users are running kernels build
from my personal tree to get early access to various fixes
in there and I got a regression report on the DELL 5855, where
the blacklisting of the ACPI battery driver if INT33F4 is
present caused the battery monitoring to stop working, that
devices has an INT33F4 node with _STA returning 15 yet it
is not using an axp288 PMIC at all, I'm still gathering more
info, but I believe atm that Dell simply disabled the i2c
controller to which the axp288 would be connected if present
and left the other bits of the DTSD unmodified.

One option which comes to mind would be to only count devices
as present if all their deps are met, but that will only
work if the blacklist check is done after all other drivers
have loaded which is not how things work.

So I believe that my earlier attempts at fixing the double
power_supply registration by unregistering the ACPI one when
the native one has successfully loaded is better. That guarantees
regressions like this one will not happen, because the ACPI
power_supply does not get unregistered until the native one
has loaded.

Regards,

Hans
