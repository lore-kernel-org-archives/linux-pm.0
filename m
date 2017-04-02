From: Liam Breck <liam@networkimprov.net>
Subject: Re: [PATCH v3 4/4] power: bq24190_charger: Delay before polling reset flag
Date: Sun, 2 Apr 2017 13:16:59 -0700
Message-ID: <CAKvHMgSq5LAo7294p4X4EuzzBii9yB5pgajW7HJtuw-X7MehUw@mail.gmail.com>
References: <20170401202519.16280-1-liam@networkimprov.net>
 <20170401202519.16280-5-liam@networkimprov.net> <66a0a8ca-16e2-ecbb-a5c3-73ef94d869c7@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-io0-f194.google.com ([209.85.223.194]:33354 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751240AbdDBURA (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 2 Apr 2017 16:17:00 -0400
Received: by mail-io0-f194.google.com with SMTP id f84so10386611ioj.0
        for <linux-pm@vger.kernel.org>; Sun, 02 Apr 2017 13:17:00 -0700 (PDT)
In-Reply-To: <66a0a8ca-16e2-ecbb-a5c3-73ef94d869c7@redhat.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Liam Breck <kernel@networkimprov.net>

On Sun, Apr 2, 2017 at 5:29 AM, Hans de Goede <hdegoede@redhat.com> wrote:
> Hi,
>
> On 01-04-17 22:25, Liam Breck wrote:
>>
>> From: Liam Breck <kernel@networkimprov.net>
>>
>> On chip reset, polling loop was reading reset register immediately.
>> Instead, call udelay() before reading chip register.
>
>
> Why ? What does this buy us ?
>
> Also I've yet to hear back from you on my patch to remove doing
> resets of the device altogether have you find any bad side-effects
> of that patch in your testing ?

On a DT-configured device, we don't want any charger settings done
prior to probe(), as we are going to apply DT values. So
register_reset() on probe seems right. If that can trigger a charger
bug, we should find a way to make the charger recover.

I will test for the possible bug you described when I have a chance;
I'm occupied with other stuff near-future. For the time being, let's
use the no_register_reset property from your first patchset.


> If not I would like us to proceed with simply removing the reset
> code as my patch does.
>
> Regards,
>
> Hans
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
>> index 52389c5..898faed 100644
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
