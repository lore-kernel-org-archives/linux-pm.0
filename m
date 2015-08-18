From: Petr Cvek <petr.cvek@tul.cz>
Subject: Re: [PATCH v2 01/21] ARM: pxa: magician: Fix Kconfig for magician to
 always include htc-egpio
Date: Tue, 18 Aug 2015 22:02:40 +0200
Message-ID: <55D38F60.7010405@tul.cz>
References: <cover.1439843482.git.petr.cvek@tul.cz> <55D25880.3030507@tul.cz>
 <87zj1o8n3w.fsf@belgarion.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: 7bit
Return-path: <linux-leds-owner@vger.kernel.org>
In-Reply-To: <87zj1o8n3w.fsf@belgarion.home>
Sender: linux-leds-owner@vger.kernel.org
To: Robert Jarzmik <robert.jarzmik@free.fr>
Cc: philipp.zabel@gmail.com, daniel@zonque.org, haojian.zhuang@gmail.com, sameo@linux.intel.com, lee.jones@linaro.org, cooloney@gmail.com, rpurdie@rpsys.net, j.anaszewski@samsung.com, linux@arm.linux.org.uk, sre@kernel.org, dbaryshkov@gmail.com, dwmw2@infradead.org, linux-leds@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

Dne 18.8.2015 v 20:31 Robert Jarzmik napsal(a):
> Petr Cvek <petr.cvek@tul.cz> writes:
> 
>> The htc-egpio driver should be always included in the kernel as it
>> controls MMC/charging/IrDA power, which is the only way to get
>> an useful rootfs.
>>
>> Signed-off-by: Petr Cvek <petr.cvek@tul.cz>
> It's already defined in magician_defconfig, why enforce it in Kconfig ?

Good remark, I did not use defconfig at all (as I had to fix from zero configuration + I did not know if defconfig works and will be supported in the future).

I will check if magician_defconfig needs to be updated (probably for leds).

> 
> And if it's enforced and I want to build a kernel for magician without
> MMC/charging/IrDA, why should I be forced to build in HTC_EGPIO ?
> 
> Or said differently, does a kernel without HTC_EGPIO is proven to fail 100%
> without this option ?

Kernel will probably run OK, but the phone will be unusable (for any practical purposes). The EGPIO chip (CPLD) will stay in the state programmed from the previous environment (bootloader or WinCE/Mobile) and drivers fail to init because of the missing EGPIO (and if they init, they will be without any idea about state of the peripherals (no charger detection/charging current stuck on the previous settings, no LCD backlight control, no IrDA, no rootfs, no GSM, no sound, no LEDs).

Different PCB revisions probably use EGPIO pin for LCD power (and at least on my phone, LCD power must have very specific order).

For future (when ROM XIP will work) I would like to be able boot kernel from flash, which itself uses EGPIO for Vpp control (another initial EGPIO configuration). Last possible boot is from JTAG and there will be no previous EGPIO initialization.

Petr
