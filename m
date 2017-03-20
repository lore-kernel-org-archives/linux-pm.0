From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH 3/4] power: supply: axp288_fuel_gauge: Unregister
 duplicate ACPI battery supply
Date: Mon, 20 Mar 2017 14:07:03 +0100
Message-ID: <03a81b89-eb09-08df-3a0e-32fce7f92d2c@redhat.com>
References: <20170316161601.32267-1-hdegoede@redhat.com>
 <20170316161601.32267-4-hdegoede@redhat.com>
 <1489681990.19767.23.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <1489681990.19767.23.camel@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Sebastian Reichel <sre@kernel.org>, Chen-Yu Tsai <wens@csie.org>
Cc: linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hi,

On 16-03-17 17:33, Andy Shevchenko wrote:
> On Thu, 2017-03-16 at 17:16 +0100, Hans de Goede wrote:
>> On some systems with axp288 PMIC the dsdt also exports an ACPI battery
>> device (PNP0C0A device). This leads to there being 2 battery
>> power_supply-s registed like this:
>>
>> ~$ acpi
>> Battery 0: Charging, 84%, 00:49:39 until charged
>> Battery 1: Unknown, 0%, rate information unavailable
>>
>> Note that the ACPI battery device does not work properly this is due
>> to Linux missing support for the vendor specific BMOP ACPI opregion.
>> But even if the ACPI battery where to function fine we still do not
>> want to export the same battery to userspace twice.
>>
>> Therefor this commit calls acpi_battery_unregister() after
>> successfully
>> registering the axp288-fuel-gauge power_supply to remove the duplicate
>> (and often broken) ACPI battery power_supply.
>
>> +	# if ACPI_BATTERY=m, this can't be 'y'
>
> Driver dependencies? Deferred probe?

axp288_fuel_gauge.ko will use a symbol from drivers/acpi/battery.c
now. If ACPI_BATTERY is disabled include/linux/power/acpi.h provides
a stub, but if it is enabled in any form then no stub, so then
if ACPI_BATTERY=m axp288_fuel_gauge.ko needs to be a module too.

Regards,

Hans

