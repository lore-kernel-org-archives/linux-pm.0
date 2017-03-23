From: Liam Breck <liam@networkimprov.net>
Subject: Re: [PATCH v2 4/7] power: supply: bq24190_charger: Never reset the
 charger chip
Date: Thu, 23 Mar 2017 00:16:46 -0700
Message-ID: <CAKvHMgSy0iobRDEYWrOwVSz940TPNhOQXxRCUftT-8q3mUfXwA@mail.gmail.com>
References: <20170322145536.30570-1-hdegoede@redhat.com> <20170322145536.30570-5-hdegoede@redhat.com>
 <20170322154313.GU8575@atomide.com> <2ab0b7d5-61b0-2a1f-7c45-07d7f3f180b6@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-io0-f195.google.com ([209.85.223.195]:36603 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751868AbdCWILK (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 23 Mar 2017 04:11:10 -0400
Received: by mail-io0-f195.google.com with SMTP id 68so12494240ioh.3
        for <linux-pm@vger.kernel.org>; Thu, 23 Mar 2017 01:11:09 -0700 (PDT)
In-Reply-To: <2ab0b7d5-61b0-2a1f-7c45-07d7f3f180b6@redhat.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Tony Lindgren <tony@atomide.com>, Sebastian Reichel <sre@kernel.org>, Takashi Iwai <tiwai@suse.de>, linux-pm@vger.kernel.org, Liam Breck <kernel@networkimprov.net>

On Wed, Mar 22, 2017 at 8:45 AM, Hans de Goede <hdegoede@redhat.com> wrote:
> Hi,
>
> On 22-03-17 16:43, Tony Lindgren wrote:
>>
>> * Hans de Goede <hdegoede@redhat.com> [170322 07:57]:
>>>
>>> Resetting the charger should never be necessary it should always have
>>> sane values programmed. If it is running with invalid values while we
>>> are not running (system turned off or suspended) there is a big problem
>>> as that may lead to overcharging the battery.
>>
>>
>> And some systems may only configure it in the bootloader with no
>> configuration passed to the kernel at all.
>
>
> Right.
>
>
>>> The reset in suspend() is meant to put the charger back into default
>>> mode, but this is not necessary and not a good idea. If the charger has
>>> been programmed with a higher max charge_current / charge_voltage then
>>> putting it back in default-mode will reset those to the safe power-on
>>> defaults, leading to slower charging, or charging to a lower voltage
>>> (and thus not using the full capacity) while suspended which is
>>> undesirable. Reprogramming the max charge_current / charge_voltage
>>> after the reset will not help here as that will put the charger back
>>> in host mode and start the i2c watchdog if the host then does not do
>>> anything for 40s (iow if we're suspended for more then 40s) the watchdog
>>> expires resetting the device to default-mode, including resetting all
>>> the registers to there safe power-on defaults. So the only way to keep
>>> using custom charge settings while suspending is to keep the charger in
>>> its normal running state with the i2c watchdog disabled. This is fine
>>> as the charger will still automatically switch from constant current
>>> to constant voltage and stop charging when the battery is full.
>>>
>>> Besides never being necessary resetting the charger also causes problems
>>> on systems where the charge voltage limit is set higher then the reset
>>> value, if this is the case and the charger is reset while charging and
>>> the battery voltage is between the 2 voltages, then about half the time
>>> the charger gets confused and claims to be charging (REG08 contains 0x64)
>>> but in reality the charger has decoupled itself from VBUS (Q1 off) and
>>> is drawing 0A from VBUS, leaving the system running from the battery.
>>
>>
>> We do have cases where Linux kernel is the bootloader though using
>> kexec. And in those cases we may need to reset, so I wonder if the
>> reset should just be optional based on a proper device tree
>> (or platform_data) configuration?
>
>
> As described above during my testing I've found that the chip does not
> respond well to reset under certain conditions, so I think that if
> we have settings to apply we should just overwrite the settings with
> our settings, what does doing a reset before overwriting the registers
> buy us? We still need to do the overwrite anyways.

When driver loads on any conceivable hw, how do we know the chip is in
a state we predicted? If it isn't, how can we fix any undesirable
settings? Reset + fix a,b,c is simple way to do that.

I'm OK with abandoning reset on suspend. Tho I need to review the docs
about host mode...
