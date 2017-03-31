From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH 3/4] power: supply: axp288_fuel_gauge: Unregister
 duplicate ACPI battery supply
Date: Fri, 31 Mar 2017 11:05:36 +0200
Message-ID: <CAJZ5v0h466y6hBy_-12AEgcpAUXEA7cZkNwXZwvsHnjWtoqFeg@mail.gmail.com>
References: <20170316161601.32267-1-hdegoede@redhat.com> <20170316161601.32267-4-hdegoede@redhat.com>
 <6382698.NuYXpb6L7h@aspire.rjw.lan> <0ed23626-b6b2-a42e-2a1d-762c8c833f7b@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oi0-f51.google.com ([209.85.218.51]:35322 "EHLO
        mail-oi0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932605AbdCaJFi (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 31 Mar 2017 05:05:38 -0400
In-Reply-To: <0ed23626-b6b2-a42e-2a1d-762c8c833f7b@redhat.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Sebastian Reichel <sre@kernel.org>, Chen-Yu Tsai <wens@csie.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>

On Fri, Mar 31, 2017 at 11:01 AM, Hans de Goede <hdegoede@redhat.com> wrote:

[cut]

>>> --- a/drivers/power/supply/axp288_fuel_gauge.c
>>> +++ b/drivers/power/supply/axp288_fuel_gauge.c
>>> @@ -26,6 +26,7 @@
>>>  #include <linux/mfd/axp20x.h>
>>>  #include <linux/platform_device.h>
>>>  #include <linux/power_supply.h>
>>> +#include <linux/power/acpi.h>
>>>  #include <linux/iio/consumer.h>
>>>  #include <linux/debugfs.h>
>>>  #include <linux/seq_file.h>
>>> @@ -754,6 +755,8 @@ static int axp288_fuel_gauge_probe(struct
>>> platform_device *pdev)
>>>                 return ret;
>>>         }
>>>
>>> +       acpi_battery_unregister();
>>> +
>>
>>
>> What if the ACPI battery driver is loaded after this has been called
>> already?
>
>
> The module exports that symbol so it must be loaded already.

But then it may be unloaded manually and loaded again, may it not?

Thanks,
Rafael
