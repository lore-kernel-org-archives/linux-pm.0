From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH v4 4/4] power: bq24190_charger: Delay before polling reset
 flag
Date: Sat, 8 Apr 2017 11:58:17 +0200
Message-ID: <0ce727cf-7871-89a8-7bec-7915f2699a73@redhat.com>
References: <20170406031048.12401-1-liam@networkimprov.net>
 <20170406031048.12401-5-liam@networkimprov.net>
 <3a514e1e-8ad0-4951-c675-10c2e7de37ec@redhat.com>
 <CAKvHMgSY++54vuG9rAE=+fP1kPdMs9imGtQDY_HB5FhQQyoD-Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:42430 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751569AbdDHJ6T (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sat, 8 Apr 2017 05:58:19 -0400
In-Reply-To: <CAKvHMgSY++54vuG9rAE=+fP1kPdMs9imGtQDY_HB5FhQQyoD-Q@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Liam Breck <liam@networkimprov.net>
Cc: Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Liam Breck <kernel@networkimprov.net>

Hi,

On 07-04-17 23:46, Liam Breck wrote:
> Hi Hans,
>
> On Thu, Apr 6, 2017 at 12:20 AM, Hans de Goede <hdegoede@redhat.com> wrote:
>> Hi,
>>
>> On 06-04-17 05:10, Liam Breck wrote:
>>>
>>> From: Liam Breck <kernel@networkimprov.net>
>>>
>>> On chip reset, polling loop was reading reset register immediately.
>>> Instead, call udelay() before reading chip register.
>>
>>
>> Can you extend the commit message to explain why udelay is being
>> called ?  IOW what is the problem with reading the register
>> immediately which this patch addresses ?
>
> I thought I'd read that reset isn't instantaneous, but in testing it
> seems to be. So I will revert to the original post-reset delay, and
> change udelay() to usleep_range(10, 20). Any thoughts on those
> numbers?

Using usleep makes no sense for such short delays, so I would stick
with udelay.

More importantly you still have not explained why we need to delay
*at all* esp. such a short delay, 10us is a single bit at 100kHz i2c
so the set bq24190 register-pointer part of the i2c transfer which
happens before reading back the reset-bit alone takes 20 times as
long as the delay.

I still don't understand why a delay is needed at all, what are
you trying to achieve with this delay ? Are you seeing a specific
problem you are trying to fix ?

Regards,

Hans





>
>
>
>>
>>
>>
>>
>>>
>>> Cc: Tony Lindgren <tony@atomide.com>
>>> Cc: Hans de Goede <hdegoede@redhat.com>
>>> Signed-off-by: Liam Breck <kernel@networkimprov.net>
>>> ---
>>>  drivers/power/supply/bq24190_charger.c | 8 ++------
>>>  1 file changed, 2 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/drivers/power/supply/bq24190_charger.c
>>> b/drivers/power/supply/bq24190_charger.c
>>> index fa29cb3..71a796e 100644
>>> --- a/drivers/power/supply/bq24190_charger.c
>>> +++ b/drivers/power/supply/bq24190_charger.c
>>> @@ -543,18 +543,14 @@ static int bq24190_register_reset(struct
>>> bq24190_dev_info *bdi)
>>>
>>>         /* Reset bit will be cleared by hardware so poll until it is */
>>>         do {
>>> +               udelay(10);
>>>                 ret = bq24190_read_mask(bdi, BQ24190_REG_POC,
>>>                                 BQ24190_REG_POC_RESET_MASK,
>>>                                 BQ24190_REG_POC_RESET_SHIFT,
>>>                                 &v);
>>>                 if (ret < 0)
>>>                         return ret;
>>> -
>>> -               if (!v)
>>> -                       break;
>>> -
>>> -               udelay(10);
>>> -       } while (--limit);
>>> +       } while (v && --limit);
>>>
>>>         if (!limit)
>>>                 return -EIO;
>>>
>>
