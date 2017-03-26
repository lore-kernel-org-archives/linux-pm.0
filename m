From: Liam Breck <liam@networkimprov.net>
Subject: Re: [PATCH v2] power: bq24190_charger: Limit over/under voltage fault logging
Date: Sun, 26 Mar 2017 03:56:08 -0700
Message-ID: <CAKvHMgQOv=0cYJj6_0QgP9ApKwaxiJWvOwWfShFhBVGQtvpJQg@mail.gmail.com>
References: <20170325112419.25120-1-liam@networkimprov.net> <be76b89a-7d18-096a-b22c-53101ba43cfc@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-it0-f68.google.com ([209.85.214.68]:34913 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751264AbdCZK4K (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 26 Mar 2017 06:56:10 -0400
Received: by mail-it0-f68.google.com with SMTP id y18so6106497itc.2
        for <linux-pm@vger.kernel.org>; Sun, 26 Mar 2017 03:56:09 -0700 (PDT)
In-Reply-To: <be76b89a-7d18-096a-b22c-53101ba43cfc@redhat.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Liam Breck <kernel@networkimprov.net>

On Sun, Mar 26, 2017 at 1:44 AM, Hans de Goede <hdegoede@redhat.com> wrote:
> Hi,
>
>
> On 25-03-17 12:24, Liam Breck wrote:
>>
>> From: Liam Breck <kernel@networkimprov.net>
>>
>> If the charger is unplugged before the battery is full we may
>> see an over/under voltage fault. Ignore this rather then emitting
>> a message or uevent.
>>
>> This fixes messages like these getting logged on charger unplug + replug:
>> bq24190-charger 15-006b: Fault: boost 0, charge 1, battery 0, ntc 0
>> bq24190-charger 15-006b: Fault: boost 0, charge 0, battery 0, ntc 0
>>
>> Cc: Tony Lindgren <tony@atomide.com>
>> Cc: Hans de Goede <hdegoede@redhat.com>
>> Signed-off-by: Liam Breck <kernel@networkimprov.net>
>> ---
>> v2: Don't hide clearance of other more urgent faults, or produce
>>     a uevent for this superficial fault.
>>
>>  drivers/power/supply/bq24190_charger.c | 7 ++++++-
>>  1 file changed, 6 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/power/supply/bq24190_charger.c
>> b/drivers/power/supply/bq24190_charger.c
>> index 897491d..de1c54f 100644
>> --- a/drivers/power/supply/bq24190_charger.c
>> +++ b/drivers/power/supply/bq24190_charger.c
>> @@ -1256,8 +1256,13 @@ static void bq24190_check_status(struct
>> bq24190_dev_info *bdi)
>>                 }
>>         } while (f_reg && ++i < 2);
>>
>> +       /* ignore over/under voltage fault after disconnect */
>> +       if (f_reg == (1 << BQ24190_REG_F_CHRG_FAULT_SHIFT) &&
>> +           !(ss_reg & BQ24190_REG_SS_PG_STAT_MASK))
>> +               f_reg = 0;
>> +
>>         if (f_reg != bdi->f_reg) {
>> -               dev_info(bdi->dev,
>> +               dev_warn(bdi->dev,
>>                         "Fault: boost %d, charge %d, battery %d, ntc
>> %d\n",
>>                         !!(f_reg & BQ24190_REG_F_BOOST_FAULT_MASK),
>>                         !!(f_reg & BQ24190_REG_F_CHRG_FAULT_MASK),
>>
>
> You're now once again logging a warning when all faults clear,

By design; I want to know when any serious fault clears.

The under-voltage fault on disconnect will not trigger a cleared msg,
because the orig error is not recorded in bdi->f_reg.

> I believe this should now be:
>
>                 if (freg)
>                         dev_warn(bdi->dev,
>                                 "Fault: boost %d, charge %d, battery %d, ntc
> %d\n",
>                                 !!(f_reg & BQ24190_REG_F_BOOST_FAULT_MASK),
>                                 !!(f_reg & BQ24190_REG_F_CHRG_FAULT_MASK),
>
> Regards,
>
> Hans
>
>
>
