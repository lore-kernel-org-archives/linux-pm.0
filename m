From: Leo Yan <leo.yan@linaro.org>
Subject: Re: [Bug] ARM: cpuidle: possible memleak
Date: Sun, 13 Aug 2017 11:50:40 +0800
Message-ID: <20170813035040.GA13637@leoy-linaro>
References: <1980049531.494543.1502543973258@email.1und1.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f41.google.com ([74.125.82.41]:34837 "EHLO
        mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752227AbdHMDuu (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 12 Aug 2017 23:50:50 -0400
Received: by mail-wm0-f41.google.com with SMTP id m85so16598281wma.0
        for <linux-pm@vger.kernel.org>; Sat, 12 Aug 2017 20:50:49 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1980049531.494543.1502543973258@email.1und1.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Stefan Wahren <stefan.wahren@i2se.com>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Sudeep Holla <sudeep.holla@arm.com>, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi Stefan,

On Sat, Aug 12, 2017 at 03:19:33PM +0200, Stefan Wahren wrote:
> Hi,
> 
> if i additionally enable kmemleak (on top of multi_v7_defconfig) on RPi 3 (4 cores) with 4.13-rc4, i get the following output from kmemleak:
> 
> unreferenced object 0xede0dc00 (size 1024):
>   comm "swapper/0", pid 1, jiffies 4294937431 (age 744.510s)
>   hex dump (first 32 bytes):
>     94 9e 0b c1 00 00 00 00 00 00 00 00 00 00 00 00  ................
>     57 46 49 00 00 00 00 00 00 00 00 00 00 00 00 00  WFI.............
>   backtrace:
>     [<c1295f04>] arm_idle_init+0x44/0x1ac
>     [<c0301e6c>] do_one_initcall+0x3c/0x16c
>     [<c1200d70>] kernel_init_freeable+0x110/0x1d0
>     [<c0cb3624>] kernel_init+0x8/0x114
>     [<c0307a98>] ret_from_fork+0x14/0x3c
>     [<ffffffff>] 0xffffffff
> 
> If i revert the last commit in cpuidle-arm d50a7d8acd78 ("ARM: cpuidle: Support asymmetric idle definition") then kmemleak stays calm.

I cannot reproduce the error at my side, I also tried to disable idle
states but cannot trigger the failure. So first thing is to know the
reason for registeration failure and finally introduce the memory
leaking. Could you point out the dts you are using for idle states
binding?

Also reviewed a bit for the idle driver, it does have issue to handle
failure case. I tweaked a bit for it, could you try it? Also would like
to hear the comments from Daniel.

diff --git a/drivers/cpuidle/cpuidle-arm.c b/drivers/cpuidle/cpuidle-arm.c
index 7080c38..80dc86f 100644
--- a/drivers/cpuidle/cpuidle-arm.c
+++ b/drivers/cpuidle/cpuidle-arm.c
@@ -152,11 +152,13 @@ static int __init arm_idle_init(void)
 out_fail:
        while (--cpu >= 0) {
                dev = per_cpu(cpuidle_devices, cpu);
-               cpuidle_unregister_device(dev);
-               kfree(dev);
-               drv = cpuidle_get_driver();
+               drv = cpuidle_get_cpu_driver(dev);
+
                cpuidle_unregister_driver(drv);
                kfree(drv);
+
+               cpuidle_unregister_device(dev);
+               kfree(dev);
        }
 
        return ret;


> 
> Best regards
> Stefan
