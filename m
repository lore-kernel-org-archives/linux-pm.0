From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH v3] power: supply: bq24190_charger: Use extcon to
 determine ilimit, 5v boost
Date: Fri, 31 Mar 2017 17:43:02 +0200
Message-ID: <ed292253-c1ea-4041-6799-3e2cbb829cb0@redhat.com>
References: <20170323083235.15072-1-hdegoede@redhat.com>
 <CAKvHMgTqyW8MnVLyzR5L3+DjQHZ+04GZtW+MhkNAt7HBrqUhBw@mail.gmail.com>
 <0b3d3f1e-0f86-1090-4812-1a574d9dadb0@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:17254 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933217AbdCaPnG (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 31 Mar 2017 11:43:06 -0400
In-Reply-To: <0b3d3f1e-0f86-1090-4812-1a574d9dadb0@redhat.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Liam Breck <liam@networkimprov.net>
Cc: Sebastian Reichel <sre@kernel.org>, Takashi Iwai <tiwai@suse.de>, linux-pm@vger.kernel.org, Liam Breck <kernel@networkimprov.net>, Tony Lindgren <tony@atomide.com>

Hi,

On 29-03-17 09:34, Hans de Goede wrote:

<snip>

>>> @@ -36,6 +38,8 @@
>>>  #define BQ24190_REG_POC_WDT_RESET_SHIFT                6
>>>  #define BQ24190_REG_POC_CHG_CONFIG_MASK                (BIT(5) | BIT(4))
>>>  #define BQ24190_REG_POC_CHG_CONFIG_SHIFT       4
>>> +#define BQ24190_REG_POC_CHG_CONFIG_CHARGE      1
>>> +#define BQ24190_REG_POC_CHG_CONFIG_OTG         2
>>
>> Place these at the end of the reg_poc section, so the mask & shift
>> names are together.

Small note while I'm sending an email anyways: the BQ24190_REG_VPRS defines
do things the same way and I believe that keeping the masks and the
values for the bits together is better.

<snip>

>>> +       /*
>>> +        * If no charger has been detected and host mode is requested, activate
>>> +        * the 5V boost converter, otherwise deactivate it.
>>> +        */
>>
>> u8 val = BQ24190_REG_POC_CHG_CONFIG_CHARGE;
>>
>>> +       if (!iinlim && extcon_get_state(bdi->extcon, EXTCON_USB_HOST) == 1) {
>>
>> if (above) val = BQ24190_REG_POC_CHG_CONFIG_OTG;
>>
>> Then call write_mask once, with val.
>
> Good idea,

Scrap that I thought you were trying to fold the ilimit and boost-converter
writes into 1 write which would be good I now see that those are 2 different
regs and what you're suggesting is a coding style change only. I don't like
your proposed change, this is a clear example where using an if-else
construct is much more readable then using the:
val=condition-false-value; if (condition) val=condition-true-value
construct you suggest.

> but actually I found out by booting my board with a host-cable
> (USB-C equivalent of id-pin connected to ground) plugged in that there is
> a second 5v boost converter on the board and that that-one gets used by
> the firmware, so I will submit a patch soon-ish dropping the EXTCON_USB_HOST
> handling all together.

Ok scrap that, yes my board has 2 5v boost converters, yes the firmware
uses the one which is not part of the bq24190, but that is a BAD idea,
because even if we stop the bq24190 from trying to charge the
battery from the 5v boost converter, by driving not-CE high, it still
tries to supply Vsys from the 5v boost converter causing an extra 300mA
of battery drain as long as the other 5v boost converter is active.

So what the firmware is doing is stupid and I'm not going to send a patch
to remove the 5v boost converter enabling from the bq24190 extcon handling
as that is actually what we want. Instead I'll do a patch for the
pmic-extcon driver to turn off the other 5v boost converter at boot,
as it should never be used on machines with a bq24190.

Regards,

Hans
