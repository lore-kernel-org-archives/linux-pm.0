From: Guenter Roeck <linux@roeck-us.net>
Subject: Re: [RFC] w1: regression, remove need for ida and use
 PLATFORM_DEVID_AUTO
Date: Fri, 3 Feb 2017 06:07:29 -0800
Message-ID: <0a4d4a6d-5ede-b77a-0600-19a8d815a33f@roeck-us.net>
References: <d0b52b94-0c87-61f8-32ff-99f2a354e500@tul.cz>
 <308e185e-26eb-39ee-d82f-a0d210a41743@ti.com>
 <cfa35897-383e-674a-f049-e45c4dfeb534@tul.cz>
 <0928fc89-490f-1d12-dc3d-51f2d433d2e0@roeck-us.net>
 <822b1827-959b-13dc-6331-f0954954c010@tul.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:42679 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752248AbdBCOHe (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 3 Feb 2017 09:07:34 -0500
In-Reply-To: <822b1827-959b-13dc-6331-f0954954c010@tul.cz>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Petr Cvek <petr.cvek@tul.cz>, "Andrew F. Davis" <afd@ti.com>, zbr@ioremap.net, Sebastian Reichel <sre@kernel.org>, philipp.zabel@gmail.com, lost.distance@yahoo.com, daniel@caiaq.de, rui.zhang@intel.com, edubezval@gmail.com, jdelvare@suse.com
Cc: linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-hwmon@vger.kernel.org

On 02/03/2017 05:28 AM, Petr Cvek wrote:
> Dne 3.2.2017 v 04:31 Guenter Roeck napsal(a):
>> On 02/02/2017 05:31 PM, Petr Cvek wrote:
>>> Dne 2.2.2017 v 15:23 Andrew F. Davis napsal(a):
>>>> On 02/01/2017 07:05 PM, Petr Cvek wrote:
>>>>> Patch
>>>>>     w1: remove need for ida and use PLATFORM_DEVID_AUTO
>>>>>     098f9fb0c962eb2fdba5f9d34f4cf7a938237184
>>>>>
>>>>> causes a regression in the w1_ds2760 driver. Initialization creates a name "ds2760-battery.0.auto". It seems that name of that size will cause checking code in __thermal_cooling_device_register() from thermal_core.c to fail as it checks for names shorter than 20 chars:
>>>>>
>>>>>     if (type && strlen(type) >= THERMAL_NAME_LENGTH)
>>>>>         return ERR_PTR(-EINVAL);
>>>>>
>>>>> A second problem seems to be with magician_supplicants list as "ds2760-battery.0" does not match in a test power_supply_am_i_supplied() in ds2760_battery_update_status() from drivers/power/supply/ds2760_battery.c . This causes status flag to be forever in POWER_SUPPLY_STATUS_DISCHARGING state.
>>>>>
>>>>> Functionality returned after I hotfix changed (drivers/w1/slaves/w1_ds2760.c)
>>>>>
>>>>>     pdev = platform_device_alloc("ds2760-battery", PLATFORM_DEVID_AUTO);
>>>>>
>>>>> to
>>>>>
>>>>>     pdev = platform_device_alloc("ds2760-battery", 0);
>>>>>
>>>>> Which solution do you advise. Shortening the name let's say just to "ds2760" (with changes to arch files, w1 files and supply files), increasing THERMAL_NAME_LENGTH to let's say 32 (I don't know if this doesn't break something other) or just reverting to the old behavior?
>>>>>
>>>>
>>>> If 20 is no longer the max thermal name then THERMAL_NAME_LENGTH should
>>>> be changed.
>>>
>>> Yes it is that ".auto" addition to "ds2760-battery.0" makes 21 chars long string. With higher number (".10" onwards) it is 22 chars. Load of the module then fails at test in thermal_zone_device_register():
>>>
>>>     https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/drivers/thermal/thermal_core.c?id=refs/tags/v4.10-rc6#n1158
>>>
>>>     if (type && strlen(type) >= THERMAL_NAME_LENGTH)
>>>         return ERR_PTR(-EINVAL);
>>>
>>> I searched in code further and with THERMAL_NAME_LENGTH = 30 (enough space) the module load fails at another place in __hwmon_device_register():
>>>
>>>     https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/drivers/hwmon/hwmon.c?id=refs/tags/v4.10-rc6#n548
>>>
>>>     if (name && (!strlen(name) || strpbrk(name, "-* \t\n")))
>>>         return ERR_PTR(-EINVAL);
>>>
>>> That's because there is "-" in "ds2760-battery.0.auto" (and that's why shortening to "ds2760.0" works). Is there some reason for disallowing "-" in a name? If not then I'm for removal (in other case we need to change ds2760-battery and others names). Increasing THERMAL_NAME_LENGTH to 22 should be just OK for ds2760 (but maybe not enough for others) I would increased it to 32 (nice number ;-) ).
>>>
>>
>> '-' is not permitted in hwmon name attributes, primarily because libsensors
>> interprets it as a delimiter in its configuration file.
>>
>
> OK so this means we need to rename ds2760-battery so libsensors works.
>
> Hmm is an underscore in "ds2760_battery.0.auto" OK?

Theoretically yes, but there was objection to that idea because replacing the '-'
with '_' is considered by some to be an ABI change (why the addition of '.auto'
doesn't matter escapes me, though).

>
>> Anyway, the related change in thermal has been reverted, so that should
>
> s/thermal/hwmon ? Or I'm confused :-D (there was no change in thermal, code stopped working because of change in w1 driver (".auto" addition))
>

3feb479cea37 Revert "thermal: thermal_hwmon: Convert to hwmon_device_register_with_info()"

Guenter

