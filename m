From: Stefan Wahren <stefan.wahren@i2se.com>
Subject: [Bug] ARM: cpuidle: possible memleak
Date: Sat, 12 Aug 2017 15:19:33 +0200 (CEST)
Message-ID: <1980049531.494543.1502543973258@email.1und1.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.134]:54233 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750802AbdHLNUR (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 12 Aug 2017 09:20:17 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Leo Yan <leo.yan@linaro.org>, Sudeep Holla <sudeep.holla@arm.com>, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi,

if i additionally enable kmemleak (on top of multi_v7_defconfig) on RPi 3 (4 cores) with 4.13-rc4, i get the following output from kmemleak:

unreferenced object 0xede0dc00 (size 1024):
  comm "swapper/0", pid 1, jiffies 4294937431 (age 744.510s)
  hex dump (first 32 bytes):
    94 9e 0b c1 00 00 00 00 00 00 00 00 00 00 00 00  ................
    57 46 49 00 00 00 00 00 00 00 00 00 00 00 00 00  WFI.............
  backtrace:
    [<c1295f04>] arm_idle_init+0x44/0x1ac
    [<c0301e6c>] do_one_initcall+0x3c/0x16c
    [<c1200d70>] kernel_init_freeable+0x110/0x1d0
    [<c0cb3624>] kernel_init+0x8/0x114
    [<c0307a98>] ret_from_fork+0x14/0x3c
    [<ffffffff>] 0xffffffff

If i revert the last commit in cpuidle-arm d50a7d8acd78 ("ARM: cpuidle: Support asymmetric idle definition") then kmemleak stays calm.

Best regards
Stefan
