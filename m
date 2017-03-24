From: Liam Breck <liam@networkimprov.net>
Subject: Re: [PATCH v2 4/7] power: supply: bq24190_charger: Never reset the
 charger chip
Date: Fri, 24 Mar 2017 16:49:14 -0700
Message-ID: <CAKvHMgStz5RqizXS1xfYDxypGusaBBMtVOYLH7R8N7wbOJAyjg@mail.gmail.com>
References: <20170322145536.30570-1-hdegoede@redhat.com> <20170322145536.30570-5-hdegoede@redhat.com>
 <20170322154313.GU8575@atomide.com> <2ab0b7d5-61b0-2a1f-7c45-07d7f3f180b6@redhat.com>
 <CAKvHMgSy0iobRDEYWrOwVSz940TPNhOQXxRCUftT-8q3mUfXwA@mail.gmail.com>
 <a8cd7854-38e0-e808-e22f-844c023cab88@redhat.com> <CAKvHMgS1Bc=G2Qa9SVFsjePTyoDJo0etA7d4-fJ+y03xpwwGqQ@mail.gmail.com>
 <ff62ab2b-b0d7-87f2-1b42-624e26e9ef52@redhat.com> <CAKvHMgSSihQRTcXwZXtS6sOgtr7Pxzkb-Jb_iMeys7YLtOGv3A@mail.gmail.com>
 <65527878-47cb-70a8-f605-b251835b94ed@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-it0-f68.google.com ([209.85.214.68]:34589 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754888AbdCXXtV (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 24 Mar 2017 19:49:21 -0400
Received: by mail-it0-f68.google.com with SMTP id z70so966304itb.1
        for <linux-pm@vger.kernel.org>; Fri, 24 Mar 2017 16:49:16 -0700 (PDT)
In-Reply-To: <65527878-47cb-70a8-f605-b251835b94ed@redhat.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Tony Lindgren <tony@atomide.com>, Sebastian Reichel <sre@kernel.org>, Takashi Iwai <tiwai@suse.de>, linux-pm@vger.kernel.org, Liam Breck <kernel@networkimprov.net>

On Thu, Mar 23, 2017 at 3:01 PM, Hans de Goede <hdegoede@redhat.com> wrote:
> Hi,
>
>
> On 23-03-17 21:33, Liam Breck wrote:
>>
>> On Thu, Mar 23, 2017 at 4:44 AM, Hans de Goede <hdegoede@redhat.com>
>> wrote:
>>>
>>> Hi,
>>>
>>>
>>> On 23-03-17 12:36, Liam Breck wrote:
>>>>
>>>>
>>>> On Thu, Mar 23, 2017 at 1:44 AM, Hans de Goede <hdegoede@redhat.com>
>>>> wrote:
>>>>>
>>>>>
>>>>> Hi,
>>>>>
>>>>>
>>>>> On 23-03-17 08:16, Liam Breck wrote:
>>>>>>
>>>>>>
>>>>>>
>>>>>> On Wed, Mar 22, 2017 at 8:45 AM, Hans de Goede <hdegoede@redhat.com>
>>>>>> wrote:
>>>>>>>
>>>>>>>
>>>>>>>
>>>>>>> Hi,
>>>>>>>
>>>>>>> On 22-03-17 16:43, Tony Lindgren wrote:
>>>>>>>>
>>>>>>>>
>>>>>>>>
>>>>>>>>
>>>>>>>> * Hans de Goede <hdegoede@redhat.com> [170322 07:57]:
>>>>>>>>>
>>>>>>>>>
>>>>>>>>>
>>>>>>>>>
>>>>>>>>> Resetting the charger should never be necessary it should always
>>>>>>>>> have
>>>>>>>>> sane values programmed. If it is running with invalid values while
>>>>>>>>> we
>>>>>>>>> are not running (system turned off or suspended) there is a big
>>>>>>>>> problem
>>>>>>>>> as that may lead to overcharging the battery.
>>>>>>>>
>>>>>>>>
>>>>>>>>
>>>>>>>>
>>>>>>>>
>>>>>>>> And some systems may only configure it in the bootloader with no
>>>>>>>> configuration passed to the kernel at all.
>>>>>>>
>>>>>>>
>>>>>>>
>>>>>>>
>>>>>>>
>>>>>>> Right.
>>>>>>>
>>>>>>>
>>>>>>>>> The reset in suspend() is meant to put the charger back into
>>>>>>>>> default
>>>>>>>>> mode, but this is not necessary and not a good idea. If the charger
>>>>>>>>> has
>>>>>>>>> been programmed with a higher max charge_current / charge_voltage
>>>>>>>>> then
>>>>>>>>> putting it back in default-mode will reset those to the safe
>>>>>>>>> power-on
>>>>>>>>> defaults, leading to slower charging, or charging to a lower
>>>>>>>>> voltage
>>>>>>>>> (and thus not using the full capacity) while suspended which is
>>>>>>>>> undesirable. Reprogramming the max charge_current / charge_voltage
>>>>>>>>> after the reset will not help here as that will put the charger
>>>>>>>>> back
>>>>>>>>> in host mode and start the i2c watchdog if the host then does not
>>>>>>>>> do
>>>>>>>>> anything for 40s (iow if we're suspended for more then 40s) the
>>>>>>>>> watchdog
>>>>>>>>> expires resetting the device to default-mode, including resetting
>>>>>>>>> all
>>>>>>>>> the registers to there safe power-on defaults. So the only way to
>>>>>>>>> keep
>>>>>>>>> using custom charge settings while suspending is to keep the
>>>>>>>>> charger
>>>>>>>>> in
>>>>>>>>> its normal running state with the i2c watchdog disabled. This is
>>>>>>>>> fine
>>>>>>>>> as the charger will still automatically switch from constant
>>>>>>>>> current
>>>>>>>>> to constant voltage and stop charging when the battery is full.
>>>>>>>>>
>>>>>>>>> Besides never being necessary resetting the charger also causes
>>>>>>>>> problems
>>>>>>>>> on systems where the charge voltage limit is set higher then the
>>>>>>>>> reset
>>>>>>>>> value, if this is the case and the charger is reset while charging
>>>>>>>>> and
>>>>>>>>> the battery voltage is between the 2 voltages, then about half the
>>>>>>>>> time
>>>>>>>>> the charger gets confused and claims to be charging (REG08 contains
>>>>>>>>> 0x64)
>>>>>>>>> but in reality the charger has decoupled itself from VBUS (Q1 off)
>>>>>>>>> and
>>>>>>>>> is drawing 0A from VBUS, leaving the system running from the
>>>>>>>>> battery.
>>>>>>>>
>>>>>>>>
>>>>>>>>
>>>>>>>>
>>>>>>>>
>>>>>>>> We do have cases where Linux kernel is the bootloader though using
>>>>>>>> kexec. And in those cases we may need to reset, so I wonder if the
>>>>>>>> reset should just be optional based on a proper device tree
>>>>>>>> (or platform_data) configuration?
>>>>>>>
>>>>>>>
>>>>>>>
>>>>>>>
>>>>>>>
>>>>>>> As described above during my testing I've found that the chip does
>>>>>>> not
>>>>>>> respond well to reset under certain conditions, so I think that if
>>>>>>> we have settings to apply we should just overwrite the settings with
>>>>>>> our settings, what does doing a reset before overwriting the
>>>>>>> registers
>>>>>>> buy us? We still need to do the overwrite anyways.
>>>>>>
>>>>>>
>>>>>>
>>>>>>
>>>>>> When driver loads on any conceivable hw, how do we know the chip is in
>>>>>> a state we predicted?
>>>>>
>>>>>
>>>>>
>>>>>
>>>>> Any non reset values have to come from somewhere, likely firmware,
>>>>> and unless we've platform data telling us the exact settings we should
>>>>> use why would we decide the reset values are better then the ones
>>>>> the charger was *already using* before our driver loads ? As said in
>>>>> the commit msg: "If it is running with invalid values while we
>>>>> are not running (system turned off or suspended) there is a big problem
>>>>> as that may lead to overcharging the battery."
>>>>>
>>>>>> If it isn't, how can we fix any undesirable
>>>>>> settings?
>>>>>
>>>>>
>>>>>
>>>>>
>>>>> Why would the chip not be in a sane state? Where would the undesirable
>>>>> settings come from ?
>>>>>
>>>>>> Reset + fix a,b,c is simple way to do that.
>>>>>
>>>>>
>>>>>
>>>>>
>>>>> As my testing using real-world hardware under real-world conditions
>>>>> has shown resetting the charger IC while it is charging can cause it
>>>>> to misbehave. So we have this theoretical problem of there somehow
>>>>> being undesirable settings at boot vs a real-world problem...
>>>>
>>>>
>>>>
>>>> A bug in the charger? Or in the platform hw/fw?
>>>
>>>
>>>
>>> I'm pretty sure the fw is not touching the charger, still the problem
>>> might be something specific to my hw. Either way there does not seem
>>> to be a good reason to reset the chip and doing a reset despite it
>>> not being necessary does cause real problems independently of the
>>> root cause (I'm running this on production hardware which many
>>> people have, so no way to modify the hardware).
>>>
>>> If you want to test this on your systems you can easily add a
>>> patch on top of your current branch which just comments out
>>> all the reset calls (and the bq24190_set_mode_host call in
>>> resume) to get the same result on top of your current branch.
>>
>>
>> My mistake... what I need to try is reproducing your failure due to
>> reset during charge. Can you explain what switches I need to flip and
>> dials to watch?
>
>
> The GPDwin mini laptop I'm developing this on /for has a bq24292i
> (bq24192i compatible) with a LiHV battery and max charging
> voltage set to 4.38V When resetting the charger while the
> battery voltage is between 4.1V (reset max volt) and 4.38V
> and the charger is charging. Sometimes instead of just
> turning of charging as the bat voltage is now above the max
> voltage, it turns of Q1 (disconnects itself from Vbus) while
> it thinks it is still charging (observed from REG08 as well
> as the charging LED.

Thanks. It will take me a few days to get to this.

In the meantime, note that on a DT-configured system, we don't want
any charger settings made by the bootloader, as we're going to change
default settings (e.g. precharge & endcharge from my patchset) based
on DT params.
