From: Matt Ranostay <matt@ranostay.consulting>
Subject: Re: [PATCH v2 3/3] power: bq27xxx: add support for NVRAM R/W access
Date: Thu, 5 Jan 2017 19:23:48 -0800
Message-ID: <CAJ_EiSQjRn=rot7Zu+oB80DruN0qexd+3_PxjXS6_JaF7CY1Bw@mail.gmail.com>
References: <20170105021007.22088-1-matt@ranostay.consulting>
 <20170105021007.22088-4-matt@ranostay.consulting> <20170106015314.7qju6eodkwldty6h@earth>
 <CAJ_EiSTVv90QSB6TY7+5KXWPbLkkr5vEXpDQrQ0VCvtAkddt5A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qk0-f174.google.com ([209.85.220.174]:34575 "EHLO
        mail-qk0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754330AbdAFDXt (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 5 Jan 2017 22:23:49 -0500
Received: by mail-qk0-f174.google.com with SMTP id a20so64225969qkc.1
        for <linux-pm@vger.kernel.org>; Thu, 05 Jan 2017 19:23:49 -0800 (PST)
In-Reply-To: <CAJ_EiSTVv90QSB6TY7+5KXWPbLkkr5vEXpDQrQ0VCvtAkddt5A@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: Tony Lindgren <tony@atomide.com>, devicetree@vger.kernel.org, linux-pm@vger.kernel.org

On Thu, Jan 5, 2017 at 6:34 PM, Matt Ranostay <matt@ranostay.consulting> wr=
ote:
> On Thu, Jan 5, 2017 at 5:53 PM, Sebastian Reichel <sre@kernel.org> wrote:
>> On Wed, Jan 04, 2017 at 06:10:07PM -0800, Matt Ranostay wrote:
>>> Initial support for access and modification of the non-volatile regions
>>> of the bq27425 fuel gauge DesignEnergy, DesignCapacity, and
>>> TerminateVoltage settings.
>>>
>>> This is intended for fine tuning the fuel gauge state machine for the
>>> respective battery specifications.
>>>
>>> Cc: Sebastian Reichel <sre@kernel.org>
>>> Signed-off-by: Matt Ranostay <matt@ranostay.consulting>
>>> ---
>>>  drivers/power/supply/bq27xxx_battery_i2c.c | 335 +++++++++++++++++++++=
++++++++
>>>  include/linux/power/bq27xxx_battery.h      |   4 +
>>>  2 files changed, 339 insertions(+)
>>
>> I only skipped over this one, as the changed DT binding requires
>> quite some changes in this patch anyways. Here are a couple of
>> comments how I would like to see this implemented:
>>
>> Add a patch for the power-supply core, which implements a
>> structure for the battery info. Something like this:
>>
>> struct power_supply_battery_info {
>>     uint32 energy; /* =C2=B5Wh */
>>     uint32 power;  /* =C2=B5Ah */
>>     uint32 nominal_voltage; /* =C2=B5V */
>>     /* ... */
>> };
>>
>> And a function in the core framework, which gets the information
>> from DT. The function itself should *not* be DT specific, so that
>> ACPI/platformdata/whatever support can be added later without
>> modifying every single driver.
>>
>> static struct power_supply_battery_info*
>> power_supply_get_battery_info(struct power_supply *psy) {
>>     if (psy->dt) {
>>         /* get battery phandle or return -ENXIO */
>>         /* fill and return struct */
>>     }
>>
>>     return -ENOTSUP;
>> }
>>
>> Then call power_supply_get_battery_info() during bq27xxx probe and
>> use the struct to initialize the registers. Also I expect that
>> functionality in bq27xxx_battery.c instead of bq27xxx_battery_i2c.c,
>> since it's not I=C2=B2C specific.
>
> They may not be i2c specific but they are only used by the i2c path of
> the code currently. Do you think that platform data would ever have a
> struct to pass with the respective data?
>
> Also it would have to be in bq27xxx_battery_setup() and not
> bq27xxx_battery_platform_probe() since the former is only thing called
> by both code paths.

Also there is no bq27xxx_battery_platform_write to even write the
configuration data.

>
>
>>
>> -- Sebastian
