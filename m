From: Liam Breck <liam@networkimprov.net>
Subject: Re: [PATCH v11 07/10] power: bq27xxx_battery: Keep track of specific
 chip id
Date: Thu, 23 Mar 2017 14:44:58 -0700
Message-ID: <CAKvHMgR=bcw2kO_8QLQfyAm241Ynk2woMw81pPnVGUDCu7vMBA@mail.gmail.com>
References: <20170320094335.19224-1-liam@networkimprov.net>
 <20170320094335.19224-8-liam@networkimprov.net> <20170323102825.vvxfzvuvvnhyzlna@earth>
 <CAKvHMgQsuTNcGUXZL7qk_YZ+qcdcLJ1+1xPB0zP97DqiitHJXA@mail.gmail.com> <f8e49417-ea2a-3486-26c2-63eb3306990a@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-io0-f196.google.com ([209.85.223.196]:33785 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751837AbdCWVpA (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 23 Mar 2017 17:45:00 -0400
Received: by mail-io0-f196.google.com with SMTP id f84so965024ioj.0
        for <linux-pm@vger.kernel.org>; Thu, 23 Mar 2017 14:44:59 -0700 (PDT)
In-Reply-To: <f8e49417-ea2a-3486-26c2-63eb3306990a@ti.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Andrew F. Davis" <afd@ti.com>
Cc: Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org, Matt Ranostay <matt@ranostay.consulting>, Liam Breck <kernel@networkimprov.net>

On Thu, Mar 23, 2017 at 7:49 AM, Andrew F. Davis <afd@ti.com> wrote:
> On 03/23/2017 05:35 AM, Liam Breck wrote:
>> On Thu, Mar 23, 2017 at 3:28 AM, Sebastian Reichel <sre@kernel.org> wrote:
>>> Hi,
>>>
>>> On Mon, Mar 20, 2017 at 02:43:32AM -0700, Liam Breck wrote:
>>>> From: Liam Breck <kernel@networkimprov.net>
>>>>
>>>> Pass actual chip ID into _setup(), which translates it to a group ID,
>>>> to allow support for all chips by the power_supply_battery_info code.
>>>> There are no functional changes to the driver.
>>>>
>>>> Signed-off-by: Liam Breck <kernel@networkimprov.net>
>>>
>>> This is really ugly. If we need chip ID and group ID let's store
>>> them in different variables. For example put the detailed chipid
>>> into di->realchip and then do
>>
>> I tried this in a previous version, and Andrew rejected it as
>> confusing to have two IDs. That was while you were away on business
>> :-)
>>
>
> I rejected two tables, to indexes is what I've been pushing for a while.

On March 9, you wrote, "each chip should have one unique ID, I think
what ever way you prefer would work for the table structure, lets just
keep the chip ID enums clean"

Anyway, we have a solution - realid via argument.

>>> switch(di->realchip) {
>>> case FOO:
>>>     di->chip = GRP_FOO;
>>>     break;
>>> case BAR:
>>>     di->chip = GRP_BAR;
>>>     break;
>>> default:
>>>     di->chip = di->realchip;
>>>     break;
>>> }
>>>
>>> -- Sebastian
>>>
>>>>  drivers/power/supply/bq27xxx_battery.c     | 27 +++++++++++++++++++++++++++
>>>>  drivers/power/supply/bq27xxx_battery_i2c.c | 16 ++++++++--------
>>>>  include/linux/power/bq27xxx_battery.h      | 11 +++++++++++
>>>>  3 files changed, 46 insertions(+), 8 deletions(-)
>>>>
>>>> diff --git a/drivers/power/supply/bq27xxx_battery.c b/drivers/power/supply/bq27xxx_battery.c
>>>> index f36a6f1..db1a388 100644
>>>> --- a/drivers/power/supply/bq27xxx_battery.c
>>>> +++ b/drivers/power/supply/bq27xxx_battery.c
>>>> @@ -1391,6 +1391,33 @@ int bq27xxx_battery_setup(struct bq27xxx_device_info *di)
>>>>       struct power_supply_desc *psy_desc;
>>>>       struct power_supply_config psy_cfg = { .drv_data = di, };
>>>>
>>>> +     switch(di->chip) {
>>>> +     case BQ27000:
>>>> +     case BQ27010:
>>>> +     case BQ2750X:
>>>> +     case BQ2751X:
>>>> +     case BQ27500:
>>>> +     case BQ27510G1:
>>>> +     case BQ27510G2:
>>>> +     case BQ27510G3:
>>>> +     case BQ27520G1:
>>>> +     case BQ27520G2:
>>>> +     case BQ27520G3:
>>>> +     case BQ27520G4:
>>>> +     case BQ27530:
>>>> +     case BQ27541:
>>>> +     case BQ27545:
>>>> +     case BQ27421: break;
>>>> +     case BQ2752X: di->chip = BQ2751X; break;
>>>> +     case BQ27531: di->chip = BQ27530; break;
>>>> +     case BQ27542: di->chip = BQ27541; break;
>>>> +     case BQ27546: di->chip = BQ27541; break;
>>>> +     case BQ27742: di->chip = BQ27541; break;
>>>> +     case BQ27425: di->chip = BQ27421; break;
>>>> +     case BQ27441: di->chip = BQ27421; break;
>>>> +     case BQ27621: di->chip = BQ27421; break;
>>>> +     }
>>>> +
>>>>       INIT_DELAYED_WORK(&di->work, bq27xxx_battery_poll);
>>>>       mutex_init(&di->lock);
>>>>       di->regs = bq27xxx_regs[di->chip];
>>>> diff --git a/drivers/power/supply/bq27xxx_battery_i2c.c b/drivers/power/supply/bq27xxx_battery_i2c.c
>>>> index c68fbc3..b3f2494 100644
>>>> --- a/drivers/power/supply/bq27xxx_battery_i2c.c
>>>> +++ b/drivers/power/supply/bq27xxx_battery_i2c.c
>>>> @@ -150,7 +150,7 @@ static const struct i2c_device_id bq27xxx_i2c_id_table[] = {
>>>>       { "bq27210", BQ27010 },
>>>>       { "bq27500", BQ2750X },
>>>>       { "bq27510", BQ2751X },
>>>> -     { "bq27520", BQ2751X },
>>>> +     { "bq27520", BQ2752X },
>>>>       { "bq27500-1", BQ27500 },
>>>>       { "bq27510g1", BQ27510G1 },
>>>>       { "bq27510g2", BQ27510G2 },
>>>> @@ -160,16 +160,16 @@ static const struct i2c_device_id bq27xxx_i2c_id_table[] = {
>>>>       { "bq27520g3", BQ27520G3 },
>>>>       { "bq27520g4", BQ27520G4 },
>>>>       { "bq27530", BQ27530 },
>>>> -     { "bq27531", BQ27530 },
>>>> +     { "bq27531", BQ27531 },
>>>>       { "bq27541", BQ27541 },
>>>> -     { "bq27542", BQ27541 },
>>>> -     { "bq27546", BQ27541 },
>>>> -     { "bq27742", BQ27541 },
>>>> +     { "bq27542", BQ27542 },
>>>> +     { "bq27546", BQ27546 },
>>>> +     { "bq27742", BQ27742 },
>>>>       { "bq27545", BQ27545 },
>>>>       { "bq27421", BQ27421 },
>>>> -     { "bq27425", BQ27421 },
>>>> -     { "bq27441", BQ27421 },
>>>> -     { "bq27621", BQ27421 },
>>>> +     { "bq27425", BQ27425 },
>>>> +     { "bq27441", BQ27441 },
>>>> +     { "bq27621", BQ27621 },
>>>>       {},
>>>>  };
>>>>  MODULE_DEVICE_TABLE(i2c, bq27xxx_i2c_id_table);
>>>> diff --git a/include/linux/power/bq27xxx_battery.h b/include/linux/power/bq27xxx_battery.h
>>>> index c3369fa..96cec17 100644
>>>> --- a/include/linux/power/bq27xxx_battery.h
>>>> +++ b/include/linux/power/bq27xxx_battery.h
>>>> @@ -2,6 +2,7 @@
>>>>  #define __LINUX_BQ27X00_BATTERY_H__
>>>>
>>>>  enum bq27xxx_chip {
>>>> +     /* categories; index for bq27xxx_regs[] */
>>>>       BQ27000 = 1, /* bq27000, bq27200 */
>>>>       BQ27010, /* bq27010, bq27210 */
>>>>       BQ2750X, /* bq27500 deprecated alias */
>>>> @@ -18,6 +19,16 @@ enum bq27xxx_chip {
>>>>       BQ27541, /* bq27541, bq27542, bq27546, bq27742 */
>>>>       BQ27545, /* bq27545 */
>>>>       BQ27421, /* bq27421, bq27425, bq27441, bq27621 */
>>>> +
>>>> +     /* members of categories; translate these to category in _setup() */
>>>> +     BQ2752X, /* deprecated alias */
>>>> +     BQ27531,
>>>> +     BQ27542,
>>>> +     BQ27546,
>>>> +     BQ27742,
>>>> +     BQ27425,
>>>> +     BQ27441,
>>>> +     BQ27621,
>>>>  };
>>>>
>>>>  /**
>>>> --
>>>> 2.9.3
>>>>
