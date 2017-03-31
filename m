From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH 1/4] acpi: battery: Add acpi_battery_unregister() function
Date: Fri, 31 Mar 2017 10:53:36 +0200
Message-ID: <580faaaa-0cf2-7afc-4c25-5007fadfdb99@redhat.com>
References: <20170316161601.32267-1-hdegoede@redhat.com>
 <20170316161601.32267-2-hdegoede@redhat.com>
 <1AE640813FDE7649BE1B193DEA596E886CE675FE@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <1AE640813FDE7649BE1B193DEA596E886CE675FE@SHSMSX101.ccr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
To: "Zheng, Lv" <lv.zheng@intel.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Sebastian Reichel <sre@kernel.org>, Chen-Yu Tsai <wens@csie.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi,

On 27-03-17 03:16, Zheng, Lv wrote:
> Hi, Hans
>
>> From: linux-acpi-owner@vger.kernel.org [mailto:linux-acpi-owner@vger.kernel.org] On Behalf Of Hans de
>> Goede
>> Subject: [PATCH 1/4] acpi: battery: Add acpi_battery_unregister() function
>>
>> On some systems we have a native pmic driver which provides battery
>> monitoring, while the acpi battery driver is broken on these systems
>> due to bad dstds or because of missing vendor specific acpi opregion
>
> dstds -> dsdts?

Yes, fixed locally.

>
>> (e.g. BMOP opregion) support, which the acpi battery device in the
>> dsdt relies on.
>
> Why don't we support BMOP and leverage between PMIC driver and BMOP opregion driver?

Multiple reasons:
1) The BMOP is an undocumented proprietary ACPI interface (not part of the
    ACPI spec) which would need to be reverse engineered and implemented per
    fuel-gauge driver; once for the axp288, once for the max17047 once for
    the ti fuel gauge which can be used on some models according to the DSDTs
    I've.

2) Even if we do this we still will not get a battery everywhere as not all
    DSDTs export the ACPI battery interface, only some do. So we still need
    the native driver + power_supply for those tablets without the ACPI
    battery interface and on those with the ACPI interface we end up with
    multiple battery interfaces for a single battery which breaks the userspace
    ABI.

3) Even if we reverse-engineer the BMOP stuff and get things to work, the
    quality of the ACPI battery implementation in these DSDTs is questionable,
    where as with native fuel-gauge drivers we can guarantee proper reporting
    of the battery stare to userspace

TL;DR: having a native driver is better and there should only be one driver
registered, hence this patch.


>
>>
>> This leads to there being 2 battery power_supply-s registed like this:
>>
>> ~$ acpi
>> Battery 0: Charging, 84%, 00:49:39 until charged
>> Battery 1: Unknown, 0%, rate information unavailable
>>
>> Even if the acpi battery where to function fine (which on systems
>> where we have a native pmic driver it often doesn't) we still do not
>> want to export the same battery to userspace twice.
>>
>> This commit adds an acpi_battery_unregister() function which native
>> pmic drivers can call to tell the acpi-battery driver to unregister
>> itself so that we do not end up with 2 power_supply-s for the same
>> battery device.
>
> I'm not sure if this is a good idea:
> Driver A calls Driver B's unregister function in case Driver A should be unware of the existence of Driver B.
>
> For example, acpi_video_unregister() is such a bad practice.

acpi_video_unregister() although not pretty is very much necessary
actually the whole backlight sysfs interface were we do sometimes
register multiple sysfs backlight class devices for a single
backlight and let userspace figure things out is a prime
example of why we need this, we need to export only one
interface and in case of the power_supply interface doing
anything else would be an ABI break.

Note that in this case things are actually much better then
the acpi_video stuff, since we've a very clear place when to
do the unregister (in the native x86 only drivers) rather then
needing some magic heuristics.

> Do we have any other choices?

We could alternatively have the ACPI battery and ac drivers
contain a black list of ACPI HIDs which they check and when
these are in the DSDT and enabled/present have their probe
methods return -ENODEV.

I dismissed this at first, but on second thought that should
work.

Regards,

Hans




> For example, driver priority and etc.?
>
> Thanks
> Lv
>
>
>>
>> BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=194811
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>> Tested-by: Sergei Trusov <t.rus76@ya.ru>
>> ---
>>  drivers/acpi/battery.c     | 32 +++++++++++++++++++++++++++++++-
>>  include/linux/power/acpi.h | 18 ++++++++++++++++++
>>  2 files changed, 49 insertions(+), 1 deletion(-)
>>  create mode 100644 include/linux/power/acpi.h
>>
>> diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
>> index 4ef1e46..644e154 100644
>> --- a/drivers/acpi/battery.c
>> +++ b/drivers/acpi/battery.c
>> @@ -31,6 +31,7 @@
>>  #include <linux/delay.h>
>>  #include <linux/slab.h>
>>  #include <linux/suspend.h>
>> +#include <linux/mutex.h>
>>  #include <asm/unaligned.h>
>>
>>  #ifdef CONFIG_ACPI_PROCFS_POWER
>> @@ -41,6 +42,7 @@
>>
>>  #include <linux/acpi.h>
>>  #include <linux/power_supply.h>
>> +#include <linux/power/acpi.h>
>>
>>  #include "battery.h"
>>
>> @@ -66,6 +68,10 @@ MODULE_AUTHOR("Alexey Starikovskiy <astarikovskiy@suse.de>");
>>  MODULE_DESCRIPTION("ACPI Battery Driver");
>>  MODULE_LICENSE("GPL");
>>
>> +enum init_state_enum { BAT_NONE, BAT_INITIALIZED, BAT_EXITED };
>> +
>> +static enum init_state_enum init_state;
>> +static DEFINE_MUTEX(init_state_mutex);
>>  static async_cookie_t async_cookie;
>>  static int battery_bix_broken_package;
>>  static int battery_notification_delay_ms;
>> @@ -1336,17 +1342,41 @@ static int __init acpi_battery_init(void)
>>  	if (acpi_disabled)
>>  		return -ENODEV;
>>
>> +	/* Check if acpi_battery_unregister got called before _init() */
>> +	mutex_lock(&init_state_mutex);
>> +	if (init_state != BAT_NONE)
>> +		goto out_unlock;
>> +
>>  	async_cookie = async_schedule(acpi_battery_init_async, NULL);
>> +	init_state = BAT_INITIALIZED;
>> +out_unlock:
>> +	mutex_unlock(&init_state_mutex);
>> +
>>  	return 0;
>>  }
>>
>> -static void __exit acpi_battery_exit(void)
>> +void acpi_battery_unregister(void)
>>  {
>> +	/* Check if _init() is done and only do unregister once */
>> +	mutex_lock(&init_state_mutex);
>> +	if (init_state != BAT_INITIALIZED)
>> +		goto out_exit;
>> +
>>  	async_synchronize_cookie(async_cookie + 1);
>>  	acpi_bus_unregister_driver(&acpi_battery_driver);
>>  #ifdef CONFIG_ACPI_PROCFS_POWER
>>  	acpi_unlock_battery_dir(acpi_battery_dir);
>>  #endif
>> +
>> +out_exit:
>> +	init_state = BAT_EXITED;
>> +	mutex_unlock(&init_state_mutex);
>> +}
>> +EXPORT_SYMBOL_GPL(acpi_battery_unregister);
>> +
>> +static void __exit acpi_battery_exit(void)
>> +{
>> +	acpi_battery_unregister();
>>  }
>>
>>  module_init(acpi_battery_init);
>> diff --git a/include/linux/power/acpi.h b/include/linux/power/acpi.h
>> new file mode 100644
>> index 0000000..83bdfb9
>> --- /dev/null
>> +++ b/include/linux/power/acpi.h
>> @@ -0,0 +1,18 @@
>> +/*
>> + * Functions exported by the acpi power_supply drivers
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License version 2 as
>> + * published by the Free Software Foundation.
>> + */
>> +
>> +#ifndef __LINUX_POWER_ACPI_H_
>> +#define __LINUX_POWER_ACPI_H_
>> +
>> +#if IS_ENABLED(CONFIG_ACPI_BATTERY)
>> +void acpi_battery_unregister(void);
>> +#else
>> +static inline void acpi_battery_unregister(void) {}
>> +#endif
>> +
>> +#endif
>> --
>> 2.9.3
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
