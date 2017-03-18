From: Liam Breck <liam@networkimprov.net>
Subject: Re: [09/15] power: supply: bq24190_charger: Add voltage_max_design
 prop to battery
Date: Sat, 18 Mar 2017 12:34:34 -0700
Message-ID: <CAKvHMgQEqa1aTZQs-34R_207UTDp5s3YHPbyxeQoAA4oMCgokg@mail.gmail.com>
References: <20170318071019.4561-6-liam@networkimprov.net> <6c675434-4ac1-2cd4-c4e3-7edf7a3b5af5@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-it0-f65.google.com ([209.85.214.65]:34542 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751708AbdCRTeg (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 18 Mar 2017 15:34:36 -0400
Received: by mail-it0-f65.google.com with SMTP id r141so10071331ita.1
        for <linux-pm@vger.kernel.org>; Sat, 18 Mar 2017 12:34:35 -0700 (PDT)
In-Reply-To: <6c675434-4ac1-2cd4-c4e3-7edf7a3b5af5@redhat.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Sebastian Reichel <sre@kernel.org>, Tony Lindgren <tony@atomide.com>, linux-pm@vger.kernel.org

On Sat, Mar 18, 2017 at 7:34 AM, Hans de Goede <hdegoede@redhat.com> wrote:
> Hi,
>
> On 18-03-17 08:10, Liam Breck wrote:
>>
>> On Fri, 17 Mar 2017 10:55:21 +0100, Hans de Goede wrote:
>>
>>> When combined with an external fuel-gauge, upower needs
>>> voltage_max_design
>>> as it internally does all its calculations in Watts and converts the
>>> charge_foo properties from A to Watts by using voltage_max_design.
>>
>>
>> This is a battery characteristic which should be obtained from the fuel
>> gauge (e.g. V at charge
>> termination)
>
>
> V at charge termination is *exactly* what bq24190_charger_get_voltage()
> returns. And the fuel-gauge only measures charging it does not control
> it, so unless we had some nvram to store things in over time the fg
> driver cannot no what "V at charge termination" will be, where as the
> bq24190_charger code actually knows as it controls at which voltage
> the charger switches from constant current to constant voltage mode.
>
>> or external battery config.
>>
>> See also https://patchwork.kernel.org/patch/9626487/
>
>
> There is no external battery config on x86.

ACPI? The battery data/config should really be used to set the charger
register in question.

charger/voltage_max already has this. Can you find a way to use that?

> Regards,
>
> Hans
>
>
>>
>>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>>> ---
>>>  drivers/power/supply/bq24190_charger.c | 10 +++++++++-
>>>  1 file changed, 9 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/power/supply/bq24190_charger.c
>>> b/drivers/power/supply/bq24190_charger.c
>>> index 9fe69a5..82cb33d 100644
>>> --- a/drivers/power/supply/bq24190_charger.c
>>> +++ b/drivers/power/supply/bq24190_charger.c
>>> @@ -1103,6 +1103,13 @@ static int bq24190_battery_get_property(struct
>>> power_supply *psy,
>>>                 val->intval = POWER_SUPPLY_TECHNOLOGY_UNKNOWN;
>>>                 ret = 0;
>>>                 break;
>>> +       case POWER_SUPPLY_PROP_VOLTAGE_MAX_DESIGN:
>>> +               /*
>>> +                * Report charger configured voltage as max design
>>> voltage,
>>> +                * not entirely correct, but userspace needs something
>>> here.
>>> +                */
>>> +               ret = bq24190_charger_get_voltage(bdi, val);
>>> +               break;
>>>         case POWER_SUPPLY_PROP_TEMP_ALERT_MAX:
>>>                 ret = bq24190_battery_get_temp_alert_max(bdi, val);
>>>                 break;
>>> @@ -1169,6 +1176,7 @@ static enum power_supply_property
>>> bq24190_battery_properties[] = {
>>>         POWER_SUPPLY_PROP_HEALTH,
>>>         POWER_SUPPLY_PROP_ONLINE,
>>>         POWER_SUPPLY_PROP_TECHNOLOGY,
>>> +       POWER_SUPPLY_PROP_VOLTAGE_MAX_DESIGN,
>>>         POWER_SUPPLY_PROP_TEMP_ALERT_MAX,
>>>         POWER_SUPPLY_PROP_SCOPE,
>>>         /* Begin of extended battery properties */
>>> @@ -1186,7 +1194,7 @@ static const struct power_supply_desc
>>> bq24190_battery_desc = {
>>>         .name                   = "bq24190-battery",
>>>         .type                   = POWER_SUPPLY_TYPE_BATTERY,
>>>         .properties             = bq24190_battery_properties,
>>> -       .num_properties         = 6,
>>> +       .num_properties         = 7,
>>>         .get_property           = bq24190_battery_get_property,
>>>         .set_property           = bq24190_battery_set_property,
>>>         .property_is_writeable  = bq24190_battery_property_is_writeable,
