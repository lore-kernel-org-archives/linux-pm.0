From: Liam Breck <liam@networkimprov.net>
Subject: Re: [PATCH v2 5/7] power: supply: bq24190_charger: Don't spam the
 logs on charger plug / unplug
Date: Thu, 23 Mar 2017 15:24:15 -0700
Message-ID: <CAKvHMgQP_hZCt+-U85MCJfjoxf6muKrks2V+B52JQx8WCWcqyw@mail.gmail.com>
References: <20170322145536.30570-1-hdegoede@redhat.com> <20170322145536.30570-6-hdegoede@redhat.com>
 <CAKvHMgQdccLPDz2HyxopdDgQxk+6DMtBrvFxKD--wxLPfe5DQQ@mail.gmail.com> <07ee304f-f86d-ae79-8bda-9f0538db11c7@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-it0-f66.google.com ([209.85.214.66]:35360 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750952AbdCWWYR (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 23 Mar 2017 18:24:17 -0400
Received: by mail-it0-f66.google.com with SMTP id y18so24111itc.2
        for <linux-pm@vger.kernel.org>; Thu, 23 Mar 2017 15:24:16 -0700 (PDT)
In-Reply-To: <07ee304f-f86d-ae79-8bda-9f0538db11c7@redhat.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Sebastian Reichel <sre@kernel.org>, Takashi Iwai <tiwai@suse.de>, linux-pm@vger.kernel.org, Liam Breck <kernel@networkimprov.net>, Tony Lindgren <tony@atomide.com>

On Thu, Mar 23, 2017 at 3:02 PM, Hans de Goede <hdegoede@redhat.com> wrote:
> Hi,
>
>
> On 23-03-17 22:31, Liam Breck wrote:
>>
>> On Wed, Mar 22, 2017 at 7:55 AM, Hans de Goede <hdegoede@redhat.com>
>> wrote:
>>>
>>> If the charger gets unplugged before the battery is fully charged we will
>>> get a one time Input fault. Ignore this rather then logging a message for
>>> it. Likewise on the next interrupt after the one time Input fault all
>>> fault flags will be 0, do not log a message when there are no faults.
>>>
>>> This fixes messages like these getting logged on charger unplug + replug:
>>> bq24190-charger 15-006b: Fault: boost 0, charge 1, battery 0, ntc 0
>>> bq24190-charger 15-006b: Fault: boost 0, charge 0, battery 0, ntc 0
>>>
>>> Cc: Liam Breck <kernel@networkimprov.net>
>>> Cc: Tony Lindgren <tony@atomide.com>
>>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>>> ---
>>> Changes in v2:
>>> -This is a new patch in v2 of this patch-set
>>> ---
>>>  drivers/power/supply/bq24190_charger.c | 17 +++++++++++------
>>>  1 file changed, 11 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/drivers/power/supply/bq24190_charger.c
>>> b/drivers/power/supply/bq24190_charger.c
>>> index b535f24..351e020 100644
>>> --- a/drivers/power/supply/bq24190_charger.c
>>> +++ b/drivers/power/supply/bq24190_charger.c
>>> @@ -1189,12 +1189,17 @@ static void bq24190_check_status(struct
>>> bq24190_dev_info *bdi)
>>>         } while (f_reg && ++i < 2);
>>>
>>>         if (f_reg != bdi->f_reg) {
>>> -               dev_info(bdi->dev,
>>> -                       "Fault: boost %d, charge %d, battery %d, ntc
>>> %d\n",
>>> -                       !!(f_reg & BQ24190_REG_F_BOOST_FAULT_MASK),
>>> -                       !!(f_reg & BQ24190_REG_F_CHRG_FAULT_MASK),
>>> -                       !!(f_reg & BQ24190_REG_F_BAT_FAULT_MASK),
>>> -                       !!(f_reg & BQ24190_REG_F_NTC_FAULT_MASK));
>>> +               /*
>>> +                * Don't spam the logs if all faults are cleared, or when
>>> the
>>> +                * cable providing Vbus gets unplugged.
>>> +                */
>>> +               if  (f_reg && f_reg != (1 <<
>>> BQ24190_REG_F_CHRG_FAULT_SHIFT))
>>
>>
>> if (f_reg && ((ss_reg & BQ24190_REG_SS_PG_STAT_MASK) ||
>>     f_reg != (1 << BQ24190_REG_F_CHRG_FAULT_SHIFT)) )
>
>
> Sebastian has already merged the original patch into his for-next branch,
> please
> provide a patch on top.

I recall Sebastian merging and then dropping a commit from the other
series I'm working on.

I'll return to the charger once the dependency for my charger patchset
is merged. I just got a big change request for that.


>>> +                       dev_info(bdi->dev,

This should probably be dev_warn now.

>>> +                               "Fault: boost %d, charge %d, battery %d,
>>> ntc %d\n",
>>> +                               !!(f_reg &
>>> BQ24190_REG_F_BOOST_FAULT_MASK),
>>> +                               !!(f_reg &
>>> BQ24190_REG_F_CHRG_FAULT_MASK),
>>> +                               !!(f_reg & BQ24190_REG_F_BAT_FAULT_MASK),
>>> +                               !!(f_reg &
>>> BQ24190_REG_F_NTC_FAULT_MASK));
>>>
>>>                 mutex_lock(&bdi->f_reg_lock);
>>>                 if ((bdi->f_reg & battery_mask_f) != (f_reg &
>>> battery_mask_f))
>>> --
>>> 2.9.3
>>>
>
