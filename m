From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH v4 2/4] power: bq24190_charger: Clean up extcon code
Date: Sat, 8 Apr 2017 22:05:23 +0200
Message-ID: <d82efc98-daa1-cf64-d49b-2e79065886fc@redhat.com>
References: <20170406031048.12401-1-liam@networkimprov.net>
 <20170406031048.12401-3-liam@networkimprov.net>
 <da9ca342-0573-6a17-7fdb-3a8f88980525@redhat.com>
 <CAKvHMgS8c=gOFqYAn6jKg8JxwJRO+BNmiE5yj6WmOn7o-9NqTA@mail.gmail.com>
 <06c84661-ac0d-105f-2896-2615eab7c093@redhat.com>
 <CAKvHMgQngU5s1M6D6zCt2je=P6GOKD48KVexwd7LK5zMJm8gEg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:43804 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751492AbdDHUF0 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sat, 8 Apr 2017 16:05:26 -0400
In-Reply-To: <CAKvHMgQngU5s1M6D6zCt2je=P6GOKD48KVexwd7LK5zMJm8gEg@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Liam Breck <liam@networkimprov.net>
Cc: Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Liam Breck <kernel@networkimprov.net>

Hi,

On 08-04-17 21:09, Liam Breck wrote:
> On Sat, Apr 8, 2017 at 3:02 AM, Hans de Goede <hdegoede@redhat.com> wrote:
>> Hi,
>>
>> On 08-04-17 00:27, Liam Breck wrote:
>>>
>>> Hallo Hans,
>>>
>>> On Thu, Apr 6, 2017 at 12:17 AM, Hans de Goede <hdegoede@redhat.com>
>>> wrote:
>>
>>
>> <snip>
>>
>>
>>>>> -       /*
>>>>> -        * If no charger has been detected and host mode is requested,
>>>>> activate
>>>>> -        * the 5V boost converter, otherwise deactivate it.
>>>>> -        */
>>>>> -       if (!iinlim && extcon_get_state(bdi->extcon, EXTCON_USB_HOST) ==
>>>>> 1) {
>>>>> -               ret = bq24190_write_mask(bdi, BQ24190_REG_POC,
>>>>> -
>>>>> BQ24190_REG_POC_CHG_CONFIG_MASK,
>>>>> -
>>>>> BQ24190_REG_POC_CHG_CONFIG_SHIFT,
>>>>> -
>>>>> BQ24190_REG_POC_CHG_CONFIG_OTG);
>>>>> -       } else {
>>>>> -               ret = bq24190_write_mask(bdi, BQ24190_REG_POC,
>>>>> -
>>>>> BQ24190_REG_POC_CHG_CONFIG_MASK,
>>>>> -
>>>>> BQ24190_REG_POC_CHG_CONFIG_SHIFT,
>>>>> -
>>>>> BQ24190_REG_POC_CHG_CONFIG_CHARGE);
>>>>> -       }
>>>>> -       if (ret)
>>>>> -               dev_err(bdi->dev, "Can't set CHG_CONFIG: %d\n", ret);
>>>>> +       /* Set OTG 5V boost: on if no charger detected and in USB host
>>>>> mode, else off */
>>>>> +       error = bq24190_write_mask(bdi, BQ24190_REG_POC,
>>>>> +                                  BQ24190_REG_POC_CHG_CONFIG_MASK,
>>>>> +                                  BQ24190_REG_POC_CHG_CONFIG_SHIFT,
>>>>> +                       !iinlim && extcon_get_state(bdi->extcon,
>>>>> EXTCON_USB_HOST) == 1
>>>>> +                                ? BQ24190_REG_POC_CHG_CONFIG_OTG
>>>>> +                                : BQ24190_REG_POC_CHG_CONFIG_CHARGE);
>>>>> +       if (error < 0)
>>>>> +               dev_err(bdi->dev, "Can't set CHG_CONFIG: %d\n", error);
>>>>>
>>>>>         pm_runtime_mark_last_busy(bdi->dev);
>>>>>         pm_runtime_put_autosuspend(bdi->dev);
>>>>
>>>>
>>>>
>>>> I still find the refactored code you're proposing here a lot less
>>>> readable
>>>> then the original code, and the same goes for the comment. If you insist
>>>> in changing this, then I suggest changing it into this:
>>>
>>>
>>> OK. I'll collapse the comment to one line tho.
>>
>>
>> Please don't having this as 2 lines really is not a problem in any way and
>> I find the longer comment a lot easier to parse.
>>
>>
>>>
>>>>         /*
>>>>          * If no charger has been detected and host mode is requested,
>>>> activate
>>>>          * the 5V boost converter, otherwise deactivate it.
>>>>          */
>>>>         if (!iinlim && extcon_get_state(bdi->extcon, EXTCON_USB_HOST) ==
>>>> 1)
>>>>                 chg_config = BQ24190_REG_POC_CHG_CONFIG_OTG;
>>>>         else
>>>>                 chg_config = BQ24190_REG_POC_CHG_CONFIG_CHARGE;
>>>>
>>>>         error = bq24190_write_mask(bdi, BQ24190_REG_POC,
>>>>                                    BQ24190_REG_POC_CHG_CONFIG_MASK,
>>>>                                    BQ24190_REG_POC_CHG_CONFIG_SHIFT,
>>>>                                    chg_config);
>>>>         if (error)
>>>>                 dev_err(bdi->dev, "Can't set CHG_CONFIG: %d\n", error);
>>>>
>>>>> @@ -1432,8 +1427,8 @@ static int bq24190_probe(struct i2c_client
>>>>> *client,
>>>>>         }
>>>>>
>>>>>         /*
>>>>> -        * The extcon-name property is purely an in kernel interface for
>>>>> -        * x86/ACPI use, DT platforms should get extcon via phandle.
>>>>> +        * ACPI platforms should use device_property "extcon-name".
>>>>> +        * Devicetree platforms should get extcon via phandle (not yet
>>>>> supported).
>>>>>          */
>>>>>         if (device_property_read_string(dev, "extcon-name", &name) == 0)
>>>>> {
>>>>>                 bdi->extcon = extcon_get_extcon_dev(name);
>>>>
>>>>
>>>>
>>>> The new comment suggest that extcon-name is something which should
>>>> actually
>>>> be used inside ACPI DSDT tables, which it is not, please leave the
>>>> comment
>>>> as is.
>>>
>>>
>>> OK, right. But "in kernel interface" sounds official, and this is
>>> really a custom msg passing method. A platform-data struct is
>>> documented in a header, and a module parameter has its own docs
>>> scheme; and use of those methods is well documented. I can't tell how
>>> I would invoke this one. How about this...
>>>
>>> A Devicetree should provide extcon-name via phandle (not yet supported).
>>
>>
>> No a devicetree should not provide a name it would provide a phandle
>> pointing to the extcon, no name (and name based lookup) should be
>> involved.
>
> OK.
>
>>> ACPI extcon drivers/clients[?] should insert[?] device_property
>>> extcon-name into our device with relevant_api_call(args).
>>
>>
>> For an example of how this is used see:
>>
>> https://github.com/jwrdegoede/linux-sunxi/commit/7fa4460e2a18a3f6ffb39ae4940fee1dd2a880a4
>>
>> Around line 214 of i2c-cht-wc.c and later.
>
> So a comment like...
>
> On ACPI platforms, extcon clients should invoke this driver with:
> struct i2c_adapter a = { ... };
> i2c_add_adapter(&a);
> struct property_entry pe[] = { PROPERTY_ENTRY_STRING("extcon-name",
> <name>), ... };
> struct i2c_board_info bi = { .type = "bq24190", .addr = 0x6b,
> .properties = pe, .irq = <irq> };
> i2c_new_device(&a, &bi);

Sure that works for me.

Regards,

Hans
