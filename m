From: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Subject: Re: [RESEND PATCH v3 2/2] thermal: core: introduce thermal zone
 device mode control
Date: Wed, 4 Jul 2018 12:36:39 +0200
Message-ID: <f06cea77-f0bf-07bf-b8c6-6835cf0be999@collabora.com>
References: <20180226144118.24693-1-enric.balletbo@collabora.com>
 <20180226144118.24693-2-enric.balletbo@collabora.com>
 <20180629003302.GT129942@google.com> <20180703171325.GC129942@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180703171325.GC129942@google.com>
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
To: Matthias Kaehlcke <mka@chromium.org>
Cc: rui.zhang@intel.com, rjw@rjwysocki.net, groeck@chromium.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, snanda@chromium.org, lenb@kernel.org, Eduardo Valentin <edubezval@gmail.com>, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hi Matthias,

Sorry for late reply, my memory is bad so I need to look at this again. The
patch was send some time ago and there are pending changes to do but then I
switched. I'll take a look, but did you saw why this patch was not merged [1]?
Maybe that could answer some of your questions.

Best regards,
 Enric

[1] https://lkml.org/lkml/2018/2/27/910

On 03/07/18 19:13, Matthias Kaehlcke wrote:
> On Thu, Jun 28, 2018 at 05:33:02PM -0700, Matthias Kaehlcke wrote:
>> Hi,
>>
>> I stumbled across this patch since I'm currently poking around with
>> early thermal bringup on a platform and this patch has been integrated
>> in our development tree.
>>
>> I'm seeing some unexpected behaviors, which could entirely due to
>> wrong expectation from my side. I only have some basic working
>> knowledge of the thermal framework, just want to double check and
>> perhaps learn a thing or two.
>>
>> On Mon, Feb 26, 2018 at 03:41:18PM +0100, Enric Balletbo i Serra wrote:
>>> From: Zhang Rui <rui.zhang@intel.com>
>>>
>>> Thermal "mode" sysfs attribute is introduced to enable/disable a thermal
>>> zone, and .get_mode()/.set_mode() callback is introduced for platform
>>> thermal driver to enable/disable the hardware thermal control logic. And
>>> thermal core takes no action upon thermal zone enable/disable.
>>>
>>> Actually, this is not quite right because thermal core still pokes those
>>> disabled thermal zones occasionally, e.g. upon system resume.
>>>
>>> To fix this, a new flag 'mode' is introduced in struct thermal_zone_device
>>> to represent the thermal zone mode, and several decisions have been made
>>> based on this flag, including
>>> 1. check the thermal zone mode right after it's registered.
>>> 2. skip updating thermal zone if the zone is disabled
>>> 3. stop the polling timer when the thermal zone is disabled
>>>
>>> Note: basically, this patch doesn't affect the existing always-enabled
>>> thermal zones much, with just one exception -
>>> thermal zone .get_mode() must be well prepared to reflect the real thermal
>>> zone status upon the thermal zone registration.
>>
>> From my perspective this looks like a pretty significant change. For
>> the platform I'm working on I added a thermal zone to the device tree,
>> with the expectation that it would be enabled. Judging from the code
>> without this patch this expectation seems to be naive, since
>> of-thermal.c sets tz->mode to THERMAL_DEVICE_DISABLED, so apparently
>> either userspace or some driver should call _set_mode(tz,
>> THERMAL_DEVICE_ENABLED). However even without this the thermal zone
>> appears to be active (I didn't really test end-to-end yet, but at
>> least thermal_zone_device_update() is called and calls
>> handle_thermal_trip()). Not sure why this is the case with
>> THERMAL_DEVICE_DISABLED, but before I learned about the existence of
>> the flag my expectation was that the zone would be enabled.
>>
>> With this patch thermal_zone_device_update() is skipped if the zone
>> hasn't been explictly enabled, which may be consistent with the state
>> of 'tz->mode', but effectively changes the previous/current behavior.
>>
>> Not sure if I'm just dumbly overlooking something obvious or if there
>> is an actual problem with of_thermal (and maybe others).
> 
> The problem is that there are now two 'mode' fields, tzd->mode and the
> other typically tzd->devdata->mode, and tzd->mode is never set to enabled.
> 
>> thermal zone .get_mode() must be well prepared to reflect the real thermal
>> zone status upon the thermal zone registration.
> 
> For of_thermal tzd->mode is initialized with the result of .get_mode()
> when the zone is registered. At this time no sensor has been added
> to the zone, hence the zone is disabled. When a sensor is added later
> tzd->devdata->mode is set to enabled, however tzd->mode remains disabled:
> 
> tzd->mode = DISABLED
> tzd->devdata->mode = DISABLED
> 
> of_parse_thermal_zones
>   thermal_zone_device_register
>     tzd->mode = tzd->get_mode() // => DISABLED
> 
> <sensor>_probe
>   thermal_zone_of_sensor_register
>     tzd->set_mode(THERMAL_DEVICE_ENABLED)
>       tzd->devdata->mode = ENABLED
> 
> One way to fix this for of_thermal could be to setting tzd->mode in
> .set_mode() in addition to setting tzd->devdata->mode. However this
> feels like a workaround/hack. Personally I find it confusing to have
> two mode fields for a thermal zone device. Maybe tzd->mode should
> replace tzd->devdata->mode?
> 
