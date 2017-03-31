From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH 3/4] power: supply: axp288_fuel_gauge: Unregister
 duplicate ACPI battery supply
Date: Fri, 31 Mar 2017 11:11:16 +0200
Message-ID: <CAJZ5v0i7TN+iJLR_SeaCrpKJ13g1_bQ-G54cugAF9Dm4=pifAg@mail.gmail.com>
References: <20170316161601.32267-1-hdegoede@redhat.com> <20170316161601.32267-4-hdegoede@redhat.com>
 <6382698.NuYXpb6L7h@aspire.rjw.lan> <0ed23626-b6b2-a42e-2a1d-762c8c833f7b@redhat.com>
 <CAJZ5v0h466y6hBy_-12AEgcpAUXEA7cZkNwXZwvsHnjWtoqFeg@mail.gmail.com> <eb52c4b4-fc3c-b11b-edef-a35c6bb0d82d@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <eb52c4b4-fc3c-b11b-edef-a35c6bb0d82d@redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Sebastian Reichel <sre@kernel.org>, Chen-Yu Tsai <wens@csie.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Fri, Mar 31, 2017 at 11:08 AM, Hans de Goede <hdegoede@redhat.com> wrote:
> Hi,
>
> On 31-03-17 11:05, Rafael J. Wysocki wrote:
>>
>> On Fri, Mar 31, 2017 at 11:01 AM, Hans de Goede <hdegoede@redhat.com>
>> wrote:
>>
>> [cut]
>>
>>>>> --- a/drivers/power/supply/axp288_fuel_gauge.c
>>>>> +++ b/drivers/power/supply/axp288_fuel_gauge.c
>>>>> @@ -26,6 +26,7 @@
>>>>>  #include <linux/mfd/axp20x.h>
>>>>>  #include <linux/platform_device.h>
>>>>>  #include <linux/power_supply.h>
>>>>> +#include <linux/power/acpi.h>
>>>>>  #include <linux/iio/consumer.h>
>>>>>  #include <linux/debugfs.h>
>>>>>  #include <linux/seq_file.h>
>>>>> @@ -754,6 +755,8 @@ static int axp288_fuel_gauge_probe(struct
>>>>> platform_device *pdev)
>>>>>                 return ret;
>>>>>         }
>>>>>
>>>>> +       acpi_battery_unregister();
>>>>> +
>>>>
>>>>
>>>>
>>>> What if the ACPI battery driver is loaded after this has been called
>>>> already?
>>>
>>>
>>>
>>> The module exports that symbol so it must be loaded already.
>>
>>
>> But then it may be unloaded manually and loaded again, may it not?
>
>
> Only if you first unload axp288_fuel_gauge.ko otherwise it will
> have a refcount > 0.

OK

Anyway, I'd prefer blacklists in the battery and ac drivers to be honest.

Thanks,
Rafael
