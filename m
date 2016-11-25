From: Joonyoung Shim <jy0922.shim@samsung.com>
Subject: Re: [PATCH] PM / OPP: fix CPU device to be removed from OPP table in
 wrong order
Date: Fri, 25 Nov 2016 10:54:52 +0900
Message-ID: <583799EC.4060101@samsung.com>
References: <1479973761-21225-1-git-send-email-jy0922.shim@samsung.com>
 <CGME20161124084531epcas2p1f662ed5a74f2c6f3da5911f1fe38a200@epcas2p1.samsung.com>
 <20161124083403.GA29969@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:53779 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750910AbcKYByL (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 24 Nov 2016 20:54:11 -0500
In-reply-to: <20161124083403.GA29969@vireshk-i7>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, vireshk@kernel.org, nm@ti.com, sboyd@codeaurora.org, rjw@rjwysocki.net, len.brown@intel.com, pavel@ucw.cz, gregkh@linuxfoundation.org, Joonyoung Shim <jy0922.shim@samsung.com>

Hi Viresh.

On 11/24/2016 05:34 PM, Viresh Kumar wrote:
> Ho Joonyoung,
> 
> On 24-11-16, 16:49, Joonyoung Shim wrote:
>> The device that creates OPP table first should be removed from dev_list
>> of OPP table in last because it can be used by other resources
>> (supported_hw, prop_name, regulator), but not now.
> 
> I am not sure what you are trying to do here? Why can't the CPU which
> added the OPP should be removed last.
> 
> Can you give a real example where you see a problem ?
> 
>> If OPP table is
>> shared by several CPUs, the CPU device that creates OPP table can be
>> removed earlier than other CPU devices.
> 
> I don't think that's a problem, though I can be wrong for sure.
> 

I found this problem during system suspend/resume of Odroid-XU3 board.

# rtcwake -m mem -s 3
wakeup from "mem" at Wed Apr  4 05:54:44 2001
[   15.965996] PM: Syncing filesystems ... done.
[   15.976333] Freezing user space processes ... (elapsed 0.002 seconds) done.
[   15.983287] Freezing remaining freezable tasks ... (elapsed 0.002 seconds) done.
[   16.006951] wake enabled for irq 135
[   16.008782] smsc95xx 1-1.1:1.0 eth0: entering SUSPEND2 mode
[   16.094110] PM: suspend of devices complete after 95.038 msecs
[   16.105648] PM: late suspend of devices complete after 6.903 msecs
[   16.116356] PM: noirq suspend of devices complete after 5.912 msecs
[   16.121213] Disabling non-boot CPUs ...
[   16.154140] IRQ51 no longer affine to CPU1
[   16.154709] CPU1: shutdown
[   16.214148] IRQ52 no longer affine to CPU2
[   16.214646] CPU2: shutdown
[   16.273980] IRQ53 no longer affine to CPU3
[   16.274458] CPU3: shutdown
[   16.335093] IRQ54 no longer affine to CPU4
[   16.336033] CPU4: shutdown
[   16.389979] IRQ55 no longer affine to CPU5
[   16.390823] CPU5: shutdown
[   16.444829] IRQ56 no longer affine to CPU6
[   16.445621] CPU6: shutdown
[   16.509229] cpu cpu4: Failed to find opp_table: -19
[   16.514008] IRQ57 no longer affine to CPU7
[   16.514824] CPU7: shutdown

CPU4-7 are offline on after system resume.

Above -19 error occurs because cannot find OPP table for CPU4 from
dev_pm_opp_put_regulator() when regulator resource for CPU4 is put.

Odroid-XU3 board uses exynos5422 SoCs having 8 CPUs (4 little cores / 
4 bit cores). CPU0-3 (little core) shares a OPP table and CPU4-7
(bit core) shares a OPP table (operating-points-v2 binding). CPU0 and
CPU4 have each regulators. You can find them from below dts files,

arch/arm/boot/dts/exynos5420.dtsi
arch/arm/boot/dts/exynos5422-cpus.dtsi
arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi

Let's see CPU4-7 case. A OPP tables are created by device of CPU4 from
cpufreq_init() of drivers/cpufreq/cpufreq-dt.c. Each OPP devices of
CPU4-7 are registered at dev_list of OPP table created by CPU4 device
as CPU4 - CPU5 - CPU6 - CPU7 order. And regulator resource for CPU4 uses
OPP device of CPU4. 

The cpufreq_exit() tries to free OPP table for CPU4-7 during system
suspend. It will remove OPP devices as CPU4 - CPU5 - CPU6 - CPU7 order,
then only OPP device for CPU7 remains before regulator resource of CPU4
is put, but it needs CPU4 OPP device that creates OPP table to put
regulator resource of CPU4, not CPU7 OPP device.

This patch will make to remove OPP devices as CPU5 - CPU6 - CPU7 - CPU4
order.

As another way, we can consider reference count for OPP device. Above
problem occurs because CPU4 and regulator of CPU4 use same OPP device.

Any ideas?

Thanks.
