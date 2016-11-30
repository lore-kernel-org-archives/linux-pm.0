From: Joonyoung Shim <jy0922.shim@samsung.com>
Subject: Re: [PATCH V4] PM / OPP: Pass opp_table to dev_pm_opp_put_regulator()
Date: Wed, 30 Nov 2016 15:19:52 +0900
Message-ID: <583E6F88.9010805@samsung.com>
References: <CGME20161130040034epcas5p4344849b26e8b5c435e658e3a0179cef6@epcas5p4.samsung.com>
 <480ae6e161788d338fb1637aa2615a75588ac3c6.1480478081.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <stable-owner@vger.kernel.org>
In-reply-to: <480ae6e161788d338fb1637aa2615a75588ac3c6.1480478081.git.viresh.kumar@linaro.org>
Sender: stable-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>, Rafael Wysocki <rjw@rjwysocki.net>, Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@codeaurora.org>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, "# v4 . 4+" <stable@vger.kernel.org>, Joonyoung Shim <jy0922.shim@samsung.com>
List-Id: linux-pm@vger.kernel.org

Hi Viresh,

On 11/30/2016 12:59 PM, Viresh Kumar wrote:
> From: Stephen Boyd <sboyd@codeaurora.org>
> 
> Joonyoung Shim reported an interesting problem on his ARM octa-core
> Odoroid-XU3 platform. During system suspend, dev_pm_opp_put_regulator()
> was failing for a struct device for which dev_pm_opp_set_regulator() is
> called earlier.
> 
> This happened because an earlier call to
> dev_pm_opp_of_cpumask_remove_table() function (from cpufreq-dt.c file)
> removed all the entries from opp_table->dev_list apart from the last CPU
> device in the cpumask of CPUs sharing the OPP.
> 
> But both dev_pm_opp_set_regulator() and dev_pm_opp_put_regulator()
> routines get CPU device for the first CPU in the cpumask. And so the OPP
> core failed to find the OPP table for the struct device.
> 
> In order to fix that up properly, we need to revisit APIs like
> dev_pm_opp_set_regulator() and make them talk in terms of cookies
> provided by the OPP core. But such a solution will be hard to backport
> to stable kernels.
> 
> This patch attempts to fix this problem by returning a pointer to the
> opp_table from dev_pm_opp_set_regulator() and using that as the
> parameter to dev_pm_opp_put_regulator(). This ensures that the
> dev_pm_opp_put_regulator() doesn't fail to find the opp table.
> 
> Note that similar design problem also exists with other
> dev_pm_opp_put_*() APIs, but those aren't used currently by anyone and
> so we don't need to update them for now.
> 
> [Viresh]: Written commit log, minor improvements in the patch and tested
> on exynos 5250.
> 
> Cc: # v4.4+ <stable@vger.kernel.org>
> Reported-by: Joonyoung Shim <jy0922.shim@samsung.com>
> Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
> V3->V4:
> - Completely different approach, suggested earlier by Stephen.
> - Can be merged safely now as both /me and Stephen agree to this one.
> 
> @Joonyoung: Can you please test this last patch please ?
> 

Just system suspend/resume is working but i was missing below test case
that you inform when i test for prior patches on my Odroid-XU3 board.

- offline CPU 4
- suspend the system

With this test case, now all patches posted have the problem that is
failed to get clk: -2.

If all CPUs are online, cpufreq_driver->init(policy) is called by
cpufreq_online() only for CPU0 and CPU4 during system resume but it is
called for CPU5, CPU6 and CPU7 during system resume after CPU4 is
offline, and causes error.

Please refer below logs.

# echo 0 > /sys/devices/system/cpu/cpu4/online 
[  145.438931] IRQ54 no longer affine to CPU4
[  145.439931] CPU4: shutdown
#
#
# rtcwake -m mem -s 3
wakeup from "mem" at Mon Apr  9 11:04:19 2001
[  148.708773] PM: Syncing filesystems ... done.
[  148.718591] Freezing user space processes ... (elapsed 0.005 seconds) done.
[  148.727749] Freezing remaining freezable tasks ... (elapsed 0.002 seconds) done.
[  148.753406] wake enabled for irq 135
[  148.754006] smsc95xx 1-1.1:1.0 eth0: entering SUSPEND2 mode
[  148.844402] PM: suspend of devices complete after 100.196 msecs
[  148.869158] PM: late suspend of devices complete after 19.793 msecs
[  148.891948] PM: noirq suspend of devices complete after 17.803 msecs
[  148.897067] Disabling non-boot CPUs ...
[  148.920201] IRQ51 no longer affine to CPU1
[  148.921414] CPU1: shutdown
[  148.990114] IRQ52 no longer affine to CPU2
[  148.991158] CPU2: shutdown
[  149.049416] IRQ53 no longer affine to CPU3
[  149.050477] CPU3: shutdown
[  149.114297] IRQ55 no longer affine to CPU5
[  149.115318] CPU5: shutdown
[  149.184539] IRQ56 no longer affine to CPU6
[  149.185421] CPU6: shutdown
[  149.257561] IRQ57 no longer affine to CPU7
[  149.258458] CPU7: shutdown
exynos_suspend_enter: suspending the system...
exynos_suspend_enter: wakeup masks: fffffffd,ffffffef
UART[f7020000]: ULCON=0003, UCON=f3c5, UFCON=0131, UBRDIV=001b
[  149.295339] Enabling non-boot CPUs ...
[  149.314454] CPU1 is up
[  149.329717] CPU2 is up
[  149.350140] CPU3 is up
[  149.370365] cpu cpu5: cpufreq_init: failed to get clk: -2
[  149.374803] IRQ55 no longer affine to CPU5
[  149.375126] CPU5: shutdown
[  149.399737] Error taking CPU5 up: -2
[  149.425424] cpu cpu6: cpufreq_init: failed to get clk: -2
[  149.429886] IRQ56 no longer affine to CPU6
[  149.430242] CPU6: shutdown
[  149.454745] Error taking CPU6 up: -2
[  149.480397] cpu cpu7: cpufreq_init: failed to get clk: -2
[  149.484869] IRQ57 no longer affine to CPU7
[  149.485186] CPU7: shutdown
[  149.509718] Error taking CPU7 up: -2
[  149.512392] s3c-i2c 12c60000.i2c: slave address 0x00
[  149.516787] s3c-i2c 12c60000.i2c: bus frequency set to 65 KHz
[  149.522554] s3c-i2c 12c80000.i2c: slave address 0x00
[  149.527461] s3c-i2c 12c80000.i2c: bus frequency set to 65 KHz
[  149.535818] PM: noirq resume of devices complete after 23.970 msecs
[  149.543853] PM: early resume of devices complete after 3.020 msecs
[  149.571356] s3c2410-wdt 101d0000.watchdog: watchdog disabled
[  149.575811] usb usb1: root hub lost power or was reset
[  149.641026] usb usb2: root hub lost power or was reset
[  149.646353] exynos-tmu 10060000.tmu: More trip points than supported by this TMU.
[  149.652405] exynos-tmu 10060000.tmu: 2 trip points should be configured in polling mode.
[  149.663667] wake disabled for irq 135
[  149.680093] Suspended for 2.879 seconds
[  149.715816] usb usb3: root hub lost power or was reset
[  149.719482] usb usb4: root hub lost power or was reset
[  149.728432] s3c-rtc 101e0000.rtc: rtc disabled, re-enabling
[  149.932034] usb 1-1: reset high-speed USB device number 2 using exynos-ehci
[  150.387017] usb 1-1.1: reset high-speed USB device number 3 using exynos-ehci
[  150.566376] PM: resume of devices complete after 995.669 msecs
[  150.575402] Restarting tasks ... done.

Thanks.
