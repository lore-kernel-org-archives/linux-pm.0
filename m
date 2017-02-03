From: Guenter Roeck <linux@roeck-us.net>
Subject: Re: [RFC] w1: regression, remove need for ida and use
 PLATFORM_DEVID_AUTO
Date: Thu, 2 Feb 2017 19:31:12 -0800
Message-ID: <0928fc89-490f-1d12-dc3d-51f2d433d2e0@roeck-us.net>
References: <d0b52b94-0c87-61f8-32ff-99f2a354e500@tul.cz>
 <308e185e-26eb-39ee-d82f-a0d210a41743@ti.com>
 <cfa35897-383e-674a-f049-e45c4dfeb534@tul.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:45811 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752174AbdBCDbS (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 2 Feb 2017 22:31:18 -0500
In-Reply-To: <cfa35897-383e-674a-f049-e45c4dfeb534@tul.cz>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Petr Cvek <petr.cvek@tul.cz>, "Andrew F. Davis" <afd@ti.com>, zbr@ioremap.net, Sebastian Reichel <sre@kernel.org>, philipp.zabel@gmail.com, lost.distance@yahoo.com, daniel@caiaq.de, rui.zhang@intel.com, edubezval@gmail.com, jdelvare@suse.com
Cc: linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-hwmon@vger.kernel.org

On 02/02/2017 05:31 PM, Petr Cvek wrote:
> Dne 2.2.2017 v 15:23 Andrew F. Davis napsal(a):
>> On 02/01/2017 07:05 PM, Petr Cvek wrote:
>>> Patch
>>> 	w1: remove need for ida and use PLATFORM_DEVID_AUTO
>>> 	098f9fb0c962eb2fdba5f9d34f4cf7a938237184
>>>
>>> causes a regression in the w1_ds2760 driver. Initialization creates a name "ds2760-battery.0.auto". It seems that name of that size will cause checking code in __thermal_cooling_device_register() from thermal_core.c to fail as it checks for names shorter than 20 chars:
>>>
>>> 	if (type && strlen(type) >= THERMAL_NAME_LENGTH)
>>> 		return ERR_PTR(-EINVAL);
>>>
>>> A second problem seems to be with magician_supplicants list as "ds2760-battery.0" does not match in a test power_supply_am_i_supplied() in ds2760_battery_update_status() from drivers/power/supply/ds2760_battery.c . This causes status flag to be forever in POWER_SUPPLY_STATUS_DISCHARGING state.
>>>
>>> Functionality returned after I hotfix changed (drivers/w1/slaves/w1_ds2760.c)
>>>
>>> 	pdev = platform_device_alloc("ds2760-battery", PLATFORM_DEVID_AUTO);
>>>
>>> to
>>>
>>> 	pdev = platform_device_alloc("ds2760-battery", 0);
>>>
>>> Which solution do you advise. Shortening the name let's say just to "ds2760" (with changes to arch files, w1 files and supply files), increasing THERMAL_NAME_LENGTH to let's say 32 (I don't know if this doesn't break something other) or just reverting to the old behavior?
>>>
>>
>> If 20 is no longer the max thermal name then THERMAL_NAME_LENGTH should
>> be changed.
>
> Yes it is that ".auto" addition to "ds2760-battery.0" makes 21 chars long string. With higher number (".10" onwards) it is 22 chars. Load of the module then fails at test in thermal_zone_device_register():
>
> 	https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/drivers/thermal/thermal_core.c?id=refs/tags/v4.10-rc6#n1158
>
> 	if (type && strlen(type) >= THERMAL_NAME_LENGTH)
> 		return ERR_PTR(-EINVAL);
>
> I searched in code further and with THERMAL_NAME_LENGTH = 30 (enough space) the module load fails at another place in __hwmon_device_register():
> 	
> 	https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/drivers/hwmon/hwmon.c?id=refs/tags/v4.10-rc6#n548
>
> 	if (name && (!strlen(name) || strpbrk(name, "-* \t\n")))
> 		return ERR_PTR(-EINVAL);
>
> That's because there is "-" in "ds2760-battery.0.auto" (and that's why shortening to "ds2760.0" works). Is there some reason for disallowing "-" in a name? If not then I'm for removal (in other case we need to change ds2760-battery and others names). Increasing THERMAL_NAME_LENGTH to 22 should be just OK for ds2760 (but maybe not enough for others) I would increased it to 32 (nice number ;-) ).
>

'-' is not permitted in hwmon name attributes, primarily because libsensors
interprets it as a delimiter in its configuration file.

Anyway, the related change in thermal has been reverted, so that should
no longer be an issue. Also, we'll change the hwmon code in 4.11 to no longer
return an error but to (only) issue a warning if an invalid name is provided.

Guenter

>>
>> As for the couple boards hard-coding "ds2760-battery.0", this is a
>> problem that should be fix regardless of any fix we chose here as IDA is
>> not guaranteed to return 0, so the battery could just as easily be
>> called ds2760-battery.7. (I've had this discussion before as the N900
>> user-space also make this mistake).
>>
>
> I'm not familiar with power supply subsystem, so just a naive idea. Should suffice to change drivers/power/supply/power_supply_core.c __power_supply_is_supplied_by() for only first part of the string? (like "ds2760-battery" subset of "ds2760-battery.7").
>
> Do you have a link to discussion about N900?
>
> Petr
>

