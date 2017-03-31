From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH 1/4] acpi: battery: Add acpi_battery_unregister() function
Date: Fri, 31 Mar 2017 11:00:25 +0200
Message-ID: <7945045c-0de2-388c-c51e-71c4fd6eaddb@redhat.com>
References: <20170316161601.32267-1-hdegoede@redhat.com>
 <20170316161601.32267-2-hdegoede@redhat.com>
 <1AE640813FDE7649BE1B193DEA596E886CE675FE@SHSMSX101.ccr.corp.intel.com>
 <580faaaa-0cf2-7afc-4c25-5007fadfdb99@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <580faaaa-0cf2-7afc-4c25-5007fadfdb99@redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
To: "Zheng, Lv" <lv.zheng@intel.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Sebastian Reichel <sre@kernel.org>, Chen-Yu Tsai <wens@csie.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi,

On 31-03-17 10:53, Hans de Goede wrote:
> Hi,
>
> On 27-03-17 03:16, Zheng, Lv wrote:
>> Hi, Hans
>>
>>> From: linux-acpi-owner@vger.kernel.org [mailto:linux-acpi-owner@vger.kernel.org] On Behalf Of Hans de
>>> Goede
>>> Subject: [PATCH 1/4] acpi: battery: Add acpi_battery_unregister() function
>>>
>>> On some systems we have a native pmic driver which provides battery
>>> monitoring, while the acpi battery driver is broken on these systems
>>> due to bad dstds or because of missing vendor specific acpi opregion
>>
>> dstds -> dsdts?
>
> Yes, fixed locally.
>
>>
>>> (e.g. BMOP opregion) support, which the acpi battery device in the
>>> dsdt relies on.
>>
>> Why don't we support BMOP and leverage between PMIC driver and BMOP opregion driver?
>
> Multiple reasons:
> 1) The BMOP is an undocumented proprietary ACPI interface (not part of the
>    ACPI spec) which would need to be reverse engineered and implemented per
>    fuel-gauge driver; once for the axp288, once for the max17047 once for
>    the ti fuel gauge which can be used on some models according to the DSDTs
>    I've.
>
> 2) Even if we do this we still will not get a battery everywhere as not all
>    DSDTs export the ACPI battery interface, only some do. So we still need
>    the native driver + power_supply for those tablets without the ACPI
>    battery interface and on those with the ACPI interface we end up with
>    multiple battery interfaces for a single battery which breaks the userspace
>    ABI.
>
> 3) Even if we reverse-engineer the BMOP stuff and get things to work, the
>    quality of the ACPI battery implementation in these DSDTs is questionable,
>    where as with native fuel-gauge drivers we can guarantee proper reporting
>    of the battery stare to userspace
>
> TL;DR: having a native driver is better and there should only be one driver
> registered, hence this patch.
>
>
>>
>>>
>>> This leads to there being 2 battery power_supply-s registed like this:
>>>
>>> ~$ acpi
>>> Battery 0: Charging, 84%, 00:49:39 until charged
>>> Battery 1: Unknown, 0%, rate information unavailable
>>>
>>> Even if the acpi battery where to function fine (which on systems
>>> where we have a native pmic driver it often doesn't) we still do not
>>> want to export the same battery to userspace twice.
>>>
>>> This commit adds an acpi_battery_unregister() function which native
>>> pmic drivers can call to tell the acpi-battery driver to unregister
>>> itself so that we do not end up with 2 power_supply-s for the same
>>> battery device.
>>
>> I'm not sure if this is a good idea:
>> Driver A calls Driver B's unregister function in case Driver A should be unware of the existence of Driver B.
>>
>> For example, acpi_video_unregister() is such a bad practice.
>
> acpi_video_unregister() although not pretty is very much necessary
> actually the whole backlight sysfs interface were we do sometimes
> register multiple sysfs backlight class devices for a single
> backlight and let userspace figure things out is a prime
> example of why we need this, we need to export only one
> interface and in case of the power_supply interface doing
> anything else would be an ABI break.
>
> Note that in this case things are actually much better then
> the acpi_video stuff, since we've a very clear place when to
> do the unregister (in the native x86 only drivers) rather then
> needing some magic heuristics.
>
>> Do we have any other choices?
>
> We could alternatively have the ACPI battery and ac drivers
> contain a black list of ACPI HIDs which they check and when
> these are in the DSDT and enabled/present have their probe
> methods return -ENODEV.
>
> I dismissed this at first, but on second thought that should
> work.

Ah scrap that I remember again why this will not work, the
problem is that Intel re-uses HIDs between generations and
for the Whiskey Cove PMIC we want to not use the ACPI battery
and ac drivers on Cherry Trail (where they are known to be
broken) but things are different on Apollo Lake. Yet both
use the same HID for their companion Whiskey Cove PMIC even
though they are 2 completely different revisions of the PMIC
(e.g. one uses i2c the other does not).

The 2 native drivers have code to detect which revision they
are dealing with and exit with -ENODEV if it is not the
revision they were written for, but this means that simple
HID blacklisting will not work. So IMHO the decision to
unregister the  ACPI battery / ac interface really belongs
in the native driver as that has all the nitty gritty detail
needed to make that decision.

So I really believe we should move forward with this
patch set as-is.

Regards,

Hans
