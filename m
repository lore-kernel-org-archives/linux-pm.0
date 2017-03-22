From: Liam Breck <liam@networkimprov.net>
Subject: Re: [PATCH v1 7/7] power: bq24190_charger: Set bq24190-battery device .type=unknown
Date: Wed, 22 Mar 2017 06:22:22 -0700
Message-ID: <CAKvHMgT9=dWXXC66LarBVb-8c4BhOouZAqmAMsV3Sv9tTnmWsg@mail.gmail.com>
References: <20170321220921.5834-1-liam@networkimprov.net> <20170321220921.5834-8-liam@networkimprov.net>
 <7e117a52-bbf0-2a12-e98f-843da227e0c7@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-io0-f193.google.com ([209.85.223.193]:35852 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1759683AbdCVNWY (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 22 Mar 2017 09:22:24 -0400
Received: by mail-io0-f193.google.com with SMTP id 68so10208331ioh.3
        for <linux-pm@vger.kernel.org>; Wed, 22 Mar 2017 06:22:23 -0700 (PDT)
In-Reply-To: <7e117a52-bbf0-2a12-e98f-843da227e0c7@redhat.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Sebastian Reichel <sre@kernel.org>, Tony Lindgren <tony@atomide.com>, linux-pm@vger.kernel.org

Hi, thanks for reviews and comments on sysfs issue.

On Wed, Mar 22, 2017 at 5:25 AM, Hans de Goede <hdegoede@redhat.com> wrote:
> Hi,
>
> On 21-03-17 23:09, Liam Breck wrote:
>>
>> From: Liam Breck <kernel@networkimprov.net>
>>
>> Not for upstream. Temporary workaround to prevent bq24190-battery device
>> from interfering with a fuel gauge that has
>> .type=power_supply_type_battery
>>
>> I'll move properties from -battery device to -charger in a subsequent
>> version.
>>
>> Cc: Hans de Goede <hdegoede@redhat.com>
>
>
> Hmm, I don't like this. I was about to post v2 of my patches (which I will
> rebase on top of this series), which contains a patch to completely remove
> the battery power_supply. I understand if you think it is too early for
> that, but I believe that if we (temporarily) want to keep it around,
> it would be better to do something like this:

I need most of the properties in -battery; I am working on moving them
into -charger. It's not a trivial cut/paste but should be done by v2
next week.

This patch should clear the way for you to implement your battery
device, without touching the -battery code. That way I can run your
patches in my environment. Don't worry, it's not going upstream. I
didn't even include signed-off-by :-)

BTW I think we can just remove bdi->model; it's not used. However
let's not claim to support any chip we haven't actually tested, so in
hw_init()...

if (v != BQ24190_REG_VPRS_PN_24190 &&
    v != BQ24190_REG_VPRS_PN_yours)
        return -ENODEV;

>     /*
>      * Note the disable-battery-power-supply property is purely an in
>      * kernel interface to avoid having 2 battery type power_supplies for
>      * a single physical battery when there also is a fuel-gauge driver.
>      * The plan is to remove the battery power_supply from the bq24190
>      * driver completely, but that still needs some work.
>      * Do NOT use this property in DT files.
>      */
>     if (!device_property_read_bool(dev, "disable-battery-power-supply")) {
>         register(battery)...
>     }
>
> Sebastian would something like the above work for you as an interim
> solution ? Since this uses device-properties I can easily add the
> property to my i2c_board_info, and when the battery power_supply gets
> removed all together the board_info can be updated independently of
> the power_supply driver, so we can easily clean this up afterwards.

Would make sense if req'd upstream, but I don't think it will be.

> Regards,
>
> Hans
>
>
>
>> ---
>>  drivers/power/supply/bq24190_charger.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/power/supply/bq24190_charger.c
>> b/drivers/power/supply/bq24190_charger.c
>> index a52816b..12f3780 100644
>> --- a/drivers/power/supply/bq24190_charger.c
>> +++ b/drivers/power/supply/bq24190_charger.c
>> @@ -1228,7 +1228,7 @@ static enum power_supply_property
>> bq24190_battery_properties[] = {
>>
>>  static const struct power_supply_desc bq24190_battery_desc = {
>>         .name                   = "bq24190-battery",
>> -       .type                   = POWER_SUPPLY_TYPE_BATTERY,
>> +       .type                   = POWER_SUPPLY_TYPE_UNKNOWN,
>>         .properties             = bq24190_battery_properties,
>>         .num_properties         = ARRAY_SIZE(bq24190_battery_properties),
>>         .get_property           = bq24190_battery_get_property,
>>
>
