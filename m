From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH 1/4] acpi: battery: Add acpi_battery_unregister() function
Date: Mon, 20 Mar 2017 14:03:16 +0100
Message-ID: <84d31794-d5c5-6f09-bbdb-9f5612ddbbbe@redhat.com>
References: <20170316161601.32267-1-hdegoede@redhat.com>
 <20170316161601.32267-2-hdegoede@redhat.com>
 <1489681793.19767.21.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:48890 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753594AbdCTNFd (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 20 Mar 2017 09:05:33 -0400
In-Reply-To: <1489681793.19767.21.camel@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Sebastian Reichel <sre@kernel.org>, Chen-Yu Tsai <wens@csie.org>
Cc: linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org

Hi,

Thank you for the reviews!

On 16-03-17 17:29, Andy Shevchenko wrote:
> On Thu, 2017-03-16 at 17:15 +0100, Hans de Goede wrote:
>> On some systems we have a native pmic driver which provides battery
>> monitoring, while the acpi battery driver is broken on these systems
>> due to bad dstds or because of missing vendor specific acpi opregion
>> (e.g. BMOP opregion) support, which the acpi battery device in the
>> dsdt relies on.
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
> acpi -> ACPI
> pmic -> PMIC
> dsdt -> DSDT (perhaps not here, but just in case)

Will fix for v2, note for the rest of the series, to avoid
spamming everyone with a lot of comments I will just fix
everything and send a v2 unless I've a specific remark.

>> @@ -31,6 +31,7 @@
>>  #include <linux/delay.h>
>>  #include <linux/slab.h>
>>  #include <linux/suspend.h>
>> +#include <linux/mutex.h>
>
> Keep in alphabetical order ?

I'm a fan of having headers in alphabetical order myself,
but if you look at the actual file, rather then the diff
context, you will see that this file uses random order.

>>  #include <linux/acpi.h>
>>  #include <linux/power_supply.h>
>> +#include <linux/power/acpi.h>
>
> Ditto. (though I don't remember which is first _ or /)
>
>> +	/* Check if acpi_battery_unregister got called before _init()
>> */
>
> acpi_battery_unregister -> acpi_battery_unregister() ?
>
>> +	mutex_lock(&init_state_mutex);
>> +	if (init_state != BAT_NONE)
>> +		goto out_unlock;
>> +
>>  	async_cookie = async_schedule(acpi_battery_init_async, NULL);
>> +	init_state = BAT_INITIALIZED;
>
> + empty line here...

Both fixed for v2.

>
>> +out_unlock:
>> +	mutex_unlock(&init_state_mutex);
>
>> +
>
> ...instead of this ?
>
>> +++ b/include/linux/power/acpi.h
>
> E.g. for GPIO we keep such things directly in linux/acpi.h. Does it make
> sense to have separate one in this case?

I've taken include/acpi/video.h as example here. TBH I do not think
shoving everything acpi related into linux/acpi.h is a good idea.

Regards,

Hans
