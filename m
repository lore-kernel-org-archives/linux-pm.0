From: Liam Breck <liam@networkimprov.net>
Subject: Re: [PATCH v2 5/6] power: bq24190_charger: Don't read fault register
 outside irq_handle_thread()
Date: Mon, 16 Jan 2017 12:25:41 -0800
Message-ID: <CAKvHMgQC2im2HoN0RLnqa1-_7voAPhNy_1E-XeqkbA-idXv6uA@mail.gmail.com>
References: <CAKvHMgQgEEhmbVgTHk6VuQB=tbN+nZV5F=if1_2CzVKb5TpYnA@mail.gmail.com>
 <20170116185404.GF27262@animalcreek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-it0-f65.google.com ([209.85.214.65]:35765 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750834AbdAPU03 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 16 Jan 2017 15:26:29 -0500
Received: by mail-it0-f65.google.com with SMTP id 203so13431192ith.2
        for <linux-pm@vger.kernel.org>; Mon, 16 Jan 2017 12:25:42 -0800 (PST)
In-Reply-To: <20170116185404.GF27262@animalcreek.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Mark Greer <mgreer@animalcreek.com>
Cc: linux-pm@vger.kernel.org, Sebastian Reichel <sre@kernel.org>, Tony Lindgren <tony@atomide.com>, Liam Breck <kernel@networkimprov.net>, Matt Ranostay <matt@ranostay.consulting>

On Mon, Jan 16, 2017 at 10:54 AM, Mark Greer <mgreer@animalcreek.com> wrote:
> On Sun, Jan 15, 2017 at 10:08:25PM -0800, Liam Breck wrote:
>>
>
>> Caching the fault register after a single I2C read may not keep an accurate
>> value.
>>
>> Fix by doing two reads in irq_handle_thread() and using the cached value
>> elsewhere. If a safety timer fault later clears itself, we apparently don't get
>> an interrupt (INT), however other interrupts would refresh the register cache.
>>
>> From the data sheet: "When a fault occurs, the charger device sends out INT
>>  and keeps the fault state in REG09 until the host reads the fault register.
>>  Before the host reads REG09 and all the faults are cleared, the charger
>>  device would not send any INT upon new faults. In order to read the
>>  current fault status, the host has to read REG09 two times consecutively.
>>  The 1st reads fault register status from the last read [1] and the 2nd reads
>>  the current fault register status."
>>
>> [1] presumably a typo; should be "last fault"
>>
>> Fixes: d7bf353fd0aa3 ("bq24190_charger: Add support for TI BQ24190 Battery Charger")
>> Cc: Mark A. Greer <mgreer@animalcreek.com>
>> Cc: Tony Lindgren <tony@atomide.com>
>> Cc: Matt Ranostay <matt@ranostay.consulting>
>> Signed-off-by: Liam Breck <kernel@networkimprov.net>
>> ---
>>  drivers/power/supply/bq24190_charger.c | 93 ++++++++++------------------------
>>  1 file changed, 26 insertions(+), 67 deletions(-)
>>
>> diff --git a/drivers/power/supply/bq24190_charger.c b/drivers/power/supply/bq24190_charger.c
>> index ba5a5b2..a36788c 100644
>> --- a/drivers/power/supply/bq24190_charger.c
>> +++ b/drivers/power/supply/bq24190_charger.c
>
>> @@ -1231,33 +1195,34 @@ static irqreturn_t bq24190_irq_handler_thread(int irq, void *data)
>>                       alert_battery = true;
>>               if ((bdi->ss_reg & ~battery_mask_ss) != (ss_reg & ~battery_mask_ss))
>>                       alert_charger = true;
>> -
>
> This whitespace change has nothing to do with the purpose of the patch.
> Plus I don't agree with it.  :)
>
>>               bdi->ss_reg = ss_reg;
>>       }
>>
>> -     mutex_lock(&bdi->f_reg_lock);
>> -
>> -     ret = bq24190_read(bdi, BQ24190_REG_F, &f_reg);
>> -     if (ret < 0) {
>> -             mutex_unlock(&bdi->f_reg_lock);
>> -             dev_err(bdi->dev, "Can't read F reg: %d\n", ret);
>> -             goto out;
>> -     }
>> +     i = 0;
>> +     do {
>> +             ret = bq24190_read(bdi, BQ24190_REG_F, &f_reg);
>> +             if (ret < 0) {
>> +                     dev_err(bdi->dev, "Can't read F reg: %d\n", ret);
>> +                     goto out;
>> +             }
>> +     } while (f_reg && ++i < 2);
>>
>>       if (f_reg != bdi->f_reg) {
>> +             dev_info(bdi->dev, "Fault: boost %d, charge %d, battery %d, ntc %d\n",
>
> Please break the line above into two after the first comma.

Will do. I wish the kernel crowd counted a tab as one char :-p

>> +                     !!(f_reg & BQ24190_REG_F_BOOST_FAULT_MASK),
>> +                     !!(f_reg & BQ24190_REG_F_CHRG_FAULT_MASK),
>> +                     !!(f_reg & BQ24190_REG_F_BAT_FAULT_MASK),
>> +                     !!(f_reg & BQ24190_REG_F_NTC_FAULT_MASK));
>
> Other than nits, this looks good so you can add my acked-by once they're fixed.
>
> Acked-by: Mark Greer <mgreer@animalcreek.com>
