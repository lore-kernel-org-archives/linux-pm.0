From: Mason <slash.tmp@free.fr>
Subject: Re: Platform-specific suspend/resume code in drivers
Date: Fri, 10 Jun 2016 13:03:47 +0200
Message-ID: <575A9E93.4090508@free.fr>
References: <Pine.LNX.4.44L0.1606091054140.1697-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp2-g21.free.fr ([212.27.42.2]:12736 "EHLO smtp2-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932331AbcFJLEY (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 10 Jun 2016 07:04:24 -0400
In-Reply-To: <Pine.LNX.4.44L0.1606091054140.1697-100000@iolanthe.rowland.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: linux-pm <linux-pm@vger.kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Viresh Kumar <viresh.kumar@linaro.org>, Pavel Machek <pavel@ucw.cz>, Arnd Bergmann <arnd@arndb.de>, Mans Rullgard <mans@mansr.com>, Sebastian Frias <sf84@laposte.net>, Mark Rutland <mark.rutland@arm.com>

On 09/06/2016 17:05, Alan Stern wrote:

> On Wed, 8 Jun 2016, Mason wrote:
> 
>> On 08/06/2016 19:45, Alan Stern wrote:
>>
>>> On Wed, 8 Jun 2016, Mason wrote:
>>>
>>>> On 07/06/2016 17:06, Alan Stern wrote:
>>>>
>>>>> On Tue, 7 Jun 2016, Mason wrote:
>>>>>
>>>>>> Another point of confusion for me is this: drivers are supposed to
>>>>>> be shared among platforms, right? So my platform-specific suspend
>>>>>> code should be enabled only if my platform is detected at run-time?
>>>>>
>>>>> Is your device platform-specific?  If it is then the driver is also
>>>>> platform-specific, and so no part of the driver will be called at
>>>>> runtime unless your platform is detected.
>>>>
>>>> Specifically, my platform uses
>>>> drivers/net/ethernet/aurora/nb8800.c  => 3 entries in of_match_table.
>>>> drivers/tty/serial/8250/8250_core.c (CONFIG_SERIAL_8250_RT288X variant)
>>>>
>>>> and also the XHCI USB3 driver, and AHCI SATA driver, wouldn't I need to
>>>> save the context for these too?
>>>
>>> Those drivers should already take care of their own contexts.  Is 
>>> there anything platform-specific you need to do in addition?
>>
>> Take the eth driver, for example:
>>
>>   http://lxr.free-electrons.com/source/drivers/net/ethernet/aurora/nb8800.c
>>
>> It doesn't have any suspend/resume callbacks.
>>
>> Would that make the suspend request fail?
> 
> There are plenty of drivers that don't have suspend/resume callbacks.
> (Fewer than there used to be, fortunately.)  They don't make suspend
> fail; rather, the PM core just skips over them when carrying out a
> suspend.
> 
> Of course, if a driver needs suspend support but doesn't include it,
> then it's quite likely the driver will not work properly after the
> system has been resumed.  But that's not a platform-specific issue.
> 
>> (Side note: they guarded the code with CONFIG_PM_SLEEP, rather
>> than CONFIG_SUSPEND. Why?)
> 
> CONFIG_PM_SLEEP covers both suspend (AKA suspend-to-ram) and 
> hibernation (AKA suspend-to-disk).

Thanks for pointing that out.


>>>>> If the device isn't platform-specific then the driver has to work on a 
>>>>> bunch of different platforms.  It should be written to be 
>>>>> platform-independent as much as possible.
>>>>>
>>>>>> So this means I need to add in the probe function, for every driver
>>>>>> my platform uses:
>>>>>>
>>>>>>   if (platform == MY_PLATFORM) {
>>>>>>     ops.suspend = my_suspend;
>>>>>>     ops.resume  = my_resume;
>>>>>>   }
>>>>>>
>>>>>> Is that correct?
>>>>>
>>>>> No.  For one thing, you only have to worry about the 
>>>>> platform-independent drivers -- you know that the platform-specific 
>>>>> ones won't get used unless your platform is present.
>>>>
>>>> I guess the thermal driver is platform-specific, but most devices
>>>> are third-party IP blocks, so there is a "common" driver upstream.
>>>> But I would need a platform-specific suspend/resume sequence,
>>>> just for my platform.
>>>
>>> Why?  What sort of platform-specific things do you need to do?
>>
>> Save the value of the MMIO registers which will be lost when the
>> chip is powered down.
> 
> How did these registers get set in the first place?  Wherever the code 
> is that sets them up initially, that's where these registers should be 
> reinitialized following a resume.  If they were set up by 
> platform-specific code then they should be reinitialized by 
> platform-specific code.

Consider two SoCs, SoCA and SocB.

They both have the same device D, which exposes 16 registers to interact
with the hardware.

When SoCA is suspended, it stops D's clock, but keeps D powered on,
preserving the 16 registers. Thus when SoCA resumes, it finds the
16 registers in the same state as before suspending.

When SoCB is suspended, it powers D down. When SoCB resumes, the
16 registers contain garbage/random values. Therefore, in the case
of SoCB, the suspend routine should save the values of the registers
to RAM (which is preserved by "contract") and restore them on resume.

However, this save/restore operation is unnecessary on SoCA.

Should the save/restore operation be added unconditionally to the
driver, even if some SoCs do not need it?

In other words, do we consider the performance penalty from saving
and restoring device registers small enough that it should be done
systematically, even if some SoCs do not require it?

Some device tree nodes have a property called "always-on" which is
documented as "If present, the block is powered through an always-on
power domain, therefore it never loses context."

In that case, I suppose the driver's suspend/resume routine should:

suspend:
if (always-on is not present) {
    save device registers to RAM;
}

resume:
if (always-on is not present) {
    restore device registers from RAM;
}

Do you disagree?

Regards.
