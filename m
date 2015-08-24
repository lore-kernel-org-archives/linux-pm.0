From: Petr Cvek <petr.cvek@tul.cz>
Subject: Re: [PATCH v2 01/21] ARM: pxa: magician: Fix Kconfig for magician to
 always include htc-egpio
Date: Mon, 24 Aug 2015 05:39:57 +0200
Message-ID: <55DA920D.4030605@tul.cz>
References: <cover.1439843482.git.petr.cvek@tul.cz> <55D25880.3030507@tul.cz>
 <87zj1o8n3w.fsf@belgarion.home> <55D38F60.7010405@tul.cz>
 <1439969382.11928.6.camel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-leds-owner@vger.kernel.org>
In-Reply-To: <1439969382.11928.6.camel@gmail.com>
Sender: linux-leds-owner@vger.kernel.org
To: Philipp Zabel <philipp.zabel@gmail.com>, Robert Jarzmik <robert.jarzmik@free.fr>
Cc: daniel@zonque.org, haojian.zhuang@gmail.com, sameo@linux.intel.com, lee.jones@linaro.org, cooloney@gmail.com, rpurdie@rpsys.net, j.anaszewski@samsung.com, linux@arm.linux.org.uk, sre@kernel.org, dbaryshkov@gmail.com, dwmw2@infradead.org, linux-leds@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

Dne 19.8.2015 v 09:29 Philipp Zabel napsal(a):
> Am Dienstag, den 18.08.2015, 22:02 +0200 schrieb Petr Cvek:
>> Dne 18.8.2015 v 20:31 Robert Jarzmik napsal(a):
>>> Petr Cvek <petr.cvek@tul.cz> writes:
>>>
>>>> The htc-egpio driver should be always included in the kernel as 
>>>> it
>>>> controls MMC/charging/IrDA power, which is the only way to get
>>>> an useful rootfs.
>>>>
>>>> Signed-off-by: Petr Cvek <petr.cvek@tul.cz>
>>> It's already defined in magician_defconfig, why enforce it in 
>>> Kconfig ?
>>
>> Good remark, I did not use defconfig at all (as I had to fix from 
>> zero configuration + I did not know if defconfig works and will be 
>> supported in the future).
>>
>> I will check if magician_defconfig needs to be updated (probably for 
>> leds).
>>
>>>
>>> And if it's enforced and I want to build a kernel for magician 
>>> without
>>> MMC/charging/IrDA, why should I be forced to build in HTC_EGPIO ?
>>>
>>> Or said differently, does a kernel without HTC_EGPIO is proven to 
>>> fail 100%
>>> without this option ?
>>
>> Kernel will probably run OK, but the phone will be unusable (for any 
>> practical purposes). The EGPIO chip (CPLD) will stay in the state 
>> programmed from the previous environment (bootloader or WinCE/Mobile) 
>> and drivers fail to init because of the missing EGPIO (and if they 
>> init, they will be without any idea about state of the peripherals 
>> (no charger detection/charging current stuck on the previous 
>> settings, no LCD backlight control, no IrDA, no rootfs, no GSM, no 
>> sound, no LEDs).
>>
>> Different PCB revisions probably use EGPIO pin for LCD power (and at 
>> least on my phone, LCD power must have very specific order).
>>
>> For future (when ROM XIP will work) I would like to be able boot 
>> kernel from flash, which itself uses EGPIO for Vpp control (another 
>> initial EGPIO configuration). Last possible boot is from JTAG and 
>> there will be no previous EGPIO initialization.
>>
>> Petr
> 
> I agree with Robert, let's drop this patch.
As finishing patchset v3 I've finally got enough deterministic configuration.

Situation A:
	Most code same as v2 patchset (GPIO init, devices, ...)
	RTC patch (not in patchset, but vanilla causes errors during boot)
	Boot from bootloader (htc-tools), kernel from RAM 
	Rootfs on SDHC
	EGPIO driver in kernel
	-> boot
Situation B:
	EGPIO disabled
	-> every EGPIO requests fail (bad LCD readability, but most probably by -EDEFER)
	mci driver fails to start (SD card power EGPIO and others are not found)
	kernel prints cannot open root device ...
	there is kernel panic from rootfs mount (stackdump with some *mount* function name)

-> So it seems EGPIO driver is required for standard boot.

When trying to boot with initrd, the htc-boot will freeze during image upload (around 5 MB of initrd, not enough for rootfs), but maybe I'm doing something wrong. 

-> Without initrd, there is no way to get useful rootfs.

Petr
