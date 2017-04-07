From: Liam Breck <liam@networkimprov.net>
Subject: Re: [PATCH v4 4/4] power: bq24190_charger: Delay before polling reset flag
Date: Fri, 7 Apr 2017 14:46:44 -0700
Message-ID: <CAKvHMgSY++54vuG9rAE=+fP1kPdMs9imGtQDY_HB5FhQQyoD-Q@mail.gmail.com>
References: <20170406031048.12401-1-liam@networkimprov.net>
 <20170406031048.12401-5-liam@networkimprov.net> <3a514e1e-8ad0-4951-c675-10c2e7de37ec@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-io0-f193.google.com ([209.85.223.193]:36035 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751170AbdDGVqq (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 7 Apr 2017 17:46:46 -0400
Received: by mail-io0-f193.google.com with SMTP id 68so8708339ioh.3
        for <linux-pm@vger.kernel.org>; Fri, 07 Apr 2017 14:46:45 -0700 (PDT)
In-Reply-To: <3a514e1e-8ad0-4951-c675-10c2e7de37ec@redhat.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Liam Breck <kernel@networkimprov.net>

Hi Hans,

On Thu, Apr 6, 2017 at 12:20 AM, Hans de Goede <hdegoede@redhat.com> wrote:
> Hi,
>
> On 06-04-17 05:10, Liam Breck wrote:
>>
>> From: Liam Breck <kernel@networkimprov.net>
>>
>> On chip reset, polling loop was reading reset register immediately.
>> Instead, call udelay() before reading chip register.
>
>
> Can you extend the commit message to explain why udelay is being
> called ?  IOW what is the problem with reading the register
> immediately which this patch addresses ?

I thought I'd read that reset isn't instantaneous, but in testing it
seems to be. So I will revert to the original post-reset delay, and
change udelay() to usleep_range(10, 20). Any thoughts on those
numbers?



>
>
>
>
>>
>> Cc: Tony Lindgren <tony@atomide.com>
>> Cc: Hans de Goede <hdegoede@redhat.com>
>> Signed-off-by: Liam Breck <kernel@networkimprov.net>
>> ---
>>  drivers/power/supply/bq24190_charger.c | 8 ++------
>>  1 file changed, 2 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/power/supply/bq24190_charger.c
>> b/drivers/power/supply/bq24190_charger.c
>> index fa29cb3..71a796e 100644
>> --- a/drivers/power/supply/bq24190_charger.c
>> +++ b/drivers/power/supply/bq24190_charger.c
>> @@ -543,18 +543,14 @@ static int bq24190_register_reset(struct
>> bq24190_dev_info *bdi)
>>
>>         /* Reset bit will be cleared by hardware so poll until it is */
>>         do {
>> +               udelay(10);
>>                 ret = bq24190_read_mask(bdi, BQ24190_REG_POC,
>>                                 BQ24190_REG_POC_RESET_MASK,
>>                                 BQ24190_REG_POC_RESET_SHIFT,
>>                                 &v);
>>                 if (ret < 0)
>>                         return ret;
>> -
>> -               if (!v)
>> -                       break;
>> -
>> -               udelay(10);
>> -       } while (--limit);
>> +       } while (v && --limit);
>>
>>         if (!limit)
>>                 return -EIO;
>>
>
